#!/bin/ksh
#==============================================================================
#
# NOM
#      statspack_snap.ksh
#
# ********************************************************
# AUTEUR           : MEMODBA
# VERSION          : 1.00.00 
# DATE DE CREATION : 20140228
# ********************************************************
# DESCRIPTION
#      Script pour les versions Oracle 8i, 9i, 10g
#      prise de cliche statspack 
#       Les parametres suivants sont parametrables dans le fichier statspack.env
#       LEVEL         niveau des snapshots (0,5,6,10)
#
# USAGE
#      statspack_snap.ksh
#      en general a lancer une fois par heure
#      en dehors du lancement de statspack_snap.ksh et statspack_rebuild.ksh
#      exemple de lancement par crontab 
#      0 * * * * /data/script/dba/statspack/statspack_snap.ksh >/data/script/dba/statspack/log/statspack_snap.log 2>&1
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
#==============================================================================

# ----------------------------------------------------------
#  chargement environnement
# ----------------------------------------------------------
.  `dirname $0`/statspack.env
DBversion=0
# test variables sensibles non nulle

if [ -z "$LOGPATH"  ]
    then
echo "------------------------------------"> $STATSPACK_SNAPLOG
echo "variable LOGPATH vide ">> $STATSPACK_SNAPLOG
         exit
    fi

if [ -z "$STATSPACK_SNAPLOG"  ]
    then
echo "------------------------------------"> $STATSPACK_SNAPLOG
echo "variable STATSPACK_SNAPLOG vide ">> $STATSPACK_SNAPLOG
         exit
    fi


if [ -z "$MOIS"  ]
    then
echo "------------------------------------"> $STATSPACK_SNAPLOG
echo "variable MOIS vide ">> $STATSPACK_SNAPLOG
         exit
    fi



# test si base presente
type_mach=`uname`
if [ $type_mach = 'AIX' ] 
	then
nbr_pmon=` ps -ef | grep pmon_$ORACLE_SID| grep -cv grep`
else 
nbr_pmon=` ps -ef | grep pmon_$ORACLE_SID$| grep -cv grep`
fi 
  if [ $nbr_pmon -ne 1  ]
     then
echo "------------------------------------"> $STATSPACK_SNAPLOG
echo " base $ORACLE_SID non presente ">> $STATSPACK_SNAPLOG
           exit
     fi

sqlplus -s /nolog << EOF > $STATSPACK_SNAPLOGTMP
connect / as sysdba
set head off pages 0 feed off lines 200
select substr(version, 1, instr(version, '.') -1 ) from v\$instance;
EOF
grep -v "Connect" $STATSPACK_SNAPLOGTMP>$STATSPACK_SNAPLOGTMP1

if [ `cat $STATSPACK_SNAPLOGTMP | grep 'ORA-' | wc -l` -ne 0 ]
then
   exit 1
fi

DBversion=`cat $STATSPACK_SNAPLOGTMP1`
export DBversion
rm -f $STATSPACK_SNAPLOGTMP1 
rm -f $STATSPACK_SNAPLOGTMP
#------------------------------LANCEMENT DES COLLECTES-----------------------------------

echo "------------------------------------" > $STATSPACK_SNAPLOG
echo $(date +"%d/%m/%Y:%H:%M:%S"):Lancement des collectes >> $STATSPACK_SNAPLOG
if [ $DBversion -gt 9 ]; then
sqlplus -s /nolog << EOF >>$STATSPACK_SNAPLOG
connect / as sysdba
set echo on feed on lines 200 head on timing on
alter session set "_cursor_plan_unparse_enabled" = false;
execute perfstat.statspack.snap(i_snap_level=>$LEVEL);
EOF
else  
sqlplus -s /nolog << EOF >>$STATSPACK_SNAPLOG
connect / as sysdba
set echo on feed on lines 200 head on timing on
execute perfstat.statspack.snap(i_snap_level=>$LEVEL);
EOF
fi 
#### test si ok
if [ `cat $STATSPACK_SNAPLOG | grep 'ORA-' | wc -l` -ne 0 ]
  then
###### on conserve un  an de log archive par mois
cat $STATSPACK_SNAPLOG >> $STATSPACK_SNAPLOG.$MOIS
      exit 1
  else
      echo $(date +"%d/%m/%Y:%H:%M:%S"):Fin des collectes >> $STATSPACK_SNAPLOG
###### on conserve un  an de log archive par mois
cat $STATSPACK_SNAPLOG >> $STATSPACK_SNAPLOG.$MOIS
  fi




