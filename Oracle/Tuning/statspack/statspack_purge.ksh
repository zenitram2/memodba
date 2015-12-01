#!/bin/ksh
#==============================================================================
#
# NOM
#      statspack_purge.ksh
#
# ********************************************************
# AUTEUR           : MEMODBA
# VERSION          : 1.00.00 
# DATE DE CREATION : 20140228
# ********************************************************
# DESCRIPTION
#      Script pour les versions Oracle 8i, 9i, 10g, 11g
#      purge de cliche statspack 
#      Contourne le bug du script sppurge.sql qui ne vide pas le tablespace PERFSTAT apres les purges
#      Les parametres suivants sont parametrables dans le fichier statspack.env
#  RETENTION     duree de retention des snapshots
#  PURGE_SPPURGE ON/OFF pour activer/desactiver les purges standard par sppurge.sql
#                ATTENTION ne pas activer les purges si pas faites depuis longtemps ( generation archivelogs importante)
#  PURGE_PLUS    ON/OFF pour activer/desactiver les purges supplementaires
#                ATTENTION ne pas activer les purges si pas faites depuis longtemps ( generation archivelogs importante)
# USAGE
#      statspack_purge.ksh 
#      en general a lancer une fois par jour    
#      en dehors du lancement de statspack_snap.ksh et statspack_rebuild.ksh
#      exemple de lancement par crontab pour la base TEST 
#      5 1 * * * * /data/script/dba/statspack/statspack_purge.ksh >/data/script/dba/statspack/log/statspack_purge.log 2>&1
#
# Emplacement
#		/data/script/dba/statspack
#
# ********************************************************
# *                   MODIFICATIONS                      *
# *------------------------------------------------------*
# * Quand    | Qui | Quoi                                *
# *------------------------------------------------------*
#
# ********************************************************
#
#==============================================================================


# ----------------------------------------------------------
#  chargement environnement
# ----------------------------------------------------------
.  `dirname $0`/statspack.env
# test variables sensibles non nulle
if [ -z "$LOGPATH"  ]
    then
echo "------------------------------------"> $SNAPPURGELOG
echo "variable LOGPATH vide ">> $SNAPPURGELOG
         exit
    fi


if [ -z "$SNAPPURGELOG"  ]
    then
echo "------------------------------------"> $SNAPPURGELOG
echo "variable SNAPPURGELOG vide ">> $SNAPPURGELOG
         exit
    fi


if [ -z "$MOIS"  ]
    then
echo "------------------------------------"> $SNAPPURGELOG
echo "variable MOIS vide ">> $SNAPPURGELOG
         exit
    fi





# test si purge sppurge a faire

if [ $PURGE_SPPURGE !=  "ON" ]
    then
echo "------------------------------------"> $SNAPPURGELOG
echo  "`date +"%d/%m/%Y:%H:%M:%S"`:pas de purge , variable PURGE_SPPURGE=$PURGE_SPPURGE" >> $SNAPPURGELOG

###### on conserve un  an de log archive par mois
cat $SNAPPURGELOG >> $SNAPPURGELOG.$MOIS
         exit
    fi


# test si base presente
nbr_pmon=` ps -ef | grep pmon_$ORACLE_SID | grep -cv grep`
  if [ $nbr_pmon -ne 1  ]
     then
echo "------------------------------------"> $SNAPPURGELOG
echo " base $ORACLE_SID non presente ">> $SNAPPURGELOG
           exit
     fi



# mise a zero des variables
instance_number=0
LoSnapTime=0
HiSnapTime=0
LoSnapId=0
HiSnapId=0
index=0
Nolog=0
DBversion=0

# determination du numero d'instance                instance_number
sqlplus -s /nolog << EOF > $SNAPPURGELOG
connect / as sysdba
set head off pages 0 feed off lines 200
select instance_number from v\$instance;
EOF

grep -v "Connect" $SNAPPURGELOG>$STATSPACK_SNAPPURGELOGTMP1

if [ `cat $SNAPPURGELOG | grep 'ORA-' | wc -l` -ne 0 ]
then
   exit 1
fi

instance_number=`cat $STATSPACK_SNAPPURGELOGTMP1`
export instance_number  

 


