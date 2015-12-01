#!/bin/ksh
#==============================================================================
#
# NOM
#      statspack_gestion_log.ksh
#
# ********************************************************
# AUTEUR           : MEMODBA
# VERSION          : 1.00.00 
# DATE DE CREATION : 20140228
# ********************************************************
# DESCRIPTION
#      gestion des logs generes par script statspack_*.ksh
#
# USAGE
#      statspack_gestion_log.ksh 
#      a lancer le 1er du mois a 0h
#      exemple de lancement par crontab pour la base TEST 
#      0 0 1 * * /data/script/dba/statspack/statspack_gestion_log.ksh  > /data/script/dba/statspack/log/statspack_gestion_log.lst 2>&1
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
echo "------------------------------------"
echo "variable LOGPATH vide "
         exit
    fi

if [ -z "$STATSPACK_SNAPLOG"  ]
    then
echo "------------------------------------"
echo "variable STATSPACK_SNAPLOG vide "
         exit
    fi

if [ -z "$SNAPPURGELOG"  ]
    then
echo "------------------------------------"
echo "variable SNAPPURGELOG vide "
         exit
    fi

if [ -z "$SNAPREBUILDLOG"  ]
    then
echo "------------------------------------"
echo "variable SNAPREBUILDLOG vide "
         exit
    fi

if [ -z "$MOIS"  ]
    then
echo "------------------------------------"
echo "variable MOIS vide "
         exit
    fi


# le 1er du mois a  0h on raz les logs du mois courant correspondant a  l'annee precedente
rm  -f $STATSPACK_SNAPLOG.$MOIS
rm  -f $SNAPPURGELOG.$MOIS
rm  -f $SNAPREBUILDLOG.$MOIS


#  on recherche et on raz les fichiers de plus d'1 an
# fichiers generes par statspack_rebuild.ksh
find $SNAPREBUILDLOGETAT -mtime +365 -name "statspack_rebuild_etat*lst" -exec rm -f {} \;
