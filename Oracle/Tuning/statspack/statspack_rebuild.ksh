#!/bin/ksh
#==============================================================================
#
# NOM
#      statspack_rebuild.ksh
#
# ********************************************************
# AUTEUR           : MEMODBA
# VERSION          : 1.00.00 
# DATE DE CREATION : 20140228
# ********************************************************
# DESCRIPTION
#      Script pour les versions Oracle 8i, 9i, 10g
#      rebuild  des indexes du schema PERFSTAT 
#      Les parametres suivants sont parametrables dans le fichier statspack.env
#
# USAGE
#      statspack_rebuild.ksh 
#      en general a mettre une seule fois par mois
#  ATTENTION AUX BDD - en FORCELOGGING(9i) ( generation archivelogs importante)
#                    - avec DATAGUARD ou STANDBY  ( rebuild en logging obligatoire )
#      en dehors du lancement de statspack_snap.ksh et statspack_purge.ksh
#      exemple de lancement par crontab pour la base TEST 
#
#      tous les 20 du mois a 2h05 du matin
#      5 2 20 * * /data/script/dba/statspack/statspack_rebuild.ksh > /data/script/dba/statspack/log/statspack_rebuild.log 2>&1
#
#      tous les dimanche du mois a 2h05 du matin
#      5 2  * * 0 /data/script/dba/statspack/statspack_rebuild.ksh > /data/script/dba/statspack/log/statspack_rebuild.log 2>&1
#
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

if [ -z "$LOGPATH" ]
    then
echo "------------------------------------"> $SNAPREBUILDLOG
echo "variable LOGPATH vide ">> $SNAPREBUILDLOG
         exit
    fi

if [ -z "$SNAPREBUILDLOG"  ]
    then
echo "------------------------------------"> $SNAPREBUILDLOG
echo "variable SNAPREBUILDLOG vide ">> $SNAPREBUILDLOG
         exit
    fi

if [ -z "$MOIS"  ]
    then
echo "------------------------------------"> $SNAPREBUILDLOG
echo "variable MOIS vide ">> $SNAPREBUILDLOG
         exit
    fi


# test si base presente
nbr_pmon=` ps -ef | grep pmon_$ORACLE_SID | grep -cv grep`
  if [ $nbr_pmon -ne 1  ]
     then
echo "------------------------------------"> $SNAPREBUILDLOG
echo " base $ORACLE_SID non presente ">> $SNAPREBUILDLOG
           exit
     fi



#  capacite des tables
sqlplus -s /nolog << EOF >$SNAPREBUILDLOG
connect / as sysdba
set echo off head off feed off termout off linesize 120  pagesize 0
	--  etat par table
	spool $SNAPREBUILDLOGETAT/statspack_rebuild_etat_tables_$AnneeMoisJour.lst
	prompt taille des tables du schema perfstat
	prompt ====================================	
select
        'table= '||rpad(segment_name,30) || ' size  : ' || round(bytes/1024/1024,0) || 'Mo'
        from dba_segments where segment_type='TABLE'  and owner='PERFSTAT'
order by segment_name;  
EOF


	#------------------------------REORGANISATION DES INDEXES--------------------------------

#  capacite des objects avant rebuild
sqlplus -s /nolog << EOF >$SNAPREBUILDLOG
connect / as sysdba
	set echo off head off feed off termout off linesize 120  pagesize 0

	--  etat global objects
spool $SNAPREBUILDLOGETAT/statspack_rebuild_etat_objects_global_avant_rebuild_$AnneeMoisJour.lst
	prompt taille par type object
	prompt =====================
	select 
	rpad(segment_type,20)||'size '||round(sum(bytes/1024/1024),0) || 'Mo' 
	from dba_segments where owner='PERFSTAT' group by segment_type  ;
spool off

	--  etat par index
spool $SNAPREBUILDLOGETAT/statspack_rebuild_etat_indexes_avant_rebuild_$AnneeMoisJour.lst
	prompt taille des index de perfstat avant reorganisation 
	prompt =================================================
	select 
	 'index= '||rpad(segment_name,30) || ' size  : ' || round(bytes/1024/1024,0) || 'Mo'
	from dba_segments where segment_type='INDEX' and owner='PERFSTAT'  order by segment_name ;
spool off
EOF

#  generation des  rebuild

sqlplus -s /nolog << EOF >>$SNAPREBUILDLOG
connect / as sysdba
	spool $SNAPREBUILDLOGETAT/rebuild_schema_perfstat.sql
	set echo off head off feed off termout off linesize 120  pagesize 0
	--prompt spool $SNAPREBUILDLOGETAT/reorg_schema_perfstat.log
	prompt set termout on timing on
	prompt set echo on
	select 
'alter index perfstat."' ||segment_name || '"' || ' rebuild  ' || 'tablespace ' || tablespace_name  ||' nologging ;'
	from dba_segments where segment_type='INDEX'  and owner='PERFSTAT' order by bytes ;
	--prompt spool off
	spool off
EOF



	
	
#  lancement  des  rebuild

	echo "\n\n`date +"%d/%m/%Y:%H:%M:%S"`:Lancement de la REORGANISATION DES INDEXES" >> $SNAPREBUILDLOG


sqlplus -s /nolog << EOF >>$SNAPREBUILDLOG
connect / as sysdba
	set echo on head on feed on  linesize 120  pagesize 0 timing on
	@$SNAPREBUILDLOGETAT/rebuild_schema_perfstat.sql
EOF
rm -f $SNAPREBUILDLOGETAT/rebuild_schema_perfstat.sql
	echo "\n\n`date +"%d/%m/%Y:%H:%M:%S"`:Fin de la REORGANISATION DES INDEXES"       >> $SNAPREBUILDLOG




	
#  capacite des objects apres rebuild
	
sqlplus -s /nolog << EOF >>$SNAPREBUILDLOG
connect  / as sysdba
	set echo off head off feed off termout off linesize 120  pagesize 0

	--  etat global objects
	spool $SNAPREBUILDLOGETAT/statspack_rebuild_etat_objects_global_apres_rebuild_$AnneeMoisJour.lst
	prompt taille par type object
        prompt =====================
        select
        rpad(segment_type,20)||'size '||round(sum(bytes/1024/1024),0) || 'Mo'
        from dba_segments where owner='PERFSTAT' group by segment_type  ;
	spool off

	--  etat par index
	spool $SNAPREBUILDLOGETAT/statspack_rebuild_etat_indexes_apres_rebuild_$AnneeMoisJour.lst
        prompt taille des index de perfstat apres reorganisation
        prompt =================================================
        select
         'index= '||rpad(segment_name,30) || ' size  : ' || round(bytes/1024/1024,0) || 'Mo'
        from dba_segments where segment_type='INDEX' and owner='PERFSTAT'  order by segment_name ;
      spool off
EOF
	

###### on conserve un  an de log archive par mois
cat $SNAPREBUILDLOG >> $SNAPREBUILDLOG.$MOIS