# determination de la date des cliches              LoSnapTime HiSnapTime
sqlplus -s /nolog << EOF > $SNAPPURGELOG
connect / as sysdba
set head off pages 0 feed off lines 200
alter session set NLS_DATE_FORMAT='DD/MM/YYYY:hh24:mi:ss';
select min(snap_time),max(snap_time)
from perfstat.STATS\$SNAPSHOT s, V\$INSTANCE i
where to_char(snap_time,'yyyymmddhh24mi') < to_char(sysdate - $RETENTION,'yyyymmdd"0000"')
and s.instance_number = i.instance_number;
EOF
grep -v "Connect" $SNAPPURGELOG>$STATSPACK_SNAPPURGELOGTMP1
if [ `cat $SNAPPURGELOG | grep 'ORA-' | wc -l` -ne 0 ]
then
   exit 1
fi

LoSnapTime=`cat $STATSPACK_SNAPPURGELOGTMP1 | awk '{print($1)}'` 
HiSnapTime=`cat $STATSPACK_SNAPPURGELOGTMP1 | awk '{print($2)}'` 

export LoSnapTime       
export HiSnapTime       




# determination du snap_id                     LoSnapId HiSnapId 
sqlplus -s /nolog << EOF > $SNAPPURGELOG
connect / as sysdba
set head off pages 0 feed off lines 200
select nvl(min(snap_id),0),nvl(max(snap_id),0)
from perfstat.STATS\$SNAPSHOT s, V\$INSTANCE i
where to_char(snap_time,'yyyymmddhh24mi') < to_char(sysdate - $RETENTION,'yyyymmdd"0000"')
and s.instance_number = i.instance_number;
EOF
grep -v "Connect" $SNAPPURGELOG>$STATSPACK_SNAPPURGELOGTMP1
if [ `cat $SNAPPURGELOG | grep 'ORA-' | wc -l` -ne 0 ]
then
   exit 1
fi

LoSnapId=`cat $STATSPACK_SNAPPURGELOGTMP1 | awk '{print($1)}'`
HiSnapId=`cat $STATSPACK_SNAPPURGELOGTMP1 | awk '{print($2)}'`

export LoSnapId
export HiSnapId


# determination de la presence des indexes de performance     index
sqlplus -s /nolog << EOF > $SNAPPURGELOG
connect / as sysdba
set head off pages 0 feed off lines 200
select count(*) from dba_indexes where index_name in('STATS\$SQL_SUMMARY_IDX','STATS\$SQL_SUMMARY_HV');
EOF
grep -v "Connect" $SNAPPURGELOG>$STATSPACK_SNAPPURGELOGTMP1
if [ `cat $SNAPPURGELOG | grep 'ORA-' | wc -l` -ne 0 ]
then
   exit 1
fi

index=`cat $STATSPACK_SNAPPURGELOGTMP1`

export index



# determination si mode nologging est bien actif sur les objects  perfstat (utile pour rebuild)      Nolog
sqlplus -s /nolog << EOF > $SNAPPURGELOG
connect / as sysdba
set head off pages 0 feed off lines 200
select sum(total) from
(
select count(logging) total from dba_tables 
where logging='YES' and owner='PERFSTAT'
union
select count(logging) total from dba_indexes
where logging='YES' and owner='PERFSTAT'
);
EOF

grep -v "Connect" $SNAPPURGELOG>$STATSPACK_SNAPPURGELOGTMP1
if [ `cat $SNAPPURGELOG | grep 'ORA-' | wc -l` -ne 0 ]
then
   exit 1
fi

Nolog=`cat $STATSPACK_SNAPPURGELOGTMP1`

export Nolog



# determination de la   version oracle       DBversion
sqlplus -s /nolog << EOF > $SNAPPURGELOG
connect / as sysdba
set head off pages 0 feed off lines 200
select substr(version, 1, instr(version, '.') -1 ) from v\$instance;
EOF
grep -v "Connect" $SNAPPURGELOG>$STATSPACK_SNAPPURGELOGTMP1

if [ `cat $SNAPPURGELOG | grep 'ORA-' | wc -l` -ne 0 ]
then
   exit 1
fi

DBversion=`cat $STATSPACK_SNAPPURGELOGTMP1`
export DBversion
rm -f $STATSPACK_SNAPPURGELOGTMP1



echo "------------------------------------"> $SNAPPURGELOG
echo RETENTION=$RETENTION                  >> $SNAPPURGELOG
echo instance_number:$instance_number      >> $SNAPPURGELOG
echo LoSnapTime     :$LoSnapTime           >> $SNAPPURGELOG
echo HiSnapTime     :$HiSnapTime           >> $SNAPPURGELOG
echo LoSnapId       :$LoSnapId             >> $SNAPPURGELOG
echo HiSnapId       :$HiSnapId             >> $SNAPPURGELOG
echo index          :$index                >> $SNAPPURGELOG
echo Nolog          :$Nolog                >> $SNAPPURGELOG
echo DBversion      :$DBversion            >> $SNAPPURGELOG
echo PURGE_SPPURGE  :$PURGE_SPPURGE        >> $SNAPPURGELOG
echo PURGE_PLUS     :$PURGE_PLUS           >> $SNAPPURGELOG


#--------------------------------------------------------------------------------------------
#-------------------------LANCEMENT DES PURGES SPPURGE SI HIGHT MOINS LOW SUPERIEUR A RETENTION------
#--------------------------------------------------------------------------------------------

if [ $HiSnapId -ne 0 ]; then


	#------------------------------LANCEMENT DU SPPURGE--------------------------------------

	sqlplus -s /nolog << EOF >> $SNAPPURGELOG
	connect / as sysdba

	select sysdate||':Lancement de sppurge de $LoSnapTime a $HiSnapTime des snapshots $LoSnapId a $HiSnapId'
	from dual;

	define losnapid="$LoSnapId"
	define hisnapid="$HiSnapId"

	@?/rdbms/admin/sppurge;
	select sysdate||':Fin de sppurge de $LoSnapTime a $HiSnapTime des snapshots $LoSnapId a $HiSnapId'
	from dual;
	set head off
	select sysdate||':Fin de la purge de $LoSnapTime a $HiSnapTime des snapshots $LoSnapId a $HiSnapId' from dual;
EOF

fi





# test si purge PLUS a faire

if [ $PURGE_PLUS !=  "ON" ]
    then
echo  "`date +"%d/%m/%Y:%H:%M:%S"`:pas de purge PLUS , variable PURGE_PLUS=$PURGE_PLUS" >> $SNAPPURGELOG
###### on conserve un  an de log archive par mois
cat $SNAPPURGELOG >> $SNAPPURGELOG.$MOIS
         exit
    fi


#------------------------------CREATION DES INDEXES DE PERFORMANCE------------------
if [ $index -ne 2 ]
then
echo  `date +"%d/%m/%Y:%H:%M:%S"`:CREATION des indexes de performance >> $SNAPPURGELOG
sqlplus -s /nolog << EOF 
connect / as sysdba

set head off pages 0 feed on echo on timing on
--spool $LOGPATH/CREATE_INDEX_SQL_SUMMARY_ALL.log
CREATE INDEX PERFSTAT.STATS\$SQL_SUMMARY_IDX ON PERFSTAT.STATS\$SQL_SUMMARY
(SNAP_ID, DBID, INSTANCE_NUMBER)
NOLOGGING
NOPARALLEL;

CREATE INDEX PERFSTAT.STATS\$SQL_SUMMARY_HV ON PERFSTAT.STATS\$SQL_SUMMARY
(HASH_VALUE, TEXT_SUBSET)
NOLOGGING
NOPARALLEL;

--spool off
EOF
echo `date +"%d/%m/%Y:%H:%M:%S"`:FIN CREATION des indexes de performance >> $SNAPPURGELOG
fi



#------------------------------MISE EN NOLOGGING--------------------------------------
if [ $Nolog -ne 0 ]
then
echo `date +"%d/%m/%Y:%H:%M:%S"`:Mise en nologging des objets >> $SNAPPURGELOG
sqlplus -s /nolog << EOF >> $SNAPPURGELOG
connect / as sysdba
spool $LOGPATH/set_nologging_perfstat_objects.sql
set echo off head off feed off termout off linesize 120  pagesize 0
--prompt spool $LOGPATH/set_nologging_perfstat_objects.log
prompt set termout on 
prompt set echo on
select 'ALTER '||segment_type||' PERFSTAT.'||segment_name||' NOLOGGING;' from dba_segments where owner='PERFSTAT' and segment_type not like 'LOB%';
--prompt spool off
spool off
EOF

sqlplus -s /nolog << EOF >> $SNAPPURGELOG
connect / as sysdba
@$LOGPATH/set_nologging_perfstat_objects.sql 
EOF
echo `date +"%d/%m/%Y:%H:%M:%S"`:Fin de la mise en nologging des objets >> $SNAPPURGELOG
fi

#--------------------------------------------------------------------------------------------
#-------------------------LANCEMENT DES PURGES PLUS SI HIGHT MOINS LOW SUPERIEUR A RETENTION------
#--------------------------------------------------------------------------------------------

if [ $HiSnapId -ne 0 ]; then
     if [ $DBversion -ne 10 ]; then
	
sqlplus -s /nolog << EOF >> $SNAPPURGELOG
connect / as sysdba
	set head off pages 0 feed on lines 200 echo on timing on
	alter session set NLS_DATE_FORMAT='DD/MM/YYYY:hh24:mi:ss';

	select sysdate||':Debut de la suppression des stats sur  sql_text' from dual;
	execute dbms_stats.delete_table_stats(ownname=>'PERFSTAT',tabname=>'STATS\$SQLTEXT');
	select sysdate||':fin de la suppression des stats sur sql_text' from dual;

	select sysdate||':Lancement de la purge de $LoSnapTime a $HiSnapTime des snapshots $LoSnapId a $HiSnapId' from dual;
	select sysdate||':Debut du delete sur sql_text' from dual;	
	#------------------------------DELETE DES SQLTEXT ---------------------------------------
	set echo on
        set autotrace on
	delete --+ index_ffs(st) 
	from perfstat.stats\$sqltext st 
	where NOT EXISTS 
	(
	SELECT 'X'  from perfstat.stats\$sql_summary ss 
	WHERE (snap_id < $LoSnapId  or snap_id > $HiSnapId )  
	AND (hash_value, text_subset) = ((ST.old_hash_value, ST.text_subset))
	)
	;
	set echo off
	select sysdate||':Fin du delete sur sql_text' from dual;
EOF
     fi
	#----------------------------------------------------------------------------------------------

	#----------------------------------------------------------------------------------------------
     if [ $DBversion -eq 9 ]; then

	sqlplus -s /nolog << EOF >> $SNAPPURGELOG
	connect / as sysdba
	select sysdate||':Debut du delete sur seg_stat_obj' from dual;
	#------------------------------DELETE DES SEG_STAT_OBJ ---------------------------------------
	set echo on timing on
        set autotrace on
	delete --+ index_ffs(sso)
	from perfstat.stats\$seg_stat_obj sso
	where (dbid, dataobj#, obj#) not in
	(select --+ hash_aj full(ss) no_expand
	dbid, dataobj#, obj#
	from perfstat.stats\$seg_stat ss
	where 
	(
	( snap_id < $LoSnapId  or snap_id > $HiSnapId)
	and instance_number = $instance_number
	)
	);
	set echo off
	select sysdate||':Fin du delete sur seg_stat_obj' from dual ;
EOF
     fi
	#---------------------------------------------------------------------------------------------

	sqlplus -s /nolog << EOF >> $SNAPPURGELOG
	connect / as sysdba
	set echo on timing on
	select sysdate||':Debut des statistics sur STATS\$SQLTEXT'  from dual;
	execute dbms_stats.gather_table_stats(ownname=>'PERFSTAT',tabname=>'STATS\$SQLTEXT');
	select sysdate||':Fin des statistics sur STATS\$SQLTEXT'  from dual;

EOF
	
fi

###### on conserve un  an de log archive par mois
cat $SNAPPURGELOG >> $SNAPPURGELOG.$MOIS

