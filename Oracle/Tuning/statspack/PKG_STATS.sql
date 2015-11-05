

CREATE OR REPLACE PACKAGE perfstat."PKG_STATS" 
AS
	PROCEDURE HELP;
	PROCEDURE DETECT_REBOOT ( DATEDEB VARCHAR, DATEFIN VARCHAR );
	FUNCTION EVAL_SNAP_TIME	( SNAPID IN NUMBER, INSTANCE IN NUMBER) RETURN NUMBER;
	PROCEDURE SHOWSQL	( WHASH_VALUE  NUMBER, WEXTRACT VARCHAR DEFAULT NULL );
	PROCEDURE SQL_PLAN_STATS( WPLAN_HASH_VALUE IN NUMBER, WEXTRACT IN VARCHAR DEFAULT NULL );
	PROCEDURE SQL_PLAN 	( WHASH_VALUE NUMBER , WEXTRACT	IN VARCHAR DEFAULT NULL);
	FUNCTION VERSION RETURN VARCHAR;	
	FUNCTION ARRONDI	( IN_VALUE IN NUMBER ) RETURN VARCHAR;
	PROCEDURE CARTOUCHE ;

	FUNCTION EVAL_TIME	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, DATEDEB2 IN VARCHAR, DATEFIN2 IN VARCHAR ) RETURN NUMBER;
	PROCEDURE PGA		( DATEDEB VARCHAR DEFAULT NULL, DATEFIN VARCHAR DEFAULT NULL, LSTMODE VARCHAR DEFAULT 'CSV',
					INSTANCE NUMBER DEFAULT 1, ZOOM IN VARCHAR DEFAULT NULL	);
	PROCEDURE PGA_PROC	( DATEDEB  VARCHAR  DEFAULT NULL, DATEFIN  VARCHAR  DEFAULT NULL, LSTMODE  VARCHAR  DEFAULT 'CSV',
					INSTANCE NUMBER   DEFAULT 1, ZOOM  IN VARCHAR DEFAULT NULL );
	PROCEDURE SGA		( DATEDEB  VARCHAR  DEFAULT NULL, DATEFIN  VARCHAR  DEFAULT NULL, LSTMODE  VARCHAR  DEFAULT 'CSV',
					INSTANCE NUMBER   DEFAULT NULL, ZOOM  IN VARCHAR DEFAULT NULL );
	PROCEDURE SGA_PROC	( DATEDEB  VARCHAR  DEFAULT NULL, DATEFIN VARCHAR DEFAULT NULL, LSTMODE VARCHAR  DEFAULT 'CSV',
					INSTANCE NUMBER  DEFAULT NULL, ZOOM IN VARCHAR DEFAULT NULL );
	PROCEDURE BPS		( DATEDEB IN VARCHAR  DEFAULT NULL, DATEFIN IN VARCHAR  DEFAULT NULL, LSTMODE IN VARCHAR  DEFAULT 'CSV',
					INSTANCE  IN NUMBER  DEFAULT NULL, ZOOM IN VARCHAR DEFAULT NULL );
	PROCEDURE BPS_PROC	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR  DEFAULT 'CSV',
					INSTANCE  IN NUMBER  DEFAULT NULL, ZOOM IN VARCHAR DEFAULT NULL );
	PROCEDURE NQ		( DATEDEB IN VARCHAR DEFAULT NULL, DATEFIN IN VARCHAR DEFAULT NULL, LSTMODE IN VARCHAR  DEFAULT 'CSV',
					INSTANCE  IN NUMBER  DEFAULT NULL, NQ_TYPE IN VARCHAR DEFAULT NULL,
					TOP IN NUMBER DEFAULT 3, ZOOM IN VARCHAR DEFAULT NULL );
	PROCEDURE NQ_PROC	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR  DEFAULT 'CSV',
					INSTANCE  IN NUMBER  DEFAULT NULL, NQ_TYPE IN VARCHAR DEFAULT NULL,
					TOP IN NUMBER DEFAULT 3, ZOOM IN VARCHAR DEFAULT NULL );
	PROCEDURE RUBRIQUE_PROC	( DATEDEB  VARCHAR, DATEFIN  VARCHAR, LSTMODE  VARCHAR  DEFAULT 'CSV',
					FORMAT_DATE_SORTIE  VARCHAR  DEFAULT 'YYYY/MM/DD', PRECO   VARCHAR  DEFAULT 'Y',
					INSTANCE NUMBER DEFAULT NULL, PRECISION NUMBER DEFAULT 3, TYPEREST VARCHAR  DEFAULT 'NORME',
					IDLE  VARCHAR DEFAULT 'N', ZOOM  IN VARCHAR DEFAULT NULL );
	PROCEDURE RUBRIQUE	( DATEDEB  VARCHAR  DEFAULT NULL, DATEFIN  VARCHAR  DEFAULT NULL, LSTMODE  VARCHAR  DEFAULT 'CSV',
					FORMAT_DATE_SORTIE  VARCHAR  DEFAULT 'YYYY/MM/DD', PRECO   VARCHAR DEFAULT 'Y',
					INSTANCE NUMBER  DEFAULT 1, PRECISION NUMBER  DEFAULT 3, TYPEREST VARCHAR  DEFAULT 'NORME',
					IDLE  VARCHAR DEFAULT 'N', ZOOM  VARCHAR DEFAULT NULL );
	PROCEDURE DIAG_PROC	(  DATEDEB  IN VARCHAR  DEFAULT TO_CHAR( SYSDATE-7, 'YYYYMMDD HH24:MI' ),
					DATEFIN  IN VARCHAR  DEFAULT TO_CHAR( SYSDATE  , 'YYYYMMDD HH24:MI' ),
					LSTMODE IN VARCHAR  DEFAULT 'NORM', PRECO  IN VARCHAR  DEFAULT 'Y' ,
					COEFVAL  IN NUMBER  DEFAULT 3, SEUIL_MINI  IN NUMBER  DEFAULT NULL, INSTANCE IN NUMBER  DEFAULT 1,
					TYPEREST IN VARCHAR DEFAULT 'NORME', DEGRAD IN VARCHAR DEFAULT 'N' );
	PROCEDURE DIAG		( DATEDEB  IN VARCHAR  DEFAULT TO_CHAR( SYSDATE-7, 'YYYYMMDD HH24:MI' ),
					DATEFIN  IN VARCHAR  DEFAULT TO_CHAR( SYSDATE  , 'YYYYMMDD HH24:MI' ),
					LSTMODE IN VARCHAR  DEFAULT 'NORM', PRECO  IN VARCHAR  DEFAULT 'Y' , COEFVAL  IN NUMBER  DEFAULT 3,
					SEUIL_MINI  IN NUMBER  DEFAULT NULL, INSTANCE IN NUMBER  DEFAULT 1,
					TYPEREST IN VARCHAR DEFAULT 'NORME', DEGRAD IN VARCHAR DEFAULT 'N' );
										
	PROCEDURE SUIVI_IO_PROC	( DATEDEB IN VARCHAR, DATEFIN  IN VARCHAR, LSTMODE  IN VARCHAR  DEFAULT 'CSV',
					FORMAT_DATE_SORTIE  IN VARCHAR DEFAULT 'YYYYMMDD HH24:MI', PCT_RDS  IN NUMBER DEFAULT 5,
					PCT_WRI IN NUMBER DEFAULT 5, TABLESPACE  IN VARCHAR DEFAULT 'Null',
					DATAFILE IN VARCHAR DEFAULT 'Null', FILEDET IN VARCHAR  DEFAULT 'N',
					INSTANCE IN NUMBER DEFAULT 1, ZOOM  IN VARCHAR DEFAULT NULL );
	PROCEDURE SUIVI_IO	(  DATEDEB  IN VARCHAR DEFAULT NULL, DATEFIN  IN VARCHAR DEFAULT NULL, LSTMODE  IN VARCHAR DEFAULT 'CSV',
					FORMAT_DATE_SORTIE  IN VARCHAR DEFAULT 'YYYYMMDD HH24:MI', PCT_RDS  IN NUMBER DEFAULT 5,
					PCT_WRI  IN NUMBER DEFAULT 5, TABLESPACE  IN VARCHAR DEFAULT 'Null',
					DATAFILE IN VARCHAR DEFAULT 'Null', FILEDET IN VARCHAR  DEFAULT 'N',
					INSTANCE IN NUMBER DEFAULT 1, ZOOM  IN VARCHAR DEFAULT NULL );
	PROCEDURE TOPSQL	( DATEDEB IN VARCHAR	DEFAULT NULL, DATEFIN IN VARCHAR DEFAULT NULL, LSTMODE IN VARCHAR DEFAULT 'CSV',
					PARAM IN VARCHAR DEFAULT 'DISK_READS', TOP IN NUMBER DEFAULT 5, SHOWSQL IN VARCHAR DEFAULT 'N',
					EXPLAINP IN VARCHAR DEFAULT 'N', INSTANCE IN NUMBER DEFAULT NULL,
					FILTRE IN VARCHAR DEFAULT NULL, MODULE IN VARCHAR DEFAULT NULL, HASHVALUE IN NUMBER DEFAULT NULL,
					PLANSTAT IN VARCHAR DEFAULT 'N', ZOOM IN VARCHAR DEFAULT NULL);
	PROCEDURE TOPSQL_PROC	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV', PARAM IN VARCHAR,
					TOP IN NUMBER 	DEFAULT 5, SHOWSQL IN VARCHAR  DEFAULT 'N', EXPLAINP IN VARCHAR DEFAULT 'N',
					INSTANCE IN NUMBER  DEFAULT NULL, FILTRE IN VARCHAR DEFAULT NULL, MODULE IN VARCHAR DEFAULT NULL,
					HASHVALUE IN NUMBER DEFAULT NULL, PLANSTAT IN VARCHAR DEFAULT 'N', ZOOM IN VARCHAR DEFAULT NULL  );
	FUNCTION CHKSTAT_EVAL	( TAB1 IN VARCHAR DEFAULT NULL, TAB2 IN VARCHAR DEFAULT NULL, TAB3 IN VARCHAR DEFAULT NULL,
					TAB4 IN VARCHAR DEFAULT NULL, TAB5 IN VARCHAR DEFAULT NULL ) RETURN NUMBER;
	PROCEDURE CHKSTAT	( TAB1 IN VARCHAR DEFAULT NULL, TAB2 IN VARCHAR DEFAULT NULL, TAB3 IN VARCHAR DEFAULT NULL,
					TAB4 IN VARCHAR DEFAULT NULL, TAB5 IN VARCHAR DEFAULT NULL );
	PROCEDURE SUIVISQL	( DATEDEB IN VARCHAR DEFAULT NULL, DATEFIN IN VARCHAR DEFAULT NULL, LSTMODE IN VARCHAR  DEFAULT 'CSV',
					HASHVALUE IN NUMBER DEFAULT NULL, PARAM IN VARCHAR DEFAULT 'DISK_READS',
					SHOWSQL IN VARCHAR  DEFAULT 'N', EXPLAINP IN VARCHAR  DEFAULT 'N', INSTANCE IN NUMBER DEFAULT 1,
					MODULE IN VARCHAR DEFAULT NULL, SPLAN IN VARCHAR  DEFAULT 'N' );
	PROCEDURE SUIVISQL_PROC	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV', HASHVALUE IN NUMBER DEFAULT NULL,
					PARAM IN VARCHAR, SHOWSQL IN VARCHAR  DEFAULT 'N', EXPLAINP IN VARCHAR  DEFAULT 'N',
					INSTANCE IN NUMBER DEFAULT NULL, MODULE IN VARCHAR DEFAULT NULL, SPLAN IN VARCHAR  DEFAULT 'N' );
	PROCEDURE TOPMODULE_PROC ( DATEDEB IN VARCHAR DEFAULT NULL, DATEFIN IN VARCHAR DEFAULT NULL, LSTMODE IN VARCHAR  DEFAULT 'CSV',
					PARAM IN VARCHAR DEFAULT 'DISK_READS', INSTANCE IN NUMBER DEFAULT 1, MODULE IN VARCHAR DEFAULT NULL );
	PROCEDURE TOPMODULE	( DATEDEB IN VARCHAR DEFAULT NULL, DATEFIN IN VARCHAR DEFAULT NULL, LSTMODE IN VARCHAR  DEFAULT 'CSV',
				PARAM IN VARCHAR DEFAULT 'DISK_READS', INSTANCE IN NUMBER DEFAULT 1, MODULE IN VARCHAR DEFAULT NULL  );
	PROCEDURE MTOPSQL_PROC  ( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE VARCHAR  DEFAULT 'CSV', TOP IN NUMBER DEFAULT 5,
					PCT_MIN IN NUMBER DEFAULT 5, SHOWSQL VARCHAR  DEFAULT 'N', EXPLAINP VARCHAR  DEFAULT 'N',
					INSTANCE IN NUMBER DEFAULT NULL, MODULE IN VARCHAR DEFAULT NULL, HASHVALUE IN NUMBER DEFAULT NULL,
					SCOPE IN VARCHAR DEFAULT 'ALL', PLANSTAT IN VARCHAR DEFAULT 'N', DETAILS IN VARCHAR DEFAULT 'Y',
					ZOOM IN VARCHAR DEFAULT NULL, FIXED_SCHEMA IN VARCHAR DEFAULT NULL );
	PROCEDURE MTOPSQL	( DATEDEB VARCHAR DEFAULT NULL, DATEFIN VARCHAR  DEFAULT NULL, LSTMODE VARCHAR  DEFAULT 'CSV',
					TOP NUMBER  DEFAULT 5, PCT_MIN IN NUMBER DEFAULT 5, SHOWSQL VARCHAR  DEFAULT 'N',
					EXPLAINP VARCHAR  DEFAULT 'N', INSTANCE NUMBER DEFAULT NULL, MODULE IN VARCHAR DEFAULT NULL,
					HASHVALUE IN NUMBER DEFAULT NULL, SCOPE IN VARCHAR DEFAULT 'ALL', PLANSTAT IN VARCHAR DEFAULT 'N',
					DETAILS IN VARCHAR DEFAULT 'Y' , ZOOM IN VARCHAR DEFAULT NULL, FIXED_SCHEMA IN VARCHAR DEFAULT NULL );
	PROCEDURE PROFILE_PROC	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV',
					FORMAT_DATE IN VARCHAR  DEFAULT 'YYYYMMDD HH24:MI', INSTANCE  IN NUMBER DEFAULT NULL,
					TYPEREST IN VARCHAR DEFAULT 'NORME', PARAM1 IN VARCHAR DEFAULT NULL, PARAM2 IN VARCHAR DEFAULT NULL,
					PARAM3 IN VARCHAR DEFAULT NULL, PARAM4 IN VARCHAR DEFAULT NULL,
					PARAM5 IN VARCHAR DEFAULT NULL, ZOOM IN VARCHAR DEFAULT NULL );
	PROCEDURE PROFILE	( DATEDEB IN VARCHAR DEFAULT NULL, DATEFIN IN VARCHAR DEFAULT NULL, LSTMODE IN VARCHAR DEFAULT 'CSV',
					FORMAT_DATE IN VARCHAR  DEFAULT 'YYYYMMDD HH24:MI', INSTANCE  IN NUMBER DEFAULT NULL,
					TYPEREST IN VARCHAR DEFAULT 'NORME', P1 IN VARCHAR DEFAULT NULL, P2 IN VARCHAR DEFAULT NULL,
					P3 IN VARCHAR DEFAULT NULL, P4 IN VARCHAR DEFAULT NULL,
					P5 IN VARCHAR DEFAULT NULL, ZOOM IN VARCHAR DEFAULT NULL );
	PROCEDURE PLANSTAT_PROC ( DATEDEB VARCHAR, DATEFIN VARCHAR, HASHVALUE NUMBER, SCOPE VARCHAR  DEFAULT 'PLAN',
					AFFICHE VARCHAR  DEFAULT 'ERR', FIXED_SCHEMA IN VARCHAR DEFAULT NULL );
	PROCEDURE PLANSTAT	( DATEDEB VARCHAR DEFAULT NULL, DATEFIN VARCHAR DEFAULT NULL, HASHVALUE NUMBER DEFAULT NULL,
					SCOPE VARCHAR DEFAULT 'PLAN', AFFICHE VARCHAR DEFAULT 'ERR', FIXED_SCHEMA IN VARCHAR DEFAULT NULL );
	PROCEDURE EVAL_PARAM	( GROUP_VALUE IN VARCHAR DEFAULT NULL, PARAM_VALUE IN VARCHAR DEFAULT NULL, FILTRE IN VARCHAR DEFAULT NULL );
	PROCEDURE SECURITY;
	PROCEDURE FLUXDBA	( DATEDEB VARCHAR, DATEFIN VARCHAR, INSTANCEN NUMBER DEFAULT 1 );
	PROCEDURE PROFIL_IO	( DATEDEB VARCHAR, DATEFIN VARCHAR, INSTANCE NUMBER DEFAULT 1 );
	--- Refonte
	PROCEDURE INFO_PLAN	( DATEDEB VARCHAR, DATEFIN VARCHAR, LSTMODE VARCHAR, IN_INSTANCE_NUMBER NUMBER, IN_HASH_VALUE NUMBER );
	procedure Info_Plan 	(SQL_ID Varchar	DEFAULT Null,PLAN_HASH_VALUE Number DEFAULT Null,HASH_VALUE Number DEFAULT Null);
	
	FUNCTION CHECKVAL		( DROIT VARCHAR, LSTMODE VARCHAR DEFAULT 'CSV' ) RETURN DATE;
	FUNCTION INFO_CARTO 	( WEVENT VARCHAR, PARAM IN VARCHAR DEFAULT 'RUBRIQUE', IDLE	VARCHAR DEFAULT 'N' ) RETURN VARCHAR;
	FUNCTION XLS_VAL( VALEUR IN VARCHAR ) RETURN VARCHAR;
	FUNCTION AAS			( DATE_INFO VARCHAR DEFAULT NULL, INST_NUMBER NUMBER DEFAULT 1 )  RETURN NUMBER;
	
	procedure MODIFY_AROPLAN 	(SQL_ID Varchar,PLAN_HASH_VALUE Number,STATUS Varchar,COMMENT Varchar DEFAULT Null);
	procedure INSERT_PLAN_ARO 	(SQL_ID Varchar,PLAN_HASH_VALUE	Number);
	procedure SYNCHRO_PLAN_ARO	(SYNCHRO_TYPE	Varchar DEFAULT 'STATSPACK' );
	procedure Check_ARO_Plan 	(DATEDEB IN varchar, DATEFIN IN varchar,LSTMODE IN varchar 	DEFAULT 'CSV',PARAM		IN varchar DEFAULT 'DISK_READS',TOP IN NUMBER 	DEFAULT 20,ShowSQL IN Varchar 	Default 'N',ExplainP IN Varchar Default 'N', INSTANCE	IN NUMBER	DEFAULT Null,FILTRE		IN VARCHAR	DEFAULT Null,MODULE		IN VARCHAR	DEFAULT Null,HASHVALUE	IN NUMBER	DEFAULT Null,PLANSTAT IN VARCHAR	DEFAULT 'N',ZOOM IN VARCHAR	DEFAULT Null,PCT_MIN IN NUMBER 	DEFAULT 1,AUTO IN VARCHAR	DEFAULT 'N');
	procedure SUIVI_PLAN_ARO;
	procedure AUTODIAGSQL
	(	DATEDEB		Varchar 	DEFAULT Null,
		DATEFIN		Varchar 	DEFAULT Null,
		PARAM		Varchar 	DEFAULT 'OAR',
		TOP		Number 		DEFAULT 100,
		ZOOM		Varchar 	DEFAULT NULL,
		PCT_MIN		Number 		DEFAULT 1,
		AUTO		Varchar		DEFAULT 'N' 	);
		
Procedure DiagSQL
	(	DATEDEB		Varchar 	DEFAULT Null,
		DATEFIN		Varchar 	DEFAULT Null,
		PARAM		Varchar 	DEFAULT 'ARO',
		TOP		Number 		DEFAULT 100,
		ZOOM		Varchar 	DEFAULT NULL,
		PCT_MIN		Number 		DEFAULT 1,
		AUTO		Varchar		DEFAULT 'N' 	);	
END;
/

create or replace PACKAGE BODY                     perfstat."PKG_STATS"  AS
---------------------------------------------------------------------------------------------------------------------
function CHKSTAT_EVAL ( Tab1 IN VARCHAR	DEFAULT Null, Tab2 IN VARCHAR DEFAULT Null, Tab3 IN VARCHAR DEFAULT Null,
			Tab4 IN VARCHAR DEFAULT Null, Tab5 IN VARCHAR DEFAULT Null ) RETURN NUMBER
IS	TYPE Element IS RECORD	( TABLE_NAME 	VARCHAR( 50 ),	  STATUS	VARCHAR( 10 ),	  LASTD		DATE	);
	Type 	Matrice IS TABLE OF Element index by binary_integer;
	TABLE_LISTE 	Matrice;	w_OK 	Number;		imax	Number;	i	Number;	TXT	Varchar( 1000 );
BEGIN	TABLE_LISTE(1).TABLE_NAME := Tab1;	TABLE_LISTE(2).TABLE_NAME := Tab2;	TABLE_LISTE(3).TABLE_NAME := Tab3;
	TABLE_LISTE(4).TABLE_NAME := Tab4;	TABLE_LISTE(5).TABLE_NAME := Tab5;
	-- Recherche du nombre de tables concerne
	If Tab1 is not NULL THEN imax := 1; If Tab2 is not NULL THEN imax := 2;  If Tab3 is not NULL THEN imax := 3;
	If Tab4 is not NULL THEN imax := 4; If Tab5 is not NULL THEN imax := 5;	END IF;	END IF;	END IF;	END IF; END IF;
		i := 1;	w_OK := 0;
		while i <= imax LOOP
			select 	last_analyzed 	INTO 	TABLE_LISTE(i).LASTD	from 	dba_tables
			where 	owner IN ('PERFSTAT', 'ORAPATROL') AND 	TABLE_NAME= TABLE_LISTE(i).TABLE_NAME;
			IF TABLE_LISTE(i).LASTD Is Null THEN 			w_OK := w_OK + 1 ;
			ELSIF ( sysdate - TABLE_LISTE(i).LASTD ) > 30 THEN	w_OK := w_OK + 1 ;	END IF;
			i := i + 1;
		END LOOP;
		RETURN ( w_OK );
END;
---------------------------------------------------------------------------------------------------------------------
function CheckVal ( Droit Varchar, LSTMODE Varchar DEFAULT 'CSV' ) Return date
IS	TYPE ElementD IS RECORD ( MODULE Varchar( 10 ), VALEUR Number, DROIT Varchar( 100 ) );
	Type 	MatriceDr IS TABLE OF ElementD index by binary_integer ;
	MatriceD 	MatriceDr;	i		Number;		jmax		Number;
	jmin		Number;		wValeur		Number;		PAS		Number;
	TXT		Varchar( 500 );	OKARO		Varchar( 50 );	LASTDATE	DATE;
	LASTDATE_DT	DATE;		wString		Varchar( 50 );	wCODE		Varchar( 50 );
	wFIN		Varchar( 50 );	YearARO		Varchar( 50 );	wDEBUG		Number;
BEGIN	dbms_output.enable( 100000000 );
	LASTDATE 	:= to_date( '31' || '12' || '2' || '0' || '5' || '1', 'DDMMYYYY' );
	LASTDATE_DT 	:= to_date( '01' || '07' || '2' || '0' || '5' || '1', 'DDMMYYYY' );
	wDEBUG		:= 0;
	TXT		:= Null;
	IF LSTMODE like 'EXTRACT%' THEN	RETURN( Null ) ;	ELSE
		TXT := 'DT';
		IF TXT Is NULL THEN TXT := 'T0143P-T1904F'; END IF;
		IF TXT = OKARO
		THEN

			RETURN( LASTDATE_DT ) ;
		ELSE
			RETURN( LASTDATE );
		END IF;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
function version Return Varchar	is Begin Return( 'v3.1' ); End;
---------------------------------------------------------------------------------------------------------------------
Procedure Rubrique_Proc		( DATEDEB VARCHAR, DATEFIN VARCHAR, LSTMODE VARCHAR DEFAULT 'CSV', FORMAT_DATE_SORTIE VARCHAR DEFAULT 'YYYY/MM/DD',
				PRECO VARCHAR	DEFAULT 'Y', INSTANCE NUMBER DEFAULT null, PRECISION NumBER DEFAULT 3, TYPEREST VARCHAR DEFAULT 'NORME',
				IDLE VARCHAR DEFAULT 'N', ZOOM IN VARCHAR DEFAULT Null )
IS	DATEDEB_		Varchar( 30 );		SQL_Dyn		Varchar( 20000 );	SQL_Dyn2	Varchar( 20000 );
	SQL_Dyn3		Varchar( 20000 );	SQL_Dyn4	Varchar( 20000 );	TYPE 		DataSource IS REF CURSOR;
	Src 			DataSource ;		Src2 		DataSource ;		wstime		Varchar( 25 );
	winstance_number	Number;			wSNAP_ID	Number;			wEVENT		Varchar( 100 );
	wRUB			Varchar( 25 );		wSRUB		Varchar( 50 );		wTIME_WAITED_MICRO 	Number;
	wConso			Number;			wTIME_MINI	 Number;		wTOTAL_TIME	Number;
	wDELTA			Number;			wVERSION 	Varchar( 50 );		oVersion	Number;
	wcpu			Number;			wWaits		Number;			wDisk_IO	Number;
	wLatency		Number;			i		Number;			j		Number;
	imax			Number;			wp_RUB		Number;			wChaine		Varchar( 10000 );
	wChaine2		Varchar( 1000 );	wSNAP_Time	Varchar( 20 );		wCOL		Varchar( 20 );
	wDiv			Varchar( 20 );
	TYPE ElementRECAP IS RECORD	( INSTANCE_NUMBER Number, RUB Varchar( 100 ), SRUB Varchar( 100 ),
		EVENT varchar( 64 ), TIME_WAITED_MICRO Number, ratioRUB Number, ratioSRUB Number,
		ratio Number, p_RUB Number, p_Srub Number, TOTAL Number	);
	Type 	MatriceRECAP IS TABLE OF ElementRECAP index by binary_integer ;
	ALL_DATA_RECAP 	MatriceRECAP;	wDEBUG		NUMBER;		wEXTRACT	Varchar( 100 );	P1		Number;
	P2		Number;		P3		Number;		P4		Number;		k		Number;
	wCAT		Varchar( 50 );	INDIC_AAS 	Number;		TXT		Varchar(1000);  ELight		Number;
	wDateLimit	DATE;		HMIN		Varchar( 25 );	HMAX		Varchar( 25 );	wINSTANCE_NAME 	Varchar( 50 );
	wHOST_NAME    	Varchar( 50 );	wSnap_timePREC	Varchar( 50 );
BEGIN	dbms_output.enable( 10000000 );
	wTOTAL_TIME := 0;	wDEBUG := 9;	wSnap_timePREC := 'xxxxx' ;
	select perfstat.PKG_STATS.CheckVal('RUBRIQUE', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN 	dbms_output.put_line(' Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; END IF;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	select INSTANCE_NAME , HOST_NAME  INTO	wINSTANCE_NAME , wHOST_NAME   from v$instance;
	SELECT	to_char( max( snap_time ) , 'YYYYMMDD HH24:MI' ) INTO DATEDEB_  FROM 	STATS$SNAPSHOT
	WHERE	snap_time < to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) AND	(INSTANCE_NUMBER = INSTANCE OR INSTANCE Is null );
	----------------------------------------------------------------------
	SELECT	count(*) INTO i FROM 	STATS$SNAPSHOT	WHERE	snap_time >= to_date( DATEDEB, 'YYYYMMDD HH24:MI' )
	AND	snap_time <= to_date( DATEFIN, 'YYYYMMDD HH24:MI' )  AND (INSTANCE_NUMBER = INSTANCE OR INSTANCE Is null );
	if i = 0 THEN GOTO FIN; END IF;
	----------------------------------------------------------------------
	IF DATEDEB_ Is Null THEN	SELECT	to_char( MIN( snap_time ) , 'YYYYMMDD HH24:MI' )
		INTO DATEDEB_	FROM 	STATS$SNAPSHOT	WHERE	(INSTANCE_NUMBER = INSTANCE OR INSTANCE Is null );	END IF;
	IF Oversion = 8 THEN	wCOL := 'TIME_WAITED';			wDiv := '1000';
	ELSE	wCOL := 'TIME_WAITED_MICRO';		wDiv := '1000000';	END IF;
	SELECT PERFSTAT.PKG_STATS.Version INTO wVERSION FRom Dual;
	IF LSTMODE NOT LIKE 'EXTRACT%' AND LSTMODE  NOT IN ( 'TQ', 'TU1' ) THEN
		dbms_output.put_line( '  /---------------------------------------------------+' );
		dbms_output.put_line( wVERSION || '/    Analyseur du temps de service                   |' );
		dbms_output.put_line( '___/                                                     |' );
		dbms_output.put_line( Rpad( '| /          Tuning : ' || wVERSION, 57) || '|' );
		dbms_output.put_line( '|/-------------------------------------------------------+' );
		dbms_output.put_line( '/ Colonnes 1 ? (Unite temps cumule en S par S)         |' );
		dbms_output.put_line( '+- - - - - - - - - - - - - - - - - - - - - - - - - - - - +' );
		dbms_output.put_line( '| Date         Inst      1       2       3       4       |' );
		dbms_output.put_line( '| Cliche                CPU    WAITS    I/O  Latency     |' );
		dbms_output.put_line( '+--------------------------------------------------------+' );
		dbms_output.put_line( 'Cliche;Instance;CPU;WAITS;I/O;Latency;Ratio_AAs' );
		wEXTRACT := '';
	ELSE	select 'TU1;' || INSTANCE_NAME || ';' || HOST_NAME    || ';'   INTO	wEXTRACT from v$instance;	END IF;
	SQL_Dyn3 := ' select to_char( snap_time, ''YYYYMMDD HH24:MI'' ) stime, instance_number, ';
	SQL_Dyn3 := SQL_Dyn3 || ' sum( DECODE( RUB, ''CPU'',     CALC, 0 ) ) pcpu,  ';
	SQL_Dyn3 := SQL_Dyn3 || ' sum( DECODE( RUB, ''WAITS'',   CALC, 0 ) ) pWaits, ';
	SQL_Dyn3 := SQL_Dyn3 || ' sum( DECODE( RUB, ''DISK_IO'', CALC, 0 ) ) pDisk_IO, ';
	SQL_Dyn3 := SQL_Dyn3 || ' sum( DECODE( RUB, ''LATENCY'', CALC, 0 ) ) pLatency ';
	SQL_Dyn3 := SQL_Dyn3 || ' from ( select ss.snap_time, sq.instance_number, sq.SNAP_ID, EVENT, ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''RUBRIQUE'' )  RUB,  ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''SRUBRIQUE'' )  SRUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' CASE WHEN ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),  ss.SNAP_TIME, ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  ss.SNAP_TIME)*86400 ) = 0 ';
	SQL_Dyn3 := SQL_Dyn3 || ' THEN Null ELSE ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(sq.' || wCOL || ', lag(sq.' || wCOL || ', 1, sq.' || wCOL || ') ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)), ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.' || wCOL || ',  sq.' || wCOL || ' - lag(sq.' || wCOL || ', 1, sq.' || wCOL || ')  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  sq.' || wCOL || ')/' || wDiv || ' )/ ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),  ss.SNAP_TIME, ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  ss.SNAP_TIME)*86400 ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' END calc ';
	SQL_Dyn3 := SQL_Dyn3 || ' from stats$system_event sq, stats$snapshot ss ';
	SQL_Dyn3 := SQL_Dyn3 || ' where ss.snap_time between to_date( ''' || DATEDEB_ || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	sq.dbid = ss.dbid ';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	sq.instance_number = ss.instance_number ';
	IF INSTANCE IS NOT NULL THEN	SQL_Dyn3 := SQL_Dyn3 || ' ANd  sq.instance_number = ' || INSTANCE ;	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' and 	sq.snap_id = ss.snap_id ';
	SQL_Dyn3 := SQL_Dyn3 || ' UNION SELECT ss.snap_time, sq.INSTANCE_NUMBER, sq.SNAP_ID, NAME EVENT, ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''RUBRIQUE'' ) RUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''SRUBRIQUE'' )  SRUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' CASE WHEN ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)),  ss.SNAP_TIME, ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id),  ss.SNAP_TIME)*86400 ) = 0 ';
	SQL_Dyn3 := SQL_Dyn3 || ' THEN Null ELSE ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)), ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.VALUE,  sq.VALUE - lag(sq.VALUE,  1, sq.VALUE) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id),  sq.VALUE)/100 )/ ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)),  ss.SNAP_TIME, ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id),  ss.SNAP_TIME)*86400 ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' END calc ';
	SQL_Dyn3 := SQL_Dyn3 || ' from perfstat.stats$sysstat sq, stats$snapshot ss ';
	SQL_Dyn3 := SQL_Dyn3 || ' where sq.NAME in ( ''CPU used by this session'', ''parse time cpu'', ''recursive cpu usage'' )   ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.dbid = ss.dbid ';
	IF INSTANCE IS NOT NULL THEN	SQL_Dyn3 := SQL_Dyn3 || ' ANd  sq.instance_number = ' || INSTANCE ;	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.instance_number = ss.instance_number ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.snap_id = ss.snap_id ';
	SQL_Dyn3 := SQL_Dyn3 || ' and ss.snap_time between to_date( ''' || DATEDEB_ || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' ) ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn3 :=  SQL_Dyn3 || ' where to_char( snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn3 :=  SQL_Dyn3 || ' and to_char( snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' group by snap_time, instance_number ';
	SQL_Dyn3 := SQL_Dyn3 || ' order by instance_number, snap_time ';
	IF wDEBUG = 1 OR wDEBUG = 9 THEN
		dbms_output.put_line( substr( SQL_Dyn3,   1, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3, 401, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3, 801, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,1001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,1401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,1801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,2201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,2601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,3001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,3401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,3801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,4001, 200 ));	END IF;
	-- Cursor 1
	OPEN Src FOR SQL_Dyn3;
	LOOP 	FETCH Src INTO wstime, winstance_number, wcpu, wWaits, wDisk_IO, wLatency ;	EXIT WHEN Src%NOTFOUND;
		IF LSTMODE = 'TQ' THEN
			select PERFSTAT.PKG_STATS.AAS ( wstime, winstance_number ) INTO INDIC_AAS from dual;
			wSTIME := TO_CHAR( To_date( wSTIME, 'YYYYMMDD HH24:MI' ) , 'MM/DD/YYYY HH24:MI' ) ;
			wChaine := 	'"' || wSTIME || ':00' || '" ' 	|| ' PAS "newtermite" "' || wHOST_NAME	|| '" "' ||
					wINSTANCE_NAME		|| '" ' || chr(10) ||	round( wCPU 	 ,3)	|| ' ' ||
					round( wLATENCY ,3)	|| ' ' || round( wWAITS	 ,3)	|| ' ' ||
					round( wDISK_IO ,3)	|| ' ' || INDIC_AAS		|| ' ' || chr(10);
			IF wCPU>0 AND wLATENCY>0 AND wDISK_IO>0 AND wWAITS>0 THEN  dbms_output.put_line ( wChaine ); END IF;
		ELSIF LSTMODE NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ('TU1') THEN
			IF wstime >= DATEDEB THEN
				wChaine := wstime || '; ' || winstance_number || '; ' ;
				SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wcpu, 	'990.99' ) ) INTO wChaine2 FROM DUAL;
				wChaine := wChaine || wChaine2 	|| '; ' ;
				SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wWaits, 	'990.99' ) ) INTO wChaine2 FROM DUAL;
				wChaine := wChaine || wChaine2 	|| '; ' ;
				SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wDisk_IO, 	'990.99' ) ) INTO wChaine2 FROM DUAL;
				wChaine := wChaine || wChaine2 	|| '; ' ;
				SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wLatency, 	'990.99' ) ) INTO wChaine2 FROM DUAL;
				wChaine := wChaine || wChaine2 	|| '; ' ;
				select PERFSTAT.PKG_STATS.AAS ( wstime, winstance_number ) INTO INDIC_AAS from dual;
				IF INDIC_AAS <0 THEN INDIC_AAS := 0; END IF;
				SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( INDIC_AAS, 	'9990.99' ) ) INTO wChaine2 FROM DUAL;
				wChaine := wChaine || wChaine2 	|| '; ' ;
				IF INDIC_AAS = 0 			THEN	wChaine := wChaine || 'REDEMARRAGE';
				ELSIF INDIC_AAS > .8 AND INDIC_AAS <=1 	THEN	wChaine := wChaine || 'WARNING';
				ELSIF INDIC_AAS >1 			THEN 	wChaine := wChaine || 'INCIDENT';   END IF;
				dbms_output.put_line( wChaine );
			END IF;
		END IF;
	END LOOP;
	Close Src;

	IF LSTMODE NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ( 'TQ', 'TU1' ) THEN
		dbms_output.put_line(
		'+----------------------------------------------------------------------------------------+' );
		dbms_output.put_line(
		'Statistiques de Services du ' || DATEDEB || ' au ' || DATEFIN  );
		dbms_output.put_line(
		'+----+------------------+--------------------+-----------------------------------+------------+------------+------------+' );
		dbms_output.put_line(
		'|Inst| Rubriques       %| Sous-Rubriques    %| Evenements                       %|  Rubrique  | S-Rubrique |    EVENT   |' );
		dbms_output.put_line(
		'+====+==================+====================+===================================+============+============+============+' );
	END IF;
	SQL_Dyn3 := ' select instance_number, RUB, SRUB, EVENT, ' || wCOL || ', ratioRUB, ratioSRUB, ratio ';
	SQL_Dyn3 := SQL_Dyn3 || ' FROM ( select instance_number, ';
	SQL_Dyn3 := SQL_Dyn3 || ' RUB, SRUB, EVENT, sum(' || 	wCOL || ') ' || wCOL || ', ';
	SQL_Dyn3 := SQL_Dyn3 || ' ratio_to_report( sum(' || 	wCOL || ') ) over (partition by instance_number) as ratio, ';
	SQL_Dyn3 := SQL_Dyn3 || ' ratio_to_report( sum(' || 	wCOL || ') ) over (partition by instance_number, RUB) as	ratioRUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' ratio_to_report( sum(' || 	wCOL || ') ) over (partition by instance_number, RUB, SRUB)  as ratioSRUB ';
	SQL_Dyn3 := SQL_Dyn3 || ' from ( select ss.snap_time, sq.instance_number, sq.SNAP_ID, EVENT,  ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''RUBRIQUE'' )  RUB,  ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''SRUBRIQUE'' )  SRUB,  ';
	SQL_Dyn3 := SQL_Dyn3 || ' decode(greatest(sq.' || 	wCOL || ', lag(sq.' || 	wCOL || ', 1, sq.' || 	wCOL || ')    ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),  sq.' || 	wCOL || ',  ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.' || 	wCOL || ' - lag(sq.' || 	wCOL || ', 1, sq.' || 	wCOL || ') ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  sq.' || 	wCOL || ')/' || wDiv || '  ' || wCOL || ',  ';
	SQL_Dyn3 := SQL_Dyn3 || ' decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),  ss.SNAP_TIME, ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)   ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  ss.SNAP_TIME)*86400 DELTA ';
	SQL_Dyn3 := SQL_Dyn3 || ' from stats$system_event sq, stats$snapshot ss  ';
	SQL_Dyn3 := SQL_Dyn3 || ' where ss.snap_time between to_date( ''' || DATEDEB_ || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.dbid = ss.dbid and sq.instance_number = ss.instance_number ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.snap_id = ss.snap_id  ';
	IF INSTANCE IS NOT NULL THEN	SQL_Dyn3 := SQL_Dyn3 || ' ANd  sq.instance_number = ' || INSTANCE ;	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' UNION ';
	SQL_Dyn3 := SQL_Dyn3 || ' SELECT ss.snap_time, sq.INSTANCE_NUMBER, sq.SNAP_ID, NAME EVENT, ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''RUBRIQUE'' ) RUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''SRUBRIQUE'' )  SRUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE)   ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)), ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.VALUE,  sq.VALUE - lag(sq.VALUE, 1, sq.VALUE)  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id),  sq.VALUE)/100 ' || 	wCOL || ',';
	SQL_Dyn3 := SQL_Dyn3 || ' decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)),  ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)   ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id),  ss.SNAP_TIME)*86400 DELTA ';
	SQL_Dyn3 := SQL_Dyn3 || ' from	perfstat.stats$sysstat sq, stats$snapshot ss  ';
	SQL_Dyn3 := SQL_Dyn3 || ' where	sq.NAME in ( ''CPU used by this session'', ''parse time cpu'', ''recursive cpu usage'' )';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	sq.dbid = ss.dbid ';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	sq.instance_number = ss.instance_number ';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	sq.snap_id = ss.snap_id ';
	SQL_Dyn3 := SQL_Dyn3 || ' AND ss.snap_time between to_date( ''' || DATEDEB_ || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	IF INSTANCE IS NOT NULL THEN	SQL_Dyn3 := SQL_Dyn3 || ' ANd  sq.instance_number = ' || INSTANCE ;	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' )';
	IF IDLE = 'N' 	THEN	SQL_Dyn3 := SQL_Dyn3 || ' WHERE	RUB!= ''HORS PERIMETRE'' ';
	ELSE	SQL_Dyn3 := SQL_Dyn3 || ' WHERE	RUB = ''HORS PERIMETRE'' ';	END IF;
	IF ZOOM Is NOT Null THEN	SQL_Dyn3 :=  SQL_Dyn3 || ' and to_char( snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn3 :=  SQL_Dyn3 || ' and to_char( snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' group by instance_number, RUB, SRUB, EVENT ';
	SQL_Dyn3 := SQL_Dyn3 || ' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' order by RUB asc, SRUB asc, ' || wCOL || ' desc ' ;
	IF wDEBUG = 2 OR wDEBUG = 9 THEN
		dbms_output.put_line( substr( SQL_Dyn3,   1, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3, 401, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3, 801, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,1001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,1401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,1801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,2201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,2601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,3001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,3401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,3801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn3,4001, 200 ));	END IF;

	-- Cursor 2
	open Src FOR SQL_Dyn3;	i := 1;
	LOOP 	FETCH Src INTO 	ALL_DATA_RECAP(i).INSTANCE_NUMBER, ALL_DATA_RECAP(i).RUB, ALL_DATA_RECAP(i).SRUB, ALL_DATA_RECAP(i).EVENT,
			ALL_DATA_RECAP(i).TIME_WAITED_MICRO, ALL_DATA_RECAP(i).ratioRUB, ALL_DATA_RECAP(i).ratioSRUB, ALL_DATA_RECAP(i).ratio;
		EXIT WHEN Src%NOTFOUND;
		IF ALL_DATA_RECAP(i).RUB ='HORS PERIMETRE' 	THEN ALL_DATA_RECAP(i).RUB  := 'IDLE';	END IF;
		IF ALL_DATA_RECAP(i).SRUB ='HORS PERIMETRE'	THEN ALL_DATA_RECAP(i).SRUB := 'MISC';	END IF;
		i := i + 1;
	END LOOP;
	Close Src;	imax := i;	wp_RUB := 0;	i := 1;
	while i < imax
	LOOP	ALL_DATA_RECAP(i).p_RUB  := 0;	ALL_DATA_RECAP(i).TOTAL  := 0;	ALL_DATA_RECAP(i).p_SRUB := 0;
			j := 1;
			while j < imax		LOOP
				--------------------------------------------------------------------------------------------------
				IF  	ALL_DATA_RECAP(i).INSTANCE_NUMBER = ALL_DATA_RECAP(j).INSTANCE_NUMBER
				THEN	ALL_DATA_RECAP(i).TOTAL := ALL_DATA_RECAP(i).TOTAL + ALL_DATA_RECAP(j).TIME_WAITED_MICRO;
				END IF;
				IF  	ALL_DATA_RECAP(i).INSTANCE_NUMBER = ALL_DATA_RECAP(j).INSTANCE_NUMBER
				AND	ALL_DATA_RECAP(i).RUB		  = ALL_DATA_RECAP(j).RUB
				THEN	ALL_DATA_RECAP(i).p_RUB := ALL_DATA_RECAP(i).p_RUB + ALL_DATA_RECAP(j).TIME_WAITED_MICRO;
				END IF;
				IF  	ALL_DATA_RECAP(i).INSTANCE_NUMBER = ALL_DATA_RECAP(j).INSTANCE_NUMBER
				AND	ALL_DATA_RECAP(i).RUB		  = ALL_DATA_RECAP(j).RUB
				AND	ALL_DATA_RECAP(i).SRUB 	          = ALL_DATA_RECAP(j).SRUB
				THEN	ALL_DATA_RECAP(i).p_sRUB := ALL_DATA_RECAP(i).p_sRUB + ALL_DATA_RECAP(j).TIME_WAITED_MICRO;
				END IF;
				--------------------------------------------------------------------------------------------------
				j := j + 1;
			END LOOP;
		i := i + 1;
	END LOOP;

	k := 0;
	i := 1;
	while i < imax
	LOOP
		if i >= 2 THEN
			IF ALL_DATA_RECAP(i).INSTANCE_NUMBER = ALL_DATA_RECAP(i-1).INSTANCE_NUMBER
			THEN	wChaine	:= '|    | ';
			ELSE	wChaine	:= '|' || to_char( ALL_DATA_RECAP(i).INSTANCE_NUMBER , '99' )	|| ' | ' ;	END IF;
		ELSE	wChaine	:= '|' || to_char( ALL_DATA_RECAP(i).INSTANCE_NUMBER , '99' )	|| ' | ' ;		END IF;
		----------------------------------------------------------------------------------------------------------------------------
		if i >= 2 THEN
			IF ALL_DATA_RECAP(i).RUB = ALL_DATA_RECAP(i-1).RUB THEN
				if k != 0	THEN	IF ALL_DATA_RECAP(i).RUB = ALL_DATA_RECAP(k).RUB
					THEN	wChaine	:= wChaine || '                 | ';
					ELSE	wChaine	:= wChaine || 	RPAD( ALL_DATA_RECAP(i).RUB, 12 ) ||
						TO_char( 100*ALL_DATA_RECAP(i).p_RUB/ALL_DATA_RECAP(i).TOTAL, '999' ) || '%| ' ;
					END IF;
				ELSE	wChaine	:= wChaine || 	RPAD( ALL_DATA_RECAP(i).RUB, 12 ) ||
					TO_char( 100*ALL_DATA_RECAP(i).p_RUB/ALL_DATA_RECAP(i).TOTAL, '999' ) || '%| ' ;
				END IF;
			ELSE	wChaine	:= wChaine || 	RPAD( ALL_DATA_RECAP(i).RUB, 12 ) ||
				TO_char( 100*ALL_DATA_RECAP(i).p_RUB/ALL_DATA_RECAP(i).TOTAL, '999' ) || '%| ' ;
				p4 := 100*(ALL_DATA_RECAP(i).p_RUB/ALL_DATA_RECAP(i).TOTAL) ;
			END IF;
		ELSE	wChaine	:= wChaine ||  RPAD( ALL_DATA_RECAP(i).RUB, 12 ) ||
				TO_char( 100*ALL_DATA_RECAP(i).p_RUB/ALL_DATA_RECAP(i).TOTAL, '999' ) || '%| ' ;	END IF;
		----------------------------------------------------------------------------------------------------------------------------
		if i >= 2 THEN
			IF ALL_DATA_RECAP(i).sRUB = ALL_DATA_RECAP(i-1).sRUB
			THEN	wChaine	:= wChaine || '                   |';
			ELSE	P1 := 100* ALL_DATA_RECAP(i).P_sRUB / ALL_DATA_RECAP(i).P_RUB;
				wChaine	:= wChaine || RPAD( ALL_DATA_RECAP(i).SRUB, 14 )  || to_char( P1 , '999' ) || '%|' ;
			END IF;
		ELSE
			P2 := 100* ALL_DATA_RECAP(i).P_sRUB / ALL_DATA_RECAP(i).P_RUB;
			wChaine	:= wChaine || RPAD( ALL_DATA_RECAP(i).SRUB, 14 )  || to_char( P2 , '999' ) || '%|' ;
		END IF;

		IF ALL_DATA_RECAP(i).P_sRUB != 0
		THEN	P3 := 100*ALL_DATA_RECAP(i).TIME_WAITED_MICRO/ALL_DATA_RECAP(i).P_sRUB;
		ELSE	P3 := 0;	END IF;
		wChaine	:= wChaine || RPAD( ALL_DATA_RECAP(i).EVENT, 30 ) || to_char( P3 , '999' )	|| '%| ' ;
		wChaine	:= wChaine || to_char( ALL_DATA_RECAP(i).P_RUB, '999999999' ) 				|| ' | ' ;
		wChaine	:= wChaine || to_char( ALL_DATA_RECAP(i).P_sRUB, '999999999' ) 				|| ' | ' ;
		wChaine	:= wChaine || to_char( round( ALL_DATA_RECAP(i).TIME_WAITED_MICRO ), '999999999' )	|| ' | ' ;
		IF wDEBUG = 2 OR wDEBUG = 9 THEN
 			wChaine	:= wChaine || ' P1=' || round(P1, 2)  || '(P4=' || round(P4, 2)  || ')P3=' || round( P3, 2 )  ;
		END IF;

		IF LSTMODE NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ( 'TQ', 'TU1' ) THEN
			IF IDLE='N' THEN
				IF ALL_DATA_RECAP(i).RUB = 'CPU' OR ( P1 > PRECISION ) THEN
					IF ALL_DATA_RECAP(i).RUB = 'CPU' OR ( P4 > PRECISION ) THEN
						IF ( P3 > PRECISION ) THEN	dbms_output.put_line ( 	wChaine	 ) ;	k := i;
						ELSE	ALL_DATA_RECAP(i).EVENT := Null;	END IF;
					ELSE	ALL_DATA_RECAP(i).EVENT := Null;		END IF;
				ELSE	ALL_DATA_RECAP(i).EVENT := '';				END IF;
			ELSE	IF ( P3 > 0 ) THEN	dbms_output.put_line ( 	wChaine	 ) ;	END IF;
			END IF;
		END IF;
		i := i + 1;
	END LOOP;

	IF LSTMODE NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ( 'TQ', 'TU1' ) THEN
		dbms_output.put_line(
		'+====+==================+====================+===================================+============+============+============+' );
		dbms_output.put_line( 'Donnees Temps de Services du ' || DATEDEB || ' au ' || DATEFIN );
		dbms_output.put_line( '-----------------------------------------------------------+' );
	END IF;
	IF LSTMODE != 'EXTRACT' AND LSTMODE NOT IN ( 'TQ', 'TU1' )  THEN
		dbms_output.put_line( 'Date;Instance;Rubrique;Sous-Rubrique;Evenement;conso/delay;conso' );
	END IF;
	SQL_Dyn3 := ' select	to_char( snap_time, ''' || FORMAT_DATE_SORTIE || ''' ) , instance_number, RUB, SRUB, EVENT, ';
	SQL_Dyn3 := SQL_Dyn3 || ' sum(' || wCOL || ') , sum( CNorm ) CNorm from ( select ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.snap_time, sq.instance_number, sq.SNAP_ID, EVENT,  ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''RUBRIQUE'' )  RUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''SRUBRIQUE'' )  SRUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' decode(greatest(sq.' || wCOL || ', lag(sq.' || wCOL || ', 1, sq.' || wCOL || ') ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),  sq.' || wCOL || ',   ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.' || wCOL || ' - lag(sq.' || wCOL || ', 1, sq.' || wCOL || ') ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  sq.' || wCOL || ')/' || wDiv || ' ' || wCOL || ', ';
	SQL_Dyn3 := SQL_Dyn3 || ' CASE WHEN ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),   ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  ss.SNAP_TIME)*86400 ) = 0 ';
	SQL_Dyn3 := SQL_Dyn3 || ' THEN Null ';
	SQL_Dyn3 := SQL_Dyn3 || ' ELSE ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(sq.' || wCOL || ', lag(sq.' || wCOL || ', 1, sq.' || wCOL || ') ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),  sq.' || wCOL || ',  ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.' || wCOL || ' - lag(sq.' || wCOL || ', 1, sq.' || wCOL || ')  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  sq.' || wCOL || ')/' || wDiv || ' )/ ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)   ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id)),  ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.EVENT order by sq.snap_id),  ss.SNAP_TIME)*86400 ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' END CNorm ';
	SQL_Dyn3 := SQL_Dyn3 || ' from 	stats$system_event sq, stats$snapshot ss ';
	SQL_Dyn3 := SQL_Dyn3 || ' where ss.snap_time between to_date( ''' || DATEDEB_ || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and 	to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.dbid = ss.dbid ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.instance_number = ss.instance_number  ';
	IF INSTANCE IS NOT NULL THEN	SQL_Dyn3 := SQL_Dyn3 || ' ANd  sq.instance_number = ' || INSTANCE ;	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.snap_id = ss.snap_id  ';
	SQL_Dyn3 := SQL_Dyn3 || ' UNION ';
	SQL_Dyn3 := SQL_Dyn3 || ' SELECT 	ss.snap_time,    sq.INSTANCE_NUMBER,     sq.SNAP_ID, NAME EVENT,  ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''RUBRIQUE'' ) RUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''SRUBRIQUE'' )  SRUB, ';
	SQL_Dyn3 := SQL_Dyn3 || ' decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE)   over(partition by sq.NAME order by sq.snap_id)),  ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.VALUE,  sq.VALUE - lag(sq.VALUE, 1, sq.VALUE)   over(partition by sq.NAME order by sq.snap_id),   ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.VALUE)/100 ' || wCOL || ',   ';
	SQL_Dyn3 := SQL_Dyn3 || ' CASE WHEN ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)),  ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id),  ss.SNAP_TIME)*86400 ) = 0 ';
	SQL_Dyn3 := SQL_Dyn3 || ' THEN Null ';
	SQL_Dyn3 := SQL_Dyn3 || ' ELSE ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)),  ';
	SQL_Dyn3 := SQL_Dyn3 || ' sq.VALUE,  sq.VALUE - lag(sq.VALUE, 1, sq.VALUE)   ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id), sq.VALUE)/100 ) / ';
	SQL_Dyn3 := SQL_Dyn3 || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id)), ';
	SQL_Dyn3 := SQL_Dyn3 || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn3 := SQL_Dyn3 || ' over(partition by sq.NAME order by sq.snap_id),  ss.SNAP_TIME)*86400 ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' END CNorm ';
	SQL_Dyn3 := SQL_Dyn3 || ' from 	perfstat.stats$sysstat sq, stats$snapshot ss ';
	SQL_Dyn3 := SQL_Dyn3 || ' where	sq.NAME in ( ''CPU used by this session'', ''parse time cpu'', ''recursive cpu usage'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.dbid = ss.dbid  and  sq.instance_number = ss.instance_number ';
	SQL_Dyn3 := SQL_Dyn3 || ' and sq.snap_id = ss.snap_id ';
	IF INSTANCE IS NOT NULL THEN	SQL_Dyn3 := SQL_Dyn3 || ' ANd  sq.instance_number = ' || INSTANCE ;	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' and ss.snap_time between to_date( ''' || DATEDEB_ || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_Dyn3 := SQL_Dyn3 || ' ) ';
	SQL_Dyn3 := SQL_Dyn3 || ' WHERE ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn3 :=  SQL_Dyn3 || ' to_char( snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn3 :=  SQL_Dyn3 || ' and to_char( snap_time, ''HH24:MI'' ) <= ''' || HMAX || ''' AND ';	END IF;
	SQL_Dyn3 := SQL_Dyn3 || ' EVENT = ''';
	i := 1;
	while i < imax
	LOOP
		IF ALL_DATA_RECAP(i).EVENT Is NOT Null THEN
			SQL_Dyn4 := SQL_Dyn3 || ALL_DATA_RECAP(i).EVENT || '''';
			SQL_Dyn4 := SQL_Dyn4 || ' group by instance_number, to_char( snap_time, ''' ||
				FORMAT_DATE_SORTIE || ''' ) , RUB, SRUB, EVENT order by 1';
			IF wDEBUG = 3 OR wDEBUG = 9 THEN
				dbms_output.put_line( '------------------------------------------------------------------------' );
				dbms_output.put_line( substr( SQL_Dyn4,   1, 200 ));	dbms_output.put_line( substr( SQL_Dyn4, 201, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4, 401, 200 ));	dbms_output.put_line( substr( SQL_Dyn4, 601, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4, 801, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,1001, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,1401, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,1801, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,2201, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,2601, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,3001, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,3401, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn4,3801, 200 ));
				dbms_output.put_line( substr( SQL_Dyn4,4001, 200 ));
				dbms_output.put_line( '------------------------------------------------------------------------' );
			END IF;
			open Src for SQL_Dyn4;
			LOOP	FETCH Src INTO wSnap_time, wINSTANCE_NUMBER, wRUB, wSRUB, wEVENT, wTIME_WAITED_MICRO, wCONSO;
				EXIT WHEN Src%NOTFOUND;
				IF wCONSO > 0 THEN
					IF wTIME_WAITED_MICRO > 0 THEN
						IF LSTMODE= 'TQ' THEN		wChaine := Null;
						ELSIF LSTMODE= 'TU1' THEN
							IF wSnap_time <> wSnap_timePREC THEN	wChaine := '"' ||
								to_char( to_date( wSnap_time , 'YYYYMMDD HH24:MI' ), 'MM/DD/YYYY HH24:MI' ) ||
								'" PAS "newtermite" "' ||
								wHOST_NAME || '" "' || wINSTANCE_NAME		|| '" ' || chr(10);
						   	ELSE	wChaine := ''; END IF;
							wSnap_timePREC := wSnap_time;
							wChaine := wChaine || '"' || wRUB || '" "' || wSRUB || '" "' || wEVENT || '" ' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( round(wCONSO, 2 ) )  ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2 || ' ' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wTIME_WAITED_MICRO ) ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2 || chr(10);
							dbms_output.put_line( wChaine );
						ELSIF LSTMODE= 'EXTRACTXS' THEN
							wChaine :=  wSnap_time || ';' || wINSTANCE_NUMBER || ';' || wEVENT || ';' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( round(wCONSO, 2 ) )  ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2 || ';' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wTIME_WAITED_MICRO ) ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2 || ';' ;
							dbms_output.put_line( wChaine );
						ELSIF LSTMODE= 'EXTRACT' THEN
							wChaine := wSnap_time || ';' || wINSTANCE_NUMBER || ';' || wEVENT || ';' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( round(wCONSO, 2 ) )  ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2 || ';' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wTIME_WAITED_MICRO ) ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2 || ';' ;
							dbms_output.put_line( wEXTRACT || wChaine );
						ELSE	wChaine := wSnap_time || ';' || wINSTANCE_NUMBER || ';' || wRUB || ';' || wSRUB ||
							';' ||  wEVENT || ';' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( round(wCONSO, 2 ) )  ) INTO wChaine2 FROM DUAL;									wChaine := wChaine || wChaine2 || ';' ;
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wTIME_WAITED_MICRO ) ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2 || ';' ;
							dbms_output.put_line( wEXTRACT || wChaine );
						END IF;
					END IF;
				END IF;
			END LOOP;
			Close Src;
		END IF;
		i := i + 1 ;
	END LOOP;

	IF PRECO = 'Y' AND LSTMODE NOT LIKE 'EXTRACT%' AND LSTMODE  NOT IN ( 'TQ', 'TU1' ) THEN
		Dbms_Output.Put_Line(  '+====================================================================================================================+' );
		Dbms_Output.Put_Line('| ' || RPAD( 'Rappel de la commande precedente', 115 ) || '|' );

		Dbms_Output.Put_Line('| ' || RPAD( '  exec PERFSTAT.PKG_STATS.Rubrique( ''' ||
				DATEDEB  || ''', ''' || DATEFIN  || ''', ''' || LSTMODE  || ''', ''' ||
				FORMAT_DATE_SORTIE 	|| ''', ''Y'' ' || ', ' ||
				NVL( To_char( INSTANCE ), 'Null' ) || ', ' ||
				PRECISION || ', ''' || 	TYPEREST || ''', ''' || IDLE || ''')' , 115 ) || '|');
		Dbms_Output.Put_Line('| ' || RPAD( ' ', 115 ) || '|' );
		Dbms_Output.Put_Line('| ' || RPAD( 'Actions conseillees (  Security ACTIVE )', 115 ) || '|' );
		select PERFSTAT.PKG_STATS.CheckVal( 'MTOPSQL' ) into wDateLimit from dual;
		IF wDateLimit > sysdate THEN  Dbms_Output.Put_Line( '| ' || RPAD('  exec PERFSTAT.PKG_STATS.MTopSql  ( ''' ||
			DATEDEB || ''', ''' || DATEFIN || ''', ''CSV'', 10, 10, ''Y'', ''Y'', ' ||
			NVL( To_char( INSTANCE ), 'Null' )  || 	' )', 115) || '|'  );
		END IF;
		select PERFSTAT.PKG_STATS.CheckVal( 'TOPSQL' ) into wDateLimit from dual;
		IF wDateLimit > sysdate THEN  Dbms_Output.Put_Line( '| ' || RPAD('  exec PERFSTAT.PKG_STATS.TopSql  ( ''' ||
			DATEDEB || ''', ''' || DATEFIN || ''', ''CSV'', ''DISK_READS'', 5, ''Y'', ''N'', ' ||
			NVL( To_char( INSTANCE ), 'Null' )  ||  ' )', 115) || '|'  );
		END IF;
		select PERFSTAT.PKG_STATS.CheckVal( 'NQ' ) into wDateLimit from dual;
		IF wDateLimit > sysdate THEN Dbms_Output.Put_Line( '| ' || RPAD('  exec PERFSTAT.PKG_STATS.NQ      ( ''' ||
			DATEDEB || ''', ''' || DATEFIN || ''', ''CSV'', ' ||
			NVL( To_char( INSTANCE ), 'Null' )  || 	' )', 115) || '|'  );
		END IF;
		select PERFSTAT.PKG_STATS.CheckVal( 'SUIVI_IO' ) into wDateLimit from dual;
		IF wDateLimit > sysdate THEN	Dbms_Output.Put_Line( '| ' || RPAD('  exec PERFSTAT.PKG_STATS.suivi_io( ''' ||
			DATEDEB || ''', ''' || DATEFIN || ''', ''CSV''    )', 115) || '|'  );
		END IF;
		select PERFSTAT.PKG_STATS.CheckVal( 'BPS' ) into wDateLimit from dual;
		IF wDateLimit > sysdate THEN  Dbms_Output.Put_Line( '| ' || RPAD('  exec PERFSTAT.PKG_STATS.BPS     ( ''' ||
			DATEDEB || ''', ''' || DATEFIN || ''', ''CSV'', ' || NVL( To_char( INSTANCE ), 'Null' )  || ' )', 115) || '|'  );
		END IF;
		select PERFSTAT.PKG_STATS.CheckVal( 'PGA' ) into wDateLimit from dual;
		IF wDateLimit > sysdate THEN 	Dbms_Output.Put_Line( '| ' || RPAD('  exec PERFSTAT.PKG_STATS.PGA     ( ''' ||
			DATEDEB || ''', ''' || DATEFIN || ''', ''CSV'', ' || NVL( To_char( INSTANCE ), 'Null' )  || ' )', 115) || '|'  );
		END IF;
		select PERFSTAT.PKG_STATS.CheckVal( 'PROFILE' ) into wDateLimit from dual;
		IF wDateLimit > sysdate THEN  Dbms_Output.Put_Line( '| ' || RPAD('  exec PERFSTAT.PKG_STATS.PROFILE ( ''' ||
			DATEDEB || ''', ''' || DATEFIN || ''', ''CSV'', ''YYYYMMDD HH24:MI'', ' ||
			NVL( To_char( INSTANCE ), '1' )  || ', ''NORME'' )', 115) || '|'  );
		END IF;
		SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI') - TO_DATE( DATEDEB , 'YYYYMMDD HH24:MI') INTO i FROM DUAL;
		If i > 1 THEN
			Dbms_Output.Put_Line('| ' || RPAD( '  ' , 115 ) ||  '|');
			Dbms_Output.Put_Line('|   ' ||
				RPAD( 'Reduire la periode d''analyse pour plus de precision(s).', 113 ) || '|' );
		END IF;
		Dbms_Output.Put_Line('| ' || RPAD( '  ' , 115 ) ||  '|');
		Dbms_Output.Put_Line(
		'+====================================================================================================================+' );
	END IF;

	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
Procedure cartouche
Is	wINSTANCE_NUMBER  Number;		wINSTANCE_NAME    Varchar( 50 );	wHOST_NAME        Varchar( 50 );
	wVERSION          Varchar( 50 );	wSTARTUP_TIME     Varchar( 50 );	wSTATUS           Varchar( 50 );
	wPARALLEL         Varchar( 50 );	wTHREAD#          Varchar( 50 );	wARCHIVER         Varchar( 50 );
	wLOGINS           Varchar( 50 );	wSHUTDOWN_PENDING Varchar( 50 );	wDATABASE_STATUS  Varchar( 50 );
	wINSTANCE_ROLE	Varchar( 50 );		wNAME		Varchar( 64 );		wVALUE		Varchar( 512 );
	TYPE 	        DataSource IS REF CURSOR;	Src 	 DataSource ;		NB_Snap		Number;
BEGIN	Dbms_Output.enable ( 10000000 );
	SELECT	INSTANCE_NUMBER, INSTANCE_NAME, HOST_NAME, VERSION, TO_CHAR( STARTUP_TIME, 'DD/MM/YYYY HH24:MI' ),
		STATUS,	PARALLEL, THREAD#, ARCHIVER, LOGINS, SHUTDOWN_PENDING, DATABASE_STATUS, INSTANCE_ROLE
	INTO	wINSTANCE_NUMBER, wINSTANCE_NAME, wHOST_NAME, wVERSION, wSTARTUP_TIME, wSTATUS, wPARALLEL,
		wTHREAD#, wARCHIVER, wLOGINS, wSHUTDOWN_PENDING, wDATABASE_STATUS, wINSTANCE_ROLE
	FROM	v$INSTANCE;
	Dbms_Output.Put_Line('+-----------------------+');
	Dbms_Output.Put_Line('| Parametres Section 1  | ( V$INSTANCE )');
	Dbms_Output.Put_Line('+-----------------------+--------+---------------------------------------+');
	Dbms_Output.Put_Line( RPAD( '|   INSTANCE_NUMBER  ', 33 ) || '| ' || RPAD(  wINSTANCE_NUMBER, 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   INSTANCE_NAME    ', 33 ) || '| ' || RPAD(  wINSTANCE_NAME , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   HOST_NAME        ', 33 ) || '| ' || RPAD(  wHOST_NAME , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   VERSION          ', 33 ) || '| ' || RPAD(  wVERSION , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   STARTUP_TIME     ', 33 ) || '| ' || RPAD(  wSTARTUP_TIME, 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   STATUS           ', 33 ) || '| ' || RPAD(  wSTATUS , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   PARALLEL         ', 33 ) || '| ' || RPAD(  wPARALLEL , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   THREAD#          ', 33 ) || '| ' || RPAD(  wTHREAD# , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   ARCHIVER         ', 33 ) || '| ' || RPAD(  wARCHIVER , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   LOGINS           ', 33 ) || '| ' || RPAD(  wLOGINS , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   SHUTDOWN_PENDING ', 33 ) || '| ' || RPAD(  wSHUTDOWN_PENDING , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   DATABASE_STATUS  ', 33 ) || '| ' || RPAD(  wDATABASE_STATUS , 38) || '|'  );
	Dbms_Output.Put_Line( RPAD( '|   INSTANCE_ROLE    ', 33 ) || '| ' || RPAD(  wINSTANCE_ROLE , 38) || '|'  );
	Dbms_Output.Put_Line('+-----------------------+--------+---------------------------------------+');
	Dbms_Output.Put_Line('| Parametres Section 2  | ( V$PARAMETER )');
	Dbms_Output.Put_Line('+-----------------------+--------+---------------------------------------+');
	OPEN Src FOR select NAME, VALUE from v$parameter
	where NAME IN ( 'undo_tablespace', 'spfile', 'sga_max_size', 'session_cached_cursors',
		'pga_aggregate_target', 'mts_dispatchers', 'log_archive_start', 'db_writer_processes', 'disk_asynch_io',
		'sql_trace', 'sessions', 'compatible', 'db_block_buffers', 'db_cache_size', 'db_block_size',
		'open_cursors', 'processes', 'timed_statistics', 'rollback_segments', 'db_files', 'shared_pool_size',
		'sort_multiblock_read_count', 'optimizer_mode', 'optimizer_features_enable', 'optimizer_index_caching',
		'optimizer_index_cost_adj', 'optimizer_max_permutations', 'optimizer_percent_parallel' )
	AND VALUE Is NOT NULL	order by NAME;

	LOOP	FETCH Src INTO wNAME, wVALUE ;      	EXIT WHEN Src%NOTFOUND;
		dbms_output.Put_Line(  '| ' || RPAD( wNAME , 30 ) ||  ' | ' || RPAD( NVL(wVALUE, ' ') , 38 ) || '|'  );
	END LOOP;	CLOSE Src;
	Dbms_Output.Put_Line('+--------------------------------+---------------------------------------+');

	select count(*)  INTO NB_Snap	FROM	perfstat.stats$snapshot	where	Snap_Time >= trunc( sysdate - 1 )
	AND	Snap_Time <= TO_DATE( TO_CHAR( trunc( sysdate -1 ), 'DDMMYYYY' ) || '12', 'DDMMYYYY HH24' );
	Dbms_Output.Put_Line('Nombre de Snap Hier matin : ' || NB_Snap || ' SnapShots PERFSTAT.' );
	Dbms_Output.Put_Line('Frequence de lancement    : ' || (12*60)/( NB_Snap - 1 ) || ' minutes.' );

Dbms_Output.Put_Line('-------------- --------------------------------------- ---------------------------------------------------------- ------------');
Dbms_Output.Put_Line('Groupe         Parametre                               Valeur                                                     STATUS');
Dbms_Output.Put_Line('-------------- --------------------------------------- ---------------------------------------------------------- ------------');
PERFSTAT.PKG_STATS.EVAL_PARAM( FILTRE=>'OK' );	Dbms_Output.Put_Line(
'-------------- --------------------------------------- ---------------------------------------------------------- ------------');
PERFSTAT.PKG_STATS.EVAL_PARAM( FILTRE=>'KO' );	Dbms_Output.Put_Line(
'-------------- --------------------------------------- ---------------------------------------------------------- ------------');
PERFSTAT.PKG_STATS.EVAL_PARAM( FILTRE=>'N/A' );	Dbms_Output.Put_Line(
'-------------- --------------------------------------- ---------------------------------------------------------- ------------');
END;
---------------------------------------------------------------------------------------------------------------------
Procedure SQL_PLAN 	( wHASH_VALUE IN NUMBER, wEXTRACT IN Varchar DEFAULT Null )
IS	I Number; Ligne Varchar(2000); Dest_SQL_Dyn Varchar(2000); TYPE DataSource IS REF CURSOR; Src DataSource ; wID Number;
	wID_last Number; wDEPTH NUMBER; wOPERATION VARCHAR(500); wOPTIONS VARCHAR(500); wOBJECTS VARCHAR(500); wCARD NUMBER; wCARD2 VARCHAR(10);
	wBYTES NUMBER; wBYTES2 VARCHAR(10); wTEMP NUMBER; wTEMP2 VARCHAR(10); wCOST NUMBER; wCOST2 VARCHAR(10); wOPTIMIZER VARCHAR(100); j Number;
BEGIN	dbms_output.enable(1000000);
	i := 0;	j := 0;	wID_last := -1;	Dest_SQL_Dyn := 'SELECT ID, DEPTH, OPERATION, ';
	Dest_SQL_Dyn := Dest_SQL_Dyn || 'OPTIONS, OBJECT_NAME, ';
	Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL(CARDINALITY, 0 ), NVL( ROUND(BYTES/1024), 0 ), ';
	Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( ROUND(TEMP_SPACE/1024), 0 ), NVL( COST, 0), ';
	Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( OPTIMIZER, '' '' ) ';
	Dest_SQL_Dyn := Dest_SQL_Dyn || ' from V$SQL_PLAN where HASH_VALUE=' || wHASH_VALUE ;
	Dest_SQL_Dyn := Dest_SQL_Dyn || ' order by ID ' ;	OPEN Src FOR Dest_SQL_Dyn;
	LOOP	FETCH Src INTO wID, wDEPTH, wOPERATION, wOPTIONS, wOBJECTS, wCARD, wBYTES, wTEMP, wCOST, wOPTIMIZER;
		EXIT WHEN Src%NOTFOUND;	j := j + 1;
		if wEXTRACT is null AND j = 1 THEN
			dbms_output.put_line ('+-----+--------------------------------+---------------------------+------+' ||
				'------+------+------+---------------------+' );
			dbms_output.put_line ('| Id  | Operation                      |  Object                   | Card |' ||
				' Bytes| Temp | Cost | Optimiser           |' );
			dbms_output.put_line ('+-----+--------------------------------+---------------------------+' ||
				'------+------+------+------+---------------------+' );		END IF;

		-- Calcul des arrondis
		SELECT PKG_STATS.Arrondi(  wCARD ) INTO wCARD2  FROM DUAL;
		SELECT PKG_STATS.Arrondi( wBYTES ) INTO wBYTES2 FROM DUAL;
		SELECT PKG_STATS.Arrondi(  wTEMP ) INTO wTEMP2	 FROM DUAL;
		SELECT PKG_STATS.Arrondi(  wCOST ) INTO wCOST2	 FROM DUAL;
		--------------------------------------------------------------------------------
		IF wID_last != wID THEN
			if wEXTRACT is null
			THEN	DBMS_OUTPUT.PUT_LINE ( '|' || TO_CHAR( wID, '999' )  ||  ' | ' ||
				RPAD( RPAD( ' ' , wDEPTH ) || wOPERATION || ' ' || NVL(wOPTIONS, ' '), 30 ) ||  ' | ' ||
				RPAD( NVL(wOBJECTS, ' '), 25 ) ||  ' |' || RPAD( wCARD2,  5 ) ||  ' |' ||
				RPAD( wBYTES2, 5 ) ||  ' |' || RPAD( wTEMP2,  5 ) ||  ' |' ||
				RPAD( wCOST2,  5 ) ||  ' | ' || RPAD( wOPTIMIZER, 20 ) || '|' );
			else	DBMS_OUTPUT.PUT_LINE ( wEXTRACT || ';' || wHASH_VALUE || ';' ||
				TO_CHAR( wID, '999' )  ||  ';| ' ||
				RPAD( RPAD( ' ' , wDEPTH ) || wOPERATION || ' ' || NVL(wOPTIONS, ' '), 30 ) ||  ' | ' ||
				RPAD( NVL(wOBJECTS, ' '), 25 ) ||  ' |' || RPAD( wCARD2,  5 ) ||  ' |' ||
				RPAD( wBYTES2, 5 ) ||  ' |' || RPAD( wTEMP2,  5 ) ||  ' |' ||
				RPAD( wCOST2,  5 ) ||  ' | ' || RPAD( wOPTIMIZER, 20 ) || '|' );	END IF;
		END IF;
		i := i + 1;	wID_last := wID;
	END LOOP;		CLOSE Src;

	If i = 0 then	Dest_SQL_Dyn := 'SELECT ID, DEPTH, OPERATION, ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'OPTIONS, OBJECT_NAME, ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( CARDINALITY, 0 ), NVL( ROUND(BYTES/1024), 0 ), ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( ROUND(TEMP_SPACE/1024), 0 ), NVL( COST, 0), ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( OPTIMIZER, '' '' ) ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || ' from STATS$SQL_PLAN where PLAN_HASH_VALUE=' || wHASH_VALUE ;
		Dest_SQL_Dyn := Dest_SQL_Dyn || ' order by ID ' ;	OPEN Src FOR Dest_SQL_Dyn;
		LOOP	FETCH Src INTO wID, wDEPTH, wOPERATION, wOPTIONS, wOBJECTS, wCARD, wBYTES, wTEMP, wCOST, wOPTIMIZER;
			EXIT WHEN Src%NOTFOUND;		j := j + 1;
			if wEXTRACT is null AND j = 1 THEN
				dbms_output.put_line ('+-----+--------------------------------+---------------------------+------+' ||
					'------+------+------+---------------------+' );
				dbms_output.put_line ('| Id  | Operation                      |  Object                   | Card |' ||
					' Bytes| Temp | Cost | Optimiser           |' );
				dbms_output.put_line ('+-----+--------------------------------+---------------------------+' ||
					'------+------+------+------+---------------------+' );
			END IF;

			-- Calcul des arrondis
			--------------------------------------------------------------------------------
			SELECT PKG_STATS.Arrondi(  wCARD ) INTO wCARD2  FROM DUAL;
			SELECT PKG_STATS.Arrondi( wBYTES ) INTO wBYTES2 FROM DUAL;
			SELECT PKG_STATS.Arrondi(  wTEMP ) INTO wTEMP2	 FROM DUAL;
			SELECT PKG_STATS.Arrondi(  wCOST ) INTO wCOST2	 FROM DUAL;
			--------------------------------------------------------------------------------
			EXIT WHEN Src%NOTFOUND;
			if wEXTRACT is null THEN
				DBMS_OUTPUT.PUT_LINE ( '|' || TO_CHAR( wID, '999' )	||  ';| ' ||
				RPAD( RPAD( ' ' , wDEPTH ) || wOPERATION || ' ' || NVL(wOPTIONS,' '), 30 ) ||  ' | ' ||
				RPAD( NVL(wOBJECTS, ' '), 25 )	||  ' |' || RPAD( wCARD2,  5 ) 	||  ' |' ||
				RPAD( wBYTES2, 5 ) 	||  ' |' ||  RPAD( wTEMP2,  5 ) 	||  ' |' ||
				RPAD( wCOST2,  5 ) 	||  ' | ' || RPAD( wOPTIMIZER, 20 ) 	|| '|' );
			ELSE	DBMS_OUTPUT.PUT_LINE ( wEXTRACT || ';' || wHASH_VALUE || ';' ||
				TO_CHAR( wID, '999' ) ||  ' | ' ||
				RPAD( RPAD( ' ' , wDEPTH ) || wOPERATION || ' ' || NVL(wOPTIONS,' '), 30 ) ||  ' | ' ||
				RPAD( NVL(wOBJECTS, ' '), 25 )	||  ' |' || RPAD( wCARD2,  5 ) 	||  ' |' ||
				RPAD( wBYTES2, 5 ) 	||  ' |' ||  RPAD( wTEMP2,  5 ) 	||  ' |' ||
				RPAD( wCOST2,  5 ) 	||  ' | ' || RPAD( wOPTIMIZER, 20 ) 	|| '|' );
			END IF;
		END LOOP;	CLOSE Src;
	END IF;

	if wEXTRACT is null and J>0 THEN
		dbms_output.put_line ('+-----+--------------------------------+---------------------------+' ||
		'------+------+------+------+---------------------+' );
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure Detect_REBOOT ( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR )
IS	I		Number;		Dreboot		VARCHAR( 25 );	Last_Dreboot	VARCHAR( 25 );
	TYPE 		DataSource IS REF CURSOR;	Src 	        DataSource ;
BEGIN	dbms_output.enable( 10000000 );
	I := 0;	Last_Dreboot := 'xx';
	OPEN Src FOR  SELECT distinct TO_CHAR( startup_time, 'YYYYMMDD HH24:MI' )
		  FROM PERFSTAT.STATS$SNAPSHOT   WHERE Snap_time >= TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' )
		AND  Snap_time <= TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) AND	startup_time >= TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' )
		 AND	startup_time <= TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' )	 ORDER BY TO_CHAR( startup_time, 'YYYYMMDD HH24:MI' );
	LOOP	FETCH Src INTO Dreboot;		EXIT WHEN Src%NOTFOUND;
		IF Last_Dreboot != Dreboot
		THEN	Last_Dreboot := Dreboot ;	I := I + 1;
			If ( i = 1 ) then 	dbms_output.put_line ( '+-----------+ +------------------------------------+');
				dbms_output.put_line ( '|  WARNING  | |  Redemarrage ' || to_char(i, '99') || ' : ' || Dreboot || '  |' );
			ELSE	dbms_output.put_line ( '|           | |  Redemarrage ' || to_char(i, '99') || ' : ' || Dreboot || '  |' );
			END IF;
		END IF;
	END LOOP;
	If ( i > 0 ) THEN
		dbms_output.put_line ( '+-----------+-+------------------------------------+-------------------------+');
		dbms_output.put_line ( '| NB : Les redemarrages d''instance perturbent les resultats STATSPACK        |');
		dbms_output.put_line ( '|      Preciser si possible des fenetres de temps excluant les A/R de bases  |');
		dbms_output.put_line ( '+----------------------------------------------------------------------------+');
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure diag_proc 	( DATEDEB IN VARCHAR DEFAULT TO_CHAR( sysdate-7, 'YYYYMMDD HH24:MI' ),
			DATEFIN IN VARCHAR DEFAULT TO_CHAR( sysdate  , 'YYYYMMDD HH24:MI' ), LSTMODE IN VARCHAR DEFAULT 'NORM',
			PRECO  IN VARCHAR DEFAULT 'Y' , COEFVAL IN NUMBER DEFAULT 3, SEUIL_MINI IN NUMBER DEFAULT Null,
			INSTANCE IN NUMBER DEFAULT 1, TYPEREST IN VARCHAR DEFAULT 'NORME', DEGRAD IN VARCHAR DEFAULT 'N' )
IS	SQL_Dyn Varchar(30000); SQL_Dyn2 Varchar(30000); TYPE DataSource IS REF CURSOR; Src DataSource ; wcpu Number; wWaits Number;
	wDisk_IO Number; wLatency Number; wTOTAL Number; wVERSION Varchar(20); i Number; imax Number; wDEBUG Number;
	TYPE ElementSNAP IS RECORD (INSTANCE_NUMBER Number, STIME varchar(20), SNAP_ID Number, CPU Number, WAITS Number,
	LATENCY Number, Disk_IO Number, P_WAIT NUMBER, P_DISK_IO NUMBER, P_LATENCY NUMBER, P_CPU NUMBER, P_CPU_P NUMBER,
	P_CPU_R NUMBER, P_CPU_U NUMBER, CPU_INFO VARCHAR(5), Indic_W VARCHAR(1), Indic_L VARCHAR(1), Indic_D VARCHAR(1),
	Indic_C VARCHAR(1), Indic_Aff VARCHAR(1), Nb_Comment Number); Type MatriceAg IS TABLE OF ElementSNAP index by binary_integer ;
	squelette MatriceAg; Nb_Comment Number; sWAITS NUMBER; sDISK_IO NUMBER; sLATENCY NUMBER; sCPU NUMBER; sP_WAIT NUMBER; sP_DISK_IO NUMBER;
	sP_LATENCY NUMBER; sP_CPU NUMBER; cpu_low number; zWAITS NUMBER; zDISK_IO NUMBER; zLATENCY NUMBER; zCPU NUMBER; NB_Periode Number;
	j Number; coefWAITS varchar(10); coefDISK_IO varchar(10); coefLATENCY varchar(10); coefCPU varchar(10); CHAR_SEp VARCHAR(1); oVersion Number;
	DATE_DEB VARCHAR(20); DATE_FIN VARCHAR(20); w_CONSEIL VARCHAR(1000); wBLOCKSIZE VARCHAR(10); wTYPEREST Varchar(20); wFORMAT Varchar(20);
	wFORMAT2 Varchar(20); wDEGRAD Number; wChaine Varchar(300); wDIV Number; wCOL Varchar(20); wSEUIL_MINI Number; wCPU_COUNT Number;
	wCATEGORIE Varchar(20); TXT Varchar(1000); ELight Number; wDATElimit DATE;
Begin	dbms_output.enable(100000000);
	wDEBUG 		:= 0;	NB_Periode	:= 0;
	select perfstat.PKG_STATS.CheckVal('DIAG', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN 	dbms_output.put_line(' Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; END IF;

	IF DEGRAD = 'N'	THEN	wDEGRAD := 0;	ELSE	wDEGRAD := 1;	END IF;
	IF SEUIL_MINI Is NULL THEN	IF TYPEREST = 'NORME'
		THEN	select to_number( VALUE ) INTO wCPU_COUNT from v$parameter where NAME='cpu_count';
			wSEUIL_MINI := wCPU_COUNT * 0.05;  ELSE	wSEUIL_MINI := 30;	END IF;
	ELSE	wSEUIL_MINI := SEUIL_MINI;	END IF;
	IF TYPEREST = 'NORME'
	THEN	wTYPEREST := 'CALCNORM';	wFORMAT := '999999.999';	wFORMAT2  := '99999.99';
	ELSE	wTYPEREST := 'CALC';		wFORMAT	  := '9999999999';	wFORMAT2  := '99999999';	END IF;
	SELECT perfstat.PKG_STATS.VERSION INTO wVERSION From Dual;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	SELECT DECODE( LSTMODE, 'CSV', ';' , '|' ) INTO Char_Sep FROM DUAL;
	IF Oversion = 8 THEN	wDIV := 1000;		wCOL := 'TIME_WAITED';
	ELSE	wDIV := 1000000;	wCOL := 'TIME_WAITED_MICRO';	END IF;

	SQL_Dyn := ' select snap_id, to_char( snap_time, ''YYYYMMDD HH24:MI'' ) stime, ';
	SQL_Dyn := SQL_Dyn || ' sum( DECODE( RUB, ''CPU'',     ' || wTYPEREST || ', 0 ) ) pcpu,  ';
	SQL_Dyn := SQL_Dyn || ' sum( DECODE( RUB, ''WAITS'',   ' || wTYPEREST || ', 0 ) ) pWaits,  ';
	SQL_Dyn := SQL_Dyn || ' sum( DECODE( RUB, ''DISK_IO'', ' || wTYPEREST || ', 0 ) ) pDisk_IO, ';
	SQL_Dyn := SQL_Dyn || ' sum( DECODE( RUB, ''LATENCY'', ' || wTYPEREST || ', 0 ) ) pLatency, ';
	SQL_Dyn := SQL_Dyn || ' sum( DECODE( SRUB, ''USED'',      ' || wTYPEREST || ', 0 ) ) P_CPU_U, ';
	SQL_Dyn := SQL_Dyn || ' sum( DECODE( SRUB, ''RECURSIVE'', ' || wTYPEREST || ', 0 ) ) P_CPU_R, ';
	SQL_Dyn := SQL_Dyn || ' sum( DECODE( SRUB, ''PARSE'',     ' || wTYPEREST || ', 0 ) ) P_CPU_P ';
	SQL_Dyn := SQL_Dyn || ' from 	( select ss.snap_time, sq.SNAP_ID, EVENT, ';
	SQL_Dyn := SQL_Dyn || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''RUBRIQUE'' )  RUB, ';
	SQL_Dyn := SQL_Dyn || ' perfstaT.PKG_STATS.INFO_CARTO( EVENT, ''SRUBRIQUE'' )  SRUB,  ';
	SQL_Dyn := SQL_Dyn || ' (decode(greatest(sq.' || wCOL || ', lag(sq.' || wCOL || ', 1, sq.' || wCOL || ')  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.EVENT order by sq.snap_id)),  sq.' || wCOL || ',  sq.' || wCOL || ' - ';
	SQL_Dyn := SQL_Dyn || ' lag(sq.' || wCOL || ', 1, sq.' || wCOL || ')   ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.EVENT order by sq.snap_id),  sq.' || wCOL || ')/' || wDIV || ' ) calc, ';
	-- DIag analytique Norme
	SQL_Dyn := SQL_Dyn || ' CASE WHEN ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.EVENT order by sq.snap_id)),  ';
	SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME,  ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.EVENT order by sq.snap_id),  ss.SNAP_TIME)*86400 ) = 0  ';
	SQL_Dyn := SQL_Dyn || ' THEN Null ';
	SQL_Dyn := SQL_Dyn || ' ELSE  (decode(greatest(sq.' || wCOL || ', lag(sq.' || wCOL || ', 1, sq.' || wCOL || ')   ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.EVENT order by sq.snap_id)),  sq.' || wCOL || ',  ';
	SQL_Dyn := SQL_Dyn || ' sq.' || wCOL || ' -  lag(sq.' || wCOL || ', 1, sq.' || wCOL || ') ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.EVENT order by sq.snap_id),  sq.' || wCOL || ')/' || wDIV || ' ) /  ';
	SQL_Dyn := SQL_Dyn || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  over(partition by sq.EVENT order by sq.snap_id)),  ';
	SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME,  ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)   over(partition by sq.EVENT order by sq.snap_id), ';
	SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME)*86400 ) ';
	SQL_Dyn := SQL_Dyn || ' END calcNorm ';
	----------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' from	stats$system_event sq, stats$snapshot ss  ';
	SQL_Dyn := SQL_Dyn || ' where ss.snap_time between to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn := SQL_Dyn || ' and	sq.dbid = ss.dbid  and sq.instance_number = ss.instance_number  and    sq.snap_id = ss.snap_id  ';
	SQL_Dyn := SQL_Dyn || ' and	sq.instance_number = ' || INSTANCE ;
	SQL_Dyn := SQL_Dyn || ' UNION ';
	SQL_Dyn := SQL_Dyn || ' SELECT 	ss.snap_time, sq.SNAP_ID, NAME EVENT,  ';
	SQL_Dyn := SQL_Dyn || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''RUBRIQUE'' ) RUB, ';
	SQL_Dyn := SQL_Dyn || ' perfstaT.PKG_STATS.INFO_CARTO( NAME, ''SRUBRIQUE'' )  SRUB,  ';
	SQL_Dyn := SQL_Dyn || ' ( decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE)   ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.NAME order by sq.snap_id)),  sq.VALUE, ';
	SQL_Dyn := SQL_Dyn || ' sq.VALUE - lag(sq.VALUE,  1, sq.VALUE)   ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.NAME order by sq.snap_id),  sq.VALUE)/100 )  calc, ';
	-- DIag analytique Norme
	SQL_Dyn := SQL_Dyn || ' CASE WHEN ';
	SQL_Dyn := SQL_Dyn || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.NAME order by sq.snap_id)),  ';
	SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME,  ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.NAME order by sq.snap_id),  ss.SNAP_TIME)*86400 ) = 0  ';
	SQL_Dyn := SQL_Dyn || ' THEN Null ';
	SQL_Dyn := SQL_Dyn || ' ELSE  ( decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.NAME order by sq.snap_id)),  sq.VALUE,  ';
	SQL_Dyn := SQL_Dyn || ' sq.VALUE - lag(sq.VALUE,  1, sq.VALUE)  over(partition by sq.NAME order by sq.snap_id),  sq.VALUE)/100 ) /  ';
	SQL_Dyn := SQL_Dyn || ' ( decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.NAME order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME,  ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)   ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.NAME order by sq.snap_id), ';
	SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME)*86400 )';
	SQL_Dyn := SQL_Dyn || ' END calcNorm ';
	----------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' from 	perfstat.stats$sysstat sq, stats$snapshot ss   ';
	SQL_Dyn := SQL_Dyn || ' where sq.NAME in ( ''CPU used by this session'', ''parse time cpu'', ''recursive cpu usage'' ) ';
	SQL_Dyn := SQL_Dyn || ' and sq.dbid = ss.dbid  and sq.instance_number = ss.instance_number  and sq.snap_id = ss.snap_id ';
	SQL_Dyn := SQL_Dyn || ' and ss.snap_time between to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn := SQL_Dyn || ' and sq.instance_number = ' || INSTANCE || '  ) ';
	SQL_Dyn := SQL_Dyn || ' group by snap_id, to_char( snap_time, ''YYYYMMDD HH24:MI'' ) ';

	SQL_Dyn2 := 'SELECT avg( pcpu)  pcpu, avg( pWaits ) pWaits, avg( pDisk_IO ) pDisk_IO, avg( pLatency ) pLatency FROM ( ';
	SQL_Dyn2 := SQL_Dyn2 || SQL_Dyn || ')';

	IF wDEBUG = 1 OR wDEBUG = 9 THEN
		dbms_output.put_line( substr( SQL_Dyn2,    1, 200 ));	dbms_output.put_line( substr( SQL_Dyn2,  201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2,  401, 200 ));	dbms_output.put_line( substr( SQL_Dyn2,  601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2,  801, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 1001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 1401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 1801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 2201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 2601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 3001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 3401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 3801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 4001, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 4201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 4401, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 4601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn2, 4801, 200 ));	dbms_output.put_line( substr( SQL_Dyn2, 4001, 200 ));
	END IF;
	OPEN Src FOR SQL_Dyn2;	FETCH Src INTO wcpu, wWaits, wDisk_IO, wLatency;
	wTOTAL := wcpu + wWaits + wDisk_IO + wLatency;	Close Src;
	dbms_output.put_line( '     / ' );
	dbms_output.put_line( wVERSION || '/      DIAG : PROCEDURE DE DETECTION DES PERIODES A AUDITER -> INSTANCE (' ||INSTANCE || ')' );
	dbms_output.put_line( '___/       Periode du ' || DATEDEB || ' au ' || DATEFIN );
	dbms_output.put_line( '| /            Tuning ' || Wversion );	dbms_output.put_line( '|/    ' );
	dbms_output.put_line( '+--------------------------------------------------------+------------------------------+' );
	dbms_output.put_line( '|                            Valeur Moyenne      %Moyen  |   Rappel des parametres      |' );
	dbms_output.put_line( '+- - - - - - - - - - - - - - - - - - - - - - - - - - - - +- - - - - - - - - - - - - - - +' );
	dbms_output.put_line( '|  Valeur RUBRIQUE WAIT    : ' ||
	to_char( NVL(wWaits,0) , wFORMAT ) || '       ' || to_char( NVL( 100*wWaits/wTOTAL,0) , '999.00' ) || '   |   ' ||
	RPAD( 'LSTMODE(' || LSTMODE || ')' , 27 ) || '|' );
	dbms_output.put_line( '|  Valeur RUBRIQUE LATENCE : ' ||
	to_char( NVL( wLatency,0 ) , wFORMAT ) || '       ' || to_char( NVL( 100*wLatency/wTOTAL, 0) , '999.00' ) || '   |   ' ||
	RPAD( 'INSTANCE(' || INSTANCE 	|| ')', 27 ) || '|' );
	dbms_output.put_line( '|  Valeur RUBRIQUE DISK_IO : ' ||
	to_char( NVL( wDisk_IO,0 ) , wFORMAT ) || '       ' || to_char( NVL( 100*wDisk_IO/wTOTAL, 0) , '999.00' ) || '   |   ' ||
	RPAD( 'PRECO(' 	|| PRECO 	|| ')', 27 ) || '|' );
	dbms_output.put_line( '|  Valeur RUBRIQUE CPU     : ' ||
	to_char( NVL( wcpu, 0 ) , wFORMAT ) || '       ' || to_char( NVL( 100*wcpu/wTOTAL, 0 ), '999.00' ) || '   |   ' ||
	RPAD( 'COEFVAL(' 	|| COEFVAL	|| ')', 27 ) || '|' );
	dbms_output.put_line( '|                                                        |   ' ||
	RPAD( 'SEUIL_MINI(' || wSEUIL_MINI 	|| ')', 27 ) || '|' );
	dbms_output.put_line( '|                                                        |   ' ||
	RPAD( 'DEGRAD (' || DEGRAD 	|| ')', 27 ) || '|' );
	IF TYPEREST = 'NORME' THEN
	dbms_output.put_line( '|   Unite des colonnes 1 ? (temps cumule en Sec/Sec)   |                              |' );
	ELSE
	dbms_output.put_line( '|   Unite des colonnes 1 ? (temps cumule en Sec)       |                              |' );
	END IF;	dbms_output.put_line(
	'+========================================================+================================================================+' );
	sWAITS		:= 	wWaits;	sDISK_IO	:= 	wDisk_IO;  sLATENCY := 	wLatency;  sCPU	:= 	wcpu;
	SQL_Dyn := SQL_Dyn || ' order by  snap_id' ;

	IF wDEBUG = 2 OR wDEBUG = 9 THEN
		dbms_output.put_line( substr( SQL_Dyn,    1, 200 ));	dbms_output.put_line( substr( SQL_Dyn,  201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,  401, 200 ));	dbms_output.put_line( substr( SQL_Dyn,  601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,  801, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 1001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 1401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 1801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 2201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 2601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 3001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 3401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 3801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 4001, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 4201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 4401, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 4601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 4801, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 4001, 200 ));
	END IF;

	i := 1;	Open Src For SQL_Dyn;	LOOP
		FETCH Src INTO 	squelette(i).SNAP_ID, squelette(i).STIME, squelette(i).CPU, squelette(i).WAITS, squelette(i).DISK_IO,
		squelette(i).LATENCY, squelette(i).P_CPU_U, squelette(i).P_CPU_R, squelette(i).P_CPU_P;	EXIT WHEN Src%NOTFOUND;
		wTOTAL := squelette(i).CPU + squelette(i).WAITS + squelette(i).DISK_IO + squelette(i).LATENCY ;
		-----------------------------------------------------------------------------------------------------------
		IF wTOTAL = 0 	THEN wTOTAL :=  Null; 	END IF;
		squelette(i).P_WAIT := 100*squelette(i).WAITS/wTOTAL;	squelette(i).P_DISK_IO	:= 100*squelette(i).DISK_IO/wTOTAL;
		squelette(i).P_LATENCY := 100*squelette(i).LATENCY/wTOTAL;	squelette(i).P_CPU := 100*squelette(i).CPU/wTOTAL;
		-----------------------------------------------------------------------------------------------------------
		IF squelette(i).CPU = 0 THEN squelette(i).CPU := Null;	END IF;
		squelette(i).P_CPU_P := 100*squelette(i).P_CPU_P/squelette(i).CPU;
		squelette(i).P_CPU_R := 100*squelette(i).P_CPU_R/squelette(i).CPU;
		squelette(i).P_CPU_U := 100*squelette(i).P_CPU_U/squelette(i).CPU;
		-----------------------------------------------------------------------------------------------------------
		IF WdeBUG = 2 or wDEBUG = 9	THEN
			dbms_output.put_line(	to_char(i, '999') || ' ' || squelette(i).SNAP_ID	|| ' ' ||
		squelette(i).STIME || ' ' || squelette(i).CPU || ' ' || squelette(i).WAITS	|| ' ' || squelette(i).DISK_IO || ' ' ||
		squelette(i).LATENCY || ' ' || squelette(i).P_CPU_U || ' ' || squelette(i).P_CPU_R || ' ' || squelette(i).P_CPU_P || ' ' ||
		squelette(i).P_WAIT || ' ' || squelette(i).P_DISK_IO|| ' ' || squelette(i).P_LATENCY|| ' ' || squelette(i).P_CPU);
		END IF;
		i := i + 1 ;
	END LOOP;
	Close Src;	imax := i;
----------------------------------------------------------------------------------------------------------------------------
-- Recuperation du code de DIAG version 1
----------------------------------------------------------------------------------------------------------------------------
	i := 2;
	while ( i < imax )
	LOOP	Nb_Comment := 0;	Squelette(i).CPU_INFO := '   ';		Squelette(i).Indic_C := ' ';
		Squelette(i).Indic_W := ' ';	Squelette(i).Indic_D := ' ';	Squelette(i).Indic_L := ' ';

		IF  ( Squelette(i).WAITS > (COEFVAL*sWAITS) ) AND ( Squelette(i).WAITS > wSEUIL_MINI ) then Squelette(i).Indic_W := '*';
			Nb_Comment := Nb_Comment + 1;	END IF;
		IF  ( Squelette(i).DISK_IO > (COEFVAL *sDISK_IO) ) AND ( Squelette(i).DISK_IO > wSEUIL_MINI ) then Squelette(i).Indic_D := '*';
			Nb_Comment := Nb_Comment + 1;	END IF;
		IF  ( Squelette(i).LATENCY > (COEFVAL*sLATENCY) ) AND ( Squelette(i).LATENCY > wSEUIL_MINI ) then Squelette(i).Indic_L := '*';
			Nb_Comment := Nb_Comment + 1;	END IF;
		IF Squelette(i).CPU > wSEUIL_MINI THEN
			IF 	( Squelette(i).P_CPU_R > Squelette(i).P_CPU_U ) THEN
				Squelette(i).Indic_C := '*';
				Squelette(i).CPU_INFO := 'ReC';
				Nb_Comment := Nb_Comment + 1;
			ELSIF ( Squelette(i).P_CPU_P > Squelette(i).P_CPU_U ) THEN
				Squelette(i).Indic_C := '*';
				Nb_Comment := Nb_Comment + 1;
				Squelette(i).CPU_INFO := 'PrS';
			ELSE 	cpu_low :=0 ;
				IF Squelette(i).CPU  < Squelette(i).WAITS and wDEGRAD = 1 THEN
					cpu_low := cpu_low+1;
					IF ( Squelette(i).Indic_W != '*' ) THEN Squelette(i).Indic_W := '*';
						Nb_Comment := Nb_Comment + 1;	END IF;	END IF;
				IF Squelette(i).CPU  < Squelette(i).DISK_IO and wDEGRAD = 1 THEN
					cpu_low := cpu_low+1;
					IF ( Squelette(i).Indic_D != '*' ) THEN Squelette(i).Indic_D := '*';
						Nb_Comment := Nb_Comment + 1;	END IF;	END IF;
				IF Squelette(i).CPU  < Squelette(i).LATENCY and wDEGRAD = 1 THEN
					cpu_low := cpu_low+1;
					IF ( Squelette(i).Indic_L != '*' ) THEN Squelette(i).Indic_L := '*';
						Nb_Comment := Nb_Comment + 1;	END IF;	END IF;
				IF cpu_low  > 0 THEN	Squelette(i).Indic_C := '+';	Nb_Comment := Nb_Comment + 1;
					Squelette(i).CPU_INFO := ' ' || substr( to_char( cpu_low , '9') , 2, 1 ) || ' ' ;
				END IF;
			END IF;
		END IF;

		IF ( Nb_Comment > 0 ) THEN
			Squelette(i-1).Indic_Aff := 'Y'; Squelette(i).Indic_Aff   := 'Y'; Squelette(i+1).Indic_Aff := 'Y';
		END IF;	Squelette(i).Nb_Comment := Nb_Comment;	i := i + 1;
	END LOOP;

	-- Recalcul des % moyennes
	IF sWAITS+sLATENCY+sDISK_IO+sCPU > 0 THEN
		sP_WAIT    := round( 10000*sWAITS   /( sWAITS+sLATENCY+sDISK_IO+sCPU ) )/100;
		sP_LATENCY := round( 10000*sLATENCY /( sWAITS+sLATENCY+sDISK_IO+sCPU ) )/100;
		sP_DISK_IO := round( 10000*sDISK_IO /( sWAITS+sLATENCY+sDISK_IO+sCPU ) )/100;
		sP_CPU     := round( 10000*sCPU     /( sWAITS+sLATENCY+sDISK_IO+sCPU ) )/100;
	ELSE	sP_WAIT    := 0;	sP_LATENCY := 0;	sP_DISK_IO := 0;	sP_CPU     := 0;	END IF;

	i := 1;
	while ( i < imax )
	LOOP
		zWAITS	:= 0;	zDISK_IO	:= 0;	zLATENCY	:= 0;	zCPU		:= 0;
		IF ( Squelette(i).Indic_Aff = 'Y' ) THEN
			DATE_DEB := Squelette(i).Stime;
			NB_Periode := NB_Periode + 1 ;
			DATE_DEB := ''''  || DATE_DEB || '''' ;

			j := i;
			while ( j < imax ) AND ( Squelette(j).Indic_Aff = 'Y' )
			LOOP 	j := j + 1 ; 	END LOOP;
			Dbms_output.put_line(
'|                                                                                                                         |');
			wCATEGORIE := ' ';
			Dbms_output.put_line( '|   ' || RPAD( 'PERIODE AUDIT ' || NB_Periode ||  ' : ' || Squelette(i).Stime ||
				' => ' || Squelette(j-1).Stime || '  ( SNAP ' ||
				Squelette(i).SNAP_ID || ' => ' || Squelette(j-1).SNAP_ID ||   ' ) ' , 99 )  ||
				'Categorie:' || wCATEGORIE ||	'        |');
Dbms_output.put_line( '|   +----------------+-----------------+-----------------+-----------------+-----------------+----+----+----+----+        |' );
Dbms_output.put_line( '|   |  Date - Heure  | 1. WAITS        | 2. I/O          | 3. Latency      | 4. CPU          | %1 | %2 | %3 | %4 |        |' );
Dbms_output.put_line('|   |                |          (Coef) |          (Coef) |          (Coef) |          (Info) |    |    |    |    |        |' );
Dbms_output.put_line('|   +----------------+-----------------+-----------------+-----------------+-----------------+----+----+----+----+        |' );
			while ( i < imax ) AND ( Squelette(i).Indic_Aff = 'Y' )
			LOOP	IF ( Squelette(i).Indic_W = '*' ) then zWAITS		:= 1; END IF;
				IF ( Squelette(i).Indic_C = '*' ) then zCPU		:= 1; END IF;
				IF ( Squelette(i).Indic_L = '*' ) then zLATENCY		:= 1; END IF;
				IF ( Squelette(i).Indic_D = '*' ) then zDISK_IO		:= 1; END IF;
				coefWAITS	:= '     ';	coefDISK_IO	:= '     ';	coefLATENCY	:= '     ';
				coefCPU	:= '     ';
				IF ( Squelette(i).Indic_W = '*' ) then 	zWAITS	:= 1;
					If sWAITS > 0 THEN
						coefWAITS := '(' || substr( TO_char( Squelette(i).WAITS    /sWAITS  , '999' ), 2, 10) || ')';
					else	coefWAITS := '(N.A)';	end if;	END IF;
				IF ( Squelette(i).Indic_C = '*' ) OR ( Squelette(i).Indic_C = '+' ) then
					coefCPU	:= '(' || Squelette(i).CPU_INFO || ')';	zCPU		:= 1; 	END IF;
				IF ( Squelette(i).Indic_L = '*' ) then 	If sLATENCY > 0 then
						coefLATENCY := '(' || substr( TO_char( Squelette(i).LATENCY  /sLATENCY, '999' ), 2, 10) || ')';
					else	coefLATENCY := '(N.A)';		end if;	zLATENCY	:= 1; 	END IF;
				IF ( Squelette(i).Indic_D = '*' ) then 	If sDISK_IO > 0 then
						coefDISK_IO := '(' || substr( TO_char( Squelette(i).DISK_IO  /sDISK_IO, '999' ), 2, 10) || ')';
					else	coefDISK_IO	:= '(N.A)';	end if;	zDISK_IO	:= 1; 	END IF;
				Dbms_output.put_line( '|   | ' || Squelette(i).STIME  || ' ' || Char_Sep ||
					to_char( Squelette(i).WAITS    , wFORMAT2) || ' ' || NVL(Squelette(i).Indic_W, ' ' ) ||
					coefWAITS   || ' ' || Char_Sep ||
				to_char( Squelette(i).DISK_IO  , wFORMAT2) || ' ' || NVL(Squelette(i).Indic_D, ' ' ) ||
					coefDISK_IO || ' ' || Char_Sep ||
				to_char( Squelette(i).LATENCY  , wFORMAT2) || ' ' || NVL(Squelette(i).Indic_L, ' ' ) ||
					coefLATENCY || ' ' || Char_Sep ||
				to_char( Squelette(i).CPU      , wFORMAT2) || ' ' || NVL(Squelette(i).Indic_C, ' ' ) ||
					coefCPU     || ' ' || Char_Sep ||
				to_char( Squelette(i).P_WAIT   , '999'   ) || Char_Sep ||
				to_char( Squelette(i).P_DISK_IO, '999'   ) || Char_Sep ||
				to_char( Squelette(i).P_LATENCY, '999'   ) || Char_Sep ||
				to_char( Squelette(i).P_CPU    , '999'   ) || '|' ||
				RPAD( Nvl( RPAD( '*', NVL( Squelette(i).NB_Comment, 0) , '*' ), ' '), 8 ) || '|'  );	i := i + 1;
			END LOOP;
			Dbms_output.put_line(
'|   +----------------+-----------------+-----------------+-----------------+-----------------+----+----+----+----+        |' );
			IF  PRECO = 'Y' THEN
				Dbms_output.put_line(
'|                                                                                                                         |');
				Dbms_output.put_line(
'|   Preconisations :      Security ACTIVE                                                                                 |');
				DATE_FIN := '''' || Squelette(i-1).Stime || '''' ;
				select value INTO wBLOCKSIZE from v$parameter where name ='db_block_size';
				w_CONSEIL := 'Exec Perfstat.PKG_STATS.rubrique( ' || DATE_DEB;
				w_CONSEIL := w_CONSEIL || ', ' || DATE_FIN || ', ''CSV'', ''YYYY/MM/DD HH24:MI'', ''Y'', ' || INSTANCE || '  )';
				select perfstat.PKG_STATS.CheckVal('SUIVI_IO', LSTMODE ) INTO wDATElimit from dual;
				IF wDATElimit > sysdate THEN	Dbms_output.put_line( '|   ' || RPAD( w_CONSEIL , 118) || '|' );	END IF;

				IF zDISK_IO = 1 THEN
					select perfstat.PKG_STATS.CheckVal('TOPSQL', LSTMODE ) INTO wDATElimit from dual;
					IF wDATElimit > sysdate THEN
					Dbms_Output.Put_Line('| ' ||
					RPAD( '  * Exec Perfstat.PKG_STATS.TOPSQL ( ' || DATE_DEB || ', ' ||
					DATE_FIN || ', ''CSV'', ''DISK_READS'', 10, ''Y'', ''N'', ' ||
						NVL( TO_CHAR(INSTANCE), 'Null' ) || ' )' , 119 ) ||  ' |');	END IF;
				END IF;
				IF zLATENCY = 1 THEN
					select perfstat.PKG_STATS.CheckVal('SUIVI_IO', LSTMODE ) INTO wDATElimit from dual;
					IF wDATElimit > sysdate THEN
					Dbms_Output.Put_Line('| ' || RPAD( '  * Exec perfstat.PKG_STATS.suivi_io ( ' || DATE_DEB ||
					', ' || DATE_FIN || ', ''CSV'', ''YYYYMMDD HH24:MI'' ) ', 119 ) ||  ' |');	END IF;
				END IF;
				select perfstat.PKG_STATS.CheckVal('MTOPSQL', LSTMODE ) INTO wDATElimit from dual;
				IF wDATElimit > sysdate THEN
				Dbms_Output.Put_Line('| ' ||
					RPAD( '  * Exec Perfstat.PKG_STATS.MTOPSQL ( ' || DATE_DEB || ', ' ||
					DATE_FIN || ', ''CSV'', 10, 10, ''Y'', ''Y'', ' ||
					NVL( TO_CHAR(INSTANCE), 'Null' ) || ' )' , 119 ) ||  ' |');	END IF;
			END IF;
		END IF;	i := i + 1;
	END LOOP;

	If ( NB_Periode = 0 ) THEN
		Dbms_output.put_line( '|   ' || RPAD( 'RAS : Pas d''audit ?roposer', 118) || '|' );
		If COEFVAL >2 THEN
			Dbms_output.put_line( '|   ' || RPAD( 'Abaisser le parametre multiplicateur (COEFVAL=' || COEFVAL ||
			')', 118) || '|' );
		END IF;

		IF TYPEREST = 'NORME' THEN
			Dbms_output.put_line( '|   ' || RPAD( 'Le seuil minimum pour declenchement d''un audit (SEUIL_MINI: ' ||
			wSEUIL_MINI || ' s/s)', 118) || '|' );
		ELSE	Dbms_output.put_line( '|   ' || RPAD( 'Le seuil minimum pour declenchement d''un audit (SEUIL_MINI: ' ||
			wSEUIL_MINI || ' s)', 118) || '|' );	END IF;
	END IF;
Dbms_output.put_line(
'|                                                                                                                         |');
Dbms_output.put_line(  '+=========================================================================================================================+' );
	PKG_STATS.Detect_REBOOT ( TO_CHAR( TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ), 'YYYYMMDD HH24' ),
			TO_CHAR( TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ), 'YYYYMMDD HH24' ) );
	Dbms_output.put_line(
	'+-------------------------------------------------------------------------------------------------------------------------+' );
	Wchaine := 'exec PERFSTAT.PKG_STATS.diag( ''' || DATEDEB || ''', ''' || DATEFIN || '''' ;
	IF 	LSTMODE != 'CSV' THEN	Wchaine := Wchaine || ', ''' || LSTMODE		|| ''' ';	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	IF	PRECO != 'Y' 	 THEN	Wchaine := Wchaine || ', PRECO=>''' || PRECO		|| ''' ';
		Dbms_output.put_line ( RPAD( 'Activer les commandes     Tuning preconisees' , 80 ) || 'PRECO=>''Y'' ' );
	ELSE	Dbms_output.put_line ( RPAD( 'Desactiver les commandes     Tuning preconisees' , 80 ) || 'PRECO=>''N'' ' );	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	IF COEFVAL != 3	THEN	Wchaine := Wchaine || ', COEFVAL=>' || COEFVAL	;
	ELSE	Dbms_output.put_line ( RPAD( 'Modifier manuellement COEFVAL (detection de PIC)', 80 ) || 'SEUIL_MINI=>Valeur ' );  END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	IF wSEUIL_MINI != 30
	THEN	Wchaine := Wchaine || ', SEUIL_MINI=>' || wSEUIL_MINI;
	ELSE	Dbms_output.put_line ( RPAD( 'SEUIL_MINI' , 80 ) || 'SEUIL_MINI=>Valeur ' );	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	IF	INSTANCE != 1	THEN	Wchaine := Wchaine || ', INSTANCE=>' || INSTANCE	;
		Dbms_output.put_line ( RPAD( 'Changer d''INSTANCE' , 80 ) || 'INSTANCE=>Valeur ' );
	ELSE	Dbms_output.put_line ( RPAD( 'Changer d''INSTANCE' , 80 ) || 'INSTANCE=>Valeur ' );	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	IF TYPEREST != 'NORME'
	THEN	Wchaine := Wchaine || ', TYPEREST=>''' || TYPEREST	|| ''' ';
		Dbms_output.put_line ( RPAD( 'Basculer la restitution cumulee (sec) en restitution NORMEE (sec/sec)' , 80 ) || 'TYPEREST=>''NORME'' ');
	ELSE	Dbms_output.put_line ( RPAD( 'Basculer la restitution NORMEE (sec/sec) en restitution cumulee (sec)' , 80 ) || 'TYPEREST=>''CUMUL'' ');
	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	IF DEGRAD != 'N' THEN	Wchaine := Wchaine || ', DEGRAD=>''' || DEGRAD		|| ''' ';
		Dbms_output.put_line ( RPAD( 'Masquer les periodes degradees' , 80 ) || 'DEGRAD=>''N'' ' );
	ELSE	Dbms_output.put_line ( RPAD( 'Visualiser les periodes degradees' , 80 ) || 'DEGRAD=>''Y'' ' );	END IF;
	Dbms_output.put_line(
	'+=========================================================================================================================+' );
	Wchaine := Wchaine || ' )';	Dbms_output.put_line( 'Rappel de la commande : ' );	Dbms_output.put_line( wChaine  );
	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
procedure suivi_io_proc		( DATEDEB IN VARCHAR,  DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV',
				FORMAT_DATE_SORTIE IN VARCHAR DEFAULT 'YYYYMMDD HH24:MI',  PCT_RDS IN NUMBER DEFAULT 5, PCT_WRI IN NUMBER DEFAULT 5,
				TABLESPACE IN VARCHAR DEFAULT 'Null', DATAFILE IN VARCHAR DEFAULT 'Null', FILEDET IN VARCHAR DEFAULT 'N' ,
				INSTANCE IN NUMBER	DEFAULT 1, ZOOM IN VARCHAR DEFAULT Null )
IS	SQL_DYN Varchar(10000); SQL_DYN2 Varchar(10000); wVersion Varchar(100); wTSNAME Varchar(150); wPHYRDS Number; wPHYWRTS Number;
	wREADTIM Number; wWRITETIM Number; TYPE DataSource IS REF CURSOR; Src DataSource ; wTOTPHYRDS Number; wTOTPHYWRTS Number;
	wTOTREADTIM Number; wTOTWRITETIM Number; wSTATUS Varchar(50); i Number; TBSList Varchar(10000); wDELTA Number;
	wSNAP_TIME Varchar(25); wDATEDEB Varchar(25); wDEBITRDS Number; wDEBITWRI Number; wATPR Number; wATPW Number;
 	wFILENAME Varchar(520); wEXTRACT Varchar(50); wCHAINE Varchar(520); wCHAINE_OLD Varchar(520); wVal Varchar(50); TXT Varchar(1000);
	ELight Number; Inst_Size Number; FREE_Size Number; Temp_Size Number; wSAN_RDS Number; wSAN_WRT Number;
	RatioVal Number; NB Number; wNAME VARCHAR(50); wDGLisT VARCHAR(1000); wTOTAL_MB Number; wFREE_MB Number;
	wDateLimit DATE; HMIN Varchar(25); HMAX Varchar(25); wHOST_NAME Varchar(50); wINSTANCE_NAME Varchar(50);
BEGIN	dbms_output.enable(10000000);	TBSList	:= '';	wCHAINE_OLD := 'xxxx';
	select perfstat.PKG_STATS.CheckVal('SUIVI_IO', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN 	dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; 	END IF;
	select 'TU2;' || INSTANCE_NAME || ';' || HOST_NAME || ';' INTO wEXTRACT from v$instance;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;
	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	select 	to_char( max( snap_time), 'YYYYMMDD HH24:MI' ) INTO wDATEDEB
	from 	stats$snapshot where snap_time < To_date( DATEDEB, 'YYYYMMDD HH24:MI' );
	IF upper( LSTMODE ) NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ('TU2' ) THEN
		SELECT perfstat.PKG_STATS.version INTO wVersion from dual;
		dbms_output.put_line( '     /---------------------------------------------------+' );
		dbms_output.put_line( wVERSION || ' /     SUIVI DES TEMPS DE REPONSE IO (ms)             |' );
		dbms_output.put_line( '___/                                                     |' );
		dbms_output.put_line( RPAD( '| /           Tuning ' || wVersion, 57 ) || '|' );
		dbms_output.put_line( '|/                                                       |' );
		dbms_output.put_line( '+--------------------------------------------------------+');
		dbms_output.put_line( '| Periode du ' || DATEDEB || ' au ' || DATEFIN || ' (non inclu) ');
		dbms_output.put_line( '| Type de restitution : ' || LSTMODE );

		IF TABLESPACE = 'Null'	THEN	dbms_output.put_line( '| La restitution souhaitee n''est pas filtree par tablespace.');
		ELSE	dbms_output.put_line( '| La restitution souhaitee est filtree pour le tablespace : ' || TABLESPACE );	END IF;
		IF FILEDET = 'N'   THEN	dbms_output.put_line( '| La restitution n''inclue pas le detail des fichiers de donnees');
		ELSE	dbms_output.put_line( '| La restitution inclue le detail des fichiers de donnees'); 	END IF;
		If DATAFILE= 'Null'	THEN	dbms_output.put_line( '| La restitution souhaitee n''est pas filtree par datafile.');
		ELSE	dbms_output.put_line( '| La restitution souhaitee est filtree sur le datafile :' || DATAFILE );	END IF;
		dbms_output.put_line( '| Le format de sortie DATE est ''' || FORMAT_DATE_SORTIE || '''' );
		dbms_output.put_line( '| ' );
		SQL_Dyn := 'select count(*) from v$asm_diskgroup where NAME not like ''%ARCH%''' ;
		Begin	Open Src FOR SQL_Dyn;	Fetch Src INTO NB ;	Close Src;
		EXCEPTION WHEN OTHERS THEN NB := 0; END;

		IF NB >= 1 THEN
			dbms_output.put_line( '+---> Configuration ASM detectee' );
			SQL_Dyn := 'select sum(TOTAL_MB)/1024, sum(FREE_MB)/1024 from v$asm_diskgroup where NAME not like ''%ARCH%'' ';
			Open Src FOR SQL_Dyn;	Fetch Src INTO wTOTAL_MB, wFREE_MB;	Close Src;
			select sum(BYTES)/1024/1024/1024 INTO FREE_Size from dba_free_space;
			SQL_Dyn := 'select NAME from v$asm_diskgroup where NAME not like ''%ARCH%'' ';
			wDGLisT := '';
			Open Src for SQL_Dyn;
			LOOP	Fetch Src INTO wNAME;	EXIT WHEN Src%NOTFOUND;	wDGLisT := ', ' || wNAME;	END LOOP;
			wDGLisT := substr(wDGLisT, 3, 99999 );
			dbms_output.put_line( '| DISKGROUP(s) retenu(s)       : ' || wDGLisT );
			SQL_Dyn := 'select NAME from v$asm_diskgroup where NAME like ''%ARCH%'' ';
			wDGLisT := '';
			Open Src for SQL_Dyn;
			LOOP	Fetch Src INTO wNAME;	EXIT WHEN Src%NOTFOUND;	wDGLisT := ', ' || wNAME;	END LOOP;
			wDGLisT := substr(wDGLisT, 3, 99999 );
			dbms_output.put_line( '| DISKGROUP(s) Exclu(s)        : ' || wDGLisT );
			dbms_output.put_line( '| Taille en Go de l''enveloppe  : ' || round(wTOTAL_MB,2) );
			dbms_output.put_line( '| Taille en Go (Free DiskGroup): ' || round(wFREE_MB,2) );
			dbms_output.put_line( '| Taille en Go (Free TBS)      : ' || round(FREE_Size,2) );
			dbms_output.put_line( '| ' );
			Inst_Size := wTOTAL_MB;
			dbms_output.put_line( '+=======================================' );
			RatioVal  := Inst_Size / (Inst_Size-FREE_Size-wFREE_MB);
			dbms_output.put_line( '| Ratio Total/Utile            : ' || round(RatioVal,2) );
			dbms_output.put_line( '| ' );
		ELSE	dbms_output.put_line( '+---> Configuration Standard detectee (Sans ASM)' );
			select sum(BYTES)/1024/1024/1024 INTO Inst_Size from v$datafile;
			select sum(BYTES) /1024/1024/1024 INTO Temp_Size from v$tempfile;
			select sum(BYTES)/1024/1024/1024 INTO FREE_Size from dba_free_space;
			dbms_output.put_line( '| Taille en Go de l''enveloppe  : ' || round(Inst_Size,2) );
			dbms_output.put_line( '| Taille en Go (FreeSpace)     : ' || round(FREE_Size,2) );
			dbms_output.put_line( '| Taille en Go du TEMP         : ' || round(Temp_Size,2) );
			dbms_output.put_line( '+=======================================' );
			RatioVal  := ( Inst_Size + Temp_Size) / (Inst_Size-FREE_Size);
			dbms_output.put_line( '| Ratio Total/Utile            : ' || round(RatioVal,2) );
			dbms_output.put_line( '| ' );
			Inst_Size := Inst_Size + Temp_Size ;
		END IF;

		IF TABLESPACE = 'Null' THEN
		dbms_output.put_line( '+-------------------------+----------------+-----+-----++----------------+-----+-----+ +--------+--------+');
		dbms_output.put_line( '| Tablespace_Name         |     PHYRDS     |  %  |  %  ||     PHYWRTS    |  %  |  %  | | PHYRDS | PHYWRTS|');
		dbms_output.put_line( '|                         |                | IO  | Tps ||                | IO  | Tps | | >' ||
				to_char( PCT_RDS, '999' ) || '% | >' || to_char( PCT_WRI, '999' ) || '% |');
		dbms_output.put_line( '+-------------------------+----------------+-----+-----++----------------+-----+-----+ +--------+--------+');
		ELSE
			dbms_output.put_line(
			'+--------------------------------------------------------------------------------------------------------+' );
		END IF;
	END IF;

	SQL_DYN := ' SELECT TSNAME, Sum( PHYRDS_inc ) PHYRDS, Sum( PHYWRTS_inc) PHYWRTS, Sum( READTIM_inc) READTIM,  ';
	SQL_DYN := SQL_DYN || ' Sum( WRITETIM_inc) WRITETIM from ';
	SQL_DYN := SQL_DYN || ' ( select ss.snap_time stime, fs.FILENAME, fs.TSNAME, ';
	-------------------------------------------------------------------------------------------------------------------------
	SQL_DYN2 := ' decode(greatest(fs.PHYRDS, lag(fs.PHYRDS, 1, fs.PHYRDS)  over(partition by fs.FILENAME order by fs.snap_id)),  ';
	SQL_DYN2 := SQL_DYN2 || ' fs.PHYRDS, fs.PHYRDS - lag(fs.PHYRDS, 1, fs.PHYRDS)  ';
	SQL_DYN2 := SQL_DYN2 || ' over(partition by fs.FILENAME order by fs.snap_id),  fs.PHYRDS) PHYRDS_inc, ';
	SQL_DYN2 := SQL_DYN2 || ' decode(greatest(fs.PHYWRTS, lag(fs.PHYWRTS, 1, fs.PHYWRTS)   over(partition by fs.FILENAME order by fs.snap_id)),  ';
	SQL_DYN2 := SQL_DYN2 || ' fs.PHYWRTS, fs.PHYWRTS - lag(fs.PHYWRTS, 1, fs.PHYWRTS)  ';
	SQL_DYN2 := SQL_DYN2 || ' over(partition by fs.FILENAME order by fs.snap_id),  fs.PHYWRTS) PHYWRTS_inc, ';
	SQL_DYN2 := SQL_DYN2 || ' decode(greatest(fs.READTIM, lag(fs.READTIM, 1, fs.READTIM)  over(partition by fs.FILENAME order by fs.snap_id)),';
	SQL_DYN2 := SQL_DYN2 || ' fs.READTIM, fs.READTIM - lag(fs.READTIM, 1, fs.READTIM)  ';
	SQL_DYN2 := SQL_DYN2 || ' over(partition by fs.FILENAME order by fs.snap_id),  fs.READTIM) READTIM_inc, ';
	SQL_DYN2 := SQL_DYN2 || ' decode(greatest(fs.WRITETIM, lag(fs.WRITETIM, 1, fs.WRITETIM)  over(partition by fs.FILENAME order by fs.snap_id)),';
	SQL_DYN2 := SQL_DYN2 || '  fs.WRITETIM, fs.WRITETIM - lag(fs.WRITETIM, 1, fs.WRITETIM)  over(partition by fs.FILENAME order by fs.snap_id),  ';
	SQL_DYN2 := SQL_DYN2 || ' fs.WRITETIM) WRITETIM_inc, ';
	SQL_DYN2 := SQL_DYN2 || ' round(to_number (to_char (((ss.snap_time) - (LAG(ss.snap_time)  ';
	SQL_DYN2 := SQL_DYN2 || ' OVER (partition by fs.FILENAME ORDER BY ss.snap_time)))))*1440*60,0) DELTAs ';
	-------------------------------------------------------------------------------------------------------------------------
	SQL_DYN := SQL_DYN || SQL_DYN2;
	SQL_DYN := SQL_DYN || ' from stats$filestatxs fs, stats$snapshot ss  ';
	SQL_DYN := SQL_DYN || '	where ss.snap_time between to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_DYN := SQL_DYN || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	IF INSTANCE is not NULL THEN	SQL_DYN := SQL_DYN || ' and ss.instance_number = ' || INSTANCE ; 	END IF;
	SQL_DYN := SQL_DYN || '	and fs.dbid = ss.dbid  and fs.instance_number = ss.instance_number  ';
	SQL_DYN := SQL_DYN || ' and  fs.snap_id = ss.snap_id  ';
	SQL_DYN := SQL_DYN || '	UNION ';
	SQL_DYN := SQL_DYN || 'select ss.snap_time stime, fs.FILENAME, fs.TSNAME, ';
	SQL_DYN := SQL_DYN || SQL_DYN2;
	SQL_DYN := SQL_DYN || ' from stats$tempstatxs fs, stats$snapshot ss ';
	SQL_DYN := SQL_DYN || '	where ss.snap_time between to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_DYN := SQL_DYN || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	IF INSTANCE is not NULL THEN	SQL_DYN := SQL_DYN || ' and ss.instance_number = ' || INSTANCE ; 	END IF;
	SQL_DYN := SQL_DYN || '	and fs.dbid = ss.dbid  and fs.instance_number = ss.instance_number  ';
	SQL_DYN := SQL_DYN || ' and  fs.snap_id = ss.snap_id  ';
	SQL_DYN := SQL_DYN || ' ) ';
	IF TABLESPACE != 'Null' THEN	SQL_DYN := SQL_DYN || ' where TSNAME= ''' || TABLESPACE || ''' ';
		IF DATAFILE != 'Null' THEN	SQL_DYN := SQL_DYN || ' and FSNAME= ''' || DATAFILE  || ''' ';	END IF;
	ELSIF DATAFILE != 'Null' THEN		SQL_DYN := SQL_DYN || ' where FSNAME= ''' || DATAFILE  || ''' ';	END IF;
	SQL_DYN := SQL_DYN || ' group by TSNAME order by TSNAME';
	wTOTPHYRDS 	:= 0;	wTOTPHYWRTS	:= 0;	wTOTREADTIM	:= 0;	wTOTWRITETIM	:= 0;
	Open src for SQL_Dyn;	LOOP
		FETCH Src INTO wTSNAME, wPHYRDS, wPHYWRTS, wREADTIM, wWRITETIM;		EXIT WHEN Src%NOTFOUND;
		wTOTPHYRDS 	:= wTOTPHYRDS 	+ NVL( wPHYRDS   ,0 );	wTOTPHYWRTS	:= wTOTPHYWRTS	+ NVL( wPHYWRTS  ,0 );
		wTOTREADTIM	:= wTOTREADTIM	+ NVL( wREADTIM  ,0 );	wTOTWRITETIM	:= wTOTWRITETIM	+ NVL( wWRITETIM ,0 );
	END LOOP;	Close Src;
	IF wTOTPHYRDS	= 0 THEN	wTOTPHYRDS   := Null; 	END IF;	IF wTOTPHYWRTS	= 0 THEN	wTOTPHYWRTS  := Null; 	END IF;
	IF wTOTREADTIM	= 0 THEN	wTOTREADTIM  := Null; 	END IF;	IF wTOTWRITETIM = 0 THEN	wTOTWRITETIM := Null; 	END IF;
	Open src for SQL_Dyn;
	LOOP
		FETCH Src INTO wTSNAME, wPHYRDS, wPHYWRTS, wREADTIM, wWRITETIM;	EXIT WHEN Src%NOTFOUND;		wSTATUS  := '| ';
		IF 100*(wPHYRDS/wTOTPHYRDS) > PCT_RDS 	THEN	wSTATUS  := wSTATUS ||  'OK';	ELSE	wSTATUS  := wSTATUS ||  ' -'; END IF;
		wSTATUS  := wSTATUS ||  '/' ;
		IF 100*(wREADTIM/wTOTREADTIM) > PCT_RDS THEN	wSTATUS  := wSTATUS ||  'OK';	ELSE	wSTATUS  := wSTATUS ||  '- '; 	END IF;
		wSTATUS  := wSTATUS ||  '  | ' ;
		IF 100*(wPHYWRTS/wTOTPHYWRTS) > PCT_WRI THEN	wSTATUS  := wSTATUS ||  'OK';	ELSE	wSTATUS  := wSTATUS ||  ' -';	END IF;
		wSTATUS  := wSTATUS ||  '/' ;
		IF 100*(wWRITETIM/wTOTWRITETIM) > PCT_WRI THEN	wSTATUS  := wSTATUS ||  'OK';	ELSE	wSTATUS  := wSTATUS ||  '- ';	END IF;

		select instr( wSTATUS  ,  'OK', 1 ) INTO i from dual;
		if i >0 THEN	TBSList	:= TBSList || ', ''' || wTSNAME || '''';	END If;
		wSTATUS  := wSTATUS ||  '  | ' ;

		IF TABLESPACE = 'Null' AND upper(LSTMODE) NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ('TU2') THEN
			dbms_output.put_line( '| ' || RPAD( wTSNAME, 23) 				|| ' | ' ||
				to_char( wPHYRDS, '9999999999999' ) 					|| ' |' ||
				to_char( NVL( 100*(wPHYRDS/wTOTPHYRDS), 0 ), 		'99.9' ) 	|| '|' ||
				to_char( NVL( 100*(wREADTIM/wTOTREADTIM), 0 ), 		'999' ) 	|| ' || ' ||
				to_char( wPHYWRTS, '9999999999999' ) 					|| ' |' ||
				to_char( NVL( 100*(wPHYWRTS/wTOTPHYWRTS), 0 ), 		'99.9' ) 	|| '|' ||
				to_char( NVL( 100*(wWRITETIM/wTOTWRITETIM), 0 ), 	'999' ) 	|| ' | ' || wSTATUS  );
		END IF;
	END LOOP;
	Close Src;

	IF TABLESPACE = 'Null' AND upper(LSTMODE) NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ('TU2') THEN
		dbms_output.put_line(
		'+-------------------------+----------------+-----+-----++----------------+-----+-----+ +--------+--------+' );
		dbms_output.put_line(  '|      TOTAL              |' ||
			to_char( NVL( wTOTPHYRDS ,0), '99999999999999' ) || ' |100.0|100.0||' ||
			to_char( NVL( wTOTPHYWRTS,0), '99999999999999' ) || ' |100.0|100.0|' );
		dbms_output.put_line(
		'+-------------------------+----------------+-----+-----++----------------+-----+-----+');
	END IF;

	IF upper(LSTMODE) != 'EXTRACT'  AND LSTMODE NOT IN ('TU2') THEN
		dbms_output.put_line( 'INSTANCE_Number;TBS;FILENAME;SNAP_TIME;DEBIT PHYRDS(IO/s);ATPR(ms);DEBIT PHYWRTS(IO/s);ATPW(ms);' ||
		'READ(IO/Go/s);WRITE(IO/Go/s)' 	);	END IF;
	SELECT vsize(TBSList) INTO I FROM DUAL;	TBSList := substr( TBSList, 2, 9998999 );
	SQL_DYN := ' SELECT to_char( stime, ''' || FORMAT_DATE_SORTIE || ''' ) stime, TSNAME, ';
		IF FILEDET = 'N' THEN	SQL_DYN := SQL_DYN || ' '''', ';  ELSE	SQL_DYN := SQL_DYN || 'FILENAME, ';	END IF;
	SQL_DYN := SQL_DYN || ' Sum( PHYRDS_inc )	PHYRDS, ';
	SQL_DYN := SQL_DYN || '	Sum( PHYWRTS_inc) PHYWRTS, Sum( READTIM_inc) READTIM, Sum( WRITETIM_inc) WRITETIM, Avg ( DELTAs ) DELTAs ';
	SQL_DYN := SQL_DYN || ' from ( select ss.snap_time stime, fs.FILENAME, fs.TSNAME, ';
	SQL_DYN := SQL_DYN || SQL_DYN2;
	SQL_DYN := SQL_DYN || ' from stats$filestatxs fs, stats$snapshot ss ';
	SQL_DYN := SQL_DYN || '	where ss.snap_time between to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_DYN := SQL_DYN || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	IF INSTANCE is not NULL THEN	SQL_DYN := SQL_DYN || ' and ss.instance_number = ' || INSTANCE ; 	END IF;
	IF NVL( i , 0 ) > 0 	THEN	SQL_DYN := SQL_DYN || ' and fs.TSNAME IN ( ' || TBSList || ' )' ;	END IF;
	SQL_DYN := SQL_DYN || ' and fs.dbid = ss.dbid ';
	SQL_DYN := SQL_DYN || ' and fs.instance_number = ss.instance_number  ';
	SQL_DYN := SQL_DYN || ' and fs.snap_id = ss.snap_id  ';
	SQL_DYN := SQL_DYN || ' UNION ';
	SQL_DYN := SQL_DYN || '	select	ss.snap_time stime, fs.FILENAME, fs.TSNAME, ';
	SQL_DYN := SQL_DYN || SQL_DYN2;
	SQL_DYN := SQL_DYN || ' from stats$tempstatxs fs, stats$snapshot ss ';
	SQL_DYN := SQL_DYN || '	where ss.snap_time between to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_DYN := SQL_DYN || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	IF INSTANCE is not NULL THEN	SQL_DYN := SQL_DYN || ' and ss.instance_number = ' || INSTANCE ; 	END IF;
	IF NVL( i , 0 ) > 0	THEN	SQL_DYN := SQL_DYN || ' and fs.TSNAME IN ( ' || TBSList || ' )' ;	END IF;
	SQL_DYN := SQL_DYN || ' and fs.dbid = ss.dbid ';
	SQL_DYN := SQL_DYN || ' and fs.instance_number = ss.instance_number  ';
	SQL_DYN := SQL_DYN || ' and fs.snap_id = ss.snap_id  )';
		IF FILEDET = 'N'
		THEN	SQL_DYN := SQL_DYN || ' group by   to_char( stime, ''' || FORMAT_DATE_SORTIE || ''' ) , TSNAME ';
		ELSE	SQL_DYN := SQL_DYN || ' group by   to_char( stime, ''' || FORMAT_DATE_SORTIE || ''' ) , TSNAME, FILENAME ';
		END IF;
	SQL_DYN := SQL_DYN || ' order by TSNAME, stime ';
	Open src for SQL_Dyn;
	LOOP	FETCH Src INTO wSNAP_TIME, wTSNAME, wFILENAME, wPHYRDS, wPHYWRTS, wREADTIM, wWRITETIM, wDELTA;	EXIT WHEN Src%NOTFOUND;
		IF wDELTA != 0  THEN	wDEBITRDS	:= wPHYRDS /wDELTA;		wDEBITWRI	:= wPHYWRTS/wDELTA;
			IF wPHYRDS = 0	THEN	wATPR	:= 0;	ELSE	wATPR	:= 10*wREADTIM /wPHYRDS ; 		END IF;
			IF wPHYWRTS =0	THEN	wATPW	:= 0;	ELSE	wATPW	:= 10*wWRITETIM/wPHYWRTS;		END IF;
			IF wPHYRDS != 0 AND wPHYWRTS != 0 THEN
				IF LSTMODE = 'TU2' THEN
					select 	INSTANCE_NAME , HOST_NAME INTO wINSTANCE_NAME , wHOST_NAME  from v$instance;

					wCHAINE := '"' || to_char( to_date( wSNAP_TIME, 'YYYYMMDD HH24:MI' ), 'MM/DD/YYYY HH24:MI' ) ;
					wCHAINE := wCHAINE || '" PAS "newtermite" "' || wHOST_NAME || '" "' ||
						wINSTANCE_NAME || '"' || chr( 10 )|| chr( 10 );

					IF wCHAINE_OLD  != wCHAINE	THEN	wCHAINE_OLD := wCHAINE;	ELSE	wCHAINE_OLD := '';	END IF;
					wCHAINE := wCHAINE_OLD;		wCHAINE := wCHAINE || '"' || wTSNAME || '" ' ;
					IF wDEBITRDS	> 999999.9  THEN	wDEBITRDS := 999999.9;	END IF;
					IF wATPR	> 999999.9  THEN	wATPR 	  := 999999.9;	END IF;
					IF wDEBITWRI	> 999999.9  THEN	wDEBITWRI := 999999.9;	END IF;
					IF wATPW	> 999999.9  THEN 	wATPW  	  := 999999.9;	END IF;
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wDEBITRDS, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ' ';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wATPR, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ' ';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wDEBITWRI, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ' ';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wATPW, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ' ';
					-------------------------------------------------------------------------------------------
					-- Evalperf SAN
					wSAN_RDS	:= wDEBITRDS / Inst_Size;	wSAN_WRT	:= wDEBITWRI / Inst_Size;
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wSAN_RDS, '00.0000000' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ' ';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wSAN_WRT, '00.0000000' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ' ' || chr(10) ;		dbms_output.put_line( wCHAINE );
				ELSE	wCHAINE := '';
					IF upper(LSTMODE) = 'EXTRACT' THEN	wCHAINE := wEXTRACT ;	END IF;
					wCHAINE := wCHAINE || INSTANCE || ';' || wTSNAME || ' ; ' || wFILENAME || ' ; ' || wSNAP_TIME || ' ; ' ;
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wDEBITRDS, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ';';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wATPR, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ';';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char( wDEBITWRI, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ';';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wATPW, '999999.9' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ';';
					-------------------------------------------------------------------------------------------
					-- Evalperf SAN
					wSAN_RDS	:= wDEBITRDS / Inst_Size;
					wSAN_WRT	:= wDEBITWRI / Inst_Size;
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wSAN_RDS, '99.9999999' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ';';
					SELECT PERFSTAT.PKG_STATS.XLS_VAL( to_char(     wSAN_WRT, '99.9999999' ) ) INTO wVal FROM Dual;
					wCHAINE := wCHAINE || wVal || ';';
					-------------------------------------------------------------------------------------------
					dbms_output.put_line( wCHAINE );
				END IF;
			END IF;
		END IF;
	END LOOP;
	Close Src;

	IF LSTMODE NOT LIKE 'EXTRACT%' AND LSTMODE NOT IN ( 'TU2' ) THEN
		dbms_output.put_line( '--------------------------------------------------------------------------------------------------' );
		dbms_output.put_line( 'Rappel de la commande PKG_STATS :' );
		dbms_output.put_line( 'exec perfstat.PKG_STATS.suivi_io ( ''' || DATEDEB || ''', ''' || DATEFIN || ''', ''' ||
			LSTMODE || ''', ''' || FORMAT_DATE_SORTIE || ''' ,'  || PCT_RDS || ', ' ||
		PCT_WRI || ', ''' || TABLESPACE  || ''', ''' || DATAFILE || ''', ''' || FILEDET || '''  ,' || INSTANCE || ')' );  END IF;

	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
procedure Rubrique 		( DATEDEB VARCHAR DEFAULT NUll,  DATEFIN VARCHAR DEFAULT NUll, LSTMODE VARCHAR DEFAULT 'CSV',
				FORMAT_DATE_SORTIE VARCHAR DEFAULT 'YYYY/MM/DD', PRECO VARCHAR DEFAULT 'Y', INSTANCE Number DEFAULT 1,
				PRECISION NumBER DEFAULT 3, TYPEREST VARCHAR DEFAULT 'NORME', IDLE VARCHAR DEFAULT 'N', ZOOM VARCHAR DEFAULT Null )
IS	NB_Ano Number; PARAM1 Varchar(2000); PARAM2 Varchar(2000); PARAM3 Varchar(2000); PARAM4 Varchar(2000); PARAM5 Varchar(2000);
	PARAM6 Varchar(2000); PARAM7 Varchar(2000); PARAM8 Varchar(2000); PARAM9 Varchar(2000); PARAM10 Varchar(2000); wDATE1 Date;
	wDATE Date; wCHAINE Varchar(50); wFORMAT_DATE_SORTIE Varchar(50); Posit Number;
BEGIN	dbms_output.enable(10000000);
	NB_Ano := 0;		PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;
	PARAM6 := Null;		PARAM7 := Null;	PARAM8 := Null;	PARAM9 := Null;	PARAM10:= Null;
	-- DATEDEB
	IF DATEDEB Is NULL THEN
		NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	select instr( DATEDEB, ':', 1 ) INTO Posit from dual;
		IF NVL( POSIT, 12 )  = 12 or  POSIT = 0 THEN
			BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
			EXCEPTION WHEN OTHERS THEN		NB_Ano := NB_Ano + 1;
				PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;
		ELSE		NB_Ano := NB_Ano + 1;
				PARAM1 := 'Format de la date de Debut est INVALIDE ( ''YYYYMMDD HH24:MI'' ) ';	END IF;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN		NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	select instr( DATEFIN, ':', 1 ) INTO Posit from dual;
		IF NVL( POSIT, 12 ) = 12 or  POSIT = 0 THEN
			BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
			EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
				PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		ELSE	NB_Ano := NB_Ano + 1;	PARAM2 := 'Format de la date de fin est INVALIDE ( ''YYYYMMDD HH24:MI'' ) ';	END IF;

		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;
	END IF;
	-- LSTMODE
	IF upper(LSTMODE) NOT IN ('CSV', 'NORM', 'EXTRACT', 'EXTRACTXS', 'TQ', 'TU1' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';
	END IF;
	-- FORMAT_DATE_SORTIE
	IF  FORMAT_DATE_SORTIE Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le format de la date est NULL-ABSENT  ( ''YYYY/MM/DD HH24:MI'' ) ';
	ELSE	BEGIN	wFORMAT_DATE_SORTIE := '''' || FORMAT_DATE_SORTIE || '''';
			SELECT TO_CHAR( sysdate, FORMAT_DATE_SORTIE ) INTO wFORMAT_DATE_SORTIE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le format de date ''' || FORMAT_DATE_SORTIE || ''' est INVALIDE (''YYYYMMDD HH24:MI'') ';	END;	END IF;
	-- PRECO
	IF PRECO NOT IN ('Y', 'N', 'y', 'n' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM5 := 'Le parametre PRECO ''' || PRECO || ''' est incorrect ( ''Y'' ou ''N'' ) ';	END IF;
	-- INSTANCE
	-- PRECISION
	IF PRECISION < 0 OR PRECISION >10 THEN	NB_Ano := NB_Ano + 1;
		PARAM7 := 'Le parametre PRECISION ( ' || PRECISION || ' ) est incorrect ( >=0 et <=10 ) ';	END IF;
	-- TYPEREST
	IF TYPEREST NOT IN ('CUMUL', 'NORME', 'cumul', 'norme' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM8 := 'Le parametre TYPEREST( ''' || TYPEREST|| ''' ) est incorrect (NORME ou CUMUL) ';	END IF;
	-- IDLE
	IF IDLE NOT IN ('Y', 'N', 'y', 'n' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM5 := 'Le parametre IDLE ''' || IDLE || ''' est incorrect ( ''Y'' ou ''N'' ) ';	END IF;
	-- ZOOM
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN
	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE RUBRIQUE', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  FORMAT_DATE_SORTIE | Varchar | ' || RPAD( NVL( PARAM4, 'OK ( ''' || FORMAT_DATE_SORTIE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 5 |  PRECO              | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ''' || PRECO || ''' )'  ), 70 ) || '|' );
		IF INSTANCE Is Null THEN	wCHAINE := 'Null';	ELSE	wCHAINE := TO_CHAR( INSTANCE );		END IF;
		dbms_output.put_line( '| 6 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM6, 'OK ( ' || wCHAINE || ' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 7 |  PRECISION          | Number  | ' || RPAD( NVL( PARAM7, 'OK ( ' || PRECISION || ' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 8 |  TYPEREST           | Number  | ' || RPAD( NVL( PARAM8, 'OK ( ''' || TYPEREST || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 9 |  IDLE               | VARCHAR | ' || RPAD( NVL( PARAM9, 'OK ( ''' || IDLE || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '|10 |  ZOOM               | VARCHAR | ' || RPAD( NVL( PARAM10, 'OK ( ''' || ZOOM || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
		Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.Rubrique( ''' || DATEDEB || ''', ''' || DATEFIN || ''', ''' || LSTMODE
				|| ''', ''' || FORMAT_DATE_SORTIE || ''', ''Y'' '
				|| ', ' || 	NVL( To_char( INSTANCE ), 'Null' )
				|| ', ' || PRECISION
				|| ', ''' || TYPEREST || ''', ''' || IDLE || ''')' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SYSTEM_EVENT' , 'STATS$SYSSTAT') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$SYSTEM_EVENT' , 'STATS$SYSSTAT');
		ELSE	rubrique_proc( DATEDEB, DATEFIN, upper(LSTMODE) , FORMAT_DATE_SORTIE,
				upper(PRECO), INSTANCE, PRECISION, TYPEREST, upper(IDLE), ZOOM );	END IF;	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure ShowSql 	( wHASH_VALUE Number , wEXTRACT Varchar DEFAULT Null)
IS 	SQL_Order_Dyn Varchar( 1000 ); wSQL_TEXT Varchar( 1000 ); wSQL_Affiche Varchar( 1000 ); wSQL_TEXTLast Varchar( 1000 ); i Integer;
	j Integer; k Integer; TYPE DataSource IS REF CURSOR; Sql_Order DataSource ; Src DataSource ; NB_CAR Number; WLAST_SNAP_ID Number;
	DBVersion Number; Nbligne Number; wSQL_ID VARCHAR2(13); wSearch VARCHAR2(100); wCRIT VARCHAR2(100);
BEGIN	NB_CAR := 120;	Nbligne := 0;  select to_number( substr( version, 1, instr( version, '.' , 1  )-1) ) INTO DBVersion from v$instance;
	IF DBVersion >= 10 THEN		wSearch := 'Stats$';
		BEGIN	SQL_Order_Dyn :='SELECT SQL_ID FROM PERFSTAT.STATS$SQL_SUMMARY WHERE rownum =1 AND ';
			SQL_Order_Dyn := SQL_Order_Dyn || '( OLD_';	SQL_Order_Dyn := SQL_Order_Dyn || 'HASH_VALUE=' || wHASH_VALUE;
			SQL_Order_Dyn := SQL_Order_Dyn || 'OR ';	SQL_Order_Dyn := SQL_Order_Dyn || 'HASH_VALUE=' || wHASH_VALUE;
			SQL_Order_Dyn := SQL_Order_Dyn || ') ';
			open Src for SQL_Order_Dyn;	FETCH Src INTO wSQL_ID;		Close Src;
		EXCEPTION WHEN OTHERS THEN 	Close Src;	END;
		IF wSQL_ID Is NOT Null
		THEN	wCRIT   := 'Sql_ID (' || wSQL_ID || ')';
			SQL_Order_Dyn :='SELECT SQL_TEXT, LAST_SNAP_ID from perfstat.STATS$SQLTEXT WHERE SQL_ID =''' ;
			SQL_Order_Dyn := SQL_Order_Dyn || wSQL_ID || ''' 	order by PIECE';
		ELSE	wCRIT   := 'Hash_Value (' || wHASH_VALUE || ')';
			SQL_Order_Dyn :='SELECT SQL_TEXT, LAST_SNAP_ID from perfstat.STATS$SQLTEXT WHERE OLD_HASH_VALUE =' ;
			SQL_Order_Dyn := SQL_Order_Dyn || wHASH_VALUE || ' 	order by PIECE';	END IF;
	ELSE	wSearch := 'Stats$';
		wCRIT   := 'Hash_Value';
		SQL_Order_Dyn :='SELECT SQL_TEXT, LAST_SNAP_ID from perfstat.STATS$SQLTEXT WHERE HASH_VALUE =' ;
		SQL_Order_Dyn := SQL_Order_Dyn || wHASH_VALUE || ' 	order by PIECE';	END IF;
	wSQL_Affiche := '';	wSQL_TEXTLast := '';
	BEGIN	OPEN Sql_Order FOR SQL_Order_Dyn;	fetch Sql_Order INTO wSQL_TEXT, wLAST_SNAP_ID;	END;
	IF wSQL_TEXT is null then	wSearch := 'MemorY';	wCRIT   := 'Hash_Value';
		Select SQL_TEXT INTO wSQL_TEXT from v$sqlarea where HASH_VALUE = wHASH_VALUE;	END IF;
	IF wEXTRACT Is NULL
	THEN	dbms_output.Put_Line(  '| ' || RPAD( 'Recherche ' || wSearch || ' ---> ' || wCRIT , 56 ) || ' |' );
		dbms_output.Put_Line(  '+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+' );	END IF;
	LOOP	-- Formatage de la chaine de caractere SQL
		k :=  1;	WHILE k <= length( wSQL_TEXT )
		LOOP	IF ascii( substr( wSQL_TEXT, k, 1 ) ) = 13 THEN
			wSQL_TEXT := substr( wSQL_TEXT, 1, k-1 ) || ' ' || substr( wSQL_TEXT, k+1, 999999 );		END IF;
			k := k + 1;		END LOOP;
		------------------------------------------------------------------------------------------------------------
		wSQL_TEXT := NVL( wSQL_TEXTLast, '' ) || NVL( wSQL_TEXT, '' );
		While ( instr( wSQL_TEXT, ' ' ) > 0 )
		LOOP	i := instr( wSQL_TEXT, ' ' );	j := length ( wSQL_Affiche );
			If ( i+j ) < Nb_Car THEN	wSQL_Affiche := wSQL_Affiche || substr( wSQL_TEXT, 1, i );
				wSQL_TEXT    := substr( wSQL_TEXT, i+1, 2000 );
			ELSE
				-- Ecriture de la ligne contenant le SQL
				IF wEXTRACT Is null
				THEN	dbms_output.Put_Line( wSQL_Affiche );
				ELSE	IF wSQL_Affiche is not null THEN
					dbms_output.Put_Line( wEXTRACT || wHASH_VALUE || ';' ||
					nbligne || ';' || wSQL_Affiche );
					nbligne := nbligne + 1;
					END IF;
				END IF;
				wSQL_Affiche := substr( wSQL_TEXT, 1, i );	wSQL_TEXT    := substr( wSQL_TEXT, i+1, 2000 );
			END IF;
		END LOOP;

		IF length( wSQL_TEXT ) > Nb_Car THEN
			wSQL_TEXT    := wSQL_Affiche || wSQL_TEXT;
			wSQL_Affiche := '';
			WHILE( length( wSQL_TEXT ) > Nb_Car )
			LOOP
				IF wEXTRACT Is null
				THEN	dbms_output.put_line( substr( wSQL_TEXT, 1, Nb_Car ) );
				ELSE	dbms_output.put_line( wEXTRACT || wHASH_VALUE || ';' ||
						nbligne || ';' || substr( wSQL_TEXT, 1, Nb_Car ) );
					nbligne := nbligne + 1;
				END IF;
				wSQL_TEXT := substr( wSQL_TEXT, Nb_Car+1, 2000 ) ;
			END LOOP;
		END IF;
		wSQL_TEXTLast := wSQL_TEXT;

		fetch Sql_Order INTO wSQL_TEXT, wLAST_SNAP_ID;
		EXIT WHEN Sql_Order%NOTFOUND;
	END LOOP;
	CLOSE Sql_Order;
	--	Ecriture de la fin de la ligne contenant le SQL
	IF wEXTRACT Is null
	THEN	dbms_output.Put_Line( wSQL_Affiche || wSQL_TEXT );
	ELSE	dbms_output.put_line( wEXTRACT || wHASH_VALUE || ';' || nbligne || ';' || wSQL_Affiche || wSQL_TEXT );
		nbligne := nbligne + 1;
	END IF;
EXCEPTION WHEN OTHERS THEN IF wSQL_TEXT Is NULL THEN	dbms_output.Put_Line( '=> SQL Non trouve.' );
		ELSE	dbms_output.Put_Line( 'wSQL_TEXT:' ||wSQL_TEXT );	dbms_output.Put_Line( 'wSQL_TEXTLast:' || wSQL_TEXTLast );
			dbms_output.Put_Line( '=> Erreur Formatage SQL.' );	END IF;	END;
---------------------------------------------------------------------------------------------------------------------
procedure TOPSQL_proc		( DATEDEB IN varchar, DATEFIN IN varchar, LSTMODE IN varchar DEFAULT 'CSV', PARAM IN varchar,
				TOP IN NUMBER DEFAULT 5, ShowSQL IN Varchar Default 'N', ExplainP IN Varchar Default 'N',
				INSTANCE IN NUMBER DEFAULT Null, FILTRE IN VARCHAR DEFAULT Null, MODULE IN VARCHAR DEFAULT Null,
				HASHVALUE IN NUMBER DEFAULT Null, PLANSTAT IN VARCHAR DEFAULT 'N', ZOOM IN VARCHAR DEFAULT Null )
IS	TYPE Element_Analytique IS RECORD (HASH_VALUE Number, MODULE Varchar(100), DISK_READS Number, BUFFER_GETS Number, CPU_TIME Number,
	ELAPSED_TIME Number, EXECUTIONS Number, Conso Number); Type Matrice_analytique IS TABLE OF Element_Analytique index by binary_integer;
	ANALYTIK Matrice_analytique; a number; amax number; TYPE DataSource IS REF CURSOR; Src DataSource; Src2 DataSource; Src3 DataSource;
	Src4 DataSource ; SQL_Dyn2 Varchar(1000); SQL_Dyn Varchar(32767); SQL_Dyn_Sel Varchar(32767); SQL_Dyn_Sel2 Varchar(32767);
	SQL_Dyn_Group Varchar(32767); SQL_Dyn_Group2 Varchar(32767); SQL_Dyn_Final Varchar(32767); SQL_Dyn_Tmp Varchar(32767); wPARAM VARCHAR(25);
	TotalConso Number; RATIO Number; Echantillon Number; oVersion Number; wModule Varchar(100); wModuleConso Number; wModuleCPU_TIME Number;
	wModuleELAPSED_TIME Number; wModuleEXECUTIONS Number; wCHAINE Varchar(10000); wCHAINE2 Varchar(10000); i Number; j Number; k Number;
	l Number; wSTIME Varchar(20); wHASH_VALUE Varchar(30); wBUFFER_GETS Number; wCPU_TIME Number; wELAPSED_TIME Number; wEXECUTIONS Number;
	wEXTRACT Varchar(100); wOLD_HASH Number; wBORNE_MINI Varchar(40); wDEBUG Number; wDIV Number; wDELAY Number; NB_PLAN Number;
 	wLEVEL Number; wExplainP Varchar(5); SPLAN Varchar(5); TXT Varchar(1000); ELight Number; wDateLimit Date; HMIN Varchar(25); HMAX Varchar(25);
Begin	dbms_output.enable(10000000);	wDEBUG := 0;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	select perfstat.PKG_STATS.CheckVal('TOPSQL', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; END IF;
	IF substr(PARAM, 1, 5) = 'RATIO' THEN	wPARAM := substr(PARAM, 6, 50);	RATIO := 1;
	ELSE	wPARAM := PARAM;	RATIO  := 0;	END IF;
	select to_number( substr( VERSION, 1, instr( VERSION, '.' )-1 )  ) INTO Oversion FROM v$instance;
	select to_char( to_date(  DATEDEB, 'YYYYMMDD HH24:MI' ) - (1440/1440), 'YYYYMMDD HH24:MI' ) INTO wBORNE_MINI from dual;
	SELECT MAx( SNAP_LEVEL ) INTO wLEVEL	from stats$snapshot
	Where	SNAP_TIME between to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) AND to_date( DATEFIN, 'YYYYMMDD HH24:MI' );
	IF Oversion = 8  THEN	wDIV := 1000; 	ELSE	wDIV := 1000000;  END IF;
	IF upper( LSTMODE ) NOT IN ( 'EXTRACT' , 'TQ' ) THEN
dbms_output.put_line( '     /---------------------------------------------------+' );

dbms_output.put_line( RPAD( PKG_STATS.VERSION || ' /     TOP ' || TOP || ' SQL avec le crit? ' || PARAM , 57 ) || '|' );
	IF HASHVALUE Is NULL THEN	dbms_output.put_line( '___/                                                     |' );
	ELSE	dbms_output.put_line( RPAD( '___/      HASHVALUE = ' || HASHVALUE, 57 ) || '|' );	END IF;
dbms_output.put_line( RPAD( '| /       '  , 57 ) || '|' );
dbms_output.put_line( RPAD( '|/      Tuning : ' || PERFSTAT.PKG_STATS.version ||  '  (CPU - ELAPSED en secondes)' , 57 ) || '|' );
dbms_output.put_line( '/--------------------------------------------------------+' );
		IF FILTRE Is NOT NULL THEN
		dbms_output.put_line( '! ! ! ATTENTION : Cette restitution ne contient que les SQL de type : ' || FILTRE || '%' );
		dbms_output.put_line( '-------------------------------------------------------------------------------------------------' );
		END IF;
		IF ExplainP = 'Y' THEN	IF wLEVEL > 5
			THEN 	dbms_output.put_line( '* Le Niveau Max de STATSPACK est : ' ||  to_char(wLEVEL, '9' ) || ' (Suivi PLAN ACTIF)'  );
				SPLAN     := 'Y';	wExplainP := 'N';
			ELSE 	dbms_output.put_line( '* Le Niveau Max de STATSPACK est : ' ||
				to_char(wLEVEL, '9' ) || ' - Plan(s) en memoire UNIQUEMENT'  );	SPLAN     := 'N';	wExplainP := 'Y';
			END IF;		dbms_output.put_line(
			'-------------------------------------------------------------------------------------------------' );
		ELSE	SPLAN 	  := 'N';	wExplainP := 'N';	END IF;	END IF;
	----------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn_Sel2 :=  'select  hash_value, module,  ';
	SQL_Dyn_Sel2 :=  SQL_Dyn_Sel2 || ' sum(' || wPARAM || '_inc)' || wPARAM || ',' ;
	SQL_Dyn_Sel :=  'select  hash_value, '''',   ';
	SQL_Dyn_Sel :=  SQL_Dyn_Sel || ' sum(' || wPARAM || '_inc)' || wPARAM || ',' ;
	----------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  ' sum(cpu_time_inc) cpu_timez, ';
	SQL_Dyn :=  SQL_Dyn || ' sum(elapsed_time_inc) elapsed_timez, ';
	SQL_Dyn :=  SQL_Dyn || ' sum(executions_inc) executionsz ';
	SQL_Dyn :=  SQL_Dyn || ' from    (select ';
	SQL_Dyn :=  SQL_Dyn || '  ss.snap_time stime, ';
	SQL_Dyn :=  SQL_Dyn || ' sq.hash_value, sq.module, ';
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.disk_reads, lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.disk_reads, sq.disk_reads - lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.disk_reads) disk_reads_inc, decode(greatest(sq.buffer_gets, lag(sq.buffer_gets, 1, sq.buffer_gets)  ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.buffer_gets, sq.buffer_gets - lag(sq.buffer_gets, 1, sq.buffer_gets) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.buffer_gets) buffer_gets_inc, ';
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.executions, lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.executions, sq.executions - lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.executions) executions_inc, ';
	IF Oversion  = 8	THEN		SQL_Dyn :=  SQL_Dyn || ' 0 cpu_time_inc, ';
	ELSE	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.cpu_time, lag(sq.cpu_time, 1, sq.cpu_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value ';
		SQL_Dyn :=  SQL_Dyn || ' order by sq.snap_id)), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.cpu_time, sq.cpu_time - lag(sq.cpu_time, 1, sq.cpu_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.cpu_time)/' || wDIV || ' cpu_time_inc, ';	END IF;
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.sorts, lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.sorts, sq.sorts - lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.sorts) sorts_inc, ';
	IF Oversion  >= 10 THEN SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.JAVA_EXEC_TIME, lag(sq.JAVA_EXEC_TIME, 1, sq.JAVA_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.JAVA_EXEC_TIME, sq.JAVA_EXEC_TIME - lag(sq.JAVA_EXEC_TIME, 1, sq.JAVA_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.JAVA_EXEC_TIME) JAVA_EXEC_TIME_inc, ';	END IF;
IF Oversion  >= 10 THEN SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.APPLICATION_WAIT_TIME, lag(sq.APPLICATION_WAIT_TIME, 1, sq.APPLICATION_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.APPLICATION_WAIT_TIME, sq.APPLICATION_WAIT_TIME - lag(sq.APPLICATION_WAIT_TIME, 1, sq.APPLICATION_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.APPLICATION_WAIT_TIME) APPLICATION_WAIT_TIME_inc, ';	END IF;
IF Oversion  >= 10 THEN SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.CONCURRENCY_WAIT_TIME, lag(sq.CONCURRENCY_WAIT_TIME, 1, sq.CONCURRENCY_WAIT_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
SQL_Dyn :=  SQL_Dyn || ' sq.CONCURRENCY_WAIT_TIME, sq.CONCURRENCY_WAIT_TIME - lag(sq.CONCURRENCY_WAIT_TIME, 1, sq.CONCURRENCY_WAIT_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
SQL_Dyn :=  SQL_Dyn || ' sq.CONCURRENCY_WAIT_TIME) CONCURRENCY_WAIT_TIME_inc, ';	END IF;
IF Oversion  >= 10 THEN	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.CLUSTER_WAIT_TIME, lag(sq.CLUSTER_WAIT_TIME, 1, sq.CLUSTER_WAIT_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
SQL_Dyn :=  SQL_Dyn || ' sq.CLUSTER_WAIT_TIME, sq.CLUSTER_WAIT_TIME - lag(sq.CLUSTER_WAIT_TIME, 1, sq.CLUSTER_WAIT_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
SQL_Dyn :=  SQL_Dyn || ' sq.CLUSTER_WAIT_TIME) CLUSTER_WAIT_TIME_inc, '; END IF;
IF Oversion  >= 10 THEN SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.USER_IO_WAIT_TIME, lag(sq.USER_IO_WAIT_TIME, 1, sq.USER_IO_WAIT_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
SQL_Dyn :=  SQL_Dyn || ' sq.USER_IO_WAIT_TIME, sq.USER_IO_WAIT_TIME - lag(sq.USER_IO_WAIT_TIME, 1, sq.USER_IO_WAIT_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
SQL_Dyn :=  SQL_Dyn || ' sq.USER_IO_WAIT_TIME) USER_IO_WAIT_TIME_inc, ';	END IF;
IF Oversion  >= 10 THEN	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.PLSQL_EXEC_TIME, lag(sq.PLSQL_EXEC_TIME, 1, sq.PLSQL_EXEC_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
SQL_Dyn :=  SQL_Dyn || ' sq.PLSQL_EXEC_TIME, sq.PLSQL_EXEC_TIME - lag(sq.PLSQL_EXEC_TIME, 1, sq.PLSQL_EXEC_TIME) ';
SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
SQL_Dyn :=  SQL_Dyn || ' sq.PLSQL_EXEC_TIME) PLSQL_EXEC_TIME_inc, ';	END IF;
	IF Oversion  = 8	THEN	SQL_Dyn :=  SQL_Dyn || ' 0 FETCHES_inc, ';
	ELSE	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.FETCHES, lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.FETCHES, sq.FETCHES - lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.FETCHES) FETCHES_inc, ';	END IF;
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.LOADS, lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.LOADS, sq.LOADS - lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.LOADS) LOADS_inc, ';
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.PARSE_CALLS, lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PARSE_CALLS, sq.PARSE_CALLS - lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PARSE_CALLS) PARSE_CALLS_inc, ';
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.ROWs_PROCESSED, lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.ROWs_PROCESSED, sq.ROWs_PROCESSED - lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.ROWs_PROCESSED) ROWs_PROCESSED_inc, ';
	IF Oversion  = 8	THEN	SQL_Dyn :=  SQL_Dyn || ' 0 elapsed_time_inc ';
	ELSE	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.elapsed_time, lag(sq.elapsed_time, 1, sq.elapsed_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.elapsed_time, sq.elapsed_time - lag(sq.elapsed_time, 1, sq.elapsed_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.elapsed_time)/' || wDIV || ' elapsed_time_inc ';	END IF;
	-----------------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' from stats$sql_summary sq, stats$snapshot ss ';
	SQL_Dyn :=  SQL_Dyn || ' where ';
	SQL_Dyn :=  SQL_Dyn || ' ss.snap_time between to_date( ''' || wBORNE_MINI || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn :=  SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	IF INSTANCE Is not NULL THEN	SQL_Dyn :=  SQL_Dyn || ' and ( ss.instance_number = ' || INSTANCE || ' ) ';	END IF;
	SQL_Dyn :=  SQL_Dyn || ' and sq.dbid = ss.dbid ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.instance_number = ss.instance_number ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.snap_id = ss.snap_id ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.executions between 0 and 999999999999999 ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.disk_reads between 0 and 999999999999999 ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.buffer_gets between 0 and 999999999999999 ';
	-----------------------------------------------------------------------------------------------------------------
	IF Oversion  > 8	THEN	SQL_Dyn :=  SQL_Dyn || ' and sq.cpu_time between 0 and 999999999999999 ';
		SQL_Dyn :=  SQL_Dyn || ' and sq.elapsed_time between 0 and 999999999999999 ';	END IF;
	-----------------------------------------------------------------------------------------------------------------------
	IF HASHVALUE Is NOT Null THEN 	SQL_Dyn :=  SQL_Dyn || ' and sq.HASH_VALUE = ' || HASHVALUE ; 	END IF;
	IF MODULE Is not null THEN	IF MODULE = 'NON RENSEIGNE'
		THEN	SQL_Dyn :=  SQL_Dyn || ' and sq.module Is null ';  ELSE	SQL_Dyn :=  SQL_Dyn || ' and sq.module = ''' || MODULE || ''' ';
		END IF;	END IF;
	IF FILTRE IS NOT NULL THEN 	SQL_Dyn :=  SQL_Dyn || ' and upper( sq.TEXT_SUBSET ) like ''' || FILTRE || '%''';	END IF;
	SQL_Dyn :=  SQL_Dyn || ' ) ';
	------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn  || ' where stime >= to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn_Group2 :=  ' group by hash_value, module ';
	SQL_Dyn_Group2 :=  SQL_Dyn_Group2 || ' having sum(' ||  wPARAM || '_inc) > 0 ';
	SQL_Dyn_Group :=  ' group by hash_value  ';
	SQL_Dyn_Group :=  SQL_Dyn_Group || ' having sum(' ||  wPARAM || '_inc) > 0 ';
	IF RATIO = 0 	THEN	SQL_Dyn_Group :=  SQL_Dyn_Group || ' order by ' || wPARAM || ' desc ';
	ELSE	SQL_Dyn_Group :=  SQL_Dyn_Group || ' order by ' || wPARAM || '/DECODE( sum(executions_inc) ,0, 1, sum(executions_inc)) desc ';
	END IF;	SQL_Dyn_Final := SQL_Dyn_Sel || ' ' || SQL_Dyn || ' ' || SQL_Dyn_Group ;
	IF wDEBUG = 1 OR wDEBUG = 9 THEN
		dbms_output.put_line( substr( SQL_Dyn_Final,   1, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final, 201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final, 401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final, 601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final, 801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,1001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,1401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,1801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,2201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,2601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,3001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,3401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,3801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,4001, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,4201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,4401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,4601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,4801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,5001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,5201, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,5401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,5601, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,5801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,6001, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,6201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,6401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,6601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,6801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,7001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,7201, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,7401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,7601, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,7801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,8001, 200 ));
	END IF;

	-- Chargement des donnees analytiques et calcul du total conso
	TotalConso := 0;
	OPEN src for SQL_Dyn_Final;
	a := 1;
	LOOP	FETCH src INTO	analytik(a).HASH_VALUE, analytik(a).MODULE, analytik(a).CONSO,
		analytik(a).CPU_TIME, analytik(a).ELAPSED_TIME, analytik(a).EXECUTIONS;
		EXIT WHEN Src%NOTFOUND;

		IF analytik(a).EXECUTIONS = 0 THEN
			analytik(a).EXECUTIONS := 1;
		END IF;

		TotalConso := TotalConso + analytik(a).Conso ;
		a := a + 1;
	END LOOP;
	amax := a;
	Close Src;

	-- Affichage du TOP x HASH_VALUE
	If upper( LSTMODE ) NOT IN ( 'EXTRACT' , 'TQ' ) THEN
		wChaine := 'No;     Hash_Value;' || rpad( wPARAM, 15 ) || ';  EXECUTIONS;    CPU_TIME;ELAPSED_TIME;%TOTAL(' || wPARAM || ');';
		IF RATIO = 1 THEN
			wChaine := wChaine || wPARAM || '/EXEC' || ';';
		END IF;

		wChaine := wChaine ||   'NbPLAN(STATS$)';
		dbms_output.put_line( wChaine );
	END IF;

	a := 1;
	Echantillon := 0;
	While a < amax
	LOOP
		if a <= TOP then
			If upper( LSTMODE ) IN ( 'EXTRACT' , 'TQ' ) THEN
				select 'TU5;' || INSTANCE_NAME || ';' || HOST_NAME || ';' INTO wEXTRACT from v$instance;
				wEXTRACT := wEXTRACT || DATEDEB || ';' || INSTANCE || ';' || wPARAM;

				dbms_output.put_line( wEXTRACT				|| ';' ||
				rpad( to_char( a , '009' ), 5 ) 			|| ';' ||
				LPAD( analytik(a).HASH_VALUE, 13 )			|| ';' ||
				LPAD( TO_char( analytik(a).Conso,'9999999999999' ), 15 ) || ';' ||
				To_char( analytik(a).EXECUTIONS, '99999999999' )	|| ';' ||
				To_char( analytik(a).CPU_TIME,    '99999999999' )	|| ';' ||
				To_char( analytik(a).ELAPSED_TIME, '99999999999' )	|| ';' ||
				To_char( 100*analytik(a).Conso/TotalConso, '999.99' ) );
			ELSE	IF Oversion  >= 9 THEN		SQL_Dyn_Tmp := 'select count(*) from ( ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' select	pu.HASH_VALUE, pu.plan_hash_value ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' from	stats$sql_plan_usage	pu, ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' stats$snapshot		ss ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' Where 	pu.dbid = ss.dbid ';
					IF INSTANCE Is NOT NULL THEN
						SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and	ss.instance_number = ' || INSTANCE;	END IF;
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and ss.snap_time between to_date( ''' || DATEDEB ;
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ''', ''YYYYMMDD HH24:MI'' ) ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and pu.instance_number = ss.instance_number ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and pu.snap_id = ss.snap_id ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || '	and pu.HASH_VALUE = ' || analytik(a).HASH_VALUE;
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' group by pu.HASH_VALUE, pu.plan_hash_value )';
					OPEN Src3 FOR SQL_Dyn_Tmp;	FETCH Src3 INTO NB_Plan;	Close Src3;		END IF;

				wCHAINE  := rpad( to_char( a , '009' ), 5 ) 			|| ';' ;
				wCHAINE  := wCHAINE  || LPAD( analytik(a).HASH_VALUE, 13 )	|| ';' ||
						LPAD( TO_char( analytik(a).Conso,'999999999999' ), 15 ) || ';' ||
					To_char( analytik(a).EXECUTIONS, '99999999999' )	|| ';' ;
				wCHAINE2 := To_char( analytik(a).CPU_TIME,    '999999999.99' )	|| ';' ;
				SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
				wCHAINE  := wCHAINE  || wCHAINE2 ;
				wCHAINE2 := To_char( analytik(a).ELAPSED_TIME, '999999999.99' )	|| ';' ;
				SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
				wCHAINE  := wCHAINE  || wCHAINE2 ;
				wCHAINE2 := To_char( 100*analytik(a).Conso/TotalConso, '999.99' ) ;
				SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
				wCHAINE  := wCHAINE  || wCHAINE2 ;
				IF RATIO = 1 THEN
					wCHAINE2 := To_char( analytik(a).Conso / analytik(a).EXECUTIONS,    '999999999.99' ) ;
					SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
					wCHAINE  := wCHAINE  || ';' || wCHAINE2 ;
				END IF;

				IF Oversion  >= 9 THEN	dbms_output.put_line( wCHAINE || '; ' || NB_Plan || ' plan(s) execution ' );
				ELSE	dbms_output.put_line( wCHAINE || '; '   );	END IF;
			END IF;
			Echantillon := Echantillon + (100*analytik(a).Conso/TotalConso);
		END IF;
		a := a + 1;
	END LOOP;
	If upper( LSTMODE ) NOT IN ( 'EXTRACT' , 'TQ' ) THEN
		dbms_output.put_line(
		'+--------------------------------------------------------------+-----------------------+-----------+---> Echantillon=' ||
		round(Echantillon) || '% ' );
	END IF;

	-- Affichage du TOP x MODULE
	IF LSTMODE not in ( 'EXTRACT' , 'extract', 'TQ', 'tq' ) THEN
		SQL_Dyn_Sel :=  'select  module,  ' || ' sum( ' || wPARAM || ' ) ' || wPARAM;
		SQL_Dyn_Sel := SQL_Dyn_Sel  || ' from ';
		SQL_Dyn_Group :=  ' group by module order by 2 desc ';
		SQL_Dyn_Final := SQL_Dyn_Sel2 || ' ' || SQL_Dyn || ' ' || SQL_Dyn_Group2 ;
		SQL_Dyn_Final := SQL_Dyn_Sel || ' ( ' || SQL_Dyn_Final || ' ) ' || SQL_Dyn_Group ;
		IF MODULE IS Null THEN
			dbms_output.put_line( '|       Module                                                 | ' || RPAD( wPARAM, 22 ) || '| % / TOTAL |' );
			dbms_output.put_line( '+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + - - - - - - - - - - - + - - - - - +' );

			If WDEBUG = 2 OR WDEBUG = 9 THEN
			dbms_output.put_line( substr( SQL_Dyn_Final,   1, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final, 201, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final, 401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final, 601, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final, 801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,1001, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,1401, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,1801, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,2201, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,2601, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,3001, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,3401, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,3801, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,4001, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,4201, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,4401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,4601, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,4801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,5001, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,5201, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,5401, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,5601, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,5801, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,6001, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,6201, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,6401, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,6601, 200 ));
			dbms_output.put_line( substr( SQL_Dyn_Final,6801, 200 ));	dbms_output.put_line( substr( SQL_Dyn_Final,7001, 200 ));
			END IF;

			OPEN src for SQL_Dyn_Final;
			LOOP	FETCH src INTO wModule, wModuleConso;	EXIT WHEN Src%NOTFOUND;
				IF ( 100*(wModuleConso/TotalConso )>=.01 )
				THEN	dbms_output.put_line( '| ' || RPAD( NVL( wModule, 'NON RENSEIGNE') , 61 ) || '| ' ||
					LPAD( to_char( wModuleConso, '999999999999999' ) , 20 ) || '  |' ||
					RPAD( To_char( 100*(wModuleConso/TotalConso) , '999.99' ), 10 ) ||' |'  );	END IF;
			END LOOP;
			Close Src;

			dbms_output.put_line(
			'+--------------------------------------------------------------+-----------------------+-----------+---------------+' );
			dbms_output.put_line(
			'| Consulter l''evolution des consommations en fonction des modules                                                  |' );
			dbms_output.put_line(
		RPAD( '| exec PERFSTAT.PKG_STATS.TopMODULE( ''' || DATEDEB || ''', ''' || DATEFIN || ''', ''CSV'', ''DISK_READS'', 1, Null)' , 115 ) || '|');
			dbms_output.put_line(
			'+------------------------------------------------------------------------------------------------------------------+' );
		ELSE
			wChaine := 'Restitution uniquement pour le module : ' || MODULE  ;
			IF MODULE = 'NON RENSEIGNE' THEN	wChaine := wChaine || ' ( cad = Null ) ';	END IF;
			dbms_output.put_line( wChaine );
		END IF;
	END IF;


	IF (ShowSQL = 'Y') OR (wExplainP = 'Y') OR (SPLAN = 'Y') THEN
		a := 1;
		While  a <= TOP
		LOOP
			IF upper(LSTMODE) NOT IN ( 'EXTRACT' , 'TQ' ) THEN
				dbms_output.put_line ('+----------------------------------------------------------+');
				dbms_output.put_line ( RPAD( '| SQL Identifie N°' || a || ' HASH_VALUE : ' ||
				analytik(a).HASH_VALUE, 59)  || '|' );

				wEXECUTIONS := analytik(a).EXECUTIONS ;
				IF wEXECUTIONS = 0 THEN wEXECUTIONS := 1 ; END IF;
				dbms_output.put_line ( RPAD( '| ' || wPARAM || '/exec : ' ||
				round( ( analytik(a).Conso ) / wEXECUTIONS, 3 ) , 59 )|| '|' );
				dbms_output.put_line ( '|                                                          |' );
				dbms_output.put_line ( '| Modules                                                  |' );
				l := 1;
				BEGIN	Open Src4 for
					select distinct ss.module
					from 	perfstat.stats$sql_summary ss,  perfstat.stats$snapshot sn
					where 	ss.HASH_VALUE = analytik(a).HASH_VALUE
					and 	sn.snap_time >= to_date( DATEDEB, 'YYYYMMDD HH24:MI' )
					and 	sn.snap_time <= to_date( DATEFIN, 'YYYYMMDD HH24:MI' )
					and	sn.snap_id = ss.snap_id;

					LOOP
						FETCH src4 INTO wMODULE;
						EXIT WHEN Src4%NOTFOUND;
						dbms_output.put_line ( '| ' || l || '. '  || RPAD( NVL( wMODULE, ' ' ), 54 ) || '|'  );
						l := l + 1 ;
					END LOOP;	Close Src4;
				EXCEPTION WHEN OTHERs THEN
					dbms_output.put_line ( 'etape fin' );	Null; 	END;
			END if;

			IF LSTMODE NOT IN ( 'EXTRACT' , 'TQ' ) THEN
				dbms_output.put_line ( '+----------------------------------------------------------+' );	END IF;
			If ShowSQL = 'Y' THEN
				IF LSTMODE = 'EXTRACT'
				THEN	select 'TU4;' || INSTANCE_NAME || ';' || HOST_NAME || ';' INTO wEXTRACT from v$instance;
						IF ( oVersion >= 10 )	THEN
						SQL_Dyn2 := ' select old_hash_value from stats$sql_summary where rownum = 1 and hash_value = ';
						SQL_Dyn2 := SQL_Dyn2 || analytik(a).HASH_VALUE ;
						OPEN Src2 for SQL_Dyn2;	FETCH Src2 INTO wOLD_HASH ;	Close Src2;
						PKG_STATS.ShowSql  ( wOLD_HASH, wEXTRACT );
					ELSE	PKG_STATS.ShowSql  ( analytik(a).HASH_VALUE , wEXTRACT );	END IF;
				ELSE	IF ( oVersion >= 10 )		THEN
						SQL_Dyn2 := ' select old_hash_value from stats$sql_summary where rownum = 1 and hash_value = ';
						SQL_Dyn2 := SQL_Dyn2 || analytik(a).HASH_VALUE ;
						OPEN Src2 for SQL_Dyn2;	FETCH Src2 INTO wOLD_HASH ;	Close Src2;
					PKG_STATS.ShowSql  ( wOLD_HASH );	ELSE	PKG_STATS.ShowSql  ( analytik(a).HASH_VALUE );	END IF;
				END IF;
			END IF;

			IF wExplainP = 'Y' OR LSTMODE = 'EXTRACT' THEN
				BEGIN	IF LSTMODE = 'EXTRACT'
					THEN	select 'TU6;' || INSTANCE_NAME || ';' ||
						HOST_NAME  INTO wEXTRACT from v$instance;
						IF ( oVersion >= 10 )	THEN	PKG_STATS.SQL_PLAN ( analytik(a).HASH_VALUE , wEXTRACT );
						ELSE	PKG_STATS.SQL_PLAN ( analytik(a).HASH_VALUE , wEXTRACT );	END IF;
					ELSE	IF ( oVersion >= 10 )	THEN	PKG_STATS.SQL_PLAN ( analytik(a).HASH_VALUE, Null );
						ELSE	PKG_STATS.SQL_PLAN ( analytik(a).HASH_VALUE, Null );	END IF;
					END IF;
				EXCEPTION WHEN OTHERS THEN Null;
				dbms_output.put_line ('|   Plan d''execution indisponible                  ' ||
				'                                                                  |');
				dbms_output.put_line ( '+----------------------------------------------------' ||
				'----------------------------------------------------------------+');
				END;
			END IF;

			IF SPLAN = 'Y' THEN
				BEGIN	PKG_STATS.info_plan ( DATEDEB, DATEFIN, LSTMODE, INSTANCE, analytik(a).HASH_VALUE );
				EXCEPTION WHEN OTHERS THEN  Null;	END;		END IF;

			IF LSTMODE !='EXTRACT' THEN
			IF PLANSTAT	= 'Y'	THEN	PKG_STATS.PLANSTAT_proc ( DATEDEB, DATEFIN, analytik(a).HASH_VALUE );	END IF;
			END IF;
			IF HASHVALUE is not null THEN		a := TOP;	END IF;		a := a + 1;
		END LOOP;
	END IF;

	IF LSTMODE != 'EXTRACT' THEN
		dbms_output.put_line (
		'+------------------------------------------------------------------------------------------------------------------+' );
	END IF;
	SQL_Dyn := 'select  to_char( STIME, ''YYYYMMDD HH24:MI'' ), hash_value, sum(';
	SQL_Dyn := SQL_Dyn || wPARAM;
	SQL_Dyn := SQL_Dyn || '_inc), sum(cpu_time_inc) cpu_time, ';
	SQL_Dyn := SQL_Dyn || ' sum(elapsed_time_inc) elapsed_time, sum(executions_inc) executions , ';
	SQL_Dyn := SQL_Dyn || ' DECODE( hash_value, ''All Other Hash'', Null, module ) module ';
	SQL_Dyn := SQL_Dyn || ' , avg( DUREE ) maxDUREE ';
	SQL_Dyn := SQL_Dyn || ' from ( select ss.snap_time STIME, ';
	SQL_Dyn := SQL_Dyn || ' DECODE( hash_value, ';

	IF HASHVALUE Is null THEN	a := 1;
		While a <= TOP
		LOOP	SQL_Dyn := SQL_Dyn || analytik(a).HASH_VALUE || ', ''' || analytik(a).HASH_VALUE || ''',';
			a := a + 1;
		END LOOP;
	ELSE	SQL_Dyn := SQL_Dyn || HASHVALUE || ', ''' || HASHVALUE || ''',';	END IF;
	-----------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || '''All Other Hash'' ) Hash_value, ';
	SQL_Dyn := SQL_Dyn || ' sq.module, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.disk_reads, lag(sq.disk_reads, 1, sq.disk_reads)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),  ';
	SQL_Dyn := SQL_Dyn || ' sq.disk_reads, sq.disk_reads - lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.disk_reads) ';
	SQL_Dyn := SQL_Dyn || ' disk_reads_inc, ';
	-- Sorts --------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.sorts, lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.sorts, sq.sorts - lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.sorts) sorts_inc, ';
	-- Fetches ------------------------------------------------------------------------------------------------------
	IF Oversion  = 8	THEN	SQL_Dyn :=  SQL_Dyn || ' 0 FETCHES_inc, ';
	ELSE	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.FETCHES, lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.FETCHES, sq.FETCHES - lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.FETCHES) FETCHES_inc, ';	END IF;
	-- loads --------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.LOADS, lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.LOADS, sq.LOADS - lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.LOADS) LOADS_inc, ';
	-- parse_calls --------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.PARSE_CALLS, lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PARSE_CALLS, sq.PARSE_CALLS - lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PARSE_CALLS) PARSE_CALLS_inc, ';
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.ROWs_PROCESSED, lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.ROWs_PROCESSED, sq.ROWs_PROCESSED - lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.ROWs_PROCESSED) ROWs_PROCESSED_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.buffer_gets, lag(sq.buffer_gets, 1, sq.buffer_gets) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),   ';
	SQL_Dyn := SQL_Dyn || ' sq.buffer_gets, sq.buffer_gets - lag(sq.buffer_gets, 1, sq.buffer_gets)   ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn := SQL_Dyn || ' sq.buffer_gets) buffer_gets_inc,   ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.executions, lag(sq.executions, 1, sq.executions)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),   ';
	SQL_Dyn := SQL_Dyn || ' sq.executions,sq.executions - lag(sq.executions, 1, sq.executions)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),   ';
	SQL_Dyn := SQL_Dyn || ' sq.executions) executions_inc,  ';
	IF Oversion  = 8	THEN	SQL_Dyn := SQL_Dyn || ' 0 cpu_time_inc,   ';
	ELSE	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.cpu_time, lag(sq.cpu_time, 1, sq.cpu_time)  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value  order by sq.snap_id)),   ';
		SQL_Dyn := SQL_Dyn || ' sq.cpu_time, sq.cpu_time - lag(sq.cpu_time, 1, sq.cpu_time)  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),   ';
		SQL_Dyn := SQL_Dyn || ' sq.cpu_time)/1000000 cpu_time_inc,   ';	END IF;
	IF Oversion  = 8	THEN	SQL_Dyn := SQL_Dyn || ' 0 elapsed_time_inc,   ';	ELSE
		SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.elapsed_time, lag(sq.elapsed_time, 1, sq.elapsed_time)  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),   ';
		SQL_Dyn := SQL_Dyn || ' sq.elapsed_time, sq.elapsed_time - lag(sq.elapsed_time, 1, sq.elapsed_time)   ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  ';
		SQL_Dyn := SQL_Dyn || ' sq.elapsed_time)/1000000 elapsed_time_inc,   ';	END IF;
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.JAVA_EXEC_TIME, lag(sq.JAVA_EXEC_TIME, 1, sq.JAVA_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.JAVA_EXEC_TIME, sq.JAVA_EXEC_TIME - lag(sq.JAVA_EXEC_TIME, 1, sq.JAVA_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.JAVA_EXEC_TIME) JAVA_EXEC_TIME_inc, ';
	END IF;
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.APPLICATION_WAIT_TIME, lag(sq.APPLICATION_WAIT_TIME, 1, sq.APPLICATION_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.APPLICATION_WAIT_TIME, sq.APPLICATION_WAIT_TIME - lag(sq.APPLICATION_WAIT_TIME, 1, sq.APPLICATION_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.APPLICATION_WAIT_TIME) APPLICATION_WAIT_TIME_inc, ';	END IF;
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.CONCURRENCY_WAIT_TIME, lag(sq.CONCURRENCY_WAIT_TIME, 1, sq.CONCURRENCY_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CONCURRENCY_WAIT_TIME, sq.CONCURRENCY_WAIT_TIME - lag(sq.CONCURRENCY_WAIT_TIME, 1, sq.CONCURRENCY_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CONCURRENCY_WAIT_TIME) CONCURRENCY_WAIT_TIME_inc, ';	END IF;
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.CLUSTER_WAIT_TIME, lag(sq.CLUSTER_WAIT_TIME, 1, sq.CLUSTER_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CLUSTER_WAIT_TIME, sq.CLUSTER_WAIT_TIME - lag(sq.CLUSTER_WAIT_TIME, 1, sq.CLUSTER_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CLUSTER_WAIT_TIME) CLUSTER_WAIT_TIME_inc, ';	END IF;
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.USER_IO_WAIT_TIME, lag(sq.USER_IO_WAIT_TIME, 1, sq.USER_IO_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.USER_IO_WAIT_TIME, sq.USER_IO_WAIT_TIME - lag(sq.USER_IO_WAIT_TIME, 1, sq.USER_IO_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.USER_IO_WAIT_TIME) USER_IO_WAIT_TIME_inc, ';	END IF;
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.PLSQL_EXEC_TIME, lag(sq.PLSQL_EXEC_TIME, 1, sq.PLSQL_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PLSQL_EXEC_TIME, sq.PLSQL_EXEC_TIME - lag(sq.PLSQL_EXEC_TIME, 1, sq.PLSQL_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PLSQL_EXEC_TIME) PLSQL_EXEC_TIME_inc, ';	END IF;
	SQL_Dyn := SQL_Dyn || ' decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.Hash_value order by sq.snap_id)),  ';
	SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.Hash_value order by sq.snap_id),  ss.SNAP_TIME)*86400 DUREE ';
	SQL_Dyn := SQL_Dyn || ' from stats$sql_summary sq, stats$snapshot ss ';
--	SQL_Dyn := SQL_Dyn || ' where  	ss.snap_time between to_date(''' || DATEDEB     || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_Dyn := SQL_Dyn || ' where  	ss.snap_time between to_date(''' || wBORNE_MINI || ''', ''YYYYMMDD HH24:MI'' )  ';
	SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	IF INSTANCE Is not NULL THEN	SQL_Dyn :=  SQL_Dyn || ' and ( ss.instance_number = ' || INSTANCE || ' ) ';	END IF;
	SQL_Dyn := SQL_Dyn || ' and 	sq.dbid = ss.dbid  ';
	SQL_Dyn := SQL_Dyn || ' and 	sq.instance_number = ss.instance_number ';
	SQL_Dyn := SQL_Dyn || ' and 	sq.snap_id = ss.snap_id  ';
	SQL_Dyn := SQL_Dyn || ' and 	sq.executions between 0 and 999999999999999  ';
	SQL_Dyn := SQL_Dyn || ' and 	sq.disk_reads between 0 and 999999999999999  ';
	SQL_Dyn := SQL_Dyn || ' and 	sq.buffer_gets between 0 and 999999999999999  ';
	IF Oversion > 8	THEN	SQL_Dyn := SQL_Dyn || ' and 	sq.cpu_time between 0 and 999999999999999 ';
		SQL_Dyn := SQL_Dyn || ' and 	sq.elapsed_time between 0 and 999999999999999 ';	END IF;
	IF HASHVALUE Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and sq.HASH_VALUE = ' || HASHVALUE ;	END IF;
	SQL_Dyn := SQL_Dyn || '  )   ';
	SQL_Dyn := SQL_Dyn || ' where stime >= to_date( ''';
	SQL_Dyn := SQL_Dyn || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	SQL_Dyn := SQL_Dyn || ' group by Stime, Hash_value, ';
	SQL_Dyn := SQL_Dyn || ' DECODE( hash_value, ''All Other Hash'', Null, module ) ';
	------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' order by Hash_value, STIME';
	IF wDEBUG = 3 or WDEBUG = 9 THEN
		dbms_output.put_line( '---------------------------------------------------------------------------------');
		dbms_output.put_line( substr( SQL_Dyn,   1, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 401, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn, 801, 200 ));	dbms_output.put_line( substr( SQL_Dyn,1001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn,1401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn,1801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn,2201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn,2601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn,3001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn,3401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn,3801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,4001, 200 ));	dbms_output.put_line( substr( SQL_Dyn,4201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,4401, 200 ));	dbms_output.put_line( substr( SQL_Dyn,4601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,4801, 200 ));	dbms_output.put_line( substr( SQL_Dyn,5001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,5201, 200 ));	dbms_output.put_line( substr( SQL_Dyn,5401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,5601, 200 ));	dbms_output.put_line( substr( SQL_Dyn,5801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,6001, 200 ));	dbms_output.put_line( substr( SQL_Dyn,6201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,6401, 200 ));	dbms_output.put_line( substr( SQL_Dyn,6601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn,6801, 200 ));	dbms_output.put_line( substr( SQL_Dyn,7001, 200 ));
		dbms_output.put_line( '---------------------------------------------------------------------------------');
	END IF;

	IF LSTMODE != 'EXTRACT' THEN	wChaine := 'Stime         ;HASH_VALUE      ;' || wPARAM;
		wChaine := wChaine || ';CPU_TIME;ELAPSED_TIME;EXECUTIONS;' ;
		wChaine := wChaine || wPARAM || '/Elapsed' || ';module;' || wPARAM || '/delay' ;
		dbms_output.put_line(  wChaine );	END IF;
	Open Src For SQL_Dyn;	LOOP
		FETCH src INTO	wSTIME, wHASH_VALUE, wBUFFER_GETS, wCPU_TIME, wELAPSED_TIME, wEXECUTIONS, wMODULE, wDELAY;
		EXIT WHEN Src%NOTFOUND;
		IF wELAPSED_TIME = 0	THEN wELAPSED_TIME:= Null; 	END IF;
		IF wEXECUTIONS = 0 	THEN wEXECUTIONS  := 1; 	END IF;
		IF wDELAY = 0 		THEN wDELAY	  := Null;	END IF;
		IF upper ( LSTMODE ) = 'EXTRACT' 	THEN
			select 'TU3;' || INSTANCE_NAME || ';' || HOST_NAME || ';' INTO wEXTRACT from v$instance;
			wEXTRACT := wEXTRACT  || INSTANCE || ';' || wPARAM || ';' ;
			wCHAINE := wEXTRACT || wSTIME || ';' || RPAD(wHASH_VALUE, 15 ) 	|| ';' ;
			wCHAINE2 := to_char( wBUFFER_GETS, '9999999999999.99' );
			SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
			wCHAINE := wCHAINE || wCHAINE2 || ';' ||
			to_char( wCPU_TIME, '99999999999' )	|| ';' ||  to_char( wELAPSED_TIME ,'99999999999' )	|| ';' ||
			to_char( wEXECUTIONS , '999999999' )	|| ';' || to_char( wBUFFER_GETS/wELAPSED_TIME, '999999999.99' ) || ';' || wMODULE ;
			dbms_output.put_line( wCHAINE );
		ELSE	wCHAINE := wSTIME || ';' || wHASH_VALUE || ';' ;    wCHAINE2 := to_char( wBUFFER_GETS , '99999999999999.99' ) ;
			SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;	wCHAINE := wCHAINE || wCHAINE2  || ';';
			wChaine2 := to_char( wCPU_TIME, '99999999999.99' );
			SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
			wCHAINE := wCHAINE || wCHAINE2 || ';' ;
			wChaine2 := to_char( wELAPSED_TIME ,'999999999.99' );
			SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
			wCHAINE := wCHAINE || wCHAINE2 || ';' || to_char( wEXECUTIONS , '999999999' )		|| ';';
			wCHAINE2 := to_char( wBUFFER_GETS/wELAPSED_TIME, '999999999.99' );
			SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
			wCHAINE := wCHAINE || wchaine2 || ';' || wMODULE ;
			wCHAINE2 :=  to_char( wBUFFER_GETS/wDELAY, '9999999999999.99' );
			SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
			wCHAINE := wCHAINE || ';'  || wCHAINE2;
			dbms_output.put_line( wCHAINE );
		END IF;
	END LOOP;

	IF LSTMODE != 'EXTRACT' AND HASHVALUE is null THEN
		dbms_output.put_line (
		'+----------------------------------------------------------------------------------------------------------------------+');
		dbms_output.put_line ( '| ' || RPAD( ' Rappel de la commande precedente', 115 ) || '  |'  );
		wCHAINE := '| ' || '  * Exec Perfstat.PKG_STATS.TOPSQL ( ''' || DATEDEB || ''', ''' ;
		wCHAINE := wCHAINE || DATEFIN || ''', ''' || LSTMODE || ''', ''' || PARAM || ''', ' ;
		wCHAINE := wCHAINE || TOP || ', ''' || ShowSQL || ''', ''' || ExplainP ;
		wCHAINE := wCHAINE || ''', ' || NVL( TO_CHAR(INSTANCE), 'Null') ;
		IF ( FILTRE is not null ) THEN	wCHAINE := wCHAINE || ', ''' || FILTRE  || '''';	END IF;
		IF ( PLANSTAT != 'N' ) THEN	wCHAINE := wCHAINE || ',PLANSTAT=>''' || PLANSTAT || '''';	END IF;
		Dbms_Output.Put_Line( RPAD( wCHAINE || ' )' , 119 ) || '|' );
		dbms_output.put_line ( '|  ' || RPAD( ' ', 116 ) || '|'  );
		Dbms_Output.Put_Line( '| ' || RPAD( ' Exec Perfstat.PKG_STATS.TOPSQL ( ''DateDeb'', ''DateFin'', ''LSTMODE'', ' ||
		'''PARAM'', TOP, ''ShowSQL'', ''ExplainP'', INSTANCE   )' , 117 ) || '|' );
		dbms_output.put_line (
		'|  ' || RPAD( 'Valeurs de PARAM acceptees : Pour RATIO par EXEC ajouter RATIO (ex RATIODISK_READS) ',   116 ) || '|'  );
		dbms_output.put_line ( '|  ' || RPAD( ' ', 116 ) || '|'  );
		dbms_output.put_line (
		'+----------------------------------------------------------------------------------------------------------------------+');
		dbms_output.put_line (
		'| DISK_READS, BUFFER_GETS, CPU_TIME, ELAPSED_TIME, ROWS_PROCESSED, PARSE_CALLS, EXECUTIONS, SORTS, FETCHES, LOADS      |');

		IF Oversion  >= 10 THEN		dbms_output.put_line (
		'| Fonctionnalites 10g :                                                                                                |' );
		dbms_output.put_line (
		'| APPLICATION_WAIT_TIME, CONCURRENCY_WAIT_TIME, CLUSTER_WAIT_TIME, USER_IO_WAIT_TIME, PLSQL_EXEC_TIME, JAVA_EXEC_TIME  |' );
		END IF;
		dbms_output.put_line ( '|  ' || RPAD( ' ', 116 ) || '|'  );
		dbms_output.put_line ( '+==' || RPAD( '=', 116, '=' ) || '+'  );
		SELECT min( snap_id ) INTO i from PERFSTAT.stats$snapshot where snap_time >= to_date( DATEDEB	, 'YYYYMMDD HH24:MI' );
		SELECT max( snap_id ) INTO k from PERFSTAT.stats$snapshot where snap_time <= to_date( DATEFIN	, 'YYYYMMDD HH24:MI' );

		j := 0;
		BEGIN	SQL_Dyn := 'select count(distinct( SQL_PROFILE )) from stats$sql_summary';
			SQL_Dyn := SQL_DYN || ' where SNAP_ID >= ' || i || ' AND SNAP_ID <= ' || k;
			Open Src FOR SQL_Dyn;	FETCH Src INTO j;	EXCEPTION WHEN OTHERs THEN Null;	END;

		If j > 0 THEN	dbms_output.put_line (
			'|  ' || RPAD( '               ! ! !           WARNING : UTILISATION DE SQL_PROFILE      ! ! !', 116 ) || '|'  );
		END IF;

		j := 0;
		BEGIN
			SQL_Dyn := 'select count(distinct( OUTLINE_SID )) from stats$sql_summary';
			SQL_Dyn := SQL_DYN || ' where SNAP_ID >= ' || i || ' AND SNAP_ID <= ' || k;
			Open Src FOR SQL_Dyn;
			FETCH Src INTO j;
		EXCEPTION WHEN OTHERs THEN Null;
		END;

		If j > 1 THEN
		dbms_output.put_line ( '|  ' || RPAD( '               ! ! !           WARNING : UTILISATION DE OUTLINES         ! ! !', 116 ) || '|'  );
		END IF;
		dbms_output.put_line (
		'+----------------------------------------------------------------------------------------------------------------------+');
		dbms_output.put_line ( 'NB : Pour un suivi unitaire SQL ( Exec Perfstat.PKG_STATS.SUIVISQL )' );

	END IF;

	<<FIN>>
	Null;

EXCEPTION WHEN NO_DATA_FOUND THEN
	IF LSTMODE != 'EXTRACT' THEN	dbms_output.put_line ( 'Pas de donnees avec ce parametrage' );	END IF;
	WHEN OTHERS THEN	IF LSTMODE != 'EXTRACT' THEN	dbms_output.put_line ( 'Erreur detectee' );
	dbms_output.put_line ( sqlcode  );	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure TOPSQL	( DATEDEB varchar DEFAULT Null, DATEFIN varchar DEFAULT Null, LSTMODE varchar DEFAULT 'CSV',
			PARAM varchar DEFAULT 'DISK_READS', TOP NUMBER DEFAULT 5, ShowSQL Varchar Default 'N', ExplainP Varchar Default 'N',
			INSTANCE Number DEFAULT Null, FILTRE IN VARCHAR DEFAULT Null, MODULE IN VARCHAR DEFAULT Null,
			HASHVALUE IN NUMBER DEFAULT Null, PLANSTAT IN VARCHAR DEFAULT 'N', ZOOM IN VARCHAR DEFAULT Null )
IS	NB_Ano		Number;			PARAM1		Varchar( 2000 );	PARAM2		Varchar( 2000 );
	PARAM3		Varchar( 2000 );	PARAM4		Varchar( 2000 );	PARAM5		Varchar( 2000 );
	PARAM6		Varchar( 2000 );	PARAM7		Varchar( 2000 );	PARAM8		Varchar( 2000 );
	PARAM9		Varchar( 2000 );	PARAM10		Varchar( 2000 );	PARAM11		Varchar( 2000 );
	PARAM12		Varchar( 2000 );	PARAM13		Varchar( 2000 );	wDATE1		Date;
	wDATE		Date;			wCHAINE		Varchar( 50 );		wFORMAT_DATE_SORTIE	Varchar( 50 );
	wFILTRE		Varchar( 100 );		oVersion	Number;
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;		PARAM5 := Null;
	PARAM6 := Null;	PARAM7 := Null;	PARAM8 := Null;	PARAM9 := Null;	PARAM10 := Null;	PARAM11 := Null;
	PARAM12 := Null;	PARAM13 := Null;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;

	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN		NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract', 'TQ' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';	END IF;
	-- PARAM
	IF PARAM Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le parametre de TOP est obligatoire ( ''DISK_READS'', ''BUFFER_GETS'' ... ) ';
	ELSIF upper(PARAM) NOT IN ('DISK_READS', 'BUFFER_GETS', 'SORTS', 'FETCHES', 'EXECUTIONS',
			'LOADS', 'PARSE_CALLS', 'ROWS_PROCESSED', 'CPU_TIME', 'ELAPSED_TIME',
			'RATIODISK_READS', 'RATIOBUFFER_GETS', 'RATIOSORTS', 'RATIOFETCHES', 'RATIOEXECUTIONS',
			'RATIOLOADS', 'RATIOPARSE_CALLS', 'RATIOROWS_PROCESSED', 'RATIOCPU_TIME', 'RATIOELAPSED_TIME',
			'RATIOAPPLICATION_WAIT_TIME', 'RATIOCONCURRENCY_WAIT_TIME',  'RATIOCLUSTER_WAIT_TIME',
			'RATIOUSER_IO_WAIT_TIME', 'RATIOPLSQL_EXEC_TIME', 'RATIOJAVA_EXEC_TIME',
			'APPLICATION_WAIT_TIME', 'CONCURRENCY_WAIT_TIME',  'CLUSTER_WAIT_TIME',
			'USER_IO_WAIT_TIME', 'PLSQL_EXEC_TIME', 'JAVA_EXEC_TIME' ) THEN		NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le parametre de TOP ''' || PARAM || ''' est incorrect ( ''DISK_READS'', ''BUFFER_GETS'', ... ) ';	END IF;
	IF upper(PARAM) IN ( 'RATIOAPPLICATION_WAIT_TIME', 'RATIOCONCURRENCY_WAIT_TIME',  'RATIOCLUSTER_WAIT_TIME',
			'RATIOUSER_IO_WAIT_TIME', 'RATIOPLSQL_EXEC_TIME', 'RATIOJAVA_EXEC_TIME' ,
			'APPLICATION_WAIT_TIME', 'CONCURRENCY_WAIT_TIME',  'CLUSTER_WAIT_TIME',
			'USER_IO_WAIT_TIME', 'PLSQL_EXEC_TIME', 'JAVA_EXEC_TIME' )  AND Oversion < 10 THEN	NB_Ano := NB_Ano + 1;
		PARAM4 := 'Ce parametre de TOP ''' || PARAM || ''' est incompatible avec la version Oracle.';	END IF;
	-- TOP
	-- ShowSQL
	IF ShowSQL Is NULL OR ShowSQL NOT IN ('Y', 'N', 'y', 'n') THEN NB_Ano := NB_Ano + 1;
		PARAM6 := 'Parametre ShowSQL Incorrect (''Y'', ''N'')';	END IF;
	-- ExplainP
	IF ExplainP Is NULL OR ExplainP NOT IN ('Y', 'N', 'y', 'n' ) THEN NB_Ano := NB_Ano + 1;
		PARAM7 := 'Parametre ExplainP Incorrect (''Y'', ''N'')';	END IF;
	-- INSTANCE
	-- FILTRE
	IF FILTRE NOT IN ('SELECT', 'INSERT', 'UPDATE', 'DELETE', 'SELECT%', 'INSERT%', 'UPDATE%', 'DELETE%',
			  'select', 'insert', 'update', 'delete', 'select%', 'insert%', 'update%', 'delete%') THEN
		NB_Ano := NB_Ano + 1;	PARAM9 := 'FILTRE INCORRECT (SELECT/INSERT/UPDATE/DELETE)';	END IF;
	-- PLANSTAT
	IF Upper( PLANSTAT ) NOT IN ('Y', 'N') THEN NB_Ano := NB_Ano + 1;	PARAM12 := 'PLANSTAT INCORRECT (Y/N)';	END IF;

	-- ZOOM
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE TOPSQL', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  PARAM              | Varchar | ' || RPAD( NVL( PARAM4, 'OK ( ''' || PARAM || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 5 |  TOP                | Number  | ' || RPAD( NVL( PARAM5, 'OK ( ' ||  TOP || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 6 |  SHOWSQL            | Varchar | ' || RPAD( NVL( PARAM6, 'OK ( ''' || SHOWSQL  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 7 |  EXPLAINP           | Varchar | ' || RPAD( NVL( PARAM7, 'OK ( ''' || EXPLAINP || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 8 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM8, 'OK ( ' ||
			NVL( TO_CHAR(INSTANCE), 'Null') || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 9 |  FILTRE             | Varchar | ' || RPAD( NVL( PARAM9, 'OK ( ''' || FILTRE  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '|10 |  MODULE             | Varchar | ' || RPAD( NVL( PARAM10, 'OK ( ''' || MODULE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '|11 |  HASHVALUE          | Number  | ' || RPAD( NVL( PARAM11, 'OK ( ' ||
			NVL( to_char( HASHVALUE), 'Null' )  || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '|12 |  PLANSTAT           | Varchar | ' || RPAD( NVL( PARAM12, 'OK ( ''' || PLANSTAT || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '|13 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM13, 'OK ( ''' || ZOOM || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
		Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.TopSql( ''' || DATEDEB 	|| ''', ''' ||
			DATEFIN 	|| ''', ''' ||	LSTMODE 	|| ''', ''' ||	PARAM		|| ''', ' ||
			TOP 		|| ', ''' ||	SHOWSQL 	|| ''', ''' ||	EXPLAINP	|| ''', '   ||
			NVL( TO_CHAR(INSTANCE), 'Null' )	||  ', ' ||	NVL( FILTRE, 'Null' )	||  ', ' ||
			NVL( MODULE, 'Null' )  ||	', ' || NVL( to_char( HASHVALUE), 'Null' ) ||	', ''' || PLANSTAT || ''' )' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SQL_SUMMARY') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' ,  'STATS$SQL_SUMMARY');
		ELSE	IF FILTRE IS NOT NULL THEN wFILTRE := FILTRE || '%' ; 	END IF;
			PKG_STATS.TOPSQL_proc( DATEDEB, DATEFIN, upper(LSTMODE), upper(PARAM), TOP,
				upper(ShowSQL), upper(ExplainP), INSTANCE, wFILTRE,  MODULE, HASHVALUE, PLANSTAT, ZOOM );	END IF;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure suivi_io	( DATEDEB IN VARCHAR DEFAULT Null,  DATEFIN IN VARCHAR DEFAULT Null, LSTMODE IN VARCHAR DEFAULT 'CSV',
			FORMAT_DATE_SORTIE IN VARCHAR DEFAULT 'YYYYMMDD HH24:MI', PCT_RDS IN NUMBER DEFAULT 5, PCT_WRI IN NUMBER DEFAULT 5,
			TABLESPACE IN VARCHAR DEFAULT 'Null', DATAFILE IN VARCHAR DEFAULT 'Null', FILEDET IN VARCHAR DEFAULT 'N',
			INSTANCE IN NUMBER DEFAULT 1, ZOOM IN VARCHAR DEFAULT Null )
IS	NB_Ano		Number;			PARAM1			Varchar( 2000 );	PARAM2			Varchar( 2000 );
	PARAM3		Varchar( 2000 );	PARAM4			Varchar( 2000 );	PARAM5			Varchar( 2000 );
	wDATE1		Date;			wDATE			Date;			wCHAINE			Varchar( 50 );
	wFORMAT_DATE_SORTIE	Varchar( 50 );	TBS			varchar( 3 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;	TBS 	:= 'Y';

	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;  END IF;

	-- DATEFIN
	IF DATEFIN Is NULL THEN		NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';		END IF;	END IF;

	-- LSTMODE
	IF upper(LSTMODE) NOT IN ('CSV', 'NORM', 'EXTRACT',  'EXTRACTXS', 'TU2' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT )';
	END IF;

	-- FORMAT_DATE_SORTIE
	IF FORMAT_DATE_SORTIE Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le format de la date doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSIF FORMAT_DATE_SORTIE  NOT IN ( 'YYYYMMDD HH24:MI', 'YYYYMMDD HH24', 'YYYYMMDD' ,
					   'yyyymmdd hh24:MI', 'yyyymmdd hh24', 'yyyymmdd' ) THEN
		NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le format de la date est incorrect          ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_char( sysdate, FORMAT_DATE_SORTIE ) INTO wCHAINE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM4 := 'Le format de la date est INVALIDE     ( ''YYYYMMDD HH24:MI'' ) ';	END;
	END IF;

	-- TBS
	-- PCT_RDS
	IF PCT_RDS <= 0 THEN	NB_Ano := NB_Ano + 1;	PARAM5 := '%Lecture du TBS pour identification';	END IF;
	-- PCT_WRI
	IF PCT_WRI <= 0 THEN	NB_Ano := NB_Ano + 1;	PARAM5 := '%ecriture du TBS pour identification';	END IF;

	-- TABLESPACE
	-- DATAFILE
	-- FILEDET
	-- ZOOM

	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
		dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE SUIVI_IO', 105 ) ||'|' );
dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 4 |  FORMAT_DATE_SORTIE | Varchar | ' || RPAD( NVL( PARAM4, 'OK ( ''' || FORMAT_DATE_SORTIE || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 5 |  PCT_RDS            | Number  | ' || RPAD( NVL( PARAM5, 'OK ( ' || PCT_RDS || ' )' ), 70 ) || '|' );
dbms_output.put_line( '| 6 |  PCT_WRI            | Number  | ' || RPAD( NVL( PARAM5, 'OK ( ' || PCT_WRI || ' )' ), 70 ) || '|' );
dbms_output.put_line( '| 7 |  TABLESPACE         | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ''' || TABLESPACE|| ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 8 |  DATAFILE           | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ''' || DATAFILE || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 9 |  FILEDET            | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ''' || FILEDET || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '|10 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM5, 'OK ( ' || INSTANCE || ' )' ), 70 ) || '|' );
dbms_output.put_line( '|11 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ' || ZOOM || ' )' ), 70 ) || '|' );
dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.suivi_io( ''' || DATEDEB || ''', ''' || DATEFIN || 	 ''', ''' 	||
	LSTMODE || ''', ''' || 	FORMAT_DATE_SORTIE 	|| ''', ' || PCT_RDS   || ', ' ||
	PCT_WRI   || ', ''' || 	TABLESPACE || ''', ''' || DATAFILE   || ''', ''' || FILEDET   || ''' ,' ||	INSTANCE || ')' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$FILESTATXS' , 'STATS$TEMPSTATXS') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$FILESTATXS' , 'STATS$TEMPSTATXS');
		ELSE	PKG_STATS.suivi_io_proc ( DATEDEB, DATEFIN, upper(LSTMODE) , upper(FORMAT_DATE_SORTIE),
			PCT_RDS, PCT_WRI, TABLESPACE, DATAFILE, FILEDET, INSTANCE, ZOOM );	END IF;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure diag		( DATEDEB IN VARCHAR DEFAULT TO_CHAR( sysdate-7, 'YYYYMMDD HH24:MI' ),
			DATEFIN IN VARCHAR DEFAULT TO_CHAR( sysdate  , 'YYYYMMDD HH24:MI' ), LSTMODE IN VARCHAR DEFAULT 'NORM',
			PRECO IN VARCHAR DEFAULT 'Y' , COEFVAL IN NUMBER DEFAULT 3, SEUIL_MINI IN NUMBER DEFAULT null, INSTANCE IN NUMBER DEFAULT 1,
			TYPEREST IN VARCHAR DEFAULT 'NORME', DEGRAD IN VARCHAR DEFAULT 'N')
IS	TYPE 		DataSource IS REF CURSOR;	Src 		DataSource;	wINSTANCE	Number;
BEGIN	dbms_output.enable( 100000000 );
	OPEN Src FOR	select 	distinct INSTANCE_NUMBER	INTO 	wINSTANCE	from	stats$snapshot
	WHERE	( (INSTANCE_NUMBER = INSTANCE) OR (INSTANCE Is Null) );
	LOOP	FETCH Src INTO wINSTANCE;	EXIT WHEN Src%NOTFOUND;
	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SYSTEM_EVENT' , 'STATS$SYSSTAT') ) > 0 THEN
		PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$SYSTEM_EVENT' , 'STATS$SYSSTAT');
	ELSE	 PKG_STATS.diag_proc( DATEDEB , DATEFIN, upper(LSTMODE), upper(PRECO), COEFVAL, SEUIL_MINI, wINSTANCE, TYPEREST, DEGRAD );
	END IF;	END LOOP;	CLOSE Src;
END;
---------------------------------------------------------------------------------------------------------------------
procedure CHKSTAT	( Tab1	IN VARCHAR DEFAULT Null, Tab2	IN VARCHAR DEFAULT Null, Tab3	IN VARCHAR DEFAULT Null,
			 Tab4	IN VARCHAR DEFAULT Null, Tab5	IN VARCHAR DEFAULT Null )
IS	TYPE Element IS RECORD	( TABLE_NAME 	VARCHAR( 50 ),  STATUS	VARCHAR( 10 ),  LASTD	DATE 	);
	Type 	Matrice IS TABLE OF Element index by binary_integer;
	TABLE_LISTE 	Matrice;	w_OK 	Number;	imax	Number;	i	Number;	j	Number;
BEGIN
	dbms_output.enable( 1000000 );
	TABLE_LISTE(1).TABLE_NAME := Tab1;	TABLE_LISTE(2).TABLE_NAME := Tab2;	TABLE_LISTE(3).TABLE_NAME := Tab3;
	TABLE_LISTE(4).TABLE_NAME := Tab4;	TABLE_LISTE(5).TABLE_NAME := Tab5;

	-- Recherche du nombre de tables concerne
	If Tab1 is not NULL THEN imax := 1; If Tab2 is not NULL THEN imax := 2;  If Tab3 is not NULL THEN imax := 3;
	If Tab4 is not NULL THEN imax := 4; If Tab5 is not NULL THEN imax := 5;	END IF;	END IF;	END IF;	END IF; END IF;
--	j := to_char ( sysdate, chr(73 +1 ))  ;

--	IF j < ( (524*4687)+12+300+80 ) THEN
	i := 1;	w_OK := 0;

	while i <= imax LOOP
		select 	last_analyzed INTO TABLE_LISTE(i).LASTD from  dba_tables where 	owner IN ('PERFSTAT', 'ORAPATROL')
		AND 	TABLE_NAME= TABLE_LISTE(i).TABLE_NAME;
				IF TABLE_LISTE(i).LASTD Is Null THEN 	TABLE_LISTE(i).STATUS := 'NO_STAT';	w_OK := w_OK + 1 ;
		ELSIF ( sysdate - TABLE_LISTE(i).LASTD ) > 30 THEN  TABLE_LISTE(i).STATUS := 'OLD_STAT';   w_OK := w_OK + 1 ; 	END IF;
		i := i + 1;	END LOOP;

	IF w_OK > 0 THEN	i := 1;
	dbms_output.put_line ( '+--------------------------------+----------------+--------------------------------------------------------------------+' );
	dbms_output.put_line ( '|        Table_NAME              |   STATUS       |  COMMANDE                                                          |' );
	dbms_output.put_line ( '+--------------------------------+----------------+--------------------------------------------------------------------+' );
	while i <= imax LOOP
	dbms_output.put_line ( '| ' || RPAD( TABLE_LISTE(i).TABLE_NAME , 30 ) || ' | ' ||
		RPAD( NVL( TABLE_LISTE(i).STATUS, 'OK' ) , 14 )  || ' | ' ||
	'exec dbms_stats.gather_table_stats(''PERFSTAT'', ''' || TABLE_LISTE(i).TABLE_NAME || ''')'  );
		i := i + 1;	END LOOP;
	dbms_output.put_line(
'+--------------------------------+----------------+--------------------------------------------------------------------+' );
	dbms_output.put_line ( 'Exec dbms_stats.gather_schema_stats(''PERFSTAT'');' );
	END IF;
	--	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
function EVAL_SNAP_TIME( SNAPID in number, INSTANCE in number) return number
IS	wSNAP_ID	number;	wDATE1		DATE;	wDATE2		DATE;	wDATE_start1	DATE;
	wDATE_start2	DATE;	Val		Number;	SQL_Dyn	Varchar( 2000 );
BEGIN
	SQL_Dyn := 'select max( SNAP_ID ) into wSNAP_ID from stats$snapshot where instance_number = ' || INSTANCE || ' and SNAP_ID <' || SNAPID;
	SQL_Dyn := 'select max( SNAP_ID ) into wSNAP_ID from stats$snapshot where SNAP_ID <' || SNAPID;

	select max( SNAP_ID ) into wSNAP_ID from stats$snapshot where instance_number = INSTANCE and SNAP_ID <SNAPID;
	select snap_time, startup_time  into wDATE1, wDATE_start1 from stats$snapshot where snap_id = SNAPID  ;
	select snap_time, startup_time  into wDATE2, wDATE_start2 from stats$snapshot where snap_id = wSNAP_ID;
	IF ( wDATE_start1 < wDATE1 ) AND ( wDATE_start1 > wDATE2 )	THEN 		Val := Null;
	else		Val := ceil( 86400*( wDATE1-wDATE2 )  );	END IF;
	val := abs ( val );	return ( Val );
EXCEPTION	WHEN OTHERS THEN return ( Val );	END;
---------------------------------------------------------------------------------------------------------------------
procedure NQ_proc	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV', INSTANCE IN NUMBER DEFAULT Null,
			NQ_TYPE IN VARCHAR DEFAULT Null, TOP IN NUMBER DEFAULT 3, ZOOM IN VARCHAR DEFAULT Null	)
IS	SQL_Dyn		Varchar( 20000 );		TYPE 		DataSource IS REF CURSOR;
	Src 		DataSource ;			wCUM_WAIT_TIME	Number;
	i		Number;		Oversion	Number;		zEQ_TYPE	Varchar( 5 );
	zTOTAL_REQ	Number;		zTOTAL_WAIT	Number;		zSUCC_REQ	Number;
	zFAILED_REQ	Number;		zCUM_WAIT_TIME	Number;		wVersion	Varchar( 50 );
	zSTIME		DATE;		zEQ_TYPE_LST	Varchar( 10000 );
	Factor		Number;		wEXTRACT	Varchar( 50 );
	zREQ_REASON	Varchar( 100 );		Wchaine		Varchar( 1000 );
	TXT		Varchar( 1000 );	ELight		Number;		wDateLimit	Date;
	HMIN		Varchar( 25 );		HMAX		Varchar( 25 );
Begin	dbms_output.enable( 10000000 );
	Select PKG_STATS.version into wVersion from dual;
	select perfstat.PKG_STATS.CheckVal('NQ', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; 	END IF;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	IF LSTMODE != 'EXTRACT' THEN	dbms_output.put_line( '    Tuning : ' || wVersion  );	END IF;
	select to_number( substr( VERSION, 1, instr( VERSION, '.' )-1 ) ) INTO Oversion from v$instance;
	IF Oversion = 8 THEN	i := 1 /0 ;	END IF;
	IF Oversion >= 9 THEN	Factor := 1000000;	ELSE	Factor := 1000;	END IF;
	select 'TU7;' || INSTANCE_NAME || ';' || HOST_NAME || ';' INTO wEXTRACT from v$instance;
	---------------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := 'select  EQ_TYPE, sum( TOTAL_REQ_INC ) TOTAL_REQ, sum( TOTAL_WAIT_INC ) TOTAL_WAIT, sum( SUCC_REQ_INC ) SUCC_REQ, ';
	SQL_Dyn := SQL_Dyn || ' sum( FAILED_REQ_INC ) FAILED_REQ, sum( CUM_WAIT_TIME_INC  ) CUM_WAIT_TIME ';
	SQL_Dyn := SQL_Dyn || '	from    ( ';
	SQL_Dyn := SQL_Dyn || ' select ss.snap_time stime, es.EQ_TYPE, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.TOTAL_REQ#, lag(es.TOTAL_REQ#, 1, es.TOTAL_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.TOTAL_REQ#, es.TOTAL_REQ# - lag(es.TOTAL_REQ#, 1, es.TOTAL_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.TOTAL_REQ# ) TOTAL_REQ_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.TOTAL_WAIT#, lag(es.TOTAL_WAIT#, 1, es.TOTAL_WAIT#  )  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.TOTAL_WAIT#, es.TOTAL_WAIT# - lag(es.TOTAL_WAIT#, 1, es.TOTAL_WAIT# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.TOTAL_WAIT# ) TOTAL_WAIT_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.SUCC_REQ#, 		lag(es.SUCC_REQ#,     1, es.SUCC_REQ#    )  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.SUCC_REQ#, es.SUCC_REQ# - lag(es.SUCC_REQ#, 1, es.SUCC_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.SUCC_REQ# ) SUCC_REQ_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.FAILED_REQ#, 	lag(es.FAILED_REQ#,   1, es.FAILED_REQ#  )  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.FAILED_REQ#, es.FAILED_REQ# - lag(es.FAILED_REQ#, 1, es.FAILED_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.FAILED_REQ# ) FAILED_REQ_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.CUM_WAIT_TIME, 	lag(es.CUM_WAIT_TIME, 1, es.CUM_WAIT_TIME)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.CUM_WAIT_TIME, es.CUM_WAIT_TIME - lag(es.CUM_WAIT_TIME, 1, es.CUM_WAIT_TIME ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.CUM_WAIT_TIME ) CUM_WAIT_TIME_inc ';
	IF Oversion >= 10 THEN	SQL_Dyn := SQL_Dyn || ' from PERFSTAT.STATS$ENQUEUE_STATISTICS es, PERFSTAT.stats$snapshot ss  ';
	ELSIF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' from PERFSTAT.STATS$ENQUEUESTAT es, PERFSTAT.stats$snapshot ss  ';
	ELSIF Oversion = 9 THEN	SQL_Dyn := SQL_Dyn || ' from PERFSTAT.STATS$ENQUEUE_STAT es, PERFSTAT.stats$snapshot ss  ';	END IF;
	SQL_Dyn := SQL_Dyn || ' where	ss.snap_time between to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' )   ';
	SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	IF  INSTANCE Is NOT Null THEN	SQL_Dyn := SQL_Dyn || ' and 	( ss.instance_number = ' || INSTANCE || ' )  ';	END IF;
	SQL_Dyn := SQL_Dyn || ' and es.dbid = ss.dbid ';
	SQL_Dyn := SQL_Dyn || ' and es.instance_number = ss.instance_number  ';
	SQL_Dyn := SQL_Dyn || ' and es.snap_id = ss.snap_id  ';
	IF NQ_TYPE Is Not Null THEN	SQL_Dyn := SQL_Dyn || ' and es.EQ_TYPE	=''' || NQ_TYPE || ''' ';	END IF;
	SQL_Dyn := SQL_Dyn || '  ) group by EQ_TYPE ';
	SQL_Dyn := SQL_Dyn || ' order by CUM_WAIT_TIME desc';

	wCUM_WAIT_TIME := 0;	OPEN Src FOR SQL_Dyn;	i := 1;
	LOOP	FETCH Src INTO 	zEQ_TYPE, zTOTAL_REQ, zTOTAL_WAIT, zSUCC_REQ, zFAILED_REQ, zCUM_WAIT_TIME;
		EXIT WHEN Src%NOTFOUND;
		wCUM_WAIT_TIME := wCUM_WAIT_TIME + zCUM_WAIT_TIME;
		i := i + 1;	END LOOP;	Close Src;
	---------------------------------------------------------------------------------------------------------------------------------------
	Open Src for SQL_DYN;
	IF LSTMODE != 'EXTRACT' THEN
		dbms_output.put_line(  '-----------------------------------------------------------------------------------' );
		dbms_output.put_line(  'EQ_TYPE;TOTAL_REQ#;TOTAL_WAIT#;SUCC_REQ#;FAILED_REQ#;CUM_WAIT_TIME' );	END IF;
		i := 1;
		zEQ_TYPE_LST := '';
		LOOP	FETCH Src INTO 	zEQ_TYPE, zTOTAL_REQ, zTOTAL_WAIT, zSUCC_REQ, zFAILED_REQ, zCUM_WAIT_TIME;
			EXIT WHEN Src%NOTFOUND;
			If i <= TOP THEN
				IF LSTMODE != 'EXTRACT' THEN
				dbms_output.put_line(  zEQ_TYPE || ' ;' || to_char( zTOTAL_REQ , '999999999' ) 	|| ' ;' ||
				to_char( zTOTAL_WAIT , '999999999' )	|| ' ;' || to_char( zSUCC_REQ, '999999999' ) 	|| ' ;' ||
				to_char( zFAILED_REQ, '999999999' ) 	|| ' ;' || to_char( zCUM_WAIT_TIME/FACTOR, '9999999.9999' ) 	|| ' ;' ||
					to_char( 100*(zCUM_WAIT_TIME/wCUM_WAIT_TIME), '999.99' ) );	END IF;
				zEQ_TYPE_LST :=  zEQ_TYPE_LST || ', ''' || zEQ_TYPE || '''';	END IF;
			wCUM_WAIT_TIME := wCUM_WAIT_TIME + zCUM_WAIT_TIME;		i := i + 1;
		END LOOP;	Close Src;
	IF LSTMODE != 'EXTRACT' THEN
		dbms_output.put_line(  '-----------------------------------------------------------------------------------' );
	END IF;
	zEQ_TYPE_LST := substr( zEQ_TYPE_LST , 2, 100 );
	SQL_Dyn := 'select  Stime, EQ_TYPE, REQ_REASON, sum( TOTAL_REQ_INC ) TOTAL_REQ, sum( TOTAL_WAIT_INC ) TOTAL_WAIT, sum( SUCC_REQ_INC ) SUCC_REQ, ';
	SQL_Dyn := SQL_Dyn || ' sum( FAILED_REQ_INC ) FAILED_REQ, sum( CUM_WAIT_TIME_INC  ) CUM_WAIT_TIME ';
	SQL_Dyn := SQL_Dyn || '	from    ( ';
	SQL_Dyn := SQL_Dyn || ' select ss.snap_time stime, es.EQ_TYPE, ';
	IF Oversion > 9 THEN	SQL_Dyn := SQL_Dyn || ' REQ_REASON, ';	ELSE	SQL_Dyn := SQL_Dyn || ' '' '' REQ_REASON, ';	END IF;
	---------------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.TOTAL_REQ#, lag(es.TOTAL_REQ#, 1, es.TOTAL_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.TOTAL_REQ#, es.TOTAL_REQ# - lag(es.TOTAL_REQ#, 1, es.TOTAL_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.TOTAL_REQ# ) TOTAL_REQ_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.TOTAL_WAIT#, lag(es.TOTAL_WAIT#, 1, es.TOTAL_WAIT#  )  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.TOTAL_WAIT#, es.TOTAL_WAIT# - lag(es.TOTAL_WAIT#, 1, es.TOTAL_WAIT# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.TOTAL_WAIT# ) TOTAL_WAIT_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.SUCC_REQ#, 		lag(es.SUCC_REQ#,     1, es.SUCC_REQ#    )  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.SUCC_REQ#, es.SUCC_REQ# - lag(es.SUCC_REQ#, 1, es.SUCC_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.SUCC_REQ# ) SUCC_REQ_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.FAILED_REQ#, 	lag(es.FAILED_REQ#,   1, es.FAILED_REQ#  )  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.FAILED_REQ#, es.FAILED_REQ# - lag(es.FAILED_REQ#, 1, es.FAILED_REQ# ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.FAILED_REQ# ) FAILED_REQ_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest( es.CUM_WAIT_TIME, 	lag(es.CUM_WAIT_TIME, 1, es.CUM_WAIT_TIME)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' es.CUM_WAIT_TIME, es.CUM_WAIT_TIME - lag(es.CUM_WAIT_TIME, 1, es.CUM_WAIT_TIME ) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by es.EQ_TYPE order by es.snap_id), es.CUM_WAIT_TIME ) CUM_WAIT_TIME_inc ';
	---------------------------------------------------------------------------------------------------------------------------------------
	IF Oversion >= 10 THEN	SQL_Dyn := SQL_Dyn || ' from PERFSTAT.STATS$ENQUEUE_STATISTICS es, PERFSTAT.stats$snapshot ss  ';
	ELSIF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' from PERFSTAT.STATS$ENQUEUESTAT es, PERFSTAT.stats$snapshot ss  ';
	ELSIF Oversion = 9 THEN	SQL_Dyn := SQL_Dyn || ' from PERFSTAT.STATS$ENQUEUE_STAT es, PERFSTAT.stats$snapshot ss  ';	END IF;
	SQL_Dyn := SQL_Dyn || ' where	ss.snap_time between to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' )   ';
	SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
	---------------------------------------------------------------------------------------------------------------------------------------
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	---------------------------------------------------------------------------------------------------------------------------------------
	IF  INSTANCE Is NOT Null THEN	SQL_Dyn := SQL_Dyn || ' and 	( ss.instance_number = ' || INSTANCE || ' )  ';	END IF;
	---------------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' and es.dbid = ss.dbid ';
	SQL_Dyn := SQL_Dyn || ' and es.instance_number = ss.instance_number  ';
	SQL_Dyn := SQL_Dyn || ' and es.snap_id = ss.snap_id  ';
	SQL_Dyn := SQL_Dyn || '  ) ';
	SQL_Dyn := SQL_Dyn || ' where EQ_TYPE IN (' || zEQ_TYPE_LST || ')';
	SQL_Dyn := SQL_Dyn || ' group by EQ_TYPE, Stime, REQ_REASON ';
	SQL_Dyn := SQL_Dyn || ' order by EQ_TYPE, Stime ';
	OPEN src FOR SQL_Dyn;
	IF LSTMODE != 'EXTRACT' THEN
		dbms_output.put_line( 'STIME;EQ_TYPE;REQ_REASON;TOTAL_REQ#;TOTAL_WAIT#;SUCC_REQ#;FAILED_REQ#;CUM_WAIT_TIME' );
	END IF;
	LOOP	FETCH Src INTO 	zSTIME, zEQ_TYPE, zREQ_REASON, zTOTAL_REQ, zTOTAL_WAIT, zSUCC_REQ, zFAILED_REQ, zCUM_WAIT_TIME;
		EXIT WHEN Src%NOTFOUND;
			IF ( zCUM_WAIT_TIME/FACTOR >= .0001 ) THEN
				IF LSTMODE = 'EXTRACT'
				THEN	Wchaine := trim( to_char( zCUM_WAIT_TIME/FACTOR, '9999999.9999' ) );
					SELECT PKG_STATS.XLS_VAL( Wchaine ) INTO Wchaine From Dual;
					dbms_output.put_line( wEXTRACT || to_char( zSTIME, 'YYYYMMDD HH24:MI' )	|| ';' || zEQ_TYPE || ';' ||
		zREQ_REASON || ';' || zTOTAL_REQ || ';' || zTOTAL_WAIT || ';' || zSUCC_REQ || ';' || zFAILED_REQ || ';' || Wchaine   );
				ELSE
					Wchaine := to_char( zCUM_WAIT_TIME/FACTOR, '9999999.9999' ) ;
					SELECT PKG_STATS.XLS_VAL( Wchaine ) INTO Wchaine From Dual;
					dbms_output.put_line( to_char( zSTIME, 'YYYYMMDD HH24:MI' )	|| ';' ||
					zEQ_TYPE || ';' || zREQ_REASON || ';' || to_char( zTOTAL_REQ , '999999999' ) 	|| ';' ||
					to_char( zTOTAL_WAIT , '999999999' )	|| ';' || to_char( zSUCC_REQ, '999999999' ) 	|| ';' ||
					to_char( zFAILED_REQ, '999999999' ) 	|| ';' ||  Wchaine );
				END IF;
			END IF;		zEQ_TYPE_LST :=  zEQ_TYPE_LST || ', ''' || zEQ_TYPE || '''';
		wCUM_WAIT_TIME := wCUM_WAIT_TIME + zCUM_WAIT_TIME;	i := i + 1;
	END LOOP;	Close Src;

	IF LSTMODE != 'EXTRACT' THEN
		dbms_output.put_line( '-----------------------------------------------------------------------------------' );
		dbms_output.put_line( ' exec PERFSTAT.PKG_STATS.NQ ( ''' ||
			DATEDEB 	|| ''', ''' ||	DATEFIN 	|| ''', ''' ||	LSTMODE 	|| ''', ' ||
			INSTANCE	|| ',  ''' || 	NQ_TYPE		|| ''',  ' || 	TOP || ')' );	END IF;
	<<FIN>>
	Null;
EXCEPTION WHEN OTHERS  THEN	IF LSTMODE != 'EXTRACT' THEN	dbms_output.put_line (' Fonctionnalite non disponible ' );	END IF;	END;
---------------------------------------------------------------------------------------------------------------------
procedure BPS_proc	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV',
			INSTANCE IN NUMBER DEFAULT Null, ZOOM IN VARCHAR DEFAULT Null )
IS	TYPE 	 	DataSource IS REF CURSOR;	Src 		DataSource ;	wLIGNE		Varchar( 250 );
	wVERSION	Varchar( 25 );			wVALUE		Number;		SQL_Dyn		Varchar( 30000 );
	Oversion	Number;				Char_Sep	Varchar( 5 );	wEXTRACT	Varchar( 100 );
	TYPE ElementSNAP IS RECORD
	( STIME      		varchar( 20 ), CNUM_WRITE Number, CNUM_SET Number, BUF_GOT  Number, SUM_WRITE Number,
	 SUM_SCAN Number, FREE_BUFFER_WAIT Number, WRITE_COMPLETE_WAIT Number, BUFFER_BUSY_WAIT Number,
	 FREE_BUFFER_INSPECTED   Number, DIRTY_BUFFERS_INSPECTED Number, DB_BLOCK_CHANGE Number, DB_BLOCK_GETS Number,
	 CONSISTENT_GETS         Number, PHYSICAL_READS          Number, PHYSICAL_WRITES Number );

	Type 	MatriceAg IS TABLE OF ElementSNAP index by binary_integer ;
	squelette 	MatriceAg;
	i		Number;		imax		Number;		wINSTANCE	Varchar( 50 );	TXT		Varchar( 1000 );
	ELight		Number;		wDateLimit	Date;		HMIN		Varchar( 25 );	HMAX		Varchar( 25 );
BEGIN	dbms_output.enable( 10000000 );
	SELECT DECODE( LSTMODE , 'CSV' , ';', 'EXTRACT', ';', ' ' ) into Char_Sep FROM DUAL;
	select perfstat.PKG_STATS.CheckVal('NQ', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; 	END IF;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	IF LSTMODE = 'EXTRACT'	THEN	select 'TU8;' || INSTANCE_NAME || ';' || HOST_NAME  INTO wEXTRACT from v$instance;
	ELSE	wEXTRACT := Null;	END IF;
	IF LSTMODE != 'EXTRACT'	THEN	SELECT 	PERFSTAT.PKG_STATS.version INTO wVERSION FROM DUAL;
		Dbms_output.put_line ( '    Tuning : ' || wVERSION );
		Dbms_output.put_line ( '-------------------------------------------------------------------------------------------------------' );
	END IF;
	SQL_Dyn := 'select	to_char( ss.snap_time, ''YYYYMMDD HH24:MI'' ), ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.CNUM_WRITE, lag(bps.CNUM_WRITE, 1, bps.CNUM_WRITE) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.CNUM_WRITE,  ';
	SQL_Dyn := SQL_Dyn || ' bps.CNUM_WRITE - lag(bps.CNUM_WRITE, 1, bps.CNUM_WRITE)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.CNUM_WRITE) CNUM_WRITE, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.CNUM_SET, lag(bps.CNUM_SET, 1, bps.CNUM_SET) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.CNUM_SET,  ';
	SQL_Dyn := SQL_Dyn || ' bps.CNUM_SET - lag(bps.CNUM_SET, 1, bps.CNUM_SET)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.CNUM_SET) CNUM_SET, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.BUF_GOT, lag(bps.BUF_GOT, 1, bps.BUF_GOT) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.BUF_GOT,  ';
	SQL_Dyn := SQL_Dyn || ' bps.BUF_GOT - lag(bps.BUF_GOT, 1, bps.BUF_GOT)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.BUF_GOT) BUF_GOT, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.SUM_WRITE, lag(bps.SUM_WRITE, 1, bps.SUM_WRITE) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.SUM_WRITE,  ';
	SQL_Dyn := SQL_Dyn || ' bps.SUM_WRITE - lag(bps.SUM_WRITE, 1, bps.SUM_WRITE)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.SUM_WRITE) SUM_WRITE, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.SUM_SCAN, lag(bps.SUM_SCAN, 1, bps.SUM_SCAN) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.SUM_SCAN,  ';
	SQL_Dyn := SQL_Dyn || ' bps.SUM_SCAN - lag(bps.SUM_SCAN, 1, bps.SUM_SCAN)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.SUM_SCAN) SUM_SCAN, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.FREE_BUFFER_WAIT, lag(bps.FREE_BUFFER_WAIT, 1, bps.FREE_BUFFER_WAIT) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.FREE_BUFFER_WAIT,  ';
	SQL_Dyn := SQL_Dyn || ' bps.FREE_BUFFER_WAIT - lag(bps.FREE_BUFFER_WAIT, 1, bps.FREE_BUFFER_WAIT)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.FREE_BUFFER_WAIT) FREE_BUFFER_WAIT, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.WRITE_COMPLETE_WAIT, lag(bps.WRITE_COMPLETE_WAIT, 1, bps.WRITE_COMPLETE_WAIT) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.WRITE_COMPLETE_WAIT,  ';
	SQL_Dyn := SQL_Dyn || ' bps.WRITE_COMPLETE_WAIT - lag(bps.WRITE_COMPLETE_WAIT, 1, bps.WRITE_COMPLETE_WAIT)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.WRITE_COMPLETE_WAIT) WRITE_COMPLETE_WAIT, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.BUFFER_BUSY_WAIT, lag(bps.BUFFER_BUSY_WAIT, 1, bps.BUFFER_BUSY_WAIT) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.BUFFER_BUSY_WAIT,  ';
	SQL_Dyn := SQL_Dyn || ' bps.BUFFER_BUSY_WAIT - lag(bps.BUFFER_BUSY_WAIT, 1, bps.BUFFER_BUSY_WAIT)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.BUFFER_BUSY_WAIT) BUFFER_BUSY_WAIT, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.FREE_BUFFER_INSPECTED, lag(bps.FREE_BUFFER_INSPECTED, 1, bps.FREE_BUFFER_INSPECTED) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.FREE_BUFFER_INSPECTED,  ';
	SQL_Dyn := SQL_Dyn || ' bps.FREE_BUFFER_INSPECTED - lag(bps.FREE_BUFFER_INSPECTED, 1, bps.FREE_BUFFER_INSPECTED)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.FREE_BUFFER_INSPECTED) FREE_BUFFER_INSPECTED, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.DIRTY_BUFFERS_INSPECTED, lag(bps.DIRTY_BUFFERS_INSPECTED, 1, bps.DIRTY_BUFFERS_INSPECTED) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.DIRTY_BUFFERS_INSPECTED,  ';
	SQL_Dyn := SQL_Dyn || ' bps.DIRTY_BUFFERS_INSPECTED - lag(bps.DIRTY_BUFFERS_INSPECTED, 1, bps.DIRTY_BUFFERS_INSPECTED)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.DIRTY_BUFFERS_INSPECTED) DIRTY_BUFFERS_INSPECTED, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.DB_BLOCK_CHANGE, lag(bps.DB_BLOCK_CHANGE, 1, bps.DB_BLOCK_CHANGE) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.DB_BLOCK_CHANGE,  ';
	SQL_Dyn := SQL_Dyn || ' bps.DB_BLOCK_CHANGE - lag(bps.DB_BLOCK_CHANGE, 1, bps.DB_BLOCK_CHANGE)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.DB_BLOCK_CHANGE) DB_BLOCK_CHANGE, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.DB_BLOCK_GETS, lag(bps.DB_BLOCK_GETS, 1, bps.DB_BLOCK_GETS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.DB_BLOCK_GETS,  ';
	SQL_Dyn := SQL_Dyn || ' bps.DB_BLOCK_GETS - lag(bps.DB_BLOCK_GETS, 1, bps.DB_BLOCK_GETS)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.DB_BLOCK_GETS) DB_BLOCK_GETS, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.CONSISTENT_GETS, lag(bps.CONSISTENT_GETS, 1, bps.CONSISTENT_GETS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.CONSISTENT_GETS,  ';
	SQL_Dyn := SQL_Dyn || ' bps.CONSISTENT_GETS - lag(bps.CONSISTENT_GETS, 1, bps.CONSISTENT_GETS)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.CONSISTENT_GETS) CONSISTENT_GETS, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.PHYSICAL_READS, lag(bps.PHYSICAL_READS, 1, bps.PHYSICAL_READS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.PHYSICAL_READS,  ';
	SQL_Dyn := SQL_Dyn || ' bps.PHYSICAL_READS - lag(bps.PHYSICAL_READS, 1, bps.PHYSICAL_READS)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.PHYSICAL_READS) PHYSICAL_READS, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(bps.PHYSICAL_WRITES, lag(bps.PHYSICAL_WRITES, 1, bps.PHYSICAL_WRITES) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id)),  bps.PHYSICAL_WRITES,  ';
	SQL_Dyn := SQL_Dyn || ' bps.PHYSICAL_WRITES - lag(bps.PHYSICAL_WRITES, 1, bps.PHYSICAL_WRITES)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by bps.id order by bps.snap_id),  bps.PHYSICAL_WRITES) PHYSICAL_WRITES';
	SQL_Dyn := SQL_Dyn || ' from STATS$BUFFER_POOL_STATISTICS BPS, stats$snapshot ss ';
	SQL_Dyn := SQL_Dyn || ' WHERE ss.snap_id = bps.snap_id ';
	SQL_Dyn := SQL_Dyn || ' AND ss.DBID = bps.DBID ';
	SQL_Dyn := SQL_Dyn || ' AND ss.INSTANCE_NUMBER = bps.INSTANCE_NUMBER ';
	SQL_Dyn := SQL_Dyn || '	AND ss.snap_time >= To_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn := SQL_Dyn || '	AND ss.snap_time <= To_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( ss.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	SQL_Dyn := SQL_Dyn || '	AND ( (ss.INSTANCE_NUMBER=' || NVL(TO_CHAR(INSTANCE), 'Null') ||
		') OR (' || NVL(TO_CHAR(INSTANCE), 'Null') || ' Is NULL ) ) ';
	SQL_Dyn := SQL_Dyn || '	order by 1';
	OPEN Src FOR SQL_Dyn;	i := 1;
	LOOP	FETCH Src INTO 	squelette(i).STIME,		squelette(i).CNUM_WRITE,	squelette(i).CNUM_SET,
		squelette(i).BUF_GOT,		squelette(i).SUM_WRITE,		squelette(i).SUM_SCAN,
		squelette(i).FREE_BUFFER_WAIT,	squelette(i).WRITE_COMPLETE_WAIT,squelette(i).BUFFER_BUSY_WAIT,
		squelette(i).FREE_BUFFER_INSPECTED,squelette(i).DIRTY_BUFFERS_INSPECTED,squelette(i).DB_BLOCK_CHANGE,
		squelette(i).DB_BLOCK_GETS,	squelette(i).CONSISTENT_GETS,	squelette(i).PHYSICAL_READS,	squelette(i).PHYSICAL_WRITES;
		EXIT WHEN Src%NOTFOUND;	i := i + 1;
	END LOOP;	imax := i;

	IF LSTMODE != 'EXTRACT' THEN
	dbms_output.put_line( 'STIME;CNUM_WRITE;CNUM_SET;BUF_GOT;SUM_WRITE;SUM_SCAN;FREE_BUFFER_WAIT;WRITE_COMPLETE_WAIT;BUFFER_BUSY_WAIT;FREE_BUFFER_INSPECTED;' );
	dbms_output.put_line( 'DIRTY_BUFFERS_INSPECTED;DB_BLOCK_CHANGE;DB_BLOCK_GETS;CONSISTENT_GETS;PHYSICAL_READS;PHYSICAL_WRITES;' );
	END IF;

	i := 1;
	While i < imax
	LOOP	-- Ecriture Ligne
		IF wEXTRACT Is Null THEN
		dbms_output.put_line ( squelette(i).STIME || Char_Sep || squelette(i).CNUM_WRITE || Char_Sep || squelette(i).CNUM_SET || Char_Sep ||
			squelette(i).BUF_GOT || Char_Sep || squelette(i).SUM_WRITE || Char_Sep || squelette(i).SUM_SCAN || Char_Sep ||
			squelette(i).FREE_BUFFER_WAIT || Char_Sep || squelette(i).WRITE_COMPLETE_WAIT || Char_Sep ||
			squelette(i).BUFFER_BUSY_WAIT || Char_Sep || squelette(i).FREE_BUFFER_INSPECTED || Char_Sep ||
			squelette(i).DIRTY_BUFFERS_INSPECTED || Char_Sep || squelette(i).DB_BLOCK_CHANGE || Char_Sep ||
			squelette(i).DB_BLOCK_GETS || Char_Sep || squelette(i).CONSISTENT_GETS || Char_Sep ||
			squelette(i).PHYSICAL_READS || Char_Sep || squelette(i).PHYSICAL_WRITES	);
		ELSE	dbms_output.put_line( 	wEXTRACT || ';' || squelette(i).STIME  || Char_Sep || squelette(i).CNUM_WRITE || Char_Sep ||
			squelette(i).CNUM_SET || Char_Sep || squelette(i).BUF_GOT || Char_Sep || squelette(i).SUM_WRITE || Char_Sep ||
			squelette(i).SUM_SCAN || Char_Sep || squelette(i).FREE_BUFFER_WAIT || Char_Sep || squelette(i).WRITE_COMPLETE_WAIT || Char_Sep ||
			squelette(i).BUFFER_BUSY_WAIT || Char_Sep || squelette(i).FREE_BUFFER_INSPECTED || Char_Sep ||
			squelette(i).DIRTY_BUFFERS_INSPECTED || Char_Sep || squelette(i).DB_BLOCK_CHANGE || Char_Sep ||
			squelette(i).DB_BLOCK_GETS || Char_Sep || squelette(i).CONSISTENT_GETS || Char_Sep ||
			squelette(i).PHYSICAL_READS || Char_Sep || squelette(i).PHYSICAL_WRITES );
		END IF;
		i:= i+1;
	END LOOP;

	IF LSTMODE != 'EXTRACT' THEN
		IF INSTANCE Is NULL THEN	wINSTANCE := '''Null''';	ELSE	wINSTANCE := To_char( instance );	END IF;
		dbms_output.put_line( '-------------------------------------------------------------------------------------------------------' );
		dbms_output.put_line( 'Rappel de la commande:' );
		dbms_output.put_line( ' exec PERFSTAT.PKG_STATS.BPS ( ''' ||	DATEDEB 	|| ''', ''' ||
			DATEFIN 	|| ''', ''' ||	LSTMODE 	|| ''', ' ||	wINSTANCE	|| ')' );
	END IF;

	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
procedure BPS		( DATEDEB VARCHAR DEFAULT NUll, DATEFIN VARCHAR	DEFAULT NUll, LSTMODE VARCHAR DEFAULT 'CSV',
			INSTANCE Number DEFAULT Null, ZOOM IN VARCHAR DEFAULT Null )
IS	NB_Ano		Number;			PARAM1		Varchar( 2000 );	PARAM2		Varchar( 2000 );
	PARAM3		Varchar( 2000 );	PARAM4		Varchar( 2000 );	PARAM5		Varchar( 2000 );
	PARAM6		Varchar( 2000 );	PARAM7		Varchar( 2000 );	PARAM8		Varchar( 2000 );
	wDATE1		Date;			wDATE		Date;			wCHAINE		Varchar( 50 );
	wFORMAT_DATE_SORTIE	Varchar( 50 );
BEGIN
	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;
	PARAM6 := Null;	PARAM7 := Null;	PARAM8 := Null;

	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';
		END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;

		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract', 'TU8' ) THEN  NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';	END IF;
	-- INSTANCE
	-- ZOOM

	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE BPS : PROCEDURE BUFFER POOL STATISTICS', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
		IF INSTANCE Is Null THEN	wCHAINE := 'Null';	ELSE		wCHAINE := TO_CHAR( INSTANCE );		END IF;
	dbms_output.put_line( '| 4 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM6, 'OK ( ' || wCHAINE || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 5 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ' || ZOOM || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.BPS( ''' || DATEDEB || ''', ''' || DATEFIN || ''', '''
			|| LSTMODE || ''', ' || NVL( To_char( INSTANCE ), 'Null' )	|| ')' );
	ELSE
		IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$BUFFER_POOL_STATISTICS' , 'STATS$SYSSTAT') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$BUFFER_POOL_STATISTICS' , 'STATS$SYSSTAT');
		ELSE	PKG_STATS.BPS_proc( DATEDEB , DATEFIN, upper(LSTMODE), INSTANCE, ZOOM );
		END IF;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure NQ		( DATEDEB IN VARCHAR DEFAULT NULL, DATEFIN IN VARCHAR DEFAULT NULL, LSTMODE IN VARCHAR DEFAULT 'CSV',
			INSTANCE IN NUMBER DEFAULT Null, NQ_TYPE IN VARCHAR DEFAULT Null, TOP IN NUMBER DEFAULT 3, ZOOM IN VARCHAR DEFAULT Null )
IS	NB_Ano	Number;	PARAM1	Varchar( 2000 );	PARAM2	Varchar( 2000 );	PARAM3	Varchar( 2000 );	PARAM4	Varchar( 2000 );
	PARAM5	Varchar( 2000 );			PARAM6	Varchar( 2000 );	PARAM7	Varchar( 2000 );	PARAM8	Varchar( 2000 );
	wDATE1	Date;					wDATE		Date;		wCHAINE	Varchar( 50 );	wFORMAT_DATE_SORTIE	Varchar( 50 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;	PARAM6 := Null;
	PARAM7 := Null;	PARAM8 := Null;
	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;

		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;
	END IF;

	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'norm', 'csv', 'extract', 'TU7' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';	END IF;

	-- INSTANCE
	-- ZOOM

	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN
	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE NQ (Analyse des ENQUEUEs)', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
		IF INSTANCE Is Null THEN	wCHAINE := 'Null';	ELSE	wCHAINE := TO_CHAR( INSTANCE );	END IF;
	dbms_output.put_line( '| 4 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM4, 'OK ( ' || wCHAINE || ' )' ), 70 ) || '|' );
		IF NQ_TYPE Is Null THEN	wCHAINE := 'Null';	ELSE	wCHAINE := '''' || NQ_TYPE || '''';	END IF;
	dbms_output.put_line( '| 5 |  NQ_TYPE            | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ' || wCHAINE || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 6 |  TOP                | Number  | ' || RPAD( NVL( PARAM6, 'OK ( ' || TOP || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 7 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM7, 'OK ( ' || ZOOM || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
		IF NQ_TYPE Is Null THEN	wCHAINE := 'Null';	ELSE	wCHAINE := '''' || NQ_TYPE || '''';	END IF;
		Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.NQ( ''' || DATEDEB || ''', ''' || DATEFIN || ''', '''
			|| LSTMODE || ''', ' || NVL( To_char( INSTANCE ), 'Null' )	|| ', ' || wCHAINE || ', ' || TOP || 	')' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' ,  'STATS$SYSSTAT') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$SYSSTAT');
		ELSE	PKG_STATS.NQ_proc( DATEDEB , DATEFIN, upper(LSTMODE), INSTANCE, upper(NQ_TYPE), TOP, ZOOM );	END IF;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
function Arrondi( IN_VALUE in NUMBER ) RETURN VARCHAR
IS	OUT_VALUE	varchar( 100 );
BEGIN	If    IN_VALUE < 1000       THEN OUT_VALUE := TO_CHAR( IN_VALUE           , '999' );
	ELSIF IN_VALUE < 1000000    THEN OUT_VALUE := TO_CHAR( IN_VALUE/1000      , '999' ) || 'K';
	ELSIF IN_VALUE < 1000000000 THEN OUT_VALUE := TO_CHAR( IN_VALUE/1000000   , '999' ) || 'M';
	ELSE	OUT_VALUE := TO_CHAR( IN_VALUE/1000000000, '999' ) || 'G';	END IF;	RETURN( OUT_VALUE );
END;
---------------------------------------------------------------------------------------------------------------------
function eval_time	( DATEDEB IN VARCHAR,  DATEFIN IN VARCHAR, DATEDEB2 IN VARCHAR, DATEFIN2 IN VARCHAR ) return NUMBER
IS	wTIMEG		Number;	wSNAP		Number;	wTIME		Date;	wTIME2		Date;
BEGIN	wTIMEG	:= 0;	SELECT MIN( SNAP_ID ) INTO wSNAP FROM PERFSTAT.stats$snapshot where to_char( snap_time , 'YYYYMMDD HH24:MI' ) = DATEDEB2;
	SELECT 	snap_time INTO wTIME2	from stats$snapshot where snap_id = wSNAP ;
	SELECT 	snap_time 	INTO wTIME	FROM STATS$snapshot where snap_id = (wSNAP -1);
	wTIMEG := 86400*( wTIME2 - wTIME );	RETURN( wTIMEG );
END;
---------------------------------------------------------------------------------------------------------------------
procedure PGA		( DATEDEB VARCHAR DEFAULT NUll, DATEFIN VARCHAR DEFAULT NUll, LSTMODE VARCHAR DEFAULT 'CSV',
			INSTANCE Number DEFAULT 1, ZOOM IN VARCHAR	DEFAULT Null )
IS	NB_Ano		Number;			PARAM1	Varchar( 2000 );	PARAM2	Varchar( 2000 );	PARAM3	Varchar( 2000 );
	PARAM4		Varchar( 2000 );	PARAM5	Varchar( 2000 );	PARAM6	Varchar( 2000 );	PARAM7	Varchar( 2000 );
	PARAM8		Varchar( 2000 );	wDATE1	Date;			wDATE	Date;			wCHAINE	Varchar( 50 );
	wFORMAT_DATE_SORTIE	Varchar( 50 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;
	PARAM6 := Null;	PARAM7 := Null;	PARAM8 := Null;
	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';	END IF;
	-- INSTANCE
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN
	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE PGA : PROCEDURE Suivi PGA', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM4, 'OK ( ' || INSTANCE || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ' || ZOOM || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.PGA( ''' || DATEDEB || ''', ''' || DATEFIN || ''', '''
		|| LSTMODE || ''', ' || To_char( INSTANCE ) || ')' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$PGASTAT' ) ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$PGASTAT' );
		ELSE	 PKG_STATS.PGA_proc( DATEDEB , DATEFIN, upper(LSTMODE), INSTANCE, ZOOM );	END IF;	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure PGA_proc	( DATEDEB Varchar DEFAULT NULL, DATEFIN Varchar	DEFAULT NULL, LSTMODE Varchar DEFAULT 'CSV',
			INSTANCE Number DEFAULT 1, ZOOM VARCHAR DEFAULT Null )
IS	TYPE 		DataSource IS REF CURSOR;	Src 		DataSource ;	wVERSION	Varchar( 20 );
	wSNAP_TIME	Varchar( 50 );			wPGA		Number;		wPGA2		Varchar( 30 );
	CharSep 	Varchar( 5 );			wINSTANCE	Varchar( 50 );	SQL_DYN		Varchar( 2000 );
	TXT		Varchar( 1000 );		ELight		Number;		wDateLimit 	Date;
	HMIN		Varchar( 25 );			HMAX		Varchar( 25 );
BEGIN	dbms_output.enable( 10000000 );
	SELECT DECODE( LSTMODE, 'CSV', ';' , 'EXTRACT', ';' , ' ' ) INTO CharSep FROM DUAL;
	select perfstat.PKG_STATS.CheckVal('PGA', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN 	dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; 	END IF;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	IF LSTMODE != 'EXTRACT' THEN	SELECT 	PKG_STATS.version INTO wVERSION FROM DUAL;
		Dbms_output.put_line ( '    Tuning : ' || wVERSION );
		Dbms_output.put_line ( '-------------------------------------------------------------------------------------------------------' );
	END IF;
	SQL_DYN := ' SELECT to_char( sn.snap_time, ''YYYYMMDD HH24:MI'' ) snap_time, VALUE/1024/1024 PGA_SIZE ';
	SQL_DYN := SQL_DYN || ' from stats$pgastat ps, stats$snapshot sn ';
	SQL_DYN := SQL_DYN || ' where sn.SNAP_ID = ps.SNAP_ID AND sn.DBID = ps.DBID ';
	SQL_DYN := SQL_DYN || ' AND sn.INSTANCE_NUMBER = ps.INSTANCE_NUMBER ';
	SQL_DYN := SQL_DYN || ' AND sn.INSTANCE_NUMBER = ' || NVL( INSTANCE, 1 ) ;
	SQL_DYN := SQL_DYN || ' AND NAME = ''total PGA allocated'' ';
	SQL_DYN := SQL_DYN || ' AND sn.snap_time >= TO_DATE( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_DYN := SQL_DYN || ' AND sn.snap_time <  TO_DATE( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( sn.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( sn.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	SQL_DYN := SQL_DYN || ' order by sn.snap_time';
	dbms_output.put_line('Snap_Time;Pga_Size');
	OPEN Src FOR SQL_DYN;
	LOOP	FETCH Src INTO	wSNAP_TIME, wPGA;
		EXIT WHEN Src%NOTFOUND;
		SELECT perfstat.PKG_STATS.XLS_VAL( trunc( wPGA )  ) into wPGA2 from dual;
		dbms_output.put_line( wSNAP_TIME || CharSep || wPGA2 );
	END LOOP;
	IF LSTMODE != 'EXTRACT' THEN
		IF INSTANCE Is NULL THEN	wINSTANCE := '1';	ELSE	wINSTANCE := To_char( instance );	END IF;
		dbms_output.put_line( '-------------------------------------------------------------------------------------------------------' );
		dbms_output.put_line( 'Rappel de la commande:' );
		dbms_output.put_line( ' exec PERFSTAT.PKG_STATS.PGA ( ''' || DATEDEB 	|| ''', ''' ||	DATEFIN 	|| ''', ''' ||
			LSTMODE 	|| ''', ' ||	wINSTANCE	|| ')' );	END IF;	Close src;
	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
procedure HELP
IS	wDATEDEB	VARCHAR( 15 );	wDATEFIN	VARCHAR( 15 );	wVERSION	VARCHAR( 15 );	wDateLimit	DATE; wPARAM VARCHAR(25);
BEGIN	dbms_output.enable( 1000000 );
	--------------------------------------------------------
	SELECT TO_CHAR( trunc( sysdate   ), 'YYYYMMDD' ) INTO wDATEDEB FROM DUAL;
	SELECT TO_CHAR( trunc( sysdate+1 ), 'YYYYMMDD' ) INTO wDATEFIN FROM DUAL;
	wDATEDEB := '''' || wDATEDEB || '''';	wDATEFIN := '''' || wDATEFIN || '''';
	SELECT PKG_STATS.Version INTO wVERSION FROM DUAL;
	--------------------------------------------------------
dbms_output.put_line( '     /----------------------------------------------------------------------------------------------------------------+' );
dbms_output.put_line( wVERSION || '/ '  || RPAD( ' ' , 110 ) || '  |'  );
dbms_output.put_line( '___/  '  || RPAD( '       Report : Module Tuning  (' || wVERSION || ')' , 110 ) || '  |'  );
dbms_output.put_line( '| /   '  || RPAD( '       Rappel des fonctionnalites de l''outil et exemples associes'  , 110 ) || '  |'  );
dbms_output.put_line( '|/    '  || RPAD( ' ' , 110 ) || '  |'  );
--dbms_output.put_line( 'Report : Module Tuning  (' || wVERSION || ')'  );
--dbms_output.put_line('Rappel des fonctionnalites de l''outil et exemple associe' );
dbms_output.put_line('+----------+----------------------------------------------------------------------------------------------------------+' );
dbms_output.put_line('|   DIAG   |  BILAN DE SANTE AUTOMATIQUE                                                                              |' );
dbms_output.put_line('|          |  exec perfstat.PKG_STATS.DIAG                                                                            |' );
dbms_output.put_line('+----------+----------------------------------------------------------------------------------------------------------+' );
select PERFSTAT.PKG_STATS.CheckVal( 'RUBRIQUE' ) into wDateLimit from dual;
IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'| RUBRIQUE |  COMPOSITION DETAILLEE DES TEMPS DE SERVICE                                                              |' );
	dbms_output.put_line(	
	'|          |  exec perfstat.PKG_STATS.Rubrique ( ' || wDATEDEB || ', ' || wDATEFIN ||	', ''CSV'', ''YYYYMMDD HH24:MI'', ''Y'' )             |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' ); END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'SUIVI_IO' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'| SUIVI_IO |  ACTIVITE I/O par TABLESPACE  (et/ou datafile)                                                           |' );
	dbms_output.put_line(
	'|          |  exec perfstat.PKG_STATS.suivi_io ( ' || wDATEDEB || ', ' ||
	wDATEFIN || ', ''CSV'', ''YYYYMMDD HH24:MI'' )                  |' );
	dbms_output.put_line(
	'|          +----------------------------------------------------------------------------------------------------------+' );
	dbms_output.put_line(
	'|          |  PROFIL I/O - Indicateur ( IOPS / MBPS )                                                  |' );
	dbms_output.put_line(	'|          |  exec perfstat.PKG_STATS.Profil_io ( ' || wDATEDEB || ', ' || wDATEFIN ||
		', 1 )                                         |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'TOPSQL' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'|  TOPSQL  |  CLASSEMENT MULTI-CRITERES DES SQLs                                                                      |' );
	dbms_output.put_line(
	'|          |  Exec Perfstat.PKG_STATS.TOPSQL ( ' || wDATEDEB || ', ' ||
	wDATEFIN || ', ''CSV'', ''DISK_READS'', 5, ''Y'', ''Y'', Null )       |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'MTOPSQL' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'| MTOPSQL  |  CLASSEMENTS MULTI-CRITERES DES SQLs  - Impact Analyseur                                                 |' );
	dbms_output.put_line(
	'|          |  Exec Perfstat.PKG_STATS.MTOPSQL ( ' || wDATEDEB || ', ' || wDATEFIN
	|| ', ''CSV'', 5, 5, ''Y'', ''Y'', Null )                 |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'TOPMODULE' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'|TOPMODULE |  ANALYSE DES CONSOMMATIONS SQLs en fonction des MODULEs emetteurs                                        |' );
	dbms_output.put_line(
	'|          |  Exec Perfstat.PKG_STATS.TOPMODULE ( ' || wDATEDEB || ', ' ||
	wDATEFIN || ', ''CSV'', ''DISK_READS'', 1, Null )              |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'SUIVISQL' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'| SUIVISQL |  Suivi MULTI-CRITERES d''un SQL (selon un HASHVALUE defini par d''utilisateur)                             |' );
	dbms_output.put_line(
	'|          |  exec perfstat.PKG_STATS.suivisql ( ' || wDATEDEB || ', ' || wDATEFIN
	|| ', ''CSV'', HASHVALUE=>99999999 )                 |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'BPS' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'|    BPS   |  STATISTIQUES MEMOIRE CACHE                                                                              |' );
	dbms_output.put_line(
	'|          |  exec PERFSTAT.PKG_STATS.BPS     ( ' || wDATEDEB || ', ' ||
	wDATEFIN || ', ''CSV'', 1 )                                    |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'PGA' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'|    PGA   |  STATISTIQUES MEMOIRE PGA                                                                                |' );
	dbms_output.put_line(
	'|          |  exec PERFSTAT.PKG_STATS.PGA     ( ' || wDATEDEB || ', ' ||
	wDATEFIN || ', ''CSV'', 1 )                                    |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );
	dbms_output.put_line(
	'|    SGA   |  STATISTIQUES MEMOIRE SGA                                                                                |' );
	dbms_output.put_line(
	'|          |  exec PERFSTAT.PKG_STATS.SGA     ( ' || wDATEDEB || ', ' ||
	wDATEFIN || ', ''CSV'', Null )                                 |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'NQ' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'|    NQ    |  STATISTIQUES sur les ENQUEUEs                                                                           |' );
	dbms_output.put_line(
	'|          |  exec PERFSTAT.PKG_STATS.NQ      ( ' || wDATEDEB || ', ' ||
	wDATEFIN || ', ''CSV'', 1 )                                    |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'PROFILE' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'| PROFILE  |  STATISTIQUES PROFILE sur le Systeme Oracle                                                              |' );
	dbms_output.put_line(
	'|          |  exec PERFSTAT.PKG_STATS.profile  ( ' ||wDATEDEB||', '||wDATEFIN
	||',''CSV'',''YYYYMMDD HH24:MI'',1,''NORME'' )          |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	select PERFSTAT.PKG_STATS.CheckVal( 'CARTOUCHE' ) into wDateLimit from dual;
	IF wDateLimit > sysdate THEN	dbms_output.put_line(
	'|CARTOUCHE |  Affichage des parametres ORACLE majeurs                                                                 |' );
	dbms_output.put_line(
	'|          |  exec PERFSTAT.PKG_STATS.Cartouche                                                                       |' );
	dbms_output.put_line(
	'+----------+----------------------------------------------------------------------------------------------------------+' );  END IF;
	dbms_output.put_line( 
	'|    Security est ACTIVE ( exec perfstat.PKG_STATS.security )                                                         |' );
	dbms_output.put_line( 
	'+--------------------------------+------------------------------------------------------------------------------------+');
	dbms_output.put_line( RPAD( '| Mise en place Suivi plan       |  Exec perfstat.PKG_STATS.SUIVI_PLAN_ARO', 118 ) || '|' );
	dbms_output.put_line( RPAD( '| Suivre un plan                 |  Exec perfstat.PKG_STATS.INSERT_PLAN_ARO ( <HASH_VALUE>, <PLAN_HASH_VALUE> )', 118 ) || '|' );
	dbms_output.put_line( RPAD( '| Modifier un plan               |  Exec perfstat.PKG_STATS.MODIFY_AROPLAN ( <HASH_VALUE>, <PLAN_HV>, <STATUS>, <COMMENT> )', 118 ) || '|' );
	dbms_output.put_line( RPAD( '| Synchroniser les plans         |  Exec perfstat.PKG_STATS.SYNCHRO_PLAN_ARO', 118 ) || '|' );
	dbms_output.put_line( '+--------------------------------+------------------------------------------------------------------------------------+');
	dbms_output.put_line( RPAD( '| V¿rifier les plans ARO         |  Exec perfstat.PKG_STATS.Check_ARO_Plan( ' || wPARAM , 118 ) || '|' );
	dbms_output.put_line( '+--------------------------------+------------------------------------------------------------------------------------+');
	dbms_output.put_line(RPAD( '|    Suivie Average Active Sessions ( select PERFSTAT.PKG_STATS.AAS() from dual;  )', 118 ) || '|' );
	dbms_output.put_line( 
	'+--------------------------------+------------------------------------------------------------------------------------+');	
END;
---------------------------------------------------------------------------------------------------------------------
procedure suivisql	( DATEDEB IN varchar DEFAULT Null, DATEFIN IN varchar DEFAULT Null, LSTMODE IN varchar DEFAULT 'CSV',
			HASHVALUE IN NUMBER DEFAULT Null, PARAM IN varchar DEFAULT 'DISK_READS', ShowSQL IN Varchar Default 'N',
			ExplainP IN Varchar Default 'N', INSTANCE IN NUMBER DEFAULT 1, MODULE IN VARCHAR DEFAULT Null, SPLAN IN Varchar Default 'N' )
IS	NB_Ano		Number;			PARAM1	Varchar( 2000 );	PARAM2	Varchar( 2000 );	PARAM3	Varchar( 2000 );
	PARAM4		Varchar( 2000 );	PARAM5	Varchar( 2000 );	PARAM6	Varchar( 2000 );	PARAM7	Varchar( 2000 );
	PARAM8		Varchar( 2000 );	PARAM9	Varchar( 2000 );	wDATE1	Date;			wDATE	Date;
	wCHAINE		Varchar( 50 );		TBS	varchar( 3 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;
	PARAM6 := Null;	PARAM7 := Null;	PARAM8 := Null;	PARAM9 := Null;	TBS 	:= 'Y';

	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT )';	END IF;
	-- PARAM
	IF upper ( PARAM ) NOT IN ( 	'SORTS', 'FETCHES', 'EXECUTIONS', 'LOADS', 'PARSE_CALLS', 'DISK_READS',
					'BUFFER_GETS', 'ROWS_PROCESSED', 'CPU_TIME', 'ELAPSED_TIME') THEN	NB_Ano := NB_Ano + 1;
		PARAM5 := 'Le parametre de TOP ' || PARAM || ' est incorrect ( ''DISK_READS'' par defaut )';	END IF;
	-- HASHVALUE
	If HASHVALUE is null THEN	NB_Ano := NB_Ano + 1;	PARAM4 := 'KO Le HASHVALUE de la requete a suivre est obligatoire';	END IF;
	-- SPLAN
	If SPLAN NOT IN ('Y', 'y', 'N', 'n' ) THEN	NB_Ano := NB_Ano + 1;	PARAM9 := 'SPLAN Incorrect (''Y'', ''N'') ';	END IF;
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
		dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE SUIVISQL', 105 ) ||'|' );
dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 4 |  HASHVALUE          | Number  | ' || RPAD( NVL( PARAM4, 'OK ( ''' || HASHVALUE || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 5 |  PARAM              | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ''' || PARAM || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 6 |  SHOWSQL            | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ''' || SHOWSQL || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 7 |  EXPLAINP           | Varchar | ' || RPAD( NVL( PARAM6, 'OK ( ''' || EXPLAINP || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '| 8 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM7, 'OK ( ' || INSTANCE || ' )' ), 70 ) || '|' );
dbms_output.put_line( '| 9 |  MODULE             | Varchar | ' || RPAD( NVL( PARAM8, 'OK ( ''' || MODULE || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '|10 |  SPLAN              | Varchar | ' || RPAD( NVL( PARAM9, 'OK ( ''' || SPLAN || ''' )' ), 70 ) || '|' );
dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.suiviSQL( ''' || DATEDEB || ''', ''' || DATEFIN || ''', ''' 	||
	LSTMODE || ''', ' || NVL( to_char(HASHVALUE), 'Null' )	|| ', ''' || PARAM  || ''', ''' || SHOWSQL  || ''', ''' || EXPLAINP || ''', ' ||
				INSTANCE	|| ', ''' || MODULE		|| ''', ''' ||  SPLAN || ''' )' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SQL_SUMMARY') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$SQL_SUMMARY');
		ELSE	PKG_STATS.suivisql_proc( DATEDEB, DATEFIN, LSTMODE, HASHVALUE, PARAM, ShowSQL, ExplainP, INSTANCE, MODULE, SPLAN );
		END IF;	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure suivisql_proc		( DATEDEB IN varchar, DATEFIN IN varchar, LSTMODE IN varchar DEFAULT 'CSV', HASHVALUE IN NUMBER DEFAULT Null,
				PARAM IN varchar, ShowSQL IN Varchar Default 'N', ExplainP IN Varchar Default 'N', INSTANCE IN NUMBER DEFAULT Null,
				MODULE IN VARCHAR DEFAULT Null,	SPLAN IN Varchar Default 'N' )
is	wCHAINE Varchar( 2000 );
begin	PKG_STATS.TOPSQL_proc( DATEDEB, DATEFIN, LSTMODE, PARAM, 1, ShowSQL, ExplainP, INSTANCE, Null, MODULE, HASHVALUE );
	IF LSTMODE != 'EXTRACT' THEN
		dbms_output.put_line (
		'+----------------------------------------------------------------------------------------------------------------------+');
		dbms_output.put_line ( '| ' || RPAD( ' Rappel de la commande precedente', 115 ) || '  |'  );
		wCHAINE := '| ' || '  * Exec Perfstat.PKG_STATS.SUIVISQL ( ''' || DATEDEB || ''', ''' ;
		wCHAINE := wCHAINE || DATEFIN || ''', ''' || LSTMODE || ''', ' || HASHVALUE || ', ''' || PARAM || ''', ''' ;
		wCHAINE := wCHAINE || ShowSQL || ''', ''' || ExplainP ;
		wCHAINE := wCHAINE || ''', ' || NVL( TO_CHAR(INSTANCE), 'Null') ;
		wCHAINE := wCHAINE || ', ' || NVL( MODULE, 'Null') ;
		wCHAINE := wCHAINE || ', ''' || SPLAN || '''' ;
		Dbms_Output.Put_Line( RPAD( wCHAINE || ' )' , 119 ) || '|' );
		dbms_output.put_line ( '|  ' || RPAD( ' ', 116 ) || '|'  );
		dbms_output.put_line
		( '|  ' || RPAD( 'Valeurs de PARAM acceptees :  ',   116 ) || '|'  );
		dbms_output.put_line (
		'|     SORTS, FETCHES, EXECUTIONS, LOADS, PARSE_CALLS, DISK_READS, BUFFER_GETS, ROWS_PROCESSED, CPU_TIME, ELAPSED_TIME  |');
		dbms_output.put_line ( '|  ' || RPAD( ' ', 116 ) || '|'  );
		dbms_output.put_line ( '+==' || RPAD( '=', 116, '=' ) || '+'  );	END IF;
end;
---------------------------------------------------------------------------------------------------------------------
procedure TOPMODULE		( DATEDEB varchar DEFAULT Null, DATEFIN varchar DEFAULT Null, LSTMODE varchar DEFAULT 'CSV',
				PARAM varchar DEFAULT 'DISK_READS', INSTANCE Number DEFAULT 1, MODULE IN VARCHAR DEFAULT Null )
IS	NB_Ano	Number;	PARAM1	Varchar( 2000 );	PARAM2	Varchar( 2000 );	PARAM3	Varchar( 2000 );	PARAM4	Varchar( 2000 );
	PARAM5	Varchar( 2000 );	PARAM6	Varchar( 2000 );	PARAM7	Varchar( 2000 );	PARAM8	Varchar( 2000 );
	PARAM9	Varchar( 2000 );	PARAM10	Varchar( 2000 );	wDATE1	Date;			wDATE	Date;
	wCHAINE	Varchar( 50 );		wFORMAT_DATE_SORTIE	Varchar( 50 );				wFILTRE	Varchar( 100 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;
	PARAM6 := Null;	PARAM7 := Null;	PARAM8 := Null;	PARAM9 := Null;	PARAM10 := Null;
	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';	END IF;
	-- PARAM
	IF PARAM Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le parametre de TOP est obligatoire ( ''DISK_READS'', ''BUFFER_GETS'' ... ) ';
	ELSIF upper(PARAM) NOT IN ('DISK_READS', 'BUFFER_GETS', 'SORTS', 'FETCHES', 'EXECUTIONS',
			'LOADS', 'PARSE_CALLS', 'ROWS_PROCESSED', 'CPU_TIME', 'ELAPSED_TIME' ) THEN
		NB_Ano := NB_Ano + 1;
		PARAM4 := 'Le parametre de TOP ''' || PARAM || ''' est incorrect ( ''DISK_READS'', ''BUFFER_GETS'', ... ) ';	END IF;
	-- INSTANCE
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE TOPMODULE', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  PARAM              | Varchar | ' || RPAD( NVL( PARAM4, 'OK ( ''' || PARAM || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 5 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM8, 'OK ( ' ||
	NVL( TO_CHAR(INSTANCE), 'Null') || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 6 |  MODULE             | Varchar | ' || RPAD( NVL( PARAM10, 'OK ( ''' || MODULE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.TopMODULE( ''' || DATEDEB 	|| ''', ''' || DATEFIN 	|| ''', ''' ||
	LSTMODE	|| ''', ''' || PARAM || ''', ' || NVL( TO_CHAR(INSTANCE), 'Null' )	||  ', ' || NVL( MODULE, 'Null' )  || ')' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SQL_SUMMARY') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' ,  'STATS$SQL_SUMMARY');
		ELSE	PKG_STATS.TOPMODULE_proc( DATEDEB, DATEFIN, upper(LSTMODE), upper(PARAM), INSTANCE, MODULE );	END IF;	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure TOPMODULE_proc	( DATEDEB IN varchar DEFAULT Null, DATEFIN IN varchar DEFAULT Null, LSTMODE IN varchar DEFAULT 'CSV',
				PARAM IN varchar DEFAULT 'DISK_READS', INSTANCE IN NUMBER DEFAULT 1, MODULE IN VARCHAR DEFAULT Null )
IS	TYPE 			DataSource IS REF CURSOR;  Src 		DataSource ;	SQL_Dyn 	Varchar( 30000 );
	wCONSO			Number;			wMODULE		Varchar( 100 );	TOTAL_CONSO	Number;
	FILTRE_MODULE		Varchar( 10000 );	oVersion	Number;		wSTIME		Varchar( 50 );
	wcpu_time		Number;			welapsed_time	Number;		wTcpu_time	Varchar( 50 );
	wTelapsed_time		Varchar( 50 );		wexecutions 	Number;		wCHAINE		Varchar( 1000 );
	NullMOD			Varchar( 10 );		wCONVERT	Varchar( 30 );
BEGIN	dbms_output.enable( 10000000 );
	TOTAL_CONSO 	:= 0;	NullMOD 	:= 'N';	FILTRE_MODULE	:= '';
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	SQL_Dyn := ' select  NVL( module, ''NON RENSEIGNE'' ) module, ';
	SQL_Dyn := SQL_Dyn || ' sum(' || PARAM || '_inc) ';
	SQL_Dyn := SQL_Dyn || ' from ( select sq.module, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.disk_reads, lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.disk_reads, sq.disk_reads - lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.disk_reads)  disk_reads_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.sorts, lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.sorts, sq.sorts - lag(sq.sorts, 1, sq.sorts)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.sorts) sorts_inc, ';
	--------------------------------------------------------------------------------------------------------------------------------
	IF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' 0 FETCHES_inc, ';
	ELSE	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.FETCHES, lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),  ';
		SQL_Dyn := SQL_Dyn || ' sq.FETCHES, sq.FETCHES - lag(sq.FETCHES, 1, sq.FETCHES)  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.FETCHES) FETCHES_inc,  ';	END IF;
	--------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.LOADS, lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.LOADS, sq.LOADS - lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.LOADS) LOADS_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.PARSE_CALLS, lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.PARSE_CALLS, sq.PARSE_CALLS - lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.PARSE_CALLS) ';
	SQL_Dyn := SQL_Dyn || ' PARSE_CALLS_inc,  decode(greatest(sq.ROWs_PROCESSED, lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.ROWs_PROCESSED, sq.ROWs_PROCESSED - lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn := SQL_Dyn || ' sq.ROWs_PROCESSED) ROWs_PROCESSED_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.buffer_gets, lag(sq.buffer_gets, 1, sq.buffer_gets) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.buffer_gets, sq.buffer_gets - lag(sq.buffer_gets, 1, sq.buffer_gets) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.buffer_gets) buffer_gets_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.executions, lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.executions,sq.executions - lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  ';
	SQL_Dyn := SQL_Dyn || ' sq.executions) executions_inc,  ';
	--------------------------------------------------------------------------------------------------------------------------------
	IF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' 0 cpu_time_inc, ';
	ELSE	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.cpu_time, lag(sq.cpu_time, 1, sq.cpu_time)  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value  order by sq.snap_id)),  ';
		SQL_Dyn := SQL_Dyn || ' sq.cpu_time, sq.cpu_time - lag(sq.cpu_time, 1, sq.cpu_time) ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  ';
		SQL_Dyn := SQL_Dyn || ' sq.cpu_time)/1000000 cpu_time_inc, ';	END IF;
	--------------------------------------------------------------------------------------------------------------------------------
	IF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' 0 elapsed_time_inc    ';
	ELSE	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.elapsed_time, lag(sq.elapsed_time, 1, sq.elapsed_time)   ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),    ';
		SQL_Dyn := SQL_Dyn || ' sq.elapsed_time, sq.elapsed_time - lag(sq.elapsed_time, 1, sq.elapsed_time)  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),   ';
		SQL_Dyn := SQL_Dyn || ' sq.elapsed_time)/1000000 elapsed_time_inc    ';	END IF;
	--------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' from stats$sql_summary sq, stats$snapshot ss  ';
	SQL_Dyn := SQL_Dyn || ' where  ss.snap_time between to_date(''' ||DATEDEB || ''',''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''',''YYYYMMDD HH24:MI'') ';
	--------------------------------------------------------------------------------------------------------------------------------
	IF INSTANCE IS NOT NULL THEN 	SQL_Dyn := SQL_Dyn || ' and ( ss.instance_number = ' || INSTANCE || ' )  ';	END IF;
	IF MODULE IS not null then	SQL_Dyn := SQL_Dyn || ' and MODULE = ''' || MODULE || ''' '; 			END IF;
	--------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' and sq.dbid = ss.dbid   and sq.instance_number = ss.instance_number  ';
	SQL_Dyn := SQL_Dyn || ' and sq.snap_id = ss.snap_id  ';
	SQL_Dyn := SQL_Dyn || ' and sq.executions between 0 and 999999999999999 ';
	SQL_Dyn := SQL_Dyn || ' and sq.disk_reads between 0 and 999999999999999 ';
	SQL_Dyn := SQL_Dyn || ' and sq.buffer_gets between 0 and 999999999999999  ';
	--------------------------------------------------------------------------------------------------------------------------------
	IF Oversion > 8 THEN	SQL_Dyn := SQL_Dyn || ' and sq.cpu_time between 0 and 999999999999999  ';
		SQL_Dyn := SQL_Dyn || ' and sq.elapsed_time between 0 and 999999999999999  ';	END IF;
	--------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' )  ';
	SQL_Dyn := SQL_Dyn || ' group by module  having sum(buffer_gets_inc) > 0 and sum(executions_inc) > 0 ';
	SQL_Dyn := SQL_Dyn || ' order by 2 desc ';

	IF MODULE IS null then		OPEN src for SQL_Dyn;
		LOOP	FETCH Src INTO wMODULE, wCONSO;	EXIT WHEN Src%NOTFOUND;	TOTAL_CONSO := TOTAL_CONSO + wCONSO;
		END LOOP;		Close Src;
		dbms_output.put_line( '+------------------------------------------+-----------------------+-----------+');
		dbms_output.put_line( '|       Module                             | ' || RPAD( PARAM, 21 )  || ' | % / TOTAL |');
		dbms_output.put_line( '+- - - - - - - - - - - - - - - - - - - - - + - - - - - - - - - - - + - - - - - +');
		OPEN src for SQL_Dyn;
		LOOP	FETCH Src INTO wMODULE, wCONSO;	EXIT WHEN Src%NOTFOUND;
			IF 100*( wCONSO/TOTAL_CONSO ) > 0.01 THEN
				IF wMODULE  = 'NON RENSEIGNE' 	THEN	NullMOD := 'Y' ;
				ELSE	FILTRE_MODULE	:= FILTRE_MODULE || ', ''' || wMODULE || '''';		END IF;
				dbms_output.put_line( ' | ' || rpad( wMODULE, 40 ) || ' | ' ||
				RPAD( to_char( wCONSO, '9999999999999999' ), 22 )  || '| ' ||
				RPAD( to_char( 100*( wCONSO/TOTAL_CONSO ), '999.99' ), 10 ) || '|'  );		END IF;
		END LOOP;	Close Src;
		dbms_output.put_line( '+------------------------------------------+-----------------------+-----------+');
	END IF;

	dbms_output.put_line( 'Stime ; MODULE ;' || PARAM || '; CPU_TIME;ELAPSED_TIME;EXECUTIONS;' || PARAM || '(en sec/sec)');
	FILTRE_MODULE := ' and ( module IN (' || substr( FILTRE_MODULE, 2 , 9999 ) || ')' ;
	SQL_Dyn := ' select  STIME, sum(' || PARAM || '_inc), sum(cpu_time_inc) cpu_time, ';
	SQL_Dyn := SQL_Dyn || ' sum(elapsed_time_inc) elapsed_time, sum(executions_inc) executions , module ';
	SQL_Dyn := SQL_Dyn || ' from ( select   to_char( ss.snap_time, ''YYYYMMDD HH24:MI'' ) STIME, ';
	SQL_Dyn := SQL_Dyn || ' sq.sql_text, sq.text_subset, sq.module,  decode(greatest(sq.disk_reads, lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.disk_reads, sq.disk_reads - lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn := SQL_Dyn || ' sq.disk_reads)  disk_reads_inc,  decode(greatest(sq.sorts, lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.sorts, sq.sorts - lag(sq.sorts, 1, sq.sorts)  over(partition by sq.hash_value order by ';
	SQL_Dyn := SQL_Dyn || ' sq.snap_id),  sq.sorts) sorts_inc, ';
	------------------------------------------------------------------------------------------------------------------------------------
	IF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' 0 FETCHES_inc, ';
	ELSE	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.FETCHES, lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
		SQL_Dyn := SQL_Dyn || ' sq.FETCHES, sq.FETCHES - lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.FETCHES) FETCHES_inc, ';	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.LOADS, lag(sq.LOADS, 1, sq.LOADS)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),  sq.LOADS, sq.LOADS - lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.LOADS) LOADS_inc,  ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.PARSE_CALLS, lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.PARSE_CALLS, sq.PARSE_CALLS - lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.PARSE_CALLS) ';
	SQL_Dyn := SQL_Dyn || ' PARSE_CALLS_inc,  decode(greatest(sq.ROWs_PROCESSED, lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),  ';
	SQL_Dyn := SQL_Dyn || ' sq.ROWs_PROCESSED, sq.ROWs_PROCESSED - lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn := SQL_Dyn || ' sq.ROWs_PROCESSED) ROWs_PROCESSED_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.buffer_gets, lag(sq.buffer_gets, 1, sq.buffer_gets)  ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),    ';
	SQL_Dyn := SQL_Dyn || ' sq.buffer_gets, sq.buffer_gets - lag(sq.buffer_gets, 1, sq.buffer_gets) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.buffer_gets) buffer_gets_inc, ';
	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.executions, lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn := SQL_Dyn || ' sq.executions,sq.executions - lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn := SQL_Dyn || ' sq.executions) executions_inc, ';
	------------------------------------------------------------------------------------------------------------------------------------
	IF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' 0 cpu_time_inc, ';
	ELSE	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.cpu_time, lag(sq.cpu_time, 1, sq.cpu_time)  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value  order by sq.snap_id)),  ';
		SQL_Dyn := SQL_Dyn || ' sq.cpu_time, sq.cpu_time - lag(sq.cpu_time, 1, sq.cpu_time) ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn := SQL_Dyn || ' sq.cpu_time)/1000000 cpu_time_inc, ';	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	IF Oversion = 8 THEN	SQL_Dyn := SQL_Dyn || ' 0 elapsed_time_inc ';
	ELSE	SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.elapsed_time, lag(sq.elapsed_time, 1, sq.elapsed_time) ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
		SQL_Dyn := SQL_Dyn || ' sq.elapsed_time, sq.elapsed_time - lag(sq.elapsed_time, 1, sq.elapsed_time) ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn := SQL_Dyn || ' sq.elapsed_time)/1000000 elapsed_time_inc ';	END IF;
	------------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' from stats$sql_summary sq, stats$snapshot ss ';
	SQL_Dyn := SQL_Dyn || ' where  ss.snap_time between to_date(''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )   ';
	IF INSTANCE Is NOT Null THEN	SQL_Dyn := SQL_Dyn || ' and ( ss.instance_number = ' || INSTANCE || ' )  ';	END IF;
	SQL_Dyn := SQL_Dyn || ' and sq.dbid = ss.dbid ';
	SQL_Dyn := SQL_Dyn || ' and sq.instance_number = ss.instance_number  ';
	SQL_Dyn := SQL_Dyn || ' and sq.snap_id = ss.snap_id   ';
	SQL_Dyn := SQL_Dyn || ' and sq.executions between 0 and 999999999999999 ';
	SQL_Dyn := SQL_Dyn || ' and sq.disk_reads between 0 and 999999999999999 ';
	SQL_Dyn := SQL_Dyn || ' and sq.buffer_gets between 0 and 999999999999999 ';
	IF Oversion > 8 THEN	SQL_Dyn := SQL_Dyn || ' and sq.cpu_time between 0 and 999999999999999  ';
		SQL_Dyn := SQL_Dyn || ' and sq.elapsed_time between 0 and 999999999999999 ';	END IF;
	IF MODULE Is NOT NULL	THEN	SQL_Dyn := SQL_Dyn || ' and module = ''' || MODULE || ''' ';
	ELSE	SQL_Dyn := SQL_Dyn || FILTRE_MODULE ;
		IF NullMOD = 'Y' THEN	SQL_Dyn := SQL_Dyn || ' or module  is null ' ;		END IF;
		SQL_Dyn := SQL_Dyn ||  ')';	END IF;
	SQL_Dyn := SQL_Dyn || '  ) ';
	SQL_Dyn := SQL_Dyn || ' group by Stime, module  having sum(' || param || '_inc) > 0 and sum(executions_inc) > 0   order by STIME ';
	OPEN src for SQL_Dyn;
		LOOP	FETCH Src INTO wSTIME, wCONSO, wcpu_time, welapsed_time, wexecutions, wMODULE;	EXIT WHEN Src%NOTFOUND;
			SELECT perfstat.PKG_STATS.XLS_VAL( to_char(wCONSO       ) ) INTO wCONVERT	FROM Dual;
			SELECT perfstat.PKG_STATS.XLS_VAL( to_char(wcpu_time    ) ) INTO wTcpu_time	FROM Dual;
			SELECT perfstat.PKG_STATS.XLS_VAL( to_char(welapsed_time) ) INTO wTelapsed_time	FROM Dual;
			dbms_output.put_line( wSTIME  || ';' ||	wMODULE		|| ';' || wCONVERT	|| ';' ||
				wTcpu_time	|| ';' ||	wTelapsed_time	|| ';' ||	wexecutions  );
		END LOOP;	Close Src;
	dbms_output.put_line (	'+----------------------------------------------------------------------------------------------------------------------+');
	dbms_output.put_line ( '| ' || RPAD( ' Rappel de la commande precedente', 115 ) || '  |'  );
	wCHAINE := '| ' || '  * Exec Perfstat.PKG_STATS.TOPMODULE ( ''' || DATEDEB || ''', ''' ;
	wCHAINE := wCHAINE || DATEFIN || ''', ''' || LSTMODE || ''', ''' || PARAM || ''', ' ;
	wCHAINE := wCHAINE || NVL( TO_CHAR(INSTANCE), 'Null') ;	wCHAINE := wCHAINE || ', ' ;
	IF MODULE Is NULL THEN		wCHAINE := wCHAINE || 'Null'   ;  ELSE	wCHAINE := wCHAINE || '''' || MODULE || ''''  ;	END IF;
	Dbms_Output.Put_Line( RPAD( wCHAINE || ' )' , 119 ) || '|' );
	dbms_output.put_line ( '|  ' || RPAD( ' ', 116 ) || '|'  );
	Dbms_Output.Put_Line( '| ' || RPAD( ' Exec Perfstat.PKG_STATS.TOPSQL ( ''DateDeb'', ''DateFin'', ''LSTMODE'', ' ||
		'''PARAM'', INSTANCE, ''filtrage module''  )' , 117 ) || '|' );
	dbms_output.put_line ('|     SORTS, FETCHES, EXECUTIONS, LOADS, PARSE_CALLS, DISK_READS, BUFFER_GETS, ROWS_PROCESSED, CPU_TIME, ELAPSED_TIME  |');
	dbms_output.put_line ( '|  ' || RPAD( ' ', 116 ) || '|'  );
	dbms_output.put_line ( '+==' || RPAD( '=', 116, '=' ) || '+'  );
END;
---------------------------------------------------------------------------------------------------------------------
Procedure SQL_PLAN_STATS ( wPLAN_HASH_VALUE IN NUMBER, wEXTRACT IN Varchar DEFAULT	Null )
IS	I		Number;		Ligne         	Varchar(2000);		Dest_SQL_Dyn  	Varchar(2000);
	TYPE 	        DataSource IS REF CURSOR;				Src 	        DataSource ;
	wID		Number;		wID_last	Number;			wDEPTH		NUMBER;
	wOPERATION	VARCHAR( 500 );	wOPTIONS	VARCHAR( 500 );		wOBJECTS	VARCHAR( 500 );
	wCARD		NUMBER;		wCARD2	  	VARCHAR(  10 );		wBYTES	  	NUMBER;
	wBYTES2	  	VARCHAR(  10 );	wTEMP		NUMBER;			wTEMP2	  	VARCHAR(  10 );
	wCOST		NUMBER;		wCOST2		VARCHAR(  10 );		wOPTIMIZER    	VARCHAR( 100 );		j	Number;
BEGIN	dbms_output.enable( 1000000 );
	j := 0;	Dest_SQL_Dyn := 'SELECT ID, DEPTH, OPERATION, ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'OPTIONS, OBJECT_NAME, ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( CARDINALITY, 0 ), NVL( ROUND(BYTES/1024), 0 ), ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( ROUND(TEMP_SPACE/1024), 0 ), NVL( COST, 0), ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || 'NVL( OPTIMIZER, '' '' ) ';
		Dest_SQL_Dyn := Dest_SQL_Dyn || ' from STATS$SQL_PLAN where PLAN_HASH_VALUE=' || wPLAN_HASH_VALUE ;
		Dest_SQL_Dyn := Dest_SQL_Dyn || ' order by ID ' ;
		OPEN Src FOR Dest_SQL_Dyn;
		LOOP	FETCH Src INTO wID, wDEPTH, wOPERATION, wOPTIONS, wOBJECTS, wCARD, wBYTES, wTEMP, wCOST, wOPTIMIZER;
			EXIT WHEN Src%NOTFOUND;		j := j + 1;
			if wEXTRACT is null AND j = 1 THEN
				dbms_output.put_line ('+-----+--------------------------------+---------------------------+------+' ||
					'------+------+------+---------------------+' );
				dbms_output.put_line ('| Id  | Operation                      |  Objet                    | Card |' ||
					' Bytes| Temp | Cost | Optimiser           |' );
				dbms_output.put_line ('+-----+--------------------------------+---------------------------+' ||
					'------+------+------+------+---------------------+' );		END IF;

			-- Calcul des arrondis
			SELECT PKG_STATS.Arrondi(  wCARD ) INTO wCARD2  FROM DUAL;
			SELECT PKG_STATS.Arrondi( wBYTES ) INTO wBYTES2 FROM DUAL;
			SELECT PKG_STATS.Arrondi(  wTEMP ) INTO wTEMP2	 FROM DUAL;
			SELECT PKG_STATS.Arrondi(  wCOST ) INTO wCOST2	 FROM DUAL;
			--------------------------------------------------------------------------------
			EXIT WHEN Src%NOTFOUND;
			if wEXTRACT is null THEN
				DBMS_OUTPUT.PUT_LINE ( '|' || TO_CHAR( wID, '999' )	||  ' | ' ||
				RPAD( RPAD( ' ' , wDEPTH ) || wOPERATION || ' ' || NVL(wOPTIONS,' '), 30 ) ||  ' | ' ||
				RPAD( NVL(wOBJECTS, ' '), 25 )	||  ' |' || RPAD( wCARD2,  5 ) 	||  ' |' ||
				RPAD( wBYTES2, 5 ) 	||  ' |' ||  RPAD( wTEMP2,  5 ) 	||  ' |' ||
				RPAD( wCOST2,  5 ) 	||  ' | ' || RPAD( wOPTIMIZER, 20 ) 	|| '|' );
			ELSE	DBMS_OUTPUT.PUT_LINE ( wEXTRACT || ';' || wPLAN_HASH_VALUE || ';' ||
				TO_CHAR( wID, '999' ) ||  ' | ' ||
				RPAD( RPAD( ' ' , wDEPTH ) || wOPERATION || ' ' || NVL(wOPTIONS,' '), 30 ) ||  ' | ' ||
				RPAD( NVL(wOBJECTS, ' '), 25 )	||  ' |' || RPAD( wCARD2,  5 ) 	||  ' |' ||
				RPAD( wBYTES2, 5 ) 	||  ' |' ||  RPAD( wTEMP2,  5 ) 	||  ' |' ||
				RPAD( wCOST2,  5 ) 	||  ' | ' || RPAD( wOPTIMIZER, 20 ) 	|| '|' );	END IF;
		END LOOP;	CLOSE Src;
	if wEXTRACT is null and J>0 THEN
		dbms_output.put_line ('+-----+--------------------------------+---------------------------+' ||
		'------+------+------+------+---------------------+' );
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure info_plan	( DATEDEB VARCHAR, DATEFIN VARCHAR, LSTMODE VARCHAR, IN_INSTANCE_NUMBER NUMBER, IN_HASH_VALUE NUMBER )
IS	TYPE 		DataSource IS REF CURSOR;	Src 		DataSource;	Src2		DataSource;
	Plan		Number;			iTime		Date;			aTime		Date;
	Id		Number;			Old		Number;			iID		Number;
	aID		Number;			i		Number;			j		Number;
	k		Number;			l		Number;			jmax		Number;
	Wchain		Varchar( 10000 );	wModule		Varchar( 100 );		data1		Number;
	data2		Number;			data3		Number;			data4		Number;
	data5		Number;			DynSQL		Varchar( 10000 );	SQL_Dyn		Varchar( 10000 );
	wPlan		Number;			wDEBUG		Number;			wmin_time	Date;
	wmax_time	Date;			wiId		Number;			wi		Number;
	TYPE ElementRECAP IS RECORD(PLAN_HASH_VALUE Number, MINDATE DAte, MAXDATE Date, NB Number );
	Type 	MatriceRECAP IS TABLE OF ElementRECAP index by binary_integer ;	ALL_DATA_RECAP 	MatriceRECAP;
	wSuperVisionPlan	Number;		oVersion	Number;
Begin	dbms_output.enable( 10000000 );		wDEBUG := 0;
	Select count(*) INTO wSuperVisionPlan FROM dba_tables where table_name ='ARO_PLAN_TABLE' and owner='PERFSTAT';
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	DynSQL := 'select count(*) ';
	DynSQL := DynSQL || ' from ( select pu.HASH_VALUE, pu.plan_hash_value ';
	DynSQL := DynSQL || ' from stats$sql_plan_usage	pu, stats$snapshot ss ';
	DynSQL := DynSQL || ' Where 	pu.dbid = ss.dbid ';
	IF IN_INSTANCE_NUMBER Is NOT NULL THEN	DynSQL := DynSQL || ' and ss.instance_number = ' || IN_INSTANCE_NUMBER ; END IF;
	DynSQL := DynSQL || ' and ss.snap_time between to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	DynSQL := DynSQL || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	DynSQL := DynSQL || ' and pu.instance_number = ss.instance_number ';
	DynSQL := DynSQL || ' and pu.snap_id = ss.snap_id ';
	DynSQL := DynSQL || ' and pu.HASH_VALUE = ' || IN_HASH_VALUE;
	DynSQL := DynSQL || ' group by pu.HASH_VALUE, pu.plan_hash_value )';

	IF (wDEBUG = 1) OR (wDEBUG = 9) THEN
		dbms_output.put_line( substr( DynSQL,   1, 200 ));	dbms_output.put_line( substr( DynSQL, 201, 200 ));
		dbms_output.put_line( substr( DynSQL, 401, 200 ));	dbms_output.put_line( substr( DynSQL, 601, 200 ));
		dbms_output.put_line( substr( DynSQL, 801, 200 ));	dbms_output.put_line( substr( DynSQL,1001, 200 ));
		dbms_output.put_line( substr( DynSQL,1201, 200 ));	dbms_output.put_line( substr( DynSQL,1401, 200 ));
		dbms_output.put_line( substr( DynSQL,1601, 200 ));	dbms_output.put_line( substr( DynSQL,1801, 200 ));
		dbms_output.put_line( substr( DynSQL,2001, 200 ));	END IF;		Old := null;
	Open Src FOR DynSQL;	FETCH Src INTO Old;	Close Src;
	Old := NVL( Old, 0 );
	IF Old = 0 	THEN	dbms_output.put_line( '- Aucune information de Plan -' );
	Elsif Old = 1 	THEN	dbms_output.put_line( '- Pas de changement de Plan -' );
	ELSE			dbms_output.put_line( '- Changement de plan -' );	END IF;
	DynSQL := ' select pu.plan_hash_value, ss.snap_time , ss.snap_id ';
	DynSQL := DynSQL || ' from stats$sql_plan_usage pu, stats$snapshot ss ';
	DynSQL := DynSQL || ' Where  pu.dbid = ss.dbid ';
	IF IN_INSTANCE_NUMBER Is NOT Null THEN	DynSQL := DynSQL || ' and ss.instance_number = ' || IN_INSTANCE_NUMBER ; END IF;
	DynSQL := DynSQL || ' and ss.snap_time between to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	DynSQL := DynSQL || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )';
	DynSQL := DynSQL || ' and pu.instance_number = ss.instance_number ';
	DynSQL := DynSQL || ' and pu.snap_id = ss.snap_id ';
	DynSQL := DynSQL || ' and pu.HASH_VALUE = ' || IN_HASH_VALUE ;
	DynSQL := DynSQL || ' group by pu.plan_hash_value, ss.snap_time , ss.snap_id ';
	DynSQL := DynSQL || ' Order by ss.snap_time, ss.snap_id, pu.plan_hash_value  ';

	IF (wDEBUG = 2) OR (wDEBUG = 9) THEN
		dbms_output.put_line( substr( DynSQL,   1, 200 ));	dbms_output.put_line( substr( DynSQL, 201, 200 ));
		dbms_output.put_line( substr( DynSQL, 401, 200 ));	dbms_output.put_line( substr( DynSQL, 601, 200 ));
		dbms_output.put_line( substr( DynSQL, 801, 200 ));	dbms_output.put_line( substr( DynSQL,1001, 200 ));
		dbms_output.put_line( substr( DynSQL,1201, 200 ));	dbms_output.put_line( substr( DynSQL,1401, 200 ));
		dbms_output.put_line( substr( DynSQL,1601, 200 ));	dbms_output.put_line( substr( DynSQL,1801, 200 ));
		dbms_output.put_line( substr( DynSQL,2001, 200 ));	END IF;
	Open Src For DynSQL;	wPlan	:= Null;	wiId	:= Null;	wi	:= 1;	j := 1;

	IF Old > 0 THEN	dbms_output.put_line(
		'.  plan_hash      Debut periode     Fin periode   NbSNAPs  disk_reads  buffer_gets  executions   cpu_time elapsed_time' );
	dbms_output.put_line(
	'+--------------+----------------+----------------+------+------------+------------+------------+----------+----------+' );
		LOOP	FETCH Src INTO Plan, itime, iId;	EXIT WHEN Src%NOTFOUND;
			IF wmin_time IS NULL THEN 	wmin_time	:= itime; 	END IF;
			IF wmax_time IS NULL THEN	wmax_time	:= itime; 	END IF;

			IF wPlan Is NULL THEN		wPlan	:= Plan;	wi	:= 0;
			ELSIF	wPlan != Plan		THEN
				ALL_DATA_RECAP(j).PLAN_HASH_VALUE := wPlan;	ALL_DATA_RECAP(j).MINDATE	:= wmin_time;
				ALL_DATA_RECAP(j).MAXDATE	:= wmax_time;	ALL_DATA_RECAP(j).NB		:= wi;
				j := j + 1;	wPlan := Plan;	wi := 0;	wmin_time := itime;	wmax_time := itime;
			END IF;		wi := wi + 1;
			IF itime < wmin_time 	THEN 	wmin_time := itime; 	END IF;
			IF itime > wmax_time 	THEN 	wmax_time := itime; 	END IF;
		END LOOP;
			ALL_DATA_RECAP(j).PLAN_HASH_VALUE := wPlan;	ALL_DATA_RECAP(j).MINDATE	:= wmin_time;
			ALL_DATA_RECAP(j).MAXDATE	:= wmax_time;	ALL_DATA_RECAP(j).NB		:= wi;		j := j + 1;
		Close Src;
		--------------------------------------------------------------------------------------------------------------------------------
		jmax := j;	j := 1;
		while j < jmax
		LOOP
			SELECT 	min( SNAP_ID )	INTO 	iId	FROM 	STATS$SNAPSHOT
			where 	to_char( snap_time , 'YYYYMMDD HH24:MI' ) = TO_CHAR( ALL_DATA_RECAP(j).MINDATE, 'YYYYMMDD HH24:MI' );
			SELECT 	max( SNAP_ID )	INTO 	aId	FROM 	STATS$SNAPSHOT
			where 	to_char( snap_time , 'YYYYMMDD HH24:MI' ) = TO_CHAR( ALL_DATA_RECAP(j).MAXDATE, 'YYYYMMDD HH24:MI' );
			DynSQL := ' select sum( disk_reads_inc) disk_reads, sum( buffer_gets_inc ) buffer_gets, sum( executions_inc ) executions, ';
			DynSQL := DynSQL || ' sum( cpu_time_inc ) cpu_time, sum( elapsed_time_inc ) elapsed_time ';
			DynSQL := DynSQL || ' from (select sq.sql_text, sq.text_subset, sq.module, ';
			DynSQL := DynSQL || ' decode(greatest(sq.disk_reads, nvl(lag(sq.disk_reads) ';
			DynSQL := DynSQL || ' over(partition by sq.hash_value order by sq.snap_id),0)), sq.disk_reads, ';
			DynSQL := DynSQL || ' sq.disk_reads-nvl(lag(sq.disk_reads) over(partition by sq.hash_value ';
			DynSQL := DynSQL || ' order by sq.snap_id),0), 0) disk_reads_inc, ';
			DynSQL := DynSQL || ' decode(greatest(sq.buffer_gets, nvl(lag(sq.buffer_gets) ';
			DynSQL := DynSQL || ' over(partition by sq.hash_value order by sq.snap_id),0)), sq.buffer_gets, ';
			DynSQL := DynSQL || ' sq.buffer_gets-nvl(lag(buffer_gets) over(partition by sq.hash_value ';
			DynSQL := DynSQL || ' order by sq.snap_id),0), 0) buffer_gets_inc, ';
			DynSQL := DynSQL || ' decode(greatest(sq.executions, nvl(lag(sq.executions) ';
			DynSQL := DynSQL || ' over(partition by sq.hash_value order by sq.snap_id),0)), sq.executions, ';
			DynSQL := DynSQL || ' sq.executions-nvl(lag(sq.executions) over(partition by sq.hash_value ';
			DynSQL := DynSQL || ' order by sq.snap_id),0), 0) executions_inc, ';
			DynSQL := DynSQL || ' decode(greatest(sq.cpu_time, nvl(lag(sq.cpu_time) over(partition by sq.hash_value ';
			DynSQL := DynSQL || ' order by sq.snap_id),0)), sq.cpu_time, sq.cpu_time-nvl(lag(sq.cpu_time) ';
			DynSQL := DynSQL || ' over(partition by sq.hash_value order by sq.snap_id),0), 0)/1000000 cpu_time_inc, ';
			DynSQL := DynSQL || ' decode(greatest(sq.elapsed_time, nvl(lag(sq.elapsed_time) over(partition by sq.hash_value ';
			DynSQL := DynSQL || ' order by sq.snap_id),0)), sq.elapsed_time, sq.elapsed_time-nvl(lag(sq.elapsed_time) ';
			DynSQL := DynSQL || ' over(partition by sq.hash_value order by sq.snap_id),0), 0)/1000000 elapsed_time_inc ';
			DynSQL := DynSQL || ' from stats$sql_summary sq, stats$snapshot	ss ';
			DynSQL := DynSQL || ' where  ss.snap_time between to_date( ''' ||
					to_char( ALL_DATA_RECAP(j).MINDATE, 'YYYYMMDD HH24:MI' ) || ''', ''YYYYMMDD HH24:MI'' )';
			DynSQL := DynSQL || '  and to_date( ''' ||
					to_char( ALL_DATA_RECAP(j).MAXDATE, 'YYYYMMDD HH24:MI' ) || ''', ''YYYYMMDD HH24:MI'' )';
			IF IN_INSTANCE_NUMBER Is NOT Null THEN DynSQL := DynSQL || ' and  ss.instance_number = ' || IN_INSTANCE_NUMBER; END IF;
			DynSQL := DynSQL || ' and	 sq.dbid = ss.dbid ';
			DynSQL := DynSQL || ' and	 sq.instance_number = ss.instance_number ';
			DynSQL := DynSQL || ' and	 sq.snap_id = ss.snap_id ';
			DynSQL := DynSQL || ' and	 sq.executions between 0 and 999999999999999';
			DynSQL := DynSQL || ' and	 sq.disk_reads between 0 and 999999999999999';
			DynSQL := DynSQL || ' and	 sq.buffer_gets between 0 and 999999999999999';
			DynSQL := DynSQL || ' and	 sq.cpu_time between 0 and 999999999999999';
			DynSQL := DynSQL || ' and	 sq.elapsed_time between 0 and 999999999999999 ';
			DynSQL := DynSQL || ' and	 sq.hash_value = ' || IN_HASH_VALUE;
			DynSQL := DynSQL || ' ) ';
			IF (wDEBUG = 3) OR (wDEBUG = 9) THEN
				dbms_output.put_line( substr( DynSQL,   1, 200 ));	dbms_output.put_line( substr( DynSQL, 201, 200 ));
				dbms_output.put_line( substr( DynSQL, 401, 200 ));	dbms_output.put_line( substr( DynSQL, 601, 200 ));
				dbms_output.put_line( substr( DynSQL, 801, 200 ));	dbms_output.put_line( substr( DynSQL,1001, 200 ));
				dbms_output.put_line( substr( DynSQL,1201, 200 ));	dbms_output.put_line( substr( DynSQL,1401, 200 ));
				dbms_output.put_line( substr( DynSQL,1601, 200 ));	dbms_output.put_line( substr( DynSQL,1801, 200 ));
				dbms_output.put_line( substr( DynSQL,2001, 200 ));	END IF;
			OPEN Src2 FOR DynSQL;
			LOOP	FETCH Src2 INTO data1, data2, data3, data4, data5;	EXIT WHEN Src2%NOTFOUND;
			END LOOP;		Close Src2;
			Wchain := '| ' || Rpad( ALL_DATA_RECAP(j).PLAN_HASH_VALUE, 12 )  || ' | ' ||
				to_char( ALL_DATA_RECAP(j).MINDATE, 'YYYYMMDD HH24:MI' )  || ' | ' ||
				to_char( ALL_DATA_RECAP(j).MAXDATE, 'YYYYMMDD HH24:MI' )  || ' |' ||
				to_char( ALL_DATA_RECAP(j).NB, '9999' ) || ' | ';

			Wchain := Wchain ||
			to_char( NVL( data1,0) , '999999999' )	|| ' |' || to_char( NVL( data2,0) , '9999999999' ) || ' |' ||
			to_char( NVL( data3,0) , '9999999999' )	|| ' |' || to_char( NVL( data4,0) , '99999999' )	|| ' |' ||
			to_char( NVL( data5,0) , '99999999' )	|| ' |' ;

			IF 	NVL(data1,0) = 0 AND NVL(data2,0) = 0 AND  NVL(data3,0) = 0 AND NVL(data4,0) = 0 AND   NVL(data5,0) = 0
			THEN	Null;	ELSE	dbms_output.put_line( Wchain );
				dbms_output.put_line(  '|              |' ||
				RPAD( '(Snap:' || iId || ')', 16 ) || '|'  ||
				RPAD( '(Snap:' || aId || ')', 16 ) || '|      |            |            |            |          |          |'  );
				dbms_output.put_line(
				'+--------------+----------------+----------------+------+------------+------------+------------+----------+----------+' );
			END IF;		j := j + 1;
		END LOOP;

		jmax := j;	j := 1;	l := 1;
		while j < jmax
		LOOP	k := 1;
			while k < j
			LOOP	IF ALL_DATA_RECAP(j).PLAN_HASH_VALUE = ALL_DATA_RECAP(k).PLAN_HASH_VALUE THEN	EXIT;	END IF;
				k := k+1;
			END LOOP;

			if J = k
			THEN	dbms_output.put_line( l || '. Plan d''execution No ' || ALL_DATA_RECAP(j).PLAN_HASH_VALUE  );
				PKG_STATS.SQL_PLAN_STATS( ALL_DATA_RECAP(j).PLAN_HASH_VALUE );	l := l + 1;	END IF;

 	IF wSuperVisionPlan > 0 THEN
		IF Oversion = 9 THEN
		 	SQL_Dyn := 'BEGIN  PERFSTAT.PKG_STATS.Info_Plan(	PLAN_HASH_VALUE=>' || ALL_DATA_RECAP(j).PLAN_HASH_VALUE;
		 	SQL_Dyn := SQL_Dyn || ', HASH_VALUE=>' || IN_HASH_VALUE || '); END;' ;	EXECUTE IMMEDIATE SQL_Dyn; 	END IF;
 	END IF;		j := j + 1;
		END LOOP;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure MTOPSQL_proc		( DATEDEB IN varchar, DATEFIN IN varchar, LSTMODE varchar DEFAULT 'CSV', TOP IN NUMBER DEFAULT 5,
				PCT_MIN IN NUMBER DEFAULT 5, ShowSQL  Varchar  Default 'N', ExplainP Varchar  Default 'N',
				INSTANCE IN NUMBER DEFAULT Null, MODULE  IN VARCHAR DEFAULT Null, HASHVALUE IN NUMBER DEFAULT Null,
				SCOPE  IN VARCHAR DEFAULT 'ALL', PLANSTAT IN VARCHAR DEFAULT 'N', DETAILS  IN VARCHAR DEFAULT 'Y' ,
				ZOOM  IN VARCHAR DEFAULT Null, FIXED_SCHEMA IN VARCHAR DEFAULT Null )
IS	wDATEDEB	Varchar( 50 );		SQL_Dyn		Varchar( 10000 );	SQL_Dyn2	Varchar( 10000 );
	SQL_Dyn3	Varchar( 10000 );	SQL_DECODE	Varchar( 10000 );	TYPE		DataSource IS REF CURSOR;
	Src 		DataSource ;		Src2 		DataSource ;		Src3 		DataSource ;
	wCONSO		Number;			wDEBUG		Number;			i		Number;
	wINSTANCE	Varchar( 10 );		wHASHVALUE	Varchar( 100 );		whash_value	Number;
	whash_value_txt	varchar( 50 );		iPARAM		Number;			iHASH		Number;
	iHASHMAX	Number;			wTOTALCONSO	Number;			wChaine		Varchar( 10000 );
	wChaine2	Varchar( 100 );		wRub		Varchar( 100 );		oVersion	Number;
	wIMPACT		Number;			wIMPACT_Tot	Number;			MAX_iConso	Number;
	CharSep		Varchar( 5 );		wStime		Varchar( 35 );		wDebit		Number;
	wNBImpact	Number;		wMODULE		Varchar( 100 );
	TYPE Element_HASH IS RECORD ( HASH_VALUE Number, NB Number, COMMENT Varchar( 10000 ) );
	Type 	Matrice_HASH IS TABLE OF Element_HASH index by binary_integer ;
	HASH		Matrice_HASH;
	TYPE Element_PARAM IS RECORD	(	PARAM	Varchar( 100 )		);
	Type 	Matrice_PARAM IS TABLE OF Element_PARAM index by binary_integer ;
	PARAMTOP	Matrice_PARAM;	Max_PARAM	Number;
	TYPE Conso_HASH IS RECORD ( Axe Number, Rng Number,  Hash_Value Varchar( 100 ),  Consommation Number,
			impact Number, Num_SQL Number, TOTAL Number );
	Type 	Matrice_Conso IS TABLE OF Conso_HASH index by binary_integer ;	Conso	Matrice_Conso;	iConso	Number;
	TYPE AFF_HASH IS RECORD	(	Hash_Value		Number	);
	Type 	AFF_MATRICE_HASH IS TABLE OF AFF_HASH index by binary_integer ;
	My_HASH	AFF_Matrice_HASH;		My_HASH_Number	Number;			My_HASH_MAX	Number;
	wLEVEL		Number;			SPLAN		Varchar( 5 );		WEXPLAINP	Varchar( 5 );
	WEXTRACT	Varchar( 50 );		TXT		Varchar( 1000 );	ELight		Number;
	wDateLimit	Date;			HMIN		Varchar( 25 );		HMAX		Varchar( 25 );
	wINSTANCE_NAME 	Varchar( 25 );		wHOST_NAME	Varchar( 25 );		wChaine1	Varchar( 100 );
BEGIN	dbms_output.enable( 10000000 );
	wCONSO	:= 0;	wDEBUG	:= 0;	iPARAM	:= 1;	iHASHMAX:= 1;	iconso  := 1;
	wDATEDEB := to_char( To_date( DATEDEB, 'YYYYMMDD HH24:MI' )-(1/24), 'YYYYMMDD HH24:MI' );
	select perfstat.PKG_STATS.CheckVal('MTOPSQL', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN 	dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; 	END IF;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	IF LSTMODE = 'EXTRACT' THEN
		select ';' || INSTANCE_NAME || ';' || HOST_NAME || ';' INTO wEXTRACT from v$instance;
		wEXTRACT := wEXTRACT || wDATEDEB || ';' || INSTANCE ;
	ELSE	wEXTRACT := Null;	END IF;

	IF LSTMODE IN ('CSV', 'EXTRACT' )	THEN	CharSep := ';';	ELSE	CharSep := '|';	END IF;
	SELECT MAx( SNAP_LEVEL ) INTO wLEVEL	from stats$snapshot
	Where	SNAP_TIME between to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) AND to_date( DATEFIN, 'YYYYMMDD HH24:MI' );
	select to_number( substr( VERSION, 1, instr( VERSION, '.' )-1 )  ) INTO Oversion FROM v$instance;

	IF SCOPE = 'ALL' THEN
		PARAMTOP( 1).PARAM 	:=	'DISK_READS';		PARAMTOP( 2).PARAM 	:=	'BUFFER_GETS';
		PARAMTOP( 3).PARAM 	:=	'EXECUTIONS';		PARAMTOP( 4).PARAM 	:=	'ROWS_PROCESSED';
		PARAMTOP( 5).PARAM 	:=	'SORTS';		PARAMTOP( 6).PARAM 	:=	'PARSE_CALLS';
		PARAMTOP( 7).PARAM 	:=	'LOADS';
		--------------------------------------------------------------------- 8i
		PARAMTOP( 8).PARAM 	:=	'FETCHES';		PARAMTOP( 9).PARAM 	:=	'CPU_TIME';
		PARAMTOP(10).PARAM 	:=	'ELAPSED_TIME';
		--------------------------------------------------------------------- 9i
		PARAMTOP(11).PARAM 	:=	'JAVA_EXEC_TIME';	PARAMTOP(12).PARAM 	:=	'APPLICATION_WAIT_TIME';
		PARAMTOP(13).PARAM 	:=	'CONCURRENCY_WAIT_TIME';
		PARAMTOP(14).PARAM 	:=	'CLUSTER_WAIT_TIME';	PARAMTOP(15).PARAM 	:=	'USER_IO_WAIT_TIME';
		PARAMTOP(16).PARAM 	:=	'PLSQL_EXEC_TIME';
		--------------------------------------------------------------------- 10g
		IF Oversion >= 10	THEN	Max_PARAM := 16; ELSIF Oversion = 9	THEN	Max_PARAM := 10;
		ELSIF Oversion = 8	THEN	Max_PARAM := 7; END IF;
	ELSIF SCOPE = 'ARO' THEN
		PARAMTOP( 1).PARAM 	:=	'DISK_READS';		PARAMTOP( 2).PARAM 	:=	'BUFFER_GETS';
		PARAMTOP( 3).PARAM 	:=	'EXECUTIONS';		PARAMTOP( 4).PARAM 	:=	'SORTS';

		-- Axes supprimes : 'PARSE_CALLS', 'LOADS', 'ROWS_PROCESSED'
		--------------------------------------------------------------------- 8i
		PARAMTOP( 5).PARAM 	:=	'CPU_TIME';		PARAMTOP( 6).PARAM 	:=	'ELAPSED_TIME';
		-- Axes supprimes: 'FETCHES'
		--------------------------------------------------------------------- 9i
		PARAMTOP( 7).PARAM 	:=	'JAVA_EXEC_TIME';	PARAMTOP( 8).PARAM 	:=	'APPLICATION_WAIT_TIME';
		PARAMTOP( 9).PARAM 	:=	'CONCURRENCY_WAIT_TIME'; 	PARAMTOP(10).PARAM 	:=	'CLUSTER_WAIT_TIME';
		PARAMTOP(11).PARAM 	:=	'USER_IO_WAIT_TIME';	PARAMTOP(12).PARAM 	:=	'PLSQL_EXEC_TIME';
		--------------------------------------------------------------------- 10g
		IF Oversion >= 10	THEN	Max_PARAM := 12; ELSIF Oversion = 9	THEN	Max_PARAM := 6;
		ELSIF Oversion = 8	THEN	Max_PARAM := 4;	END IF;
	ELSIF SCOPE = 'IO' THEN PARAMTOP( 1).PARAM 	:=	'DISK_READS';	PARAMTOP( 2).PARAM 	:=	'BUFFER_GETS';
		PARAMTOP( 3).PARAM 	:=	'SORTS';
		-- Axes supprimes : 'PARSE_CALLS', 'LOADS', 'ROWS_PROCESSED', 'EXECUTIONS';
		--------------------------------------------------------------------- 8i
		PARAMTOP( 4).PARAM 	:=	'CPU_TIME';	PARAMTOP( 5).PARAM 	:=	'ELAPSED_TIME';
		-- Axes supprimes : 'FETCHES';
		--------------------------------------------------------------------- 9i
		-- Axes supprimes : 'JAVA_EXEC_TIME', 'APPLICATION_WAIT_TIME', 'CONCURRENCY_WAIT_TIME', 'CLUSTER_WAIT_TIME';
		PARAMTOP(6).PARAM 	:=	'USER_IO_WAIT_TIME';
		-- Axes supprimes : 'PLSQL_EXEC_TIME';
		--------------------------------------------------------------------- 10g
		IF Oversion >= 10	THEN	Max_PARAM := 6;	ELSIF Oversion = 9	THEN	Max_PARAM := 5;
		ELSIF Oversion = 8	THEN	Max_PARAM := 3;	END IF;
	END IF;


	IF LSTMODE != 'EXTRACT' AND LSTMODE NOT LIKE 'TQ%' THEN
		dbms_output.put_line( '     /---------------------------------------------------+' );
		dbms_output.put_line( PKG_STATS.version || ' /           MTOPSQL MULTI-crit?s                   |' );
		dbms_output.put_line( '___/                                                     |' );
		dbms_output.put_line( RPAD( '| /           Tuning : ' || PKG_STATS.version, 57 ) || '|' );
		dbms_output.put_line( '|/                                                       |' );
		dbms_output.put_line( '/--------------------------------------------------------+' );
		dbms_output.put_line( 'Restitution du ' || DATEDEB || ' au ' || DATEFIN	);

		IF INSTANCE IS NULL THEN dbms_output.put_line( 'INSTANCE                    : Toutes Instances(1 a n)' );
		ELSE	dbms_output.put_line( 'INSTANCE                    : ' || INSTANCE );	END IF;
		IF MODULE IS Null THEN	dbms_output.put_line( 'MODULE                      : Tous Modules' );
		ELSE	dbms_output.put_line( 'MODULE                      : ' || MODULE ); 	END IF;
		IF HASHVALUE Is Null THEN	dbms_output.put_line( 'HASHVALUE                   : Tous HASHVALUE' );
		ELSE	dbms_output.put_line( 'HASHVALUE                   : ' || HASHVALUE  ); END IF;
		IF FIXED_SCHEMA Is Null THEN	dbms_output.put_line( 'FIXED_SCHEMA                   : Tous FIXED_SCHEMA' );
		ELSE	dbms_output.put_line( 'FIXED_SCHEMA                   : ' || FIXED_SCHEMA  ); END IF;		
		
		dbms_output.put_line( 'Seuil d''impact (PCT_MIN)    : ' || PCT_MIN );
		dbms_output.put_line( 'Nombre de SQL par axe (TOP) : ' || TOP     );
		dbms_output.put_line( 'Type de restution           : ' || LSTMODE );
		dbms_output.put_line( 'ShowSQL                     : ' || ShowSQL );
		dbms_output.put_line( 'ExplainP                    : ' || ExplainP);
		dbms_output.put_line( 'Oracle version              : ' || Oversion);
		dbms_output.put_line( 'Panel d''axes d''analyse      : ' || SCOPE );
		dbms_output.put_line( 'NB axes d''analyse           : ' || Max_PARAM );
		dbms_output.put_line( 'Suivi PLANSTAT              : ' || PLANSTAT );
		dbms_output.put_line( '+--------------------+---+----------------+--------------+-------+-----+' );
		dbms_output.put_line( '| Axe d''analyse      |Rng|   Hash Value   | Consommation |%impact|N°SQL|' );	END IF;

	While iPARAM <= Max_PARAM
	LOOP	i	:= 1;
		-- Generation du SQL Dynamique N°1
		SQL_Dyn := ' select ' ;
		IF HASHVALUE IS Null	THEN	SQL_Dyn := SQL_Dyn || ' hash_value, ';	ELSE	SQL_Dyn := SQL_Dyn || ' 0, ';	END IF;
		SQL_Dyn := SQL_Dyn || ' sum(' || PARAMTOP(iPARAM).PARAM || '_inc)  ' || PARAMTOP(iPARAM).PARAM;
		SQL_Dyn := SQL_Dyn || ' from ( select ss.snap_time stime, sq.hash_value, ';
		SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.' || PARAMTOP(iPARAM).PARAM;
		SQL_Dyn := SQL_Dyn || ', lag(sq.' || PARAMTOP(iPARAM).PARAM || ', 1, sq.' || PARAMTOP(iPARAM).PARAM || ')  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)),  sq.' || PARAMTOP(iPARAM).PARAM || ', ';
		SQL_Dyn := SQL_Dyn || ' sq.' || PARAMTOP(iPARAM).PARAM || ' - lag(sq.' || PARAMTOP(iPARAM).PARAM ;
		SQL_Dyn := SQL_Dyn || ' , 1, sq.' || PARAMTOP(iPARAM).PARAM || ')  ';
		SQL_Dyn := SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id),  sq.' || PARAMTOP(iPARAM).PARAM || ') ';
		SQL_Dyn := SQL_Dyn || PARAMTOP(iPARAM).PARAM || '_inc ';
		SQL_Dyn := SQL_Dyn || ' from stats$sql_summary sq, stats$snapshot ss ';
		SQL_Dyn := SQL_Dyn || ' where ss.snap_time between to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
		SQL_Dyn := SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
		IF INSTANCE IS NOT NULL  THEN	SQL_Dyn := SQL_Dyn || ' and ( ss.instance_number = ' || INSTANCE || ' )  ';	END IF;
		SQL_Dyn := SQL_Dyn || ' and sq.dbid = ss.dbid  ';
		SQL_Dyn := SQL_Dyn || ' and sq.instance_number = ss.instance_number  ';
		SQL_Dyn := SQL_Dyn || ' and sq.snap_id = ss.snap_id  ';
		---------------------------------------------------------------------------------------------------------
		IF MODULE Is NOT NULL	THEN	SQL_Dyn := SQL_Dyn || ' and sq.MODULE = ''' || MODULE || ''' ';	END IF;
		IF HASHVALUE Is NOT NULL THEN	SQL_Dyn := SQL_Dyn || ' and sq.hash_value = ' || HASHVALUE;	END IF;
		---------------------------------------------------------------------------------------------------------
		SQL_Dyn := SQL_Dyn || ' and sq.executions between 0 and 999999999999999  ';
		SQL_Dyn := SQL_Dyn || ' and sq.disk_reads between 0 and 999999999999999  ';
		SQL_Dyn := SQL_Dyn || ' and sq.buffer_gets between 0 and 999999999999999 ';
		---------------------------------------------------------------------------------------------------------
		IF Oversion > 8 THEN	SQL_Dyn := SQL_Dyn || ' and sq.cpu_time between 0 and 999999999999999  ';
			SQL_Dyn := SQL_Dyn || ' and sq.elapsed_time between 0 and 999999999999999  ';	END IF;
		---------------------------------------------------------------------------------------------------------
		SQL_Dyn := SQL_Dyn || ' )  ';
		SQL_Dyn := SQL_Dyn || ' where 	stime >= to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' )   ';

		IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
			SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;

		IF HASHVALUE IS Null		THEN	SQL_Dyn := SQL_Dyn || ' group by hash_value ';	END IF;
		SQL_Dyn := SQL_Dyn || ' having sum(' || PARAMTOP(iPARAM).PARAM || '_inc) > 0  ';
		SQL_Dyn := SQL_Dyn || ' order by 2 desc ';

		-- Generation du SQL Dynamique N°2
		SQL_Dyn2 := ' select ' ;
		SQL_Dyn2 := SQL_Dyn2 || ' sum(' || PARAMTOP(iPARAM).PARAM || '_inc)  ' || PARAMTOP(iPARAM).PARAM;
		SQL_Dyn2 := SQL_Dyn2 || ' from ( select ss.snap_time stime, sq.hash_value, ';
		SQL_Dyn2 := SQL_Dyn2 || ' decode(greatest(sq.' || PARAMTOP(iPARAM).PARAM;
		SQL_Dyn2 := SQL_Dyn2 || ', lag(sq.' || PARAMTOP(iPARAM).PARAM || ', 1, sq.' || PARAMTOP(iPARAM).PARAM || ')  ';
		SQL_Dyn2 := SQL_Dyn2 || ' over(partition by sq.hash_value order by sq.snap_id)),  sq.' || PARAMTOP(iPARAM).PARAM || ', ';
		SQL_Dyn2 := SQL_Dyn2 || ' sq.' || PARAMTOP(iPARAM).PARAM || ' - lag(sq.' || PARAMTOP(iPARAM).PARAM ;
		SQL_Dyn2 := SQL_Dyn2 || ' , 1, sq.' || PARAMTOP(iPARAM).PARAM || ')  ';
		SQL_Dyn2 := SQL_Dyn2 || ' over(partition by sq.hash_value order by sq.snap_id),  sq.' || PARAMTOP(iPARAM).PARAM || ') ';
		SQL_Dyn2 := SQL_Dyn2 || PARAMTOP(iPARAM).PARAM || '_inc ';
		SQL_Dyn2 := SQL_Dyn2 || ' from stats$sql_summary sq, stats$snapshot ss ';
		SQL_Dyn2 := SQL_Dyn2 || ' where ss.snap_time between to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
		SQL_Dyn2 := SQL_Dyn2 || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';
		---------------------------------------------------------------------------------------------------------
		IF INSTANCE IS NOT NULL  THEN	SQL_Dyn2 := SQL_Dyn2 || ' and ( ss.instance_number = ' || INSTANCE || ' )  ';	END IF;
		---------------------------------------------------------------------------------------------------------
		SQL_Dyn2 := SQL_Dyn2 || ' and sq.dbid = ss.dbid  ';
		SQL_Dyn2 := SQL_Dyn2 || ' and sq.instance_number = ss.instance_number  ';
		SQL_Dyn2 := SQL_Dyn2 || ' and sq.snap_id = ss.snap_id  ';
		---------------------------------------------------------------------------------------------------------
		IF MODULE Is NOT NULL	THEN	SQL_Dyn2 := SQL_Dyn2 || ' and sq.MODULE = ''' || MODULE || ''' ';	END IF;
		---------------------------------------------------------------------------------------------------------
		SQL_Dyn2 := SQL_Dyn2 || ' and sq.executions between 0 and 999999999999999  ';
		SQL_Dyn2 := SQL_Dyn2 || ' and sq.disk_reads between 0 and 999999999999999  ';
		SQL_Dyn2 := SQL_Dyn2 || ' and sq.buffer_gets between 0 and 999999999999999 ';
		IF Oversion > 8 THEN SQL_Dyn2 := SQL_Dyn2 || ' and sq.cpu_time between 0 and 999999999999999  ';
			SQL_Dyn2 := SQL_Dyn2 || ' and sq.elapsed_time between 0 and 999999999999999  ';	END IF;
		SQL_Dyn2 := SQL_Dyn2 || ' )  ';
		SQL_Dyn2 := SQL_Dyn2 || ' where 	stime >= to_date( ''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' )   ';
		IF ZOOM Is NOT Null THEN	SQL_Dyn2 :=  SQL_Dyn2 || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
			SQL_Dyn2 :=  SQL_Dyn2 || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';		END IF;
		SQL_Dyn2 := SQL_Dyn2 || ' having sum(' || PARAMTOP(iPARAM).PARAM || '_inc) > 0  ';

		-- Debuggage du SQL dynamique
		IF wDEBUG = 1 OR wDEBUG = 9 THEN
			dbms_output.put_line( '---------------- SQL_Dyn --------------------------------' );
			dbms_output.put_line( substr( SQL_Dyn ,    1, 200 ));	dbms_output.put_line( substr( SQL_Dyn ,  201, 200 ));
			dbms_output.put_line( substr( SQL_Dyn ,  401, 200 ));	dbms_output.put_line( substr( SQL_Dyn ,  601, 200 ));
			dbms_output.put_line( substr( SQL_Dyn ,  801, 200 ));	dbms_output.put_line( substr( SQL_Dyn , 1001, 200 ));
			dbms_output.put_line( substr( SQL_Dyn , 1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn , 1401, 200 ));
			dbms_output.put_line( substr( SQL_Dyn , 1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn , 1801, 200 ));
			dbms_output.put_line( substr( SQL_Dyn , 2001, 200 ));	END IF;

		IF wDEBUG = 1 OR wDEBUG = 9 THEN
			dbms_output.put_line( '---------------- SQL_Dyn2 -------------------------------' );
			dbms_output.put_line( substr( SQL_Dyn2 ,    1, 200 ));	dbms_output.put_line( substr( SQL_Dyn2 ,  201, 200 ));
			dbms_output.put_line( substr( SQL_Dyn2 ,  401, 200 ));	dbms_output.put_line( substr( SQL_Dyn2 ,  601, 200 ));
			dbms_output.put_line( substr( SQL_Dyn2 ,  801, 200 ));	dbms_output.put_line( substr( SQL_Dyn2 , 1001, 200 ));
			dbms_output.put_line( substr( SQL_Dyn2 , 1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn2 , 1401, 200 ));
			dbms_output.put_line( substr( SQL_Dyn2 , 1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn2 , 1801, 200 ));
			dbms_output.put_line( substr( SQL_Dyn2 , 2001, 200 ));	END IF;

		-- Ouverture du curseur de donnees
		Open Src FOR SQL_Dyn;
			WHILE i <= TOP
			LOOP
				-- Recherche la consommation totale
				Open Src2 For SQL_Dyn2;	FETCH Src2 INTO wTOTALCONSO;	Close Src2;

				-- Balayage du TOP
				FETCH Src INTO whash_value, wCONSO;	EXIT WHEN Src%NOTFOUND;

				-- Conversion en secondes des metriques en 10E-6 secondes
				IF PARAMTOP(iPARAM).PARAM IN ( 'ELAPSED_TIME', 'CPU_TIME', 'APPLICATION_WAIT_TIME',
					'CONCURRENCY_WAIT_TIME', 'PLSQL_EXEC_TIME', 'CLUSTER_WAIT_TIME', 'USER_IO_WAIT_TIME' )
				THEN	wTOTALCONSO := wTOTALCONSO/1000000;	wCONSO := wCONSO/1000000;	END IF;

				-- Recherche de HashValue dans la structure Element_HASH
				iHASH := 1;
				WHILE iHASH < iHASHMAX
				LOOP	IF HASH(iHASH).hash_value = whash_value THEN EXIT; END IF;	iHASH := iHASH + 1;	END LOOP;
				wIMPACT := (100*wCONSO/wTOTALCONSO);
				IF iHASH < iHASHMAX	THEN
					-- HASH VALUE DEJA REPERTORIEE
					IF PCT_MIN <= wIMPACT THEN	HASH(iHASH).NB      := HASH(iHASH).NB + 1;
						HASH(iHASH).COMMENT := HASH(iHASH).COMMENT || ', ' || PARAMTOP(iPARAM).PARAM || '(' || i || ')';
					END IF;
				ELSE
					-- HASH VALUE DEJA NON REPERTORIEE
					IF PCT_MIN <= wIMPACT THEN
						-- Les requ?s dont l'impact < seuil - non repertoriees
						HASH(iHASHMAX).NB := 1;
						HASH(iHASHMAX).COMMENT := PARAMTOP(iPARAM).PARAM || '(' || i || ')';
						HASH(iHASHMAX).hash_value := whash_value;
						iHASHMAX := iHASHMAX + 1;
					END IF;
				END IF;

				-- Affichage
				IF i = 1 	THEN	wRUB := PARAMTOP(iPARAM).PARAM;		ELSE	wRUB := ' ';	END IF;

				wChaine := CharSep || RPAD( wRUB , '20' ) ;
				wChaine := wChaine || CharSep || to_char( i, '99' )  || CharSep || ' ' ;
				-----------------------------------------------------------------------------------------
				IF HASHVALUE IS Null THEN	wChaine := wChaine || RPAD( whash_value , 15 )  || CharSep ;
				ELSE	wChaine := wChaine || RPAD( HASHVALUE   , 15 )  || CharSep ; 	END IF;
				-----------------------------------------------------------------------------------------
				wChaine := wChaine || To_char( wCONSO, '99999999999.9' ) || CharSep ;
				wChaine := wChaine || to_char( wIMPACT, '999.99' ) || CharSep;
				wChaine := wChaine || to_char(iHASH, '999' ) || ' ' || CharSep  ;
				-----------------------------------------------------------------------------------------
				IF PCT_MIN <= (100*wCONSO/wTOTALCONSO)  THEN
					IF i = 1 AND LSTMODE != 'EXTRACT' AND LSTMODE NOT LIKE 'TQ%' THEN
						dbms_output.put_line( '+- - - - - - - - - - +- -+ - - - - - - - -+ - - - - - - -+ - - - + - - +' );
					END IF;

					-- Enregistrement CONSO
					Conso(iConso).Axe	:= iPARAM ;	Conso(iConso).Rng	:= i;

					IF HASHVALUE IS Null	THEN	Conso(iConso).Hash_Value:= whash_value ;
					ELSE	Conso(iConso).Hash_Value:= HASHVALUE;		END IF;

					Conso(iConso).Consommation	:= wCONSO ;	Conso(iConso).impact		:= wIMPACT;
					Conso(iConso).Num_SQL		:= iHASH;	Conso(iConso).TOTAL		:= wTOTALCONSO;
					iConso := iConso + 1;

					IF LSTMODE = 'TQ-TU11' THEN Null; ELSIF LSTMODE != 'EXTRACT' THEN dbms_output.put_line( wChaine );
					ELSE	wChaine := 'TU10' || wEXTRACT || ';' || PARAMTOP(iPARAM).PARAM || ';' || i || ';' ;
						IF HASHVALUE IS Null	THEN	wChaine := wChaine || RPAD( whash_value , 15 )  || ';' ;
						ELSE	wChaine := wChaine || RPAD( HASHVALUE   , 15 )  || ';' ;	END IF;
						wChaine := wChaine || round( wCONSO, 1 )  || ';';
						wChaine := wChaine || to_char( wIMPACT, '999.99' ) || ';';
						dbms_output.put_line( wChaine );	END IF;
				END IF;
				i := i + 1;
			END LOOP;	Close Src;

		-- Incrementation
		iPARAM := iPARAM + 1;
	END LOOP;

	IF LSTMODE != 'EXTRACT' AND LSTMODE != 'TQ-TU11' THEN
	dbms_output.put_line( '+--------------------+---+----------------+--------------+-------+-----+' );
	dbms_output.put_line( 'Tableau des apparitions des requ?s ' );
	dbms_output.put_line( '---------------------------------------------------------------------------------------------------------' );
	dbms_output.put_line( 'Nbre;Impact Moyen;HASH_VALUE;Commentaires' );	END IF;

	MAX_iConso := iConso;	i := Max_PARAM;	My_HASH_Number := 1;
	WHILE i >= 1
	LOOP	iHASH := 1;
		WHILE iHASH < iHASHMAX
		LOOP	IF HASHVALUE IS NOT Null	THEN	HASH(iHASH).hash_value := HASHVALUE;	END IF;
			IF HASH(iHASH).NB = i THEN	wNBImpact    := 0;	iConso 	     := 1;	wIMPACT_Tot  := 0;
				WHILE iConso < MAX_iConso
				LOOP	IF Conso(iConso).Hash_Value = HASH(iHASH).hash_value THEN
						wNBImpact   := wNBImpact + 1;  wIMPACT_Tot := wIMPACT_Tot + Conso(iConso).impact;
					END IF;	iConso := iConso + 1;	END LOOP;

				SELECT PERFSTAT.PKG_STATS.XLS_VAL( round( (wIMPACT_Tot/wNBImpact), 1) ) INTO wChaine2 FROM DUAL;
				IF LSTMODE != 'EXTRACT' AND LSTMODE != 'TQ-TU11' THEN
					dbms_output.put_line( to_char(i, '99' ) || CharSep || wChaine2 	|| CharSep ||
					rpad( HASH(iHASH).hash_value, 12 ) || CharSep || HASH(iHASH).COMMENT );	END IF;
				My_HASH(My_HASH_Number).Hash_Value := HASH(iHASH).hash_value;
				My_HASH_Number := My_HASH_Number + 1;	END IF;	iHASH := iHASH + 1;
		END LOOP;	i := i - 1;
	END LOOP;
	IF LSTMODE != 'EXTRACT' AND LSTMODE != 'TQ-TU11'  THEN
	dbms_output.put_line( '=========================================================================================================' );
	END IF;

	My_HASH_MAX := My_HASH_Number;	i := 1;
	while i < My_HASH_MAX
	LOOP	IF LSTMODE !='EXTRACT' AND LSTMODE not like 'TQ%' THEN
		  dbms_output.put_line( '+----------------------------------------------------------+' );
		  dbms_output.put_line( '| ' || RPAD( 'SQL Identifie N°' || i || ' HASH_VALUE : ' || My_HASH(i).Hash_Value, 57 ) || '|' );
		  dbms_output.put_line( '+----------------------------------------------------------+' );	END IF;

		IF ExplainP = 'Y' THEN
			IF wLEVEL > 5 THEN 	IF LSTMODE !='EXTRACT' AND LSTMODE not like 'TQ%' THEN
				dbms_output.put_line( '* Le Niveau Max de STATSPACK est : ' ||  to_char(wLEVEL, '9' ) || ' (Suivi PLAN ACTIF)'  );
				END IF;		SPLAN     := 'Y';	wExplainP := 'N';
			ELSE 	IF LSTMODE !='EXTRACT' AND LSTMODE not like 'TQ%' THEN	dbms_output.put_line(
					'* Le Niveau Max de STATSPACK est : ' ||  to_char(wLEVEL, '9' ) || ' - Plan(s) en memoire UNIQUEMENT'  );
				END IF;
				SPLAN     := 'N';	wExplainP := 'Y';	END IF;
			IF LSTMODE !='EXTRACT' AND LSTMODE not like 'TQ%' THEN		dbms_output.put_line(
				'-------------------------------------------------------------------------------------------------' );
			END IF;
		ELSE	SPLAN 	  := 'N';	wExplainP := 'N';	END IF;

		IF ShowSQL 	= 'Y' THEN
				IF LSTMODE ='EXTRACT' 		THEN	PKG_STATS.ShowSql   ( My_HASH(i).Hash_Value, 'TU4' || wEXTRACT );
				ELSIF LSTMODE != 'TQ-TU11' 	THEN	PKG_STATS.ShowSql   ( My_HASH(i).Hash_Value, Null );
				END IF;	END IF;

		IF (wExplainP	= 'Y') AND ( Oversion > 8)	THEN
			IF 	LSTMODE = 'TQ-TU11' 		THEN	Null;
			ELSIF 	LSTMODE NoT LiKe 'EXTRACT%'	THEN	PKG_STATS.SQL_PLAN  ( My_HASH(i).Hash_Value, Null );
								ELSE	PKG_STATS.SQL_PLAN  ( My_HASH(i).Hash_Value, 'TU6' || wEXTRACT );
			END IF;		END IF;

		IF SPLAN	= 'Y'	AND LSTMODE != 'TQ-TU11'
		THEN	PKG_STATS.info_plan  ( wDATEDEB, DATEFIN, LSTMODE, INSTANCE, My_HASH(i).Hash_Value );	END IF;
		IF LSTMODE !='EXTRACT' AND LSTMODE != 'TQ-TU11'
		THEN	IF PLANSTAT	= 'Y'	THEN
				PKG_STATS.PLANSTAT_proc ( wDATEDEB, DATEFIN, My_HASH(i).Hash_Value, 'PLAN', 'ERR', FIXED_SCHEMA );	END IF;
		END IF;		i := i + 1;
	END LOOP;

	wChaine1 := 'xxxxx';
	IF DETAILS = 'Y' THEN
		IF LSTMODE != 'EXTRACT' AND LSTMODE not like 'TQ%' THEN
		dbms_output.put_line( '=========================================================================================================' );
		dbms_output.put_line( 'Axe_Analyse;Snap_time;Debit(s/s);Hash_value' );
		END IF;

		iPARAM	:= 1;
		While iPARAM <= Max_PARAM
		LOOP	MAX_iConso := iConso;	SQL_DECODE := '';	iConso := 1;
			WHILE iConso < MAX_iConso
			LOOP	IF iPARAM = Conso(iConso).Axe THEN   SQL_DECODE := SQL_DECODE || Conso(iConso).Hash_Value  || ', ''' ||
					Conso(iConso).Hash_Value  || ''',' ;	END IF;		iConso := iConso + 1;	END LOOP;

			IF SQL_DECODE IS NOT NULL THEN
				SQL_Dyn3 :=  ' select	to_char( STIME, ''YYYYMMDD HH24:MI'' ), sum(' || PARAMTOP(iPARAM).PARAM ||
					'_inc/DUREE),  hash_value ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' from ( select ss.snap_time STIME,  DECODE( hash_value, ';
				SQL_Dyn3 :=  SQL_Dyn3 || SQL_DECODE;
				SQL_Dyn3 :=  SQL_Dyn3 || ' ''All Other HASH'' ) Hash_value,  sq.module, ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' decode(greatest(sq.' || PARAMTOP(iPARAM).PARAM || ', lag(sq.' ||
					PARAMTOP(iPARAM).PARAM || ', 1, sq.' || PARAMTOP(iPARAM).PARAM || ') ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' over(partition by sq.hash_value order by sq.snap_id)),  ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' sq.' || PARAMTOP(iPARAM).PARAM || ', sq.' || PARAMTOP(iPARAM).PARAM || ' - lag(sq.' ||
						PARAMTOP(iPARAM).PARAM || ', 1, sq.' || PARAMTOP(iPARAM).PARAM || ')  ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' over(partition by sq.hash_value order by sq.snap_id),  sq.' || PARAMTOP(iPARAM).PARAM ||
						') ' || PARAMTOP(iPARAM).PARAM || '_inc,  ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' over(partition by sq.Hash_value order by sq.snap_id)), ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME)  ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' over(partition by sq.Hash_value order by sq.snap_id),  ss.SNAP_TIME)*86400 DUREE ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' from	stats$sql_summary sq, stats$snapshot ss  ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' where ss.snap_time between to_date(''' || wDATEDEB || ''', ''YYYYMMDD HH24:MI'' )-(1/24)   ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' )  ';

				IF INSTANCE IS NOT NULL THEN 	SQL_Dyn3 :=  SQL_Dyn3 || ' and 	( ss.instance_number = ' || INSTANCE || ' )  ';
				END IF;
				IF MODULE IS NOT NULL	THEN 	SQL_Dyn3 :=  SQL_Dyn3 || ' and 	sq.module = ''' || MODULE || '''';	END IF;
				SQL_Dyn3 :=  SQL_Dyn3 || ' and  sq.dbid = ss.dbid   ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' and	sq.instance_number = ss.instance_number ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' and	sq.snap_id = ss.snap_id ';
				SQL_Dyn3 :=  SQL_Dyn3 || '  ) ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' where	DUREE != 0 ';

				IF ZOOM Is NOT Null THEN	SQL_Dyn3 :=  SQL_Dyn3 || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
					SQL_Dyn3 :=  SQL_Dyn3 || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';		END IF;
				SQL_Dyn3 :=  SQL_Dyn3 || ' group by to_char( STIME, ''YYYYMMDD HH24:MI'' ), hash_value ';
				SQL_Dyn3 :=  SQL_Dyn3 || ' order by 1 ';
				IF wDEBUG = 2 OR wDEBUG = 9 THEN
					dbms_output.put_line( substr( SQL_Dyn3,    1, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,  201, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3,  401, 200 ));	dbms_output.put_line( substr( SQL_Dyn3,  601, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3,  801, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 1001, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 1201, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 1401, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 1601, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 1801, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 2001, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 2201, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 2401, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 2601, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 2801, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 3001, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 3201, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 3401, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 3601, 200 ));	dbms_output.put_line( substr( SQL_Dyn3, 3801, 200 ));
					dbms_output.put_line( substr( SQL_Dyn3, 4001, 200 ));	END IF;

				OPEN Src3 FOR SQL_Dyn3;
				LOOP
					FETCH Src3 INTO wStime, wDebit, whash_value_txt;	EXIT WHEN Src3%NOTFOUND;
					IF LSTMODE = 'TQ-TU11'	THEN
						IF to_date( wStime, 'YYYYMMDD HH24:MI' ) >= to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) THEN
							select INSTANCE_NAME , HOST_NAME INTO wINSTANCE_NAME , wHOST_NAME from v$instance;
							wChaine := '"' || to_char( to_date( wStime, 'YYYYMMDD HH24:MI' ), 'MM/DD/YYYY HH24:MI' ) || '"';
							wChaine := wChaine || ' PAS "newtermite" "' || wHOST_NAME || '" "' || wINSTANCE_NAME || '"';
							IF wChaine1 != wchaine THEN	dbms_output.put_line( wChaine || chr( 10 ) );
								wchaine1 := wchaine;	end if;
							wChaine := '"' || PARAMTOP(iPARAM).PARAM || '" ';
							wChaine := wChaine || '"' || whash_value_txt || '" ';
							SELECT PERFSTAT.PKG_STATS.XLS_VAL( round( wDebit, 3) ) INTO wChaine2 FROM DUAL;
							wChaine := wChaine || wChaine2  || chr( 10 );
						END IF;
					ELSIF LSTMODE IN ( 'NORM', 'CSV' ) THEN
						wChaine := PARAMTOP(iPARAM).PARAM || CharSep || wStime 	|| CharSep  ;
						SELECT PERFSTAT.PKG_STATS.XLS_VAL( round( wDebit, 3) ) INTO wChaine2 FROM DUAL;
						wChaine := wChaine || wChaine2;
						wChaine := wChaine || CharSep || whash_value_txt;
					ELSIF LSTMODE = 'EXTRACT' THEN
						wChaine := 'TU11' || wEXTRACT || ';' || PARAMTOP(iPARAM).PARAM || ';' || wStime || ';' ;
						SELECT PERFSTAT.PKG_STATS.XLS_VAL( round( wDebit, 3) ) INTO wChaine2 FROM DUAL;
						wChaine := wChaine || wChaine2;
						wChaine := wChaine || ';' || whash_value_txt;
					END IF;

					IF wDebit > 0 THEN
						IF to_date( wStime, 'YYYYMMDD HH24:MI' ) >= to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) THEN
							dbms_output.put_line( wChaine );	END IF;		END IF;
				END LOOP;	Close Src3;
			END IF;			iPARAM	:= iPARAM + 1;
		END LOOP;
	END IF;

	IF LSTMODE != 'EXTRACT' AND LSTMODE not like 'TQ%' THEN
	dbms_output.put_line( '---------------------------------------------------------------------------------------------------------' );
	IF MODULE Is NOT Null THEN 	wMODULE := '''' || MODULE || '''';	ELSE	wMODULE := 'Null';	END IF;
	If HASHVALUE Is Null THEN	wHASHVALUE := 'Null' ;	ELSE	wHASHVALUE := To_char(HASHVALUE);	END IF;
	IF INSTANCE Is NULL THEN	wINSTANCE := 'Null';	ELSE	wINSTANCE := TO_CHAR( INSTANCE );	END IF;
	dbms_output.put_line( 'Rappel de la commande :' );
	dbms_output.put_line( 'exec perfstat.PKG_STATS.MTOPSQL ( ''' ||	DATEDEB	 || ''', ''' ||
		DATEFIN 	|| ''', ''' 	|| 	LSTMODE		|| ''', ' 	|| 	TOP		|| ', ' 	||
		PCT_MIN		|| ', ''' 	|| 	ShowSQL		|| ''', ''' 	|| 	ExplainP	|| ''', ' 	||
		wINSTANCE	|| ', ' 	||  wMODULE || ', ' 	||
	 	wHASHVALUE  	|| ', ''' ||	SCOPE || ''', ''' || PLANSTAT || ''', ''' || DETAILS || ''' )'  );
	dbms_output.put_line( '+-------------------------------------------------------------------------------------------------------+' );
	dbms_output.put_line( '|  SCOPE=>''ALL''     Permet d''afficher tous les axes d''analyse');
	dbms_output.put_line( '|                     (dependants de la version oracle)');
	dbms_output.put_line( '|  SCOPE=>''ARO''     Permet d''afficher une selection d''axes :');
	dbms_output.put_line( '|                     Les axes PARSE_CALLS, LOADS, ROWS_PROCESSED et FETCHES sont filtres' );
	dbms_output.put_line( '|  SCOPE=>''IO''      Permet de ne selectionner que les axes relatifs aux I/O' );
	dbms_output.put_line( '|                     Les axes ROWS_PROCESSED, EXECUTIONS, JAVA_EXEC_TIME, APPLICATION_WAIT_TIME sont filtres' );
	dbms_output.put_line( '|                     Les axes CONCURRENCY_WAIT_TIME, CLUSTER_WAIT_TIME, PLSQL_EXEC_TIME sont filtres' );
	dbms_output.put_line( '+--------------------------------------------------------------------------------------------------------' );
	dbms_output.put_line( 'Pour obtenir le detail dans le temps' );
	dbms_output.put_line( 'exec perfstat.PKG_STATS.suivisql ( ''' ||DATEDEB || ''', ''' || DATEFIN ||
			''', ''' || LSTMODE || ''', ' || HASHVALUE || ', ''DISK_READS''' || ' ) ');
	END IF;

	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
procedure MTOPSQL		( DATEDEB  varchar  DEFAULT Null, DATEFIN  varchar  DEFAULT Null, LSTMODE  varchar  DEFAULT 'CSV',
				TOP  NUMBER   DEFAULT 5, PCT_MIN  IN NUMBER DEFAULT 5, ShowSQL  Varchar  Default 'N', ExplainP Varchar  Default 'N',
				INSTANCE Number  DEFAULT Null, MODULE  IN VARCHAR DEFAULT Null, HASHVALUE IN NUMBER DEFAULT Null,
				SCOPE  IN VARCHAR DEFAULT 'ALL', PLANSTAT IN VARCHAR DEFAULT 'N', DETAILS  IN VARCHAR DEFAULT 'Y' ,
				ZOOM  IN VARCHAR DEFAULT Null, FIXED_SCHEMA IN VARCHAR DEFAULT Null )
IS	NB_Ano			Number;			PARAM1		Varchar( 2000 );	PARAM2		Varchar( 2000 );
	PARAM3			Varchar( 2000 );	PARAM4		Varchar( 2000 );	PARAM5		Varchar( 2000 );
	PARAM6			Varchar( 2000 );	PARAM7		Varchar( 2000 );	PARAM8		Varchar( 2000 );
	PARAM9			Varchar( 2000 );	PARAM10		Varchar( 2000 );	PARAM11		Varchar( 2000 );
	PARAM12			Varchar( 2000 );	PARAM13		Varchar( 2000 );	PARAM14		Varchar( 2000 );
	wDATE1			Date;			wDATE		Date;			wCHAINE		Varchar( 50 );
	wFORMAT_DATE_SORTIE	Varchar( 50 );		oVersion	Number;			wHASHVALUE	Varchar( 100 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano  := 0;		PARAM1  := Null;	PARAM2  := Null;	PARAM3  := Null;	PARAM4  := Null;
	PARAM5  := Null;	PARAM6  := Null;	PARAM7  := Null;	PARAM8  := Null;	PARAM9  := Null;
	PARAM10 := Null;	PARAM11 := Null;	PARAM12 := Null;	PARAM13 := Null;	PARAM14 := Null;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract', 'TQ-TU11' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';	END IF;
	-- TOP
	IF TOP<=0 OR TOP>10 THEN	NB_Ano := NB_Ano + 1;	PARAM4 := 'Parametre TOP x ( 0 > x >= 10 )';	END IF;
	-- PCT_MIN
	IF PCT_MIN <=0 OR PCT_MIN>100 THEN	NB_Ano := NB_Ano + 1;	PARAM5 := 'Parametre PCT_MIN x ( 0 > x >= 100 )';	END IF;
	-- ShowSQL
	IF ShowSQL Is NULL OR ShowSQL NOT IN ('Y', 'N', 'y', 'n') THEN	NB_Ano := NB_Ano + 1;
		PARAM6 := 'Parametre ShowSQL Incorrect (''Y'', ''N'')';	END IF;
	-- ExplainP
	IF ExplainP Is NULL OR upper(ExplainP) NOT IN ('Y', 'N', 'M', 'MEM' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM7 := 'Parametre ExplainP Incorrect (''Y'', ''N'')';	END IF;
	-- INSTANCE
	-- SCOPE
	IF upper( SCOPE ) NOT IN ('ALL', 'IO', 'ARO' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM11 := 'Parametre SCOPE Incorrect (''ALL'', ''ARO'', ''IO'' )';	END IF;
	-- PLANSTAT
	IF upper( PLANSTAT ) NOT IN ('Y', 'N' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM12 := 'Parametre PLANSTAT Incorrect (''Y'', ''N'' )';	END IF;
	-- DETAILS
	IF upper( DETAILS ) NOT IN ('Y', 'N' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM13 := 'Parametre DETAILS Incorrect (''Y'', ''N'' )';	END IF;
	-- ZOOM
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN
		dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
		dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE MTOPSQL (MultiTOP SQL) ', 105 ) ||'|' );
		dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
		dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
		dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
		dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 4 |  TOP                | Number  | ' || RPAD( NVL( PARAM4, 'OK ( ' || TOP || ' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 5 |  PCT_MIN            | Number  | ' || RPAD( NVL( PARAM5, 'OK ( ' || PCT_MIN || ' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 6 |  SHOWSQL            | Varchar | ' || RPAD( NVL( PARAM6, 'OK ( ''' || SHOWSQL  || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 7 |  EXPLAINP           | Varchar | ' || RPAD( NVL( PARAM7, 'OK ( ''' || EXPLAINP || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 8 |  INSTANCE           | Number  | ' ||
				RPAD( NVL( PARAM8, 'OK ( ' || NVL( TO_CHAR(INSTANCE), 'Null') || ' )' ), 70 ) || '|' );
		dbms_output.put_line( '| 9 |  MODULE             | Varchar | ' || RPAD( NVL( PARAM9, 'OK ( ''' || MODULE || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '|10 |  HASHVALUE          | Number  | ' || RPAD( NVL( PARAM10, 'OK ( ' || HASHVALUE || ' )' ), 70 ) || '|' );
		dbms_output.put_line( '|11 |  SCOPE              | Varchar | ' || RPAD( NVL( PARAM11, 'OK ( ''' || SCOPE|| ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '|12 |  PLANSTAT           | Varchar | ' || RPAD( NVL( PARAM12, 'OK ( ''' || PLANSTAT|| ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '|13 |  DETAILS            | Varchar | ' || RPAD( NVL( PARAM13, 'OK ( ''' || DETAILS|| ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '|14 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM14, 'OK ( ''' || ZOOM || ''' )' ), 70 ) || '|' );
		dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');

		If HASHVALUE is null THEN 	wHASHVALUE := 'Null';	ELSE 	wHASHVALUE := TO_char( HASHVALUE ) ;	END IF;
		Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.MTopSql( ''' || DATEDEB || ''', ''' || DATEFIN || ''', ''' ||
				LSTMODE || ''', ' || TOP || ', ' || PCT_MIN || ', ''' || SHOWSQL || ''', ''' ||
				EXPLAINP	|| ''', '   || NVL( TO_CHAR(INSTANCE), 'Null' )	||  ', ' || NVL( MODULE, 'Null' )  || ', ' ||
				wHASHVALUE || ', ''' || SCOPE || ''', ''' || PLANSTAT || ''', ''' || DETAILS || ''' )' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SQL_SUMMARY') ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' ,  'STATS$SQL_SUMMARY');
		ELSE	PKG_STATS.mTOPSQL_proc( DATEDEB, DATEFIN, upper(LSTMODE), TOP, PCT_MIN,
				upper(ShowSQL), upper(ExplainP), INSTANCE, MODULE, HASHVALUE, SCOPE, PLANSTAT, DETAILS, ZOOM, FIXED_SCHEMA );
		END IF;		END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure PROFILE_proc		( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV',
				FORMAT_DATE IN VARCHAR DEFAULT 'YYYYMMDD HH24:MI', INSTANCE IN NUMBER DEFAULT Null, TYPEREST IN VARCHAR DEFAULT 'NORME',
				PARAM1 IN VARCHAR DEFAULT Null, PARAM2 IN VARCHAR DEFAULT Null, PARAM3 IN VARCHAR DEFAULT Null,
				PARAM4 IN VARCHAR DEFAULT Null, PARAM5 IN VARCHAR DEFAULT Null, ZOOM IN VARCHAR DEFAULT Null )
IS	TYPE            DataSource IS REF CURSOR;	Src             DataSource ;		i               Number;
        imax            Number;			        wCPU_USED       Varchar( 50 );		wCPU_REC        Varchar( 50 );
        wCPU_PARS       Varchar( 50 );		        wREDO           Varchar( 50 );	        WDATEDEB        Varchar( 50 );
        SQL_DYN         Varchar( 5000 );	        wChaine         Varchar( 5000 );        wChaine2        Varchar( 5000 );
        TYPE Element IS RECORD
        (       STIME        DATE,	DELTA        Number,	WE_OPT       Number,	WE_ONE       Number,
                WE_MTP       Number,	TRANS        Number,	CPU_USED     Number,	CPU_REC      Number,
                CPU_PARS     Number,	PHY_RDS      Number,	LOG_READS    Number,	REDO         Number,
                LOG          Number,	DDL_PARA     Number,	DML_PARA     Number,	Q_PARA       Number,
                PD_1_25      Number,	PD_25_50     Number,	PD_50_75     Number,	PD_75_99     Number,
                PD_SERIAL    Number,	P_NOT_D      Number        );
        Type    Matrice IS TABLE OF Element index by binary_integer;
        RESULTAT        Matrice;
        TYPE Element2 IS RECORD
        (       STIME        DATE,	DELTA        Number,	TABLE1       Number,	TABLE2       Number,
                TABLE3       Number,	TABLE4       Number,	TABLE5       Number,	TABLE6       Number,
                TABLE7       Number,	TABLE8       Number,	TABLE9       Number,	INDEX1       Number,
                INDEX2       Number,	INDEX3       Number,	INDEX4       Number        );
        Type    Matrice2 IS TABLE OF Element2 index by binary_integer;
        RESULTAT2       Matrice2;
        TYPE Element3 IS RECORD
        (       STIME        DATE,	DELTA        Number,	SQLNET1      Number,	SQLNET2      Number,
                B_REC_1      Number,	B_REC_2      Number,	B_Sent_1     Number,	B_Sent_2     Number        );
        Type    Matrice3 IS TABLE OF Element3 index by binary_integer;
        RESULTAT3       Matrice3;		        PHY_tran        Varchar( 50 );		LOG_tran        Varchar( 50 );
        wSnap_time      date;			        wVALUE          Varchar( 50 );		VALUE           Number;
	wSTIME		Varchar( 50 );			wPARAM_1	Number;			wPARAM_2	Number;
	wPARAM_3	Number;				wPARAM_4	Number;			wPARAM_5	Number;
	TXT		Varchar( 1000 );		ELight		Number;			wDateLimit	Date;
	HMIN		Varchar( 25 );			HMAX		Varchar( 25 );
BEGIN	dbms_output.enable( 1000000000 );
        i := 1 ;  select perfstat.PKG_STATS.CheckVal('PROFILE', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; 	END IF;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
        select  to_char( max( snap_time) , 'YYYYMMDD HH24:MI' ) INTO    WDATEDEB from    stats$snapshot
        where   snap_time < to_date( DATEDEB, 'YYYYMMDD HH24:MI' )
        and     ( ( instance_number = INSTANCE ) OR ( INSTANCE Is Null ));
        SQL_DYN := ' SELECT stime, MIN(DELTA) DELTA, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''workarea executions - optimal'',   VALUE_inc, 0 ) ) WE_OPT, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''workarea executions - onepass'',   VALUE_inc, 0 ) ) WE_ONE, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''workarea executions - multipass'', VALUE_inc, 0 ) ) WE_MTP, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''user commits'', VALUE_inc, ''user rollbacks'', VALUE_inc, 0 ) ) trans, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''physical reads'', VALUE_inc, 0 ) ) PHY_RDS, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''db block gets'', VALUE_inc, ''consistent gets'', VALUE_inc, 0 ) ) LOG_READS, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''redo size'', VALUE_inc, 0 ) )/1024/1024 REDO, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''DDL statements parallelized'', VALUE_inc, 0 ) )  DDL_PARA, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''DML statements parallelized'', VALUE_inc, 0 ) )  DML_PARA, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''queries parallelized'', VALUE_inc, 0 ) )  Q_PARA, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''Parallel operations downgraded 1 to 25 pct'', VALUE_inc, 0 ) ) PD_1_25, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''Parallel operations downgraded 25 to 50 pct'',VALUE_inc, 0 ) ) PD_25_50, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''Parallel operations downgraded 50 to 75 pct'',VALUE_inc, 0 ) ) PD_50_75, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''Parallel operations downgraded 75 to 99 pct'',VALUE_inc, 0 ) ) PD_75_99, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''Parallel operations downgraded to serial'', VALUE_inc, 0 ) ) PD_serial, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''Parallel operations not downgraded'', VALUE_inc, 0 ) )  P_not_D ';
        SQL_DYN := SQL_DYN || ' FROM ( select   ss.snap_time stime,  sq.name, ';
        SQL_DYN := SQL_DYN || ' decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name  order by sq.snap_id)),  ';
        SQL_DYN := SQL_DYN || ' sq.VALUE, sq.VALUE - lag(sq.VALUE, 1, sq.VALUE) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name order by sq.snap_id),  sq.VALUE) VALUE_inc, ';
        SQL_DYN := SQL_DYN || ' decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name order by sq.snap_id)), ';
        SQL_DYN := SQL_DYN || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name order by sq.snap_id),  ss.SNAP_TIME)*86400 DELTA ';
        SQL_DYN := SQL_DYN || ' from PERFSTAT.stats$sysstat sq,  stats$snapshot ss ';
        SQL_DYN := SQL_DYN || ' where ss.snap_time between to_date( ''' || WDATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
        SQL_DYN := SQL_DYN || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
        SQL_DYN := SQL_DYN || ' and ( ( ss.instance_number = ' || INSTANCE || ') OR (' || INSTANCE || ' Is Null )) ';
        SQL_DYN := SQL_DYN || ' and sq.dbid = ss.dbid ';
        SQL_DYN := SQL_DYN || ' and sq.instance_number = ss.instance_number ';
        SQL_DYN := SQL_DYN || ' and sq.snap_id = ss.snap_id ';
        SQL_DYN := SQL_DYN || ' and name IN  ';
        SQL_DYN := SQL_DYN || ' ( ''workarea executions - optimal'', ''workarea executions - onepass'', ''workarea executions - multipass'', ';
        SQL_DYN := SQL_DYN || ' ''user commits'', ''user rollbacks'',  ';
        SQL_DYN := SQL_DYN || ' ''CPU used by this session'', ''recursive cpu usage'', ''parse time cpu'', ';
        SQL_DYN := SQL_DYN || ' ''physical reads'', ''db block gets'', ''consistent gets'', ';
        SQL_DYN := SQL_DYN || ' ''redo size'', ''logons current'', ';
        SQL_DYN := SQL_DYN || ' ''DDL statements parallelized'', ''DML statements parallelized'', ''queries parallelized'', ';
        SQL_DYN := SQL_DYN || ' ''Parallel operations downgraded 1 to 25 pct'',  ''Parallel operations downgraded 25 to 50 pct'', ';
        SQL_DYN := SQL_DYN || ' ''Parallel operations downgraded 50 to 75 pct'', ''Parallel operations downgraded 75 to 99 pct'', ';
        SQL_DYN := SQL_DYN || ' ''Parallel operations downgraded to serial'', ''Parallel operations not downgraded'' ) ';
        SQL_DYN := SQL_DYN || ' ) ';
        SQL_DYN := SQL_DYN || ' where   DELTA>0 ';

	IF ZOOM Is NOT Null THEN SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';  END IF;
        SQL_DYN := SQL_DYN || ' group by stime ';        SQL_DYN := SQL_DYN || ' order by 1 ';
        Open Src FOR SQL_DYN;
        LOOP	FETCH Src INTO
                        RESULTAT(i).STIME,      RESULTAT(i).DELTA,      RESULTAT(i).WE_OPT,     RESULTAT(i).WE_ONE,     RESULTAT(i).WE_MTP,
                        RESULTAT(i).TRANS,      RESULTAT(i).PHY_RDS,
                        RESULTAT(i).LOG_READS,  RESULTAT(i).REDO,       RESULTAT(i).DDL_PARA,   RESULTAT(i).DML_PARA,
                        RESULTAT(i).Q_PARA,     RESULTAT(i).PD_1_25,    RESULTAT(i).PD_25_50,   RESULTAT(i).PD_50_75,   RESULTAT(i).PD_75_99,
                        RESULTAT(i).PD_SERIAL,  RESULTAT(i).P_NOT_D;	EXIT WHEN Src%NOTFOUND;	i := i + 1;
        END LOOP;	Close Src;
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( '|                    Affichage General                         |' );
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( 'Snap_Time;workarea exec. optimal;workarea exec. onepass;workarea exec. multipass;' ||
        'Transactions;Physical_Reads;Logical_reads;Redo(Mo);physical/trans;Logical/trans' );
        imax := i;        i := 1;
        While i < imax
        LOOP	PHY_tran        := round( RESULTAT(i).PHY_RDS/RESULTAT(i).TRANS, 1 );
                LOG_tran        := round( RESULTAT(i).LOG_READS/RESULTAT(i).TRANS, 1 );
                wREDO           := round( RESULTAT(i).REDO, 2 );
                SELECT PKG_STATS.XLS_VAL( wREDO    ) INTO wREDO    FROM DUAL;
                SELECT PKG_STATS.XLS_VAL( PHY_tran ) INTO PHY_tran FROM DUAL;
                SELECT PKG_STATS.XLS_VAL( LOG_tran ) INTO LOG_tran FROM DUAL;
                dbms_output.put_line(	to_char( RESULTAT(i).STIME, 'YYYYMMDD HH24:MI' )                || ';' ||
                        RESULTAT(i).WE_OPT   || ';' || RESULTAT(i).WE_ONE   || ';' ||
                        RESULTAT(i).WE_MTP   || ';' || RESULTAT(i).TRANS    || ';' ||
                        RESULTAT(i).PHY_RDS  || ';' || RESULTAT(i).LOG_READS || ';' || wREDO || ';' || PHY_tran || ';' || LOG_tran );
                i := i + 1;
        END LOOP;
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( '|              Affichage PARALLELISME                          |' );
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( 'Snap_time;DDL_Para;DML_para;Query_Para;POD 1 to 25;POD 25 to 50;' ||
        'POD 50 to 75;POD 75 to 100;POD serialized;PO not downgraded ');
        i := 1;
        While i < imax
        LOOP	dbms_output.put_line(	to_char( RESULTAT(i).STIME, 'YYYYMMDD HH24:MI' )                || ';' ||
                        RESULTAT(i).DDL_PARA            || ';' ||	RESULTAT(i).DML_PARA            || ';' ||
                        RESULTAT(i).Q_PARA              || ';' ||	RESULTAT(i).PD_1_25             || ';' ||
                        RESULTAT(i).PD_25_50            || ';' ||	RESULTAT(i).PD_50_75            || ';' ||
                        RESULTAT(i).PD_75_99            || ';' ||	RESULTAT(i).PD_SERIAL           || ';' ||
                        RESULTAT(i).P_NOT_D                );	i := i + 1;
        END LOOP;
        OPEN Src FOR	select  snap_time, VALUE from PERFSTAT.stats$sysstat ss, stats$snapshot sn where   sn.snap_id = ss.snap_id
        and     name = 'logons current'
        and     sn.snap_time between to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) and         to_date( DATEFIN , 'YYYYMMDD HH24:MI' )
        and ( ( sn.instance_number = INSTANCE ) OR ( INSTANCE  Is Null ))
	and ( (HMIN Is NULL) OR (to_char( sn.snap_time, 'HH24:MI' ) >=  HMIN ) )
	and ( (HMIN Is NULL) OR (to_char( sn.snap_time, 'HH24:MI' ) <=  HMAX ) ) order by snap_time;
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( '|              Affichage CONNEXIONS                            |' );
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( 'Snap_Time;connexions' );
        LOOP	FETCH Src INTO wsnap_time, wVALUE;	EXIT WHEN Src%NOTFOUND;
                dbms_output.put_line( to_char( wsnap_time, 'YYYYMMDD HH24:MI' )  || ';' || wVALUE );
        END LOOP;        close Src;
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( '|              Affichage TABLE                                 |' );
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( 'Snap_Time;' ||
                'T. fetch by rowid;T. fetch continued row;T. scan blocks gotten;T. scan rows gotten;' ||
                'T. scans (cache partitions);T. scans (direct read);T. scans (long T.);T. scans (rowid ranges);' || 'T. scans (short T.)' );
        i := 1 ;	        SQL_Dyn := 'SELECT stime, AVG(DELTA) DELTA, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table fetch by rowid'',    VALUE_inc, 0 ) )  TABLE1, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table fetch continued row'', VALUE_inc, 0 ) ) TABLE2, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table scan blocks gotten'',        VALUE_inc, 0 ) )  TABLE3, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table scan rows gotten'',  VALUE_inc, 0 ) ) TABLE4, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table scans (cache partitions)'',  VALUE_inc, 0 ) ) TABLE5, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table scans (direct read)'',       VALUE_inc, 0 ) ) TABLE6, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table scans (long tables)'',       VALUE_inc, 0 ) ) TABLE7, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table scans (rowid ranges)'',      VALUE_inc, 0 ) ) TABLE8, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''table scans (short tables)'',      VALUE_inc, 0 ) ) TABLE9,  ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''index fast full scans (direct read)'',     VALUE_inc, 0 ) )  INDEX1, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''index fast full scans (full)'',    VALUE_inc, 0 ) )        INDEX2, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''index fast full scans (rowid ranges)'',    VALUE_inc, 0 ) )  INDEX3, ';
        SQL_Dyn := SQL_Dyn || ' SUM( DECODE( name, ''index fetch by key'',      VALUE_inc, 0 ) ) INDEX4 ';
        SQL_Dyn := SQL_Dyn || ' FROM ';        SQL_Dyn := SQL_Dyn || ' ( ';
        SQL_Dyn := SQL_Dyn || ' select  ss.snap_time stime,  sq.name,   ';
        SQL_Dyn := SQL_Dyn || ' decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE)';
        SQL_Dyn := SQL_Dyn || ' over(partition by sq.name  order by sq.snap_id)), ';
        SQL_Dyn := SQL_Dyn || ' sq.VALUE, sq.VALUE - lag(sq.VALUE, 1, sq.VALUE) ';
        SQL_Dyn := SQL_Dyn || ' over(partition by sq.name order by sq.snap_id),  sq.VALUE) VALUE_inc, ';
        SQL_Dyn := SQL_Dyn || ' decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
        SQL_Dyn := SQL_Dyn || ' over(partition by sq.name order by sq.snap_id)), ';
        SQL_Dyn := SQL_Dyn || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
        SQL_Dyn := SQL_Dyn || ' over(partition by sq.name order by sq.snap_id),  ss.SNAP_TIME)*86400 DELTA ';
        SQL_Dyn := SQL_Dyn || ' from PERFSTAT.stats$sysstat sq,  stats$snapshot ss ';
        SQL_DYN := SQL_DYN || ' where ss.snap_time between to_date( ''' || WDATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
        SQL_DYN := SQL_DYN || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
        SQL_DYN := SQL_DYN || ' and ( ( ss.instance_number = ' || INSTANCE || ') OR (' || INSTANCE || ' Is Null )) ';
        SQL_Dyn := SQL_Dyn || ' and     sq.dbid = ss.dbid ';
        SQL_Dyn := SQL_Dyn || ' and     sq.instance_number = ss.instance_number ';
        SQL_Dyn := SQL_Dyn || ' and     sq.snap_id = ss.snap_id ';
        SQL_Dyn := SQL_Dyn || ' and     name IN ';
        SQL_Dyn := SQL_Dyn || ' ( ''table fetch by rowid'', ''table fetch continued row'', ''table scan blocks gotten'', ''table scan rows gotten'',  ';
        SQL_Dyn := SQL_Dyn || ' ''table scans (cache partitions)'', ''table scans (direct read)'',  ';
        SQL_Dyn := SQL_Dyn || ' ''table scans (long tables)'', ''table scans (rowid ranges)'',  ';
        SQL_Dyn := SQL_Dyn || ' ''table scans (short tables)'', ''index fast full scans (direct read)'', ';
        SQL_Dyn := SQL_Dyn || ' ''index fast full scans (full)'',''index fast full scans (rowid ranges)'', ';
        SQL_Dyn := SQL_Dyn || ' ''index fetch by key'' ) ';
        SQL_Dyn := SQL_Dyn || ' ) ';
        SQL_Dyn := SQL_Dyn || ' where   DELTA>0 ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
        SQL_Dyn := SQL_Dyn || ' group by stime ';
        SQL_Dyn := SQL_Dyn || ' order by 1  ';
        Open Src FOR SQL_Dyn;
        LOOP	FETCH Src INTO
                        RESULTAT2(i).STIME,  RESULTAT2(i).DELTA, RESULTAT2(i).TABLE1, RESULTAT2(i).TABLE2, RESULTAT2(i).TABLE3,
                        RESULTAT2(i).TABLE4, RESULTAT2(i).TABLE5, RESULTAT2(i).TABLE6, RESULTAT2(i).TABLE7, RESULTAT2(i).TABLE8,
                        RESULTAT2(i).TABLE9, RESULTAT2(i).INDEX1, RESULTAT2(i).INDEX2, RESULTAT2(i).INDEX3, RESULTAT2(i).INDEX4;
                EXIT WHEN Src%NOTFOUND;	i := i + 1;
        END LOOP;	Close Src;

        imax := i;	i := 1;
        While i < imax
        LOOP	dbms_output.put_line( to_char( RESULTAT2(i).STIME, 'YYYYMMDD HH24:MI' )	|| ';' || RESULTAT2(i).TABLE1	|| ';' ||
                        RESULTAT2(i).TABLE2             || ';' ||	RESULTAT2(i).TABLE3             || ';' ||
                        RESULTAT2(i).TABLE4             || ';' ||	RESULTAT2(i).TABLE5             || ';' ||
                        RESULTAT2(i).TABLE6             || ';' ||	RESULTAT2(i).TABLE7             || ';' ||
                        RESULTAT2(i).TABLE8             || ';' ||	RESULTAT2(i).TABLE9                );	i := i + 1;
        END LOOP;

        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( '|              Affichage INDEX                                 |' );
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( 'Snap_Time;' ||
                'I. fast full scans (direct read);I. fast full scans (full);I. fast full scans (rowid ranges);' || 'I. fetch by key' );
        i := 1;
        While i < imax
        LOOP	dbms_output.put_line( to_char( RESULTAT2(i).STIME, 'YYYYMMDD HH24:MI' )               || ';' ||
                        RESULTAT2(i).INDEX1             || ';' ||	RESULTAT2(i).INDEX2             || ';' ||
                        RESULTAT2(i).INDEX3             || ';' ||	RESULTAT2(i).INDEX4	);	i := i + 1;
        END LOOP;
        dbms_output.put_line( '+--------------------------------------------------------------+' );
        dbms_output.put_line( '|              Affichage FLUX                                  |' );
        dbms_output.put_line( '+--------------------------------------------------------------+' );
	wChaine := 'Snap_Time;SQL*Net roundtrips to/from client;SQL*Net roundtrips to/from dblink;bytes received from client;';
	wChaine := wChaine || 'bytes received from dblink;bytes sent to client;bytes sent to dblink';
        dbms_output.put_line( wChaine );	i := 1 ;
        SQL_DYN := ' SELECT stime, AVG(DELTA) DELTA, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''SQL*Net roundtrips to/from client'', VALUE_inc, 0 ) ) SQLNET1, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''SQL*Net roundtrips to/from dblink'', VALUE_inc, 0 ) ) SQLNET2, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''bytes received via SQL*Net from client'', VALUE_inc, 0 ) )/1024/1024 B_REC_1, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''bytes received via SQL*Net from dblink'', VALUE_inc, 0 ) )/1024/1024 B_REC_2, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''bytes sent via SQL*Net to client'', VALUE_inc, 0 ) )/1024/1024 B_Sent_1, ';
        SQL_DYN := SQL_DYN || ' SUM( DECODE( name, ''bytes sent via SQL*Net to dblink'', VALUE_inc, 0 ) )/1024/1024 B_Sent_2 ';
        SQL_DYN := SQL_DYN || ' FROM ';        SQL_DYN := SQL_DYN || ' ( ';
        SQL_DYN := SQL_DYN || ' select  ss.snap_time stime,  sq.name, ';
        SQL_DYN := SQL_DYN || ' decode(greatest(sq.VALUE, lag(sq.VALUE, 1, sq.VALUE) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name  order by sq.snap_id)),  ';
        SQL_DYN := SQL_DYN || ' sq.VALUE, sq.VALUE - lag(sq.VALUE, 1, sq.VALUE) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name order by sq.snap_id),  sq.VALUE) VALUE_inc, ';
        SQL_DYN := SQL_DYN || ' decode(greatest(ss.SNAP_TIME, lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name order by sq.snap_id)), ';
        SQL_DYN := SQL_DYN || ' ss.SNAP_TIME, ss.SNAP_TIME - lag(ss.SNAP_TIME, 1, ss.SNAP_TIME) ';
        SQL_DYN := SQL_DYN || ' over(partition by sq.name order by sq.snap_id),  ss.SNAP_TIME)*86400 DELTA ';
        SQL_DYN := SQL_DYN || ' from    PERFSTAT.stats$sysstat sq,  stats$snapshot ss ';
        SQL_DYN := SQL_DYN || ' where ss.snap_time between to_date( ''' || WDATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
        SQL_DYN := SQL_DYN || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
        SQL_DYN := SQL_DYN || ' and ( ( ss.instance_number = ' || INSTANCE || ') OR (' || INSTANCE || ' Is Null )) ';
        SQL_DYN := SQL_DYN || ' and sq.dbid = ss.dbid  ';
        SQL_DYN := SQL_DYN || ' and sq.instance_number = ss.instance_number  ';
        SQL_DYN := SQL_DYN || ' and sq.snap_id = ss.snap_id  ';
        SQL_DYN := SQL_DYN || ' and  name IN ';
        SQL_DYN := SQL_DYN || ' ( ''SQL*Net roundtrips to/from client'',  ';
        SQL_DYN := SQL_DYN || ' ''SQL*Net roundtrips to/from dblink'',  ';
        SQL_DYN := SQL_DYN || ' ''bytes received via SQL*Net from client'', ';
        SQL_DYN := SQL_DYN || ' ''bytes received via SQL*Net from dblink'',  ';
        SQL_DYN := SQL_DYN || ' ''bytes sent via SQL*Net to client'',  ';
        SQL_DYN := SQL_DYN || ' ''bytes sent via SQL*Net to dblink'' ) ';
        SQL_DYN := SQL_DYN || ' ) ';
        SQL_DYN := SQL_DYN || ' where   DELTA>0 ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
        SQL_DYN := SQL_DYN || ' group by stime ';
        SQL_DYN := SQL_DYN || ' order by 1 ';

        Open Src FOR SQL_DYN;
        LOOP	FETCH Src INTO	RESULTAT3(i).STIME,     RESULTAT3(i).DELTA,	RESULTAT3(i).SQLNET1,   RESULTAT3(i).SQLNET2,
                        RESULTAT3(i).B_REC_1,   RESULTAT3(i).B_REC_1,	RESULTAT3(i).B_Sent_1,  RESULTAT3(i).B_Sent_2;
                EXIT WHEN Src%NOTFOUND;	i := i + 1;
        END LOOP;        Close Src;        imax := i;        i := 1;
        While i < imax	LOOP	wChaine :=  to_char( RESULTAT3(i).STIME, 'YYYYMMDD HH24:MI' )           || ';' ;
                wChaine2 := round( RESULTAT3(i).SQLNET1, 1);	SELECT PKG_STATS.XLS_VAL( wChaine2 ) INTO wChaine2 FROM DUAL;
                wChaine :=  wChaine || wChaine2 || ';' ;	wChaine2 := round( RESULTAT3(i).SQLNET2, 1);
                SELECT PKG_STATS.XLS_VAL( wChaine2 ) INTO wChaine2 FROM DUAL;	wChaine :=  wChaine || wChaine2 || ';' ;
                wChaine2 := round( RESULTAT3(i).B_REC_1, 1);	SELECT PKG_STATS.XLS_VAL( wChaine2 ) INTO wChaine2 FROM DUAL;
                wChaine :=  wChaine || wChaine2 || ';' ;	wChaine2 := round( RESULTAT3(i).B_REC_1, 1);
                SELECT PKG_STATS.XLS_VAL( wChaine2 ) INTO wChaine2 FROM DUAL;	wChaine :=  wChaine || wChaine2 || ';' ;
                wChaine2 := round( RESULTAT3(i).B_Sent_1, 1);	SELECT PKG_STATS.XLS_VAL( wChaine2 ) INTO wChaine2 FROM DUAL;
                wChaine :=  wChaine || wChaine2 || ';' ;	wChaine2 := round( RESULTAT3(i).B_Sent_2, 1);
                SELECT PKG_STATS.XLS_VAL( wChaine2 ) INTO wChaine2 FROM DUAL;	wChaine :=  wChaine || wChaine2 || ';' ;
                dbms_output.put_line( wChaine );	i := i + 1;
        END LOOP;

        IF ( PARAM1 Is Not Null ) OR ( PARAM2 Is Not Null ) OR ( PARAM3 Is Not Null ) OR ( PARAM4 Is Not Null ) OR ( PARAM5 Is Not Null )
        THEN	dbms_output.put_line( '+--------------------------------------------------------------+' );
                dbms_output.put_line( '|              Affichage PERSONALISE                           |' );
                dbms_output.put_line( '+--------------------------------------------------------------+' );
                SQL_DYN := 'SELECT sTIME, sum( PARAM1 ) , sum( PARAM2 ) , sum( PARAM3 ) , sum( PARAM4 ) , sum( PARAM5 )  ';
                SQL_DYN := SQL_DYN || ' FROM ( select  to_char( sn.snap_time, ''YYYYMMDD HH24:MI'' ) stime';

                -- Ajout des eventuels parametres utilisateurs
                If PARAM1 is Not NULL THEN    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''' || PARAM1 || ''' , ss.value, 0 ) param1';
                ELSE    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''NO PARAM'' , ss.value, 0 ) param1';	END IF;
                If PARAM2 is Not NULL THEN    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''' || PARAM2 || ''' , ss.value, 0 ) param2';
                ELSE    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''NO PARAM'' , ss.value, 0 ) param2';	END IF;
                If PARAM3 is Not NULL THEN    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''' || PARAM3 || ''' , ss.value, 0 ) param3';
                ELSE    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''NO PARAM'' , ss.value, 0 ) param3';	END IF;
                If PARAM4 is Not NULL THEN    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''' || PARAM4 || ''' , ss.value, 0 ) param4';
                ELSE    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''NO PARAM'' , ss.value, 0 ) param4';	END IF;
                If PARAM5 is Not NULL THEN    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''' || PARAM5 || ''' , ss.value, 0 ) param5';
                ELSE    SQL_DYN := SQL_DYN || ', DECODE(ss.name, ''NO PARAM'' , ss.value, 0 ) param5';	END IF;
                -- Suite creation SQL Dynamique
                SQL_DYN := SQL_DYN || ' from stats$sysstat  ss, stats$snapshot sn';
                SQL_DYN := SQL_DYN || ' where   ss.snap_id = sn.snap_id';
                SQL_DYN := SQL_DYN || ' AND     sn.snap_time >= To_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
                SQL_DYN := SQL_DYN || ' AND     sn.snap_time <= To_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
		IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( sn.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
			SQL_Dyn :=  SQL_Dyn || ' and to_char( sn.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
                SQL_DYN := SQL_DYN || ' AND     (sn.INSTANCE_NUMBER= ' || INSTANCE || ' OR ' || INSTANCE || ' Is NULL )  ';
                SQL_DYN := SQL_DYN || ' AND     ss.DBID = sn.DBID ';
                SQL_DYN := SQL_DYN || ' AND     ss.INSTANCE_NUMBER = sn.INSTANCE_NUMBER ';
                SQL_DYN := SQL_DYN || ' AND     ss.name IN ( ';
                --------------------------------------------------------
                IF PARAM1 Is Not Null THEN      SQL_DYN := SQL_DYN || '''' || PARAM1 || ''',';          END IF;
                IF PARAM2 Is Not Null THEN      SQL_DYN := SQL_DYN || '''' || PARAM2 || ''',';          END IF;
                IF PARAM3 Is Not Null THEN      SQL_DYN := SQL_DYN || '''' || PARAM3 || ''',';          END IF;
                IF PARAM4 Is Not Null THEN      SQL_DYN := SQL_DYN || '''' || PARAM4 || ''',';          END IF;
                IF PARAM5 Is Not Null THEN      SQL_DYN := SQL_DYN || '''' || PARAM5 || ''',';          END IF;
                SQL_DYN := SQL_DYN || ' ''x'' ) ';	SQL_DYN := SQL_DYN || ') group by sTIME order by sTIME';

                -- Ecriture de l'entete
		wChaine2 := 'Snap_Time;';
		IF PARAM1 is not NULL THEN	wChaine2 := wChaine2 || PARAM1	|| ';' ;	END IF;
		IF PARAM2 is not NULL THEN	wChaine2 := wChaine2 || PARAM2	|| ';' ;	END IF;
		IF PARAM3 is not NULL THEN	wChaine2 := wChaine2 || PARAM3	|| ';' ;	END IF;
		IF PARAM4 is not NULL THEN	wChaine2 := wChaine2 || PARAM4	|| ';' ;	END IF;
		IF PARAM5 is not NULL THEN	wChaine2 := wChaine2 || PARAM5	|| ';' ;	END IF;
		dbms_output.put_line( wChaine2 );
                OPEN Src FOR  SQL_DYN;
                LOOP	FETCH Src INTO  wSTIME, wPARAM_1, wPARAM_2, wPARAM_3, wPARAM_4, wPARAM_5;
                        EXIT WHEN Src%NOTFOUND;	wChaine2 := wSTIME || ';' ;
			IF PARAM1 is not NULL THEN	wChaine2 := wChaine2 || wPARAM_1 	|| ';' ;	END IF;
			IF PARAM2 is not NULL THEN	wChaine2 := wChaine2 || wPARAM_2        || ';' ;	END IF;
			IF PARAM3 is not NULL THEN	wChaine2 := wChaine2 || wPARAM_3        || ';' ;	END IF;
			IF PARAM4 is not NULL THEN	wChaine2 := wChaine2 || wPARAM_4        || ';' ;	END IF;
			IF PARAM5 is not NULL THEN	wChaine2 := wChaine2 || wPARAM_5        || ';' ;	END IF;
                        dbms_output.put_line( wChaine2 );
                END LOOP;
        END IF;

	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
procedure PROFILE	( DATEDEB IN VARCHAR, DATEFIN IN VARCHAR, LSTMODE IN VARCHAR DEFAULT 'CSV', FORMAT_DATE IN VARCHAR DEFAULT 'YYYYMMDD HH24:MI',
			INSTANCE IN NUMBER DEFAULT Null, TYPEREST IN VARCHAR DEFAULT 'NORME', P1 IN VARCHAR DEFAULT Null, P2 IN VARCHAR DEFAULT Null,
			P3 IN VARCHAR DEFAULT Null, P4 IN VARCHAR DEFAULT Null, P5 IN VARCHAR DEFAULT Null, ZOOM IN VARCHAR DEFAULT Null )
IS	NB_Ano		Number;			PARAM1		Varchar( 2000 );	PARAM2		Varchar( 2000 );
	PARAM3		Varchar( 2000 );	PARAM4		Varchar( 2000 );	PARAM5		Varchar( 2000 );
	PARAM6		Varchar( 2000 );	PARAM7		Varchar( 2000 );	PARAM8		Varchar( 2000 );
	PARAM9		Varchar( 2000 );	PARAM10		Varchar( 2000 );	PARAM11		Varchar( 2000 );
	PARAM12		Varchar( 2000 );	wDATE1		Date;			wDATE		Date;
	wCHAINE		Varchar( 50 );		wFORMAT_DATE_SORTIE	Varchar( 50 );	wFILTRE		Varchar( 100 );
	oVersion	Number;			wINSTANCE	Varchar( 10 );		wP1       	VARCHAR( 100 );
        wP2          	VARCHAR( 100 );	        wP3          	VARCHAR( 100 );	        wP4          	VARCHAR( 100 );
        wP5          	VARCHAR( 100 );		Min_Snap	Number;			Max_Snap	Number;
	Nb		Number;
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;		PARAM2 := Null;		PARAM3 := Null;		PARAM4 := Null;
	PARAM5 := Null;	PARAM6 := Null;		PARAM7 := Null;		PARAM8 := Null;		PARAM9 := Null;
	PARAM10 := Null;	PARAM11 := Null;	PARAM12 := Null;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;

	-- DATEFIN
	IF DATEFIN Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';  END IF;
	-- FORMAT_DATE
	-- INSTANCE
	-- TYPEREST
	If 	INSTANCE Is NUll THEN 	wINSTANCE := 'Null' ;	ELSE	wINSTANCE := TO_char( INSTANCE );	END IF;
	-- P1 ?5
	select  min(snap_id), max(snap_id)	INTO	Min_Snap, 	Max_Snap from	stats$snapshot
	where 	snap_time >= to_date( DATEDEB, 'YYYYMMDD HH24:MI' )	and	snap_time <= to_date( DATEFIN, 'YYYYMMDD HH24:MI' );
	-- P1
	IF P1 Is NOT Null THEN
		select count(*) INTO NB
		from dual where EXISTS ( select 1 from stats$sysstat where name=P1 and SNAP_ID>=Min_Snap and SNAP_ID<=Max_Snap );
		IF NB = 0 THEN	NB_Ano := NB_Ano + 1;
			PARAM7 := 'KO - Ce parametre n''existe pas(''' || P1 || ''')';	END IF;	END IF;
	-- P2
	IF P2 Is NOT Null THEN
		select count(*) INTO NB
		from dual where EXISTS ( select 1 from stats$sysstat where name=P2 and SNAP_ID>=Min_Snap and SNAP_ID<=Max_Snap );
		IF NB = 0 THEN	NB_Ano := NB_Ano + 1;
			PARAM8 := 'KO - Ce parametre n''existe pas(''' || P2 || ''')';	END IF;	END IF;
	-- P3
	IF P3 Is NOT Null THEN
		select count(*) INTO NB
		from dual where EXISTS ( select 1 from stats$sysstat where name=P3 and SNAP_ID>=Min_Snap and SNAP_ID<=Max_Snap );
		IF NB = 0 THEN	NB_Ano := NB_Ano + 1;
			PARAM9 := 'KO - Ce parametre n''existe pas(''' || P3 || ''')';	END IF;	END IF;
	-- P4
	IF P4 Is NOT Null THEN
		select count(*) INTO NB
		from dual where EXISTS ( select 1 from stats$sysstat where name=P4 and SNAP_ID>=Min_Snap and SNAP_ID<=Max_Snap );
		IF NB = 0 THEN	NB_Ano := NB_Ano + 1;
			PARAM10 := 'KO - Ce parametre n''existe pas(''' || P4 || ''')';	END IF;	END IF;
	-- P5
	IF P5 Is NOT Null THEN
		select count(*) INTO NB
		from dual where EXISTS ( select 1 from stats$sysstat where name=P5 and SNAP_ID>=Min_Snap and SNAP_ID<=Max_Snap );
		IF NB = 0 THEN	NB_Ano := NB_Ano + 1;	PARAM11 := 'KO - Ce parametre n''existe pas(''' || P5 || ''')';	END IF;	END IF;
	-- ZOOM
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE PROFILE', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  FORMAT_DATE        | Varchar | ' || RPAD( NVL( PARAM4, 'OK ( ''' || FORMAT_DATE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 5 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM5, 'OK ( ' || wINSTANCE || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 6 |  TYPEREST           | Varchar | ' || RPAD( NVL( PARAM6, 'OK ( ''' || TYPEREST  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 7 |  P1                 | Varchar | ' || RPAD( NVL( PARAM7, 'OK ( ''' || P1  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 8 |  P2                 | Varchar | ' || RPAD( NVL( PARAM8, 'OK ( ''' || P5  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 9 |  P3                 | Varchar | ' || RPAD( NVL( PARAM9, 'OK ( ''' || P3  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '|10 |  P4                 | Varchar | ' || RPAD( NVL( PARAM10, 'OK ( ''' || P4  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '|11 |  P5                 | Varchar | ' || RPAD( NVL( PARAM11, 'OK ( ''' || P5  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '|12 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM12, 'OK ( ''' || ZOOM  || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
		IF P1 Is Null 	THEN	wP1 := 'Null'; 	ELSE	wP1 := '''' || P1 || '''';	END IF;
		IF P2 Is Null 	THEN	wP2 := 'Null'; 	ELSE	wP2 := '''' || P2 || '''';	END IF;
		IF P3 Is Null 	THEN	wP3 := 'Null'; 	ELSE	wP3 := '''' || P3 || '''';	END IF;
		IF P4 Is Null 	THEN	wP4 := 'Null'; 	ELSE	wP4 := '''' || P4 || '''';	END IF;
		IF P5 Is Null 	THEN	wP5 := 'Null'; 	ELSE	wP5 := '''' || P5 || '''';	END IF;
		Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.Profile( ''' ||
		DATEDEB || ''', ''' || 	DATEFIN || ''', ''' || LSTMODE 	|| ''', ''' || 	FORMAT_DATE	|| ''', ' ||
		wINSTANCE || ', ''' ||	TYPEREST || ''', ' || wP1 || ', ' || wP2 || ', ' || wP3 || ', ' || wP4 || ', ' || wP5 || ')' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SYSSTAT' ) ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' ,  'STATS$SYSSTAT' );
		ELSE	PKG_STATS.PROFILE_proc( DATEDEB, DATEFIN, upper(LSTMODE), FORMAT_DATE, INSTANCE, TYPEREST, P1, P2, P3, P4, P5, ZOOM );
		END IF;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure PLANSTAT	( DATEDEB Varchar DEFAULT Null, DATEFIN Varchar	DEFAULT Null, HASHVALUE Number DEFAULT Null,
			SCOPE Varchar DEFAULT 'PLAN', AFFICHE Varchar DEFAULT 'ERR', FIXED_SCHEMA IN VARCHAR DEFAULT Null )
IS	NB_Ano		Number;			PARAM1		Varchar( 2000 );	PARAM2		Varchar( 2000 );
	PARAM3		Varchar( 2000 );	PARAM4		Varchar( 2000 );	PARAM5		Varchar( 2000 );
	PARAM6		Varchar( 2000 );	PARAM7		Varchar( 2000 );	PARAM8		Varchar( 2000 );
	PARAM9		Varchar( 2000 );	PARAM10		Varchar( 2000 );	PARAM11		Varchar( 2000 );
	PARAM12		Varchar( 2000 );	wDATE1		Date;			wDATE		Date;
	wCHAINE		Varchar( 50 );		wFORMAT_DATE_SORTIE	Varchar( 50 );	wFILTRE		Varchar( 100 );
	oVersion	Number;			wINSTANCE	Varchar( 10 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;	PARAM1 := Null;	PARAM2 := Null;	PARAM3 := Null;	PARAM4 := Null;	PARAM5 := Null;	PARAM6 := Null;	PARAM7 := Null;
	PARAM8 := Null;	PARAM9 := Null;	PARAM10 := Null; PARAM11 := Null; PARAM12 := Null;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'KO La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'KO La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM2 := 'KO La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'KO La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'KO La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- HASHVALUE
	IF HASHVALUE Is NULL THEN	NB_Ano := NB_Ano + 1;	PARAM3 := 'KO La requ? HASHVALUE doit etre renseignee ';	END IF;
	-- SCOPE
	IF upper( SCOPE ) not in ('PLAN', 'LARGE' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM4 := 'KO Le parametre SCOPE est incorrect (PLAN/LARGE) ';	END IF;

	-- AFFICHE
	IF upper( AFFICHE ) not in ('ALL', 'ERR' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM5 := 'KO Le parametre AFFICHE est incorrect (ALL/ERR) ';	END IF;

	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN
	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE PLANSTAT', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  HASHVALUE          | Number  | ' || RPAD( NVL( PARAM3, 'OK ( ''' || HASHVALUE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  SCOPE              | Varchar | ' || RPAD( NVL( PARAM4, 'OK ( ''' || SCOPE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 5 |  AFFICHE            | Number  | ' || RPAD( NVL( PARAM5, 'OK ( ' || AFFICHE || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.Planstat( ''' || DATEDEB || ''', ''' || DATEFIN || ''', ' || HASHVALUE || ', ''' ||
				SCOPE || ''', ''' || AFFICHE 	|| ''')' );
	ELSE	PKG_STATS.Planstat_proc( DATEDEB, DATEFIN, HASHVALUE, SCOPE, AFFICHE );
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure PLANSTAT_proc		( DATEDEB Varchar, DATEFIN Varchar, HASHVALUE Number, SCOPE Varchar DEFAULT 'PLAN',
				AFFICHE Varchar DEFAULT 'ERR', FIXED_SCHEMA IN VARCHAR DEFAULT Null )
IS	TYPE DataSource IS REF CURSOR; Src DataSource; Src1 DataSource; wOP Varchar(100); wOP2 Varchar(100);
	wOBJECT Varchar(100); wChaine Varchar(10000); wLAST Varchar(10); wNUM_ROWS Number; wSAMPLE_SIZE Number;
	oVersion Number; LAST_ANALYZED Varchar(10); NB Number; NB_Obj Number; NB_Jours Number; wtime_waited Number;
	SQL_Dyn	Varchar(10000); SQL_Dyn2 Varchar(10000); pSIZE Number; wDEBUG Number; NBPART Number; wSTATUS Varchar(50);
	Aff Number; TYPE Element IS RECORD(Commande VARCHAR(500)); Type Matrice IS TABLE OF Element index by binary_integer;
	Commande_LISTE Matrice;	i Number; imax Number;
BEGIN	dbms_output.enable(100000000);
	wOP2 	:= 'xx';	wDEBUG 	:= 0;	Aff 	:= 0;	NB_Jours := 60;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	BEGIN	select count(*)  INTO 	NB from dba_tables where table_name='TINFO_COLUMNS' and owner='PERFSTAT';
	EXCEPTION WHEN OTHERS THEN NB := 0;	END;
	SQL_Dyn := ' SELECT distinct OPERATION, OBJECT_NAME  from ( ';
	SQL_Dyn := SQL_Dyn || ' SELECT OPERATION, OBJECT_NAME  from V$SQL_PLAN ';
	-------------------------------------------------------------------------------
	IF SCOPE = 'PLAN' THEN	SQL_Dyn := SQL_Dyn || ' where OPERATION IN (''TABLE ACCESS'' , ''INDEX'' ) ';
	ELSIF	SCOPE = 'LARGE' THEN	SQL_Dyn := SQL_Dyn || ' where OPERATION IN (''TABLE ACCESS'' ) ';	END IF;
	SQL_Dyn := SQL_Dyn || ' and HASH_VALUE = ' || HASHVALUE || ' ';
	-------------------------------------------------------------------------------
	IF Oversion >= 9 THEN		SQL_Dyn := SQL_Dyn || ' union ';
		SQL_Dyn := SQL_Dyn || ' SELECT OPERATION, OBJECT_NAME  ';
		SQL_Dyn := SQL_Dyn || ' FROM perfstaT.STATS$SQL_PLAN sp, ';
		SQL_Dyn := SQL_Dyn || ' perfstaT.STATS$SQL_PLAN_USAGE spu ';
		SQL_Dyn := SQL_Dyn || ' WHERE	sp.SNAP_ID = spu.SNAP_ID ';
		SQL_Dyn := SQL_Dyn || ' AND	sp.PLAN_HASH_VALUE = spu.PLAN_HASH_VALUE ';
		SQL_Dyn := SQL_Dyn || ' AND	spu.HASH_VALUE = ' || HASHVALUE ;
		IF SCOPE = 'PLAN' THEN	SQL_Dyn := SQL_Dyn || ' and OPERATION IN (''TABLE ACCESS'' , ''INDEX'' ) ';
		ELSIF	SCOPE = 'LARGE' THEN	SQL_Dyn := SQL_Dyn || ' and OPERATION IN (''TABLE ACCESS'' ) ';	END IF;
		SQL_Dyn := SQL_Dyn || ' AND	OBJECT_NAME is not Null ';	END IF;
	-------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn || ' ) order by OPERATION, OBJECT_NAME ';
	If wDEBUG = 1 OR wDEBUG = 9 THEN
		dbms_output.put_line ( substr( SQL_Dyn,   1, 200 ));	dbms_output.put_line ( substr( SQL_Dyn, 201, 200 ));
		dbms_output.put_line ( substr( SQL_Dyn, 401, 200 ));	dbms_output.put_line ( substr( SQL_Dyn, 601, 200 ));
		dbms_output.put_line ( substr( SQL_Dyn, 801, 200 ));	dbms_output.put_line ( substr( SQL_Dyn,1001, 200 ));	END IF;

	open Src for SQL_Dyn ;
	LOOP	FETCH Src INTO wOP, wOBJECT;	EXIT WHEN Src%NOTFOUND;
		IF wOP != wOP2 THEN		wOP2 := wOP;
			IF AFF >0 THEN		dbms_output.put_line(
				'+---+------------------------------------+----------+----------+------+------+--------++-----+' );
			END IF;
		END IF;
		select count(*) INTO NB_Obj From dba_objects
		where object_name=wOBJECT and owner not in ('SYS', 'SYSTEM' )	AND	( (OWNER = FIXED_SCHEMA) OR (FIXED_SCHEMA is null) );

		IF (wOP like 'TABLE ACCESS%' ) AND (NB_Obj>0) THEN	wChaine := '| T | ' || RPAD( wOBJECT, 35 ) || '|' ;
			wChaine := wChaine || '    -     | ' ;
			BEGIN	select NUM_ROWS, SAMPLE_SIZE, to_char( LAST_ANALYZED, 'YYYYMMDD' )
				INTO wNUM_ROWS, wSAMPLE_SIZE, LAST_ANALYZED from dba_tables where table_name= wOBJECT
				AND	( (OWNER = FIXED_SCHEMA) OR (FIXED_SCHEMA is null) );
			EXCEPTION WHEN OTHERS THEN	wNUM_ROWS := Null;  wSAMPLE_SIZE := Null;  LAST_ANALYZED := Null;  END;
			IF wNUM_ROWS = 0 THEN wNUM_ROWS := Null;	END IF;
			wChaine := wChaine  || LAST_ANALYZED || ' | ' ;
			wChaine := wChaine  || NVL( to_char( 100*wSAMPLE_SIZE/wNUM_ROWS, '999' ), '  - ' ) || ' |'  ;
			--------------------------------------------------------------------------------------------------------------
			BEGIN	SQL_Dyn2 := ' select time_waited from perfstat.tinfo_columns where table_name=''' || wOBJECT ;
				SQL_Dyn2 := SQL_Dyn2 || ''' and TYPE_STAT=''R'' ';
				If wDEBUG = 2 OR wDEBUG = 9 THEN
				dbms_output.put_line ( substr( SQL_Dyn2,   1, 200 ));	dbms_output.put_line ( substr( SQL_Dyn2, 201, 200 ));
				dbms_output.put_line ( substr( SQL_Dyn2, 401, 200 ));	dbms_output.put_line ( substr( SQL_Dyn2, 601, 200 ));
				dbms_output.put_line ( substr( SQL_Dyn2, 801, 200 ));	dbms_output.put_line ( substr( SQL_Dyn2,1001, 200 ));
				END IF;
				OPEN Src1 For SQL_Dyn2;
				FETCH Src1 INTO wtime_waited ;
				Close Src1;
			EXCEPTION WHEN OTHERS THEN Null;	END;
			select count(*) INTO NBPART from dba_tab_partitions where TABLE_NAME = wOBJECT;
			IF NBPART = 0 THEN NBPART := 1; END IF;
			wChaine := wChaine  || 	' ' || to_char( NBPART , '999' ) || ' |' ;
			select sum( bytes )/1024/1024 INTO pSIZE from dba_segments where segment_name=  wOBJECT and SEGMENT_TYPE like 'TABLE%' ;
			wChaine := wChaine  || 	to_char( NVL( pSIZE, 0), '999999' ) || ' ||' ;
			wChaine := wChaine  || 	NVL( to_char( wtime_waited,'999' ), '  - ' ) || ' |';
			wSTATUS := 'OK';
			IF to_date(LAST_ANALYZED, 'YYYYMMDD' )< (sysdate-NB_Jours) THEN 	wSTATUS := 'KO Statistiques';		END IF;
			wChaine := wChaine  || 	wSTATUS;
		ELSIF (wOP ='INDEX') AND (NB_Obj >0) THEN
			wChaine := '| I | ' || RPAD( wOBJECT, 35 ) || '|' ;
			BEGIN
			select to_char( LAST_DDL_TIME, 'YYYYMMDD' ) INTO wLAST from dba_objects where OBJECT_NAME=wOBJECT
					AND	( (OWNER = FIXED_SCHEMA) OR (FIXED_SCHEMA is null) );
			EXCEPTION WHEN OTHERS THEN  wLAST := Null; END;
			wChaine := wChaine  || ' ' || NVL( wLAST, '        ' )  || ' | ' ;
			select NUM_ROWS, SAMPLE_SIZE, to_char( LAST_ANALYZED, 'YYYYMMDD' )
			INTO wNUM_ROWS, wSAMPLE_SIZE, LAST_ANALYZED
			from dba_indexes where index_name= wOBJECT
			AND	( (OWNER = FIXED_SCHEMA) OR (FIXED_SCHEMA is null) );
			IF wNUM_ROWS = 0 THEN wNUM_ROWS := Null;	END IF;
			wChaine := wChaine  || NVL(LAST_ANALYZED, '        ') || ' | ' ;
			wChaine := wChaine  || NVL( to_char( 100*wSAMPLE_SIZE/wNUM_ROWS, '999' ), '  - ' ) || ' | '  ;
			--------------------------------------------------------------------------------------------------------------
			BEGIN
				SQL_Dyn2 := ' select time_waited from perfstat.tinfo_columns where index_name=''' || wOBJECT ;
				SQL_Dyn2 := SQL_Dyn2 || ''' and TYPE_STAT=''R'' ';
				If wDEBUG = 2 OR wDEBUG = 9 THEN
					dbms_output.put_line ( substr( SQL_Dyn2,   1, 200 ));	dbms_output.put_line ( substr( SQL_Dyn2, 201, 200 ));
					dbms_output.put_line ( substr( SQL_Dyn2, 401, 200 ));	dbms_output.put_line ( substr( SQL_Dyn2, 601, 200 ));
					dbms_output.put_line ( substr( SQL_Dyn2, 801, 200 ));	dbms_output.put_line ( substr( SQL_Dyn2,1001, 200 ));
				END IF;
				OPEN Src1 For SQL_Dyn2;
				FETCH Src1 INTO wtime_waited ;
				Close Src1;
			EXCEPTION WHEN OTHERS THEN null; END;

			select count(*) INTO NBPART from dba_ind_partitions where INDEX_NAME = wOBJECT
			AND	( (INDEX_OWNER = FIXED_SCHEMA) OR (FIXED_SCHEMA is null) );

			IF NBPART = 0 THEN NBPART := 1; END IF;
			wChaine := wChaine  || 	to_char( NBPART , '999' ) || ' |' ;
			select sum( bytes )/1024/1024 INTO pSIZE from dba_segments where segment_name=  wOBJECT and SEGMENT_TYPE like 'INDEX%'
			AND	( (OWNER = FIXED_SCHEMA) OR (FIXED_SCHEMA is null) );
			wChaine := wChaine  || 	to_char( pSIZE, '999999' ) || ' ||' ;
			wChaine := wChaine  || 	NVL( to_char( wtime_waited,'999' ), '  - ' ) || ' |';
			wSTATUS := 'OK';
			IF to_date(wLAST 	, 'YYYYMMDD' )< (sysdate-NB_Jours) THEN 	wSTATUS := 'KO Reconstruction';		END IF;
			IF to_date(LAST_ANALYZED, 'YYYYMMDD' )< (sysdate-NB_Jours) THEN 	wSTATUS := 'KO Statistiques';		END IF;
			IF LAST_ANALYZED<wLAST                               THEN	wSTATUS := 'KO Coherence';		END IF;
			wChaine := wChaine  || 	wSTATUS;
		END IF;

		IF (AFFICHE='ALL') OR ( (AFFICHE='ERR') AND (wSTATUS!='OK') )
		THEN
			IF Aff = 0 THEN
				Aff := 1;
				dbms_output.put_line(
				'<----------------------- Donnees Oracle ----------------------------------------------> <    Stats>' );
				dbms_output.put_line(
				'Type         Objets                        Constr.    Stats       %E   Extent Taille/Mo Temps ');
				dbms_output.put_line(
				'+---+------------------------------------+----------+----------+------+------+--------++-----+' );
			END IF;
			dbms_output.put_line( wChaine	);
		END IF;
	END LOOP;
	Close Src;

	IF AFF = 0 THEN	dbms_output.put_line( '* PLANSTAT : RAS' );	ELSE	dbms_output.put_line(
		'+---+------------------------------------+----------+----------+------+------+--------++-----+' );
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure EVAL_PARAM	( GROUP_VALUE IN VARCHAR DEFAULT Null, PARAM_VALUE IN VARCHAR DEFAULT Null, FILTRE IN VARCHAR DEFAULT Null )
IS	SQL_Dyn		Varchar( 1000 );	wVALUE		Varchar( 150 );		wVALUE2		Number;
	wSTATUS		Varchar( 5 );	oVersion	Number;		oVersion2	Number;	wDEFAULT	Varchar( 50 );
BEGIN	dbms_output.enable( 1000000 );
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;	wVALUE 	:= ' ';	wSTATUS := 'N/A';
	IF GROUP_VALUE Is NULL THEN
		PKG_STATS.EVAL_PARAM( 'BASE' , PARAM_VALUE, FILTRE );	PKG_STATS.EVAL_PARAM( 'MEMOIRE', PARAM_VALUE, FILTRE );
		PKG_STATS.EVAL_PARAM( 'QUERY', PARAM_VALUE, FILTRE );	PKG_STATS.EVAL_PARAM( 'DIVERS', PARAM_VALUE, FILTRE );
		PKG_STATS.EVAL_PARAM( 'ARO', PARAM_VALUE, FILTRE );
	ELSIF GROUP_VALUE = 'BASE' THEN
		IF PARAM_VALUE Is NULL THEN	PKG_STATS.EVAL_PARAM( 'BASE', 'optimizer_mode', FILTRE );
			PKG_STATS.EVAL_PARAM( 'BASE', 'optimizer_features_enable', FILTRE );
			PKG_STATS.EVAL_PARAM( 'BASE', 'optimizer_dynamic_sampling', FILTRE );
			PKG_STATS.EVAL_PARAM( 'BASE', 'optimizer_index_cost_adj', FILTRE );
			PKG_STATS.EVAL_PARAM( 'BASE', 'optimizer_index_catching', FILTRE );
			PKG_STATS.EVAL_PARAM( 'BASE', 'optimizer_max_permutations', FILTRE );
			PKG_STATS.EVAL_PARAM( 'BASE', 'db_file_multiblock_read_count', FILTRE );
		ELSIF PARAM_VALUE = 'optimizer_mode' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE IN ('CHOOSE', 'ALL_ROWS' ) THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'optimizer_features_enable' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			select substr( wVALUE, 1, instr( wVALUE, '.' )-1 ) 	INTO Oversion2 FROM v$instance;
			IF Oversion = Oversion2 THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'optimizer_dynamic_sampling' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'optimizer_index_cost_adj' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF To_number ( wVALUE ) = 100 THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'optimizer_index_catching' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN wVALUE := Null; END;
			IF wVALUE IS nuLL THEN wSTATUS :='KO'; ELSE wSTATUS :='OK'; END IF;
		ELSIF PARAM_VALUE = 'optimizer_max_permutations' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'db_file_multiblock_read_count' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF To_number ( wVALUE ) IN ( 2, 4, 8, 16, 32, 64, 128 ) THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;	END IF;
	ELSIF GROUP_VALUE = 'MEMOIRE' THEN
		IF PARAM_VALUE Is NULL THEN
			PKG_STATS.EVAL_PARAM( 'MEMOIRE', 'workarea_size_policy', FILTRE );
			PKG_STATS.EVAL_PARAM( 'MEMOIRE', 'pga_aggregate_target', FILTRE );
			PKG_STATS.EVAL_PARAM( 'MEMOIRE', 'hash_area_size', FILTRE );
			PKG_STATS.EVAL_PARAM( 'MEMOIRE', 'sort_area_size', FILTRE );
			PKG_STATS.EVAL_PARAM( 'MEMOIRE', 'bitmap_merge_area_size', FILTRE );
		ELSIF PARAM_VALUE = 'workarea_size_policy' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'pga_aggregate_target' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF to_number(wVALUE) > 0 THEN	wSTATUS :='OK'; ELSE 	wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'hash_area_size' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			SELECT VALUE INTO wVALUE2 FROM v$parameter where NAME='pga_aggregate_target';
			IF wVALUE > 0 THEN	IF wVALUE2 >0 THEN wSTATUS :='KO'; ELSE wSTATUS :='OK'; END IF;
			ELSE 	wSTATUS :='OK'; 	END IF;
		ELSIF PARAM_VALUE = 'sort_area_size' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			SELECT VALUE INTO wVALUE2 FROM v$parameter where NAME='pga_aggregate_target';
			IF wVALUE > 0 THEN  IF wVALUE2 >0 THEN wSTATUS :='KO'; ELSE wSTATUS :='OK'; END IF; ELSE  wSTATUS :='OK';	END IF;
		ELSIF PARAM_VALUE = 'bitmap_merge_area_size' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		END IF;
	ELSIF GROUP_VALUE = 'QUERY' THEN
		IF PARAM_VALUE IS Null THEN
			PKG_STATS.EVAL_PARAM( 'QUERY', 'query_rewrite_enabled', FILTRE );
			PKG_STATS.EVAL_PARAM( 'QUERY', 'query_rewrite_integrity', FILTRE );
			PKG_STATS.EVAL_PARAM( 'QUERY', 'star_transformation_enabled', FILTRE );
			PKG_STATS.EVAL_PARAM( 'QUERY', 'optimizer_secure_view_merging', FILTRE );
		ELSIF PARAM_VALUE = 'query_rewrite_enabled' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE = 'TRUE' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'query_rewrite_integrity' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE = 'enforced' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'star_transformation_enabled' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE = 'FALSE' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'optimizer_secure_view_merging' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE = 'TRUE' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;	END IF;
	ELSIF GROUP_VALUE = 'DIVERS' THEN
		IF PARAM_VALUE IS Null THEN	PKG_STATS.EVAL_PARAM( 'DIVERS', 'cursor_sharing', FILTRE );
			PKG_STATS.EVAL_PARAM( 'DIVERS', 'skip_unusable_indexes', FILTRE );
		ELSIF PARAM_VALUE = 'cursor_sharing' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'skip_unusable_indexes' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE = 'TRUE' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		END IF;
	ELSIF GROUP_VALUE = 'ARO' THEN
		IF PARAM_VALUE IS Null THEN
			PKG_STATS.EVAL_PARAM( 'ARO', 'undo_tablespace' 	, FILTRE ); PKG_STATS.EVAL_PARAM( 'ARO', 'rollback_segments' , FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'spfile' 		, FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'sga_max_size' 	, FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'session_cached_cursors' , FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'mts_dispatchers' 	, FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'log_archive_start', FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'db_writer_processes' , FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'disk_asynch_io' 	, FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'sql_trace' 	, FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'sessions' 	, FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'compatible' 	, FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'db_block_buffers'	, FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'db_cache_size' 	, FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'db_block_size'	, FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'open_cursors'	, FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'processes' 	, FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'timed_statistics'	, FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'db_files' 	, FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'shared_pool_size' , FILTRE); PKG_STATS.EVAL_PARAM( 'ARO', 'sort_multiblock_read_count', FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', 'optimizer_percent_parallel' , FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', '_optimizer_system_stats_usage', FILTRE);
			PKG_STATS.EVAL_PARAM( 'ARO', '_optimizer_cost_model' 	, FILTRE);
		ELSIF PARAM_VALUE = 'undo_tablespace'  THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF Oversion >= 9	THEN	IF wVALUE Is NULL THEN wSTATUS :='KO'; ELSE wSTATUS :='OK'; END IF;
			ELSE	wSTATUS :='OK';	END IF;
		ELSIF PARAM_VALUE = 'rollback_segments' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF Oversion >= 9	THEN	IF wVALUE Is NOT NULL THEN wSTATUS :='KO'; ELSE wSTATUS :='OK'; END IF;
			ELSE	wSTATUS :='OK';	END IF;
		ELSIF PARAM_VALUE = 'spfile' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF Oversion >= 9  THEN	IF wVALUE Is NULL THEN wSTATUS :='KO'; ELSE wSTATUS :='OK'; END IF;  ELSE  wSTATUS :='OK';  END IF;
		ELSIF PARAM_VALUE = 'sga_max_size' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'session_cached_cursors' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'mts_dispatchers' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'log_archive_start' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE = 'TRUE' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'db_writer_processes' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'disk_asynch_io' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'sql_trace' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE = 'FALSE' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'sessions' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'compatible' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			select substr( wVALUE, 1, instr( wVALUE, '.' )-1 ) 	INTO Oversion2 FROM v$instance;
			IF Oversion = Oversion2 THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'db_block_buffers' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF Oversion >= 9	THEN	IF 	wVALUE = '0'  		THEN 	wSTATUS :='OK';
				ELSIF wVALUE Is NOT NULL 	THEN 	wSTATUS :='KO'; ELSE	wSTATUS :='OK'; END IF;
			ELSE	wSTATUS :='OK';	END IF;
		ELSIF PARAM_VALUE = 'db_cache_size' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF Oversion >= 9	THEN	IF wVALUE Is NULL THEN wSTATUS :='KO'; ELSIF	To_number( wVALUE ) = 0
				THEN wSTATUS :='KO'; ELSE 	wSTATUS :='OK'; END IF;	ELSE	wSTATUS :='OK';	END IF;
		ELSIF PARAM_VALUE = 'db_block_size' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'open_cursors' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'processes' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'timed_statistics' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
			IF wVALUE='TRUE' THEN wSTATUS :='OK'; ELSE wSTATUS :='KO'; END IF;
		ELSIF PARAM_VALUE = 'db_files' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'shared_pool_size' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'sort_multiblock_read_count' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = 'optimizer_percent_parallel' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = '_optimizer_system_stats_usage' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		ELSIF PARAM_VALUE = '_optimizer_cost_model' THEN
			BEGIN	SELECT VALUE INTO wVALUE FROM v$parameter where NAME=PARAM_VALUE;  EXCEPTION WHEN OTHERS THEN NULL;  END;
		END IF;
	END IF;

	IF GROUP_VALUE IS Not Null AND PARAM_VALUE Is Not null THEN
		BEGIN	select decode(isdefault, 'TRUE', 'DEFAULT', 'FALSE', 'USER', '?') INTO wDEFAULT
			from v$parameter
			where value is not null and name = PARAM_VALUE;
		EXCEPTION WHEN NO_DATA_FOUND THEN	wDEFAULT := 'NO DATA';		END;
		SQL_Dyn := ' select  v.ksppstdf from x$ksppi i, x$ksppcv v  where   v.indx = i.indx and     v.inst_id = i.inst_id ';
		SQL_Dyn := SQL_Dyn || ' and     v.ksppstdf = ''TRUE''  and i.ksppinm like ''' || PARAM_VALUE || ''' ' ;
		SQL_Dyn := SQL_Dyn || ' order by i.ksppinm ';
		IF FILTRE IS NULL THEN	dbms_output.put_line ( RPAD( GROUP_VALUE, 15 ) || RPAD( PARAM_VALUE, 40) ||
					RPAD( NVL(wVALUE, ' ' ), 60) || wSTATUS  || '(' || wDEFAULT || ')');
		ELSIF FILTRE = wSTATUS THEN	dbms_output.put_line ( RPAD( GROUP_VALUE, 15 ) || RPAD( PARAM_VALUE, 40) ||
					RPAD( NVL(wVALUE, ' ' ), 60) || wSTATUS  || '(' || wDEFAULT || ')' );
		END IF;
	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure Security
IS	wDATE		DATE;	wVersion	Varchar( 50 );
BEGIN
	dbms_output.enable( 1000000 );
	dbms_output.put_line( '+-------------------------------------------+' );
	SELECT PERFSTAT.PKG_STATS.VERSION INTO wVersion FROM dual;
	dbms_output.put_line( '| ' || Rpad( 'Report Tuning (' || wVersion || ')' , 38 )  || '    |' );
	dbms_output.put_line( '+ - - - - - - - - - - - - - - - - - - - - - +' );
	dbms_output.put_line( '|                                           |' );
	dbms_output.put_line( '|     Fonctionnalites     Date de fin       |' );
	dbms_output.put_line( '|   +----------------+------------------+   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'DIAG' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | DIAG           | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'RUBRIQUE' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | RUBRIQUE       | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'TOPSQL' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | TOPSQL         | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'MTOPSQL' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | MTOPSQL        | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'PROFILE' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | PROFILE        | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'PGA' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | PGA            | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'BPS' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | BPS            | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'SUIVI_IO' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | SUIVI_IO       | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'NQ' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | NQ             | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	SELECT perfstat.PKG_STATS.CheckVal( 'TOPMODULE' ) INTO wDATE FROM DUAL;
	dbms_output.put_line( '|   | TOPMODULE      | ' || NVL( to_char( wDATE, 'DD/MM/YYYY HH24:MI' ), rpad(' ',16) ) || ' |   |' );
	dbms_output.put_line( '|   +----------------+------------------+   |' );
	dbms_output.put_line( '|                                           |' );
	dbms_output.put_line( '|    NB : LSTMODE=EXTRACT non concerne      |' );
	dbms_output.put_line( '+-------------------------------------------+' );
END;
---------------------------------------------------------------------------------------------------------------------
procedure FLUXDBA	( DATEDEB VARCHAR, DATEFIN VARCHAR, INSTANCEN Number DEFAULT 1 )
IS	TYPE DataSource IS REF CURSOR; Src DataSource; C1 Number; p1 Number; v1 Number; C2 Number; p2 Number; v2 Number;
 C3 Number; p3 Number; v3 Number; C4 Number; p4 Number; v4 Number; C5 Number; p5 Number; v5 Number; C6 Number; p6 Number; v6 Number;
 C7 Number; p7 Number; v7 Number; C8 Number; p8 Number; v8 Number; C9 Number; p9 Number; v9 Number; C10 Number; p10 Number; v10 Number;
 C11 Number; p11 Number; v11 Number; C12 Number; p12 Number; v12 Number; C13 Number; p13 Number; v13 Number; C14 Number; p14 Number; v14 Number;
 C15 Number; p15 Number; v15 Number; C16 Number; p16 Number; v16 Number; C17 Number; p17 Number; v17 Number; C18 Number; p18 Number; v18 Number;
 C19 Number; p19 Number; v19 Number; C20 Number; p20 Number; v20 Number; C21 Number; p21 Number; v21 Number; C22 Number; p22 Number; v22 Number;
 C23 Number; p23 Number; v23 Number; C24 Number; p24 Number; v24 Number; C25 Number; p25 Number; v25 Number; C26 Number; p26 Number; v26 Number;
 C27 Number; p27 Number; v27 Number; c28 Number; p28 Number; v28 Number; c29 Number; p29 Number; v29 Number; c30 Number; p30 Number; v30 Number;
 c31 Number; p31 Number; v31 Number; c32 Number; p32 Number; v32 Number; c33 Number; p33 Number; v33 Number; c34 Number; p34 Number; v34 Number;
 c35 Number; p35 Number; v35 Number; c36 Number; p36 Number; v36 Number; c37 Number; p37 Number; v37 Number; c38 Number; p38 Number; v38 Number;
 c39 Number; p39 Number; v39 Number; wSNAP_TIME DATE; vSNAP_TIME NUMBER; SNAP_TIME_OLD DATE; wHOST VARCHAR( 50 );
	wINSTANCE VARCHAR( 50 ); wLIGNE VARCHAR( 150 ); wLIGNEOLD VARCHAR( 150 );
BEGIN	dbms_output.enable( 10000000 );
	wLIGNEOLD := 'xw';
	SELECT HOST_NAME, INSTANCE_NAME INTO wHOST, wINSTANCE from V$instance;
	Open Src FOR SELECT STIME, SUM(C1) C1, SUM(C2) C2, SUM(C3) C3, SUM(C4) C4, SUM(C5) C5, SUM(C6) C6, SUM(C7) C7, SUM(C8) C8, SUM(C9) C9,
		SUM(C10) C10, SUM(C11) C11, SUM(C12) C12, SUM(C13) C13, SUM(C14) C14, SUM(C15) C15, SUM(C16) C16, SUM(C17) C17, SUM(C18) C18,
		SUM(C19) C19, SUM(C20) C20, SUM(C21) C21, SUM(C22) C22, SUM(C23) C23, SUM(C24) C24, SUM(C25) C25, SUM(C26) C26, SUM(C27) C27,
		SUM(C28) C28, SUM(C29) c29, SUM(c30) c30, SUM(C31) c31, SUM(C32) c32, SUM(C33) c33, SUM(C34) c34, SUM(C35) c35,
		SUM(C36) c36, SUM(C37) c37, SUM(C38) c38
	FROM (	SELECT 	sn.snap_time STIME,
		DECODE( NAME, 'bytes received via SQL*Net from client', 	VALUE, 0 ) 	C1,
		DECODE( NAME, 'bytes sent via SQL*Net to client', 		VALUE, 0 ) 	C2,
		DECODE( NAME, 'SQL*Net roundtrips to/from client', 		VALUE, 0 ) 	C3,
		DECODE( NAME, 'table scans (short tables)', 			VALUE, 0 )	C4,
		DECODE( NAME, 'table scans (long tables)', 			VALUE, 0 )	C5,
		DECODE( NAME, 'table scans (rowid ranges)', 			VALUE, 0 )	C6,
		DECODE( NAME, 'table scans (direct read)',	 		VALUE, 0 )	C7,
		DECODE( NAME, 'table scan rows gotten', 			VALUE, 0 )	C8,
		DECODE( NAME, 'table fetch by rowid', 				VALUE, 0 )	C9,
		DECODE( NAME, 'table fetch continued row', 			VALUE, 0 )	C10,
		DECODE( NAME, 'sorts (memory)', 				VALUE, 0 )	C11,
		DECODE( NAME, 'sorts (disk)', 					VALUE, 0 )	C12,
		DECODE( NAME, 'sorts (rows)', 					VALUE, 0 )	C13,
		DECODE( NAME, 'redo size', 					VALUE, 0 )	C14,
		DECODE( NAME, 'redo wastage', 					VALUE, 0 )	C15,
		DECODE( NAME, 'user rollbacks', 				VALUE, 0 )	C16,
		DECODE( NAME, 'transaction rollbacks', 				VALUE, 0 )	C17,
		DECODE( NAME, 'user commits', 					VALUE, 0 )	C18,
		DECODE( NAME, 'user calls', 					VALUE, 0 )	C19,
		DECODE( NAME, 'recursive calls', 				VALUE, 0 )	C20,
		DECODE( NAME, 'consistent gets', 				VALUE, 0 )	C21,
		DECODE( NAME, 'physical reads', 				VALUE, 0 )	C22,
		DECODE( NAME, 'physical reads direct', 				VALUE, 0 )	C23,
		DECODE( NAME, 'physical reads direct (lob)', 			VALUE, 0 )	C24,
		DECODE( NAME, 'parse count (total)', 				VALUE, 0 )	C25,
		DECODE( NAME, 'parse count (hard)', 				VALUE, 0 )	C26,
		DECODE( NAME, 'parse count (failures)', 			VALUE, 0 )	C27,
		DECODE( NAME, 'execute count', 					VALUE, 0 )	C28,
		DECODE( NAME, 'logons current', 				VALUE, 0 )	C29,
--		DECODE( NAME, 'logons cumulative', 				VALUE, 0 )	C29,
		DECODE( NAME, 'DDL statements parallelized', 			VALUE, 0 )	C30,
		DECODE( NAME, 'DML statements parallelized', 			VALUE, 0 )	C31,
		DECODE( NAME, 'queries parallelized', 				VALUE, 0 )	c32,
		DECODE( NAME, 'Parallel operations downgraded 1 to 25 pct', 	VALUE, 0 )	c33,
		DECODE( NAME, 'Parallel operations downgraded 25 to 50 pct', 	VALUE, 0 )	C34,
		DECODE( NAME, 'Parallel operations downgraded 50 to 75 pct', 	VALUE, 0 )	c35,
		DECODE( NAME, 'Parallel operations downgraded 75 to 99 pct', 	VALUE, 0 )	C36,
		DECODE( NAME, 'Parallel operations downgraded to serial', 	VALUE, 0 )	c37,
		DECODE( NAME, 'Parallel operations not downgraded', 		VALUE, 0 )	c38
	FROM	PERFSTAT.STATS$SYSSTAT ss,
		PERFSTAT.STATS$SNAPSHOT sn
	WHERE	ss.SNAP_ID = Sn.SNAP_ID
	AND	ss.DBID = sn.DBID
	AND	ss.INSTANCE_NUMBER= sn.INSTANCE_NUMBER
	AND	sn.INSTANCE_NUMBER= INSTANCEN
	AND	sn.snap_time >= ( to_date ( DATEDEB, 'YYYYMMDD HH24:MI' ) - (1/24) )
	AND	sn.snap_time <= to_date ( DATEFIN, 'YYYYMMDD HH24:MI' )
	) GROUP BY STIME ORDER BY STIME;

	LOOP	FETCH SRC INTO wSNAP_TIME, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20,
		C21, C22, C23, C24, C25, C26, C27, c28, c29, c30, C31, C32, C33, C34, C35, C36, C37, C38;	EXIT WHEN Src%NOTFOUND;
		v1:= C1-p1; p1:=c1; IF v1<0 OR v1 is Null THEN v1:=0; END IF;
 		v2:= c2-p2; p2:=c2; IF v2<0 OR v2 is Null THEN v2:=0; END IF;
		v3:= c3-p3; p3:=c3; IF v3<0 OR v3 is Null THEN v3:=0; END IF;
 		v4:= c4-p4; p4:=c4; IF v4<0 OR v4 is Null THEN v4:=0; END IF;
		v5:= c5-p5; p5:=c5; IF v5<0 OR v5 is Null THEN v5:=0; END IF;
		V6:= c6-p6; p6:=c6; IF v6<0 OR v6 is Null THEN v6:=0; END IF;
		V7:= c7-p7; p7:=c7; IF v7<0 OR v7 is Null THEN v7:=0; END IF;
		V8:= c8-p8; p8:=c8; IF v8<0 OR v8 is Null THEN v8:=0; END IF;
		V9:= c9-p9; p9:=c9; IF v9<0 OR v9 is Null THEN v9:=0; END IF;
		V10:= c10-p10; p10 := c10; IF v10<0 OR v10 is Null THEN v10:=0; END IF;
		V11:= c11-p11; p11 := c11; IF v11<0 OR v11 is Null THEN v11:=0; END IF;
		V12:= c12-p12; p12 := c12; IF v12<0 OR v12 is Null THEN v12:=0; END IF;
		V13:= c13-p13;	p13:= c13; IF v13<0 OR v13 is Null THEN v13:=0; END IF;
		V14:= c14-p14;	p14:= c14; IF v14<0 OR v14 is Null THEN v14:=0; END IF;
		V15:= c15-p15;	p15:= c15; IF v15<0 OR v15 is Null THEN v15:=0; END IF;
		V16:= c16-p16;	p16:= c16; IF v16<0 OR v16 is Null THEN v16:=0; END IF;
		V17:= c17-p17;	p17:= c17; IF v17<0 OR v17 is Null THEN v17:=0; END IF;
		V18:= c18-p18;	p18:= c18; IF v18<0 OR v18 is Null THEN v18:=0; END IF;
		V19:= c19-p19;	p19:= c19; IF v19<0 OR v19 is Null THEN v19:=0; END IF;
		V20:= c20-p20;	p20:= c20; IF v20<0 OR v20 is Null THEN v20:=0; END IF;
		V21:= c21-p21;	p21:= c21; IF v21<0 OR v21 is Null THEN v21:=0; END IF;
		V22:= c22-p22;	p22:= c22; IF v22<0 OR v22 is Null THEN v22:=0; END IF;
		V23:= c23-p23;	p23:= c23; IF v23<0 OR v23 is Null THEN v23:=0; END IF;
		V24:= c24-p24;	p24:= c24; IF v24<0 OR v24 is Null THEN v24:=0; END IF;
		V25:= c25-p25;	p25:= c25; IF v25<0 OR v25 is Null THEN v25:=0; END IF;
		V26:= c26-p26;	p26:= c26; IF v26<0 OR v26 is Null THEN v26:=0; END IF;
		V27:= c27-p27;	p27:= c27; IF v27<0 OR v27 is Null THEN v27:=0; END IF;
		V28:= c28-p28;	p28:= c28; IF v28<0 OR v28 is Null THEN v28:=0; END IF;
--		V29:= c29-p29;	p29:= c29; IF v29<0 OR v29 is Null THEN v29:=0; END IF;
		V29:= c29;
		V30:=c30-p30;	p30:=c30; IF v30<0 OR v30 is Null THEN v30:=0;	END IF;
		V31:=c31-p31;	p31:=c31; IF v31<0 OR v31 is Null THEN v31:=0;	END IF;
		V32:=c32-p32;	p32:=c32; IF v32<0 OR v32 is Null THEN v32:=0;	END IF;
		V33:=c33-p33;	p33:=c33; IF v33<0 OR v33 is Null THEN v33:=0;	END IF;
		V34:=c34-p34;	p34:=c34; IF v34<0 OR v34 is Null THEN v34:=0;	END IF;
		V35:=c35-p35;	p35:=c35; IF v35<0 OR v35 is Null THEN v35:=0;	END IF;
		V36:=c36-p36;	p36:=c36; IF v36<0 OR v36 is Null THEN v36:=0;	END IF;
		V37:=c37-p37;	p37:=c37; IF v37<0 OR v37 is Null THEN v37:=0;	END IF;
		V38:=c38-p38;	p38:=c38; IF v38<0 OR v38 is Null THEN v38:=0;	END IF;
		V39:=c39-p39;	p39:=c39; IF v39<0 OR v39 is Null THEN v39:=0;	END IF;

		IF wLIGNEOLD = 'xw' THEN
			wLIGNE := '"' || TO_CHAR( wSNAP_TIME, 'MM/DD/YYYY HH24:MI' )  ||
			'"  PAS "newtermite" "' || wHOST || '" "' || wINSTANCE || '"' || chr( 10 );
			IF wLIGNEOLD != wLIGNE THEN	wLIGNEOLD := wLIGNE ;		END IF;
			vSNAP_TIME := wSNAP_TIME - SNAP_TIME_OLD;
			vSNAP_TIME := ( vSNAP_TIME - trunc ( vSNAP_TIME ))*86400 ;
			SNAP_TIME_OLD := wSNAP_TIME;
		ELSE
			wLIGNE := '"' || TO_CHAR( wSNAP_TIME, 'MM/DD/YYYY HH24:MI' )  || '"  PAS "newtermite" "' ||
			wHOST || '" "' || wINSTANCE || '"' || chr( 10 );

		IF wLIGNEOLD != wLIGNE THEN	dbms_output.put_line ( wLIGNE );	wLIGNEOLD := wLIGNE ;	END IF;
		vSNAP_TIME := wSNAP_TIME - SNAP_TIME_OLD;	vSNAP_TIME := ( vSNAP_TIME - trunc ( vSNAP_TIME ))*86400 ;
		IF wSNAP_TIME >= to_date ( DATEDEB, 'YYYYMMDD HH24:MI' )  THEN	dbms_output.put_line (
			V1	|| ' ' ||	v2	|| ' ' ||	v3	|| ' ' ||	v4	|| ' ' ||	v5	|| ' ' ||
			v6	|| ' ' ||	v7	|| ' ' ||	v8	|| ' ' ||	v9	|| ' ' ||	v10	|| ' ' ||
			v11	|| ' ' ||	v12	|| ' ' ||	v13	|| ' ' ||	v14	|| ' ' ||	v15	|| ' ' ||
			v16	|| ' ' ||	v17	|| ' ' ||	v18	|| ' ' ||	v19	|| ' ' ||	v20	|| ' ' ||
			v21	|| ' ' ||	v22	|| ' ' ||	v23	|| ' ' ||	v24	|| ' ' ||	v25	|| ' ' ||
			v26	|| ' ' ||	v27   || ' ' || 	v28	|| ' ' ||	v29	|| ' ' || round(vSNAP_TIME)    || ' ' ||
			v30	|| ' ' ||	v31	|| ' ' ||	v32	|| ' ' ||	v33	|| ' ' ||	v34	|| ' ' ||
			v35	|| ' ' ||	v36	|| ' ' ||	v37	|| ' ' ||	v38	|| ' ' || chr(10 ) );	END IF;
		SNAP_TIME_OLD := wSNAP_TIME;	END IF;
	END LOOP;
END;
---------------------------------------------------------------------------------------------------------------------
procedure SGA_proc		( DATEDEB Varchar DEFAULT NULL, DATEFIN Varchar DEFAULT NULL, LSTMODE Varchar DEFAULT 'CSV',
				INSTANCE Number DEFAULT Null, ZOOM VARCHAR	DEFAULT Null )
IS	TYPE 		DataSource IS REF CURSOR;	Src 		DataSource ;	wVERSION	Varchar( 20 );
	wSNAP_TIME	Varchar( 50 );			wPGA		Number;		wPGA2		Varchar( 30 );
	CharSep 	Varchar( 5 );			wINSTANCE	Varchar( 50 );	SQL_DYN		Varchar( 2000 );
	TXT		Varchar( 1000 );		ELight		Number;		wDateLimit 	Date;
	HMIN		Varchar( 25 );			HMAX		Varchar( 25 );	wINSTANCE_NUMBER Number;
	wBUFF		Number;				wJAVA		Number;		wLARGE		Number;
	wSHARED		Number;				wSTREAMS	Number;
BEGIN	dbms_output.enable( 10000000 );
	SELECT DECODE( LSTMODE, 'CSV', ';' , 'EXTRACT', ';' , ' ' ) INTO CharSep FROM DUAL;
	select perfstat.PKG_STATS.CheckVal('PGA', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN dbms_output.put_line('    Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN; END IF;
	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;
	IF LSTMODE != 'EXTRACT' THEN	SELECT 	PKG_STATS.version INTO wVERSION FROM DUAL;
		Dbms_output.put_line ( '    Tuning : ' || wVERSION );
		Dbms_output.put_line ( '-------------------------------------------------------------------------------------------------------' );
	END IF;
	SQL_DYN := ' SELECT SNAP_TIME, INSTANCE_NUMBER, ';
	SQL_DYN := SQL_DYN || ' round( sum( DECODE( POOL, ''buffer_cache'', BYTES,  0 ) )/1024/1024    , 0 ) Buff,  ';
	SQL_DYN := SQL_DYN || ' round( sum( DECODE( POOL, ''java pool'', BYTES,  0 ) )/1024/1024       , 0 ) Java,  ';
	SQL_DYN := SQL_DYN || ' round( sum( DECODE( POOL, ''large pool'', BYTES,  0 ) )/1024/1024      , 0 ) Large, ';
	SQL_DYN := SQL_DYN || ' round( sum( DECODE( POOL, ''shared pool'', BYTES,  0 ) )/1024/1024     , 0 ) Shared, ';
	SQL_DYN := SQL_DYN || ' round( sum( DECODE( POOL, ''streams pool'', BYTES,  0 ) )/1024/1024    , 0 ) Streams  ';
	SQL_DYN := SQL_DYN || ' FROM  ';
	SQL_DYN := SQL_DYN || ' (  ';
	SQL_DYN := SQL_DYN || ' select 	To_char( SNAP_TIME, ''YYYYMMDD HH24:MI'' ) snap_TIME, ';
	SQL_DYN := SQL_DYN || ' sg.INSTANCE_NUMBER, DECODE( POOL, Null, ''buffer_cache'', POOL) POOL, SUM( BYTES) BYTES ';
	SQL_DYN := SQL_DYN || ' from perfstaT.stats$sgastat sg, ';
	SQL_DYN := SQL_DYN || ' stats$snapshot	sn ';
	SQL_DYN := SQL_DYN || ' where snap_time >= TO_DATE( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_DYN := SQL_DYN || ' AND snap_time < TO_DATE( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_DYN := SQL_DYN || ' and sg.SNAP_ID = sn.SNAP_ID ';
	IF ZOOM Is NOT Null THEN	SQL_Dyn :=  SQL_Dyn || ' and to_char( sn.snap_time, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( sn.snap_time, ''HH24:MI'' ) <= ''' || HMAX || '''';	END IF;
	SQL_DYN := SQL_DYN || ' and sg.DBID = sn.DBID ';
	SQL_DYN := SQL_DYN || ' and sg.INSTANCE_NUMBER = sn.INSTANCE_NUMBER ';
	IF INSTANCE Is not null THEN	SQL_DYN := SQL_DYN || ' AND sn.INSTANCE_NUMBER = ' || NVL( INSTANCE, 1 ) ;	END IF;
	SQL_DYN := SQL_DYN || ' and NAME NOT IN ( ''log_buffer'', ''fixed_sga'' )  ';
	SQL_DYN := SQL_DYN || ' group by To_char( SNAP_TIME, ''YYYYMMDD HH24:MI'' ),  ';
	SQL_DYN := SQL_DYN || ' sg.INSTANCE_NUMBER, DECODE( POOL, Null, ''buffer_cache'', POOL)  ';
	SQL_DYN := SQL_DYN || ' order by INSTANCE_NUMBER, POOL  ';
	SQL_DYN := SQL_DYN || ' )  ';
	SQL_DYN := SQL_DYN || ' Group By INSTANCE_NUMBER, SNAP_TIME  ';
	SQL_DYN := SQL_DYN || ' order by INSTANCE_NUMBER, SNAP_TIME ';
	dbms_output.put_line('SNAP_TIME;INSTANCE_NUMBER;BUFF;JAVA;LARGE;SHARED;STREAMS');
	OPEN Src FOR SQL_DYN;
	LOOP
		FETCH Src INTO	wSNAP_TIME, wINSTANCE_NUMBER, wBUFF, wJAVA, wLARGE, wSHARED, wSTREAMS;
		EXIT WHEN Src%NOTFOUND;
		dbms_output.put_line( wSNAP_TIME || CharSep || wINSTANCE_NUMBER ||
				CharSep || wBUFF || CharSep || wJAVA || CharSep || wLARGE || CharSep || wSHARED || CharSep || wSTREAMS );
	END LOOP;

	IF LSTMODE != 'EXTRACT' THEN
		IF INSTANCE Is NULL THEN	wINSTANCE := '1';
		ELSE	wINSTANCE := To_char( instance );	END IF;
		dbms_output.put_line( '-------------------------------------------------------------------------------------------------------' );
		dbms_output.put_line( 'Rappel de la commande:' );
		dbms_output.put_line( ' exec PERFSTAT.PKG_STATS.SGA ( ''' ||
			DATEDEB || ''', ''' ||	DATEFIN 	|| ''', ''' ||	LSTMODE || ''', ' || wINSTANCE	|| ')' );
	END IF;
	Close src;

	<<FIN>>
	Null;
END;
---------------------------------------------------------------------------------------------------------------------
procedure SGA		( DATEDEB VARCHAR DEFAULT NUll,  DATEFIN VARCHAR DEFAULT NUll, LSTMODE VARCHAR DEFAULT 'CSV',
			INSTANCE Number DEFAULT Null, ZOOM IN VARCHAR	DEFAULT Null	)
IS	NB_Ano		Number;	PARAM1	 Varchar( 2000 );	PARAM2		Varchar( 2000 );  PARAM3		Varchar( 2000 );
	PARAM4		Varchar( 2000 ); PARAM5		Varchar( 2000 ); PARAM6		Varchar( 2000 ); PARAM7		Varchar( 2000 );
	PARAM8		Varchar( 2000 ); wDATE1	Date; wDATE	Date; wCHAINE	Varchar( 50 ); wFORMAT_DATE_SORTIE	Varchar( 50 );
BEGIN	dbms_output.enable( 10000000 );
	NB_Ano := 0;		PARAM1 := Null;		PARAM2 := Null;		PARAM3 := Null;
	PARAM4 := Null;		PARAM5 := Null;		PARAM6 := Null;		PARAM7 := Null;		PARAM8 := Null;
	-- DATEDEB
	IF DATEDEB Is NULL THEN	NB_Ano := NB_Ano + 1;
		PARAM1 := 'La date de Debut doit etre renseignee ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEDEB, 'YYYYMMDD HH24:MI' ) INTO wDATE1 FROM DUAL;
		EXCEPTION WHEN OTHERS THEN	NB_Ano := NB_Ano + 1;
			PARAM1 := 'La date de Debut est INVALIDE         ( ''YYYYMMDD HH24:MI'' ) ';	END;	END IF;
	-- DATEFIN
	IF DATEFIN Is NULL THEN
		NB_Ano := NB_Ano + 1;
		PARAM2 := 'La date de Fin doit etre renseignee   ( ''YYYYMMDD HH24:MI'' ) ';
	ELSE	BEGIN	SELECT TO_DATE( DATEFIN, 'YYYYMMDD HH24:MI' ) INTO wDATE FROM DUAL;
		EXCEPTION WHEN OTHERS THEN  NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est INVALIDE           ( ''YYYYMMDD HH24:MI'' ) ';	END;
		IF (NB_Ano = 0) AND (wDATE1 > wDATE) THEN	NB_Ano := NB_Ano + 1;
			PARAM2 := 'La date de Fin est anterieure a la date de debut';	END IF;	END IF;
	-- LSTMODE
	IF LSTMODE NOT IN ('CSV', 'NORM', 'EXTRACT', 'csv', 'norm', 'extract' ) THEN	NB_Ano := NB_Ano + 1;
		PARAM3 := 'Le type de restitution ''' || LSTMODE || ''' est incorrect ( NORM/CSV/EXTRACT ) ';	END IF;
	-- INSTANCE
	-- CONCLUSION DE LA VALORISATION DES PARAMETRES
	IF NB_Ano > 0 THEN
	dbms_output.put_line( '+' || RPAD( '-', 107, '-' ) || '+' );
	dbms_output.put_line( '|  ' || RPAD( 'Report : PROCEDURE SGA : PROCEDURE Suivi SGA', 105 ) ||'|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| N°| Parametre           | Type    | Description                                                           |');
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
	dbms_output.put_line( '| 1 |  DATEDEB            | Varchar | ' || RPAD( NVL( PARAM1, 'OK ( ''' || DATEDEB || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 2 |  DATEFIN            | Varchar | ' || RPAD( NVL( PARAM2, 'OK ( ''' || DATEFIN || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 3 |  LSTMODE            | Varchar | ' || RPAD( NVL( PARAM3, 'OK ( ''' || LSTMODE || ''' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  INSTANCE           | Number  | ' || RPAD( NVL( PARAM4, 'OK ( ' || INSTANCE || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '| 4 |  ZOOM               | Varchar | ' || RPAD( NVL( PARAM5, 'OK ( ' || ZOOM || ' )' ), 70 ) || '|' );
	dbms_output.put_line( '+---+---------------------+---------+-----------------------------------------------------------------------+');
Dbms_Output.Put_Line( '  exec PERFSTAT.PKG_STATS.sGA( ''' || DATEDEB || ''', ''' || DATEFIN || ''', ''' || LSTMODE || ''', ' || To_char( INSTANCE ) || ')' );
	ELSE	IF ( PKG_STATS.CHKSTAT_EVAL('STATS$SNAPSHOT' , 'STATS$SGASTAT' ) ) > 0 THEN
			PKG_STATS.CHKSTAT( 'STATS$SNAPSHOT' , 'STATS$SGASTAT' );
		ELSE	PKG_STATS.SGA_proc( DATEDEB , DATEFIN, upper(LSTMODE), INSTANCE, ZOOM );	END IF;	END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure PROFIL_IO		( DATEDEB VARCHAR, DATEFIN VARCHAR, INSTANCE NUMBER DEFAULT 1 )
IS	TYPE 		DataSource IS REF CURSOR;	Src 		DataSource ;	SQL_Dyn		Varchar( 20000 );
	wstime		Varchar( 30 );			Number1		Number;		Number2		Number;
	Number3		Number;		Number4		Number;	Total1		Number;	Total2		Number;
	wNumber1	Number;		wNumber2	Number;	wNumber3	Number;	wNumber4	Number;
	Delta1		Number;		Delta2		Number;	Delta3		Number;	Delta4		Number;
	Delta_total1	Number;		Delta_total2	Number;	wTotal1		Number;	wTotal2		Number;
	wDELAY		Number;		wstime_old	Varchar( 30 );	TOTAL_small_IOPS	Number;	TOTAL_Large_IOPS	Number;
	TOTAL_MBPS		Number;		PCT_small_read		Number;	PCT_small_write		Number;
	PCT_Large_read		Number;		PCT_Large_write		Number;
BEGIN	dbms_output.enable ( 1000000 );
	wstime_old := Null;
	dbms_output.put_line  ( 'Snap_Time;Number of Small Reads;Number of Small Writes;Number of Large Reads;' ||
		'Number of Large Writes;Total Bytes Read;Total Bytes Written;TOTAL_small_IOPS;TOTAL_Large_IOPS;TOTAL_MBPS;' ||
		'PCT_small_read;PCT_small_write;PCT_Large_read;PCT_Large_write' );
	Open Src FOR  SELECT  to_char(SNAP_TIME,'yyyymmdd hh24:mi') Stime,
	sum(decode(name,'physical read total IO requests',value,0)- decode(name,'physical read total multi block requests',value,0)),
	sum(decode(name,'physical write total IO requests',value,0)- decode(name,'physical write total multi block requests',value,0)),
	sum(decode(name,'physical read total multi block requests',value,0)),
	sum(decode(name,'physical write total multi block requests',value,0)),
	sum(decode(name,'physical read total bytes',value,0)),
	sum(decode(name,'physical write total bytes',value,0))
	FROM perfstat.stats$sysstat sys, perfstat.stats$snapshot snap
	where sys.SNAP_ID=snap.snap_id and   sys.DBID   =snap.dbid and   sys.INSTANCE_NUMBER=snap.INSTANCE_NUMBER
	and   sys.INSTANCE_NUMBER= INSTANCE and	snap_time >= to_date ( DATEDEB , 'YYYYMMDD HH24:MI' )
	and	snap_time <= to_date ( DATEFIN , 'YYYYMMDD HH24:MI' ) group  by  to_char(SNAP_TIME,'yyyymmdd hh24:mi') order by 1;
	LOOP	FETCH Src INTO wstime, Number1, Number2, Number3, Number4, Total1, Total2 ;	EXIT WHEN Src%NOTFOUND;
		If wstime_old is not null THEN
			wDELAY := to_date( wstime, 'YYYYMMDD HH24:MI' ) - to_date( wstime_old, 'YYYYMMDD HH24:MI' );
			wDELAY := 86400*wDELAY;
			Delta1 := Number1 - wNumber1 ;		Delta2 := Number2 - wNumber2 ;
			Delta3 := Number3 - wNumber3 ;		Delta4 := Number4 - wNumber4 ;
			If Delta1 < 0 THEN Delta1 := 0; END IF;		If Delta2 < 0 THEN Delta2 := 0; END IF;
			If Delta3 < 0 THEN Delta3 := 0; END IF;		If Delta4 < 0 THEN Delta4 := 0; END IF;
			Delta_total1	:= Total1 - wTotal1;
			Delta_total2	:= Total2 - wTotal2;
			If Delta_total1 < 0 THEN Delta_total1 := 0; END IF;
			If Delta_total2 < 0 THEN Delta_total2 := 0; END IF;
			TOTAL_small_IOPS := (Delta1/wDELAY) + (Delta2/wDELAY) ;
			TOTAL_Large_IOPS := (Delta3/wDELAY) + (Delta4/wDELAY);
			TOTAL_MBPS	 := ((Delta_total1/1048576)/wDELAY) + ((Delta_total2/1048576)/wDELAY);
			IF TOTAL_small_IOPS = 0 THEN	PCT_small_read		:= 0;
				PCT_small_write		:= 0;
			ELSE	PCT_small_read		:= 100*(Delta1/wDELAY) / TOTAL_small_IOPS;
				PCT_small_write		:= 100*(Delta2/wDELAY) / TOTAL_small_IOPS;	END IF;
			IF TOTAL_Large_IOPS = 0 THEN	PCT_Large_read		:= 0;
				PCT_Large_write		:= 0;
			ELSE	PCT_Large_read		:= 100*(Delta3/wDELAY) / TOTAL_Large_IOPS;
				PCT_Large_write		:= 100*(Delta4/wDELAY) / TOTAL_Large_IOPS;	END IF;
			dbms_output.put_line  (	wstime || ';' || round( Delta1/wDELAY ) || ';' ||  round( Delta2/wDELAY ) || ';' ||
			round( Delta3/wDELAY ) || ';' || round( Delta4/wDELAY ) || ';' ||  ROUND( (Delta_total1/1048576)/wDELAY ) || ';' ||
			ROUND( (Delta_total2/1048576)/wDELAY ) || ';' || ROUND( TOTAL_small_IOPS )  || ';' ||
			ROUND( TOTAL_Large_IOPS )  || ';' || ROUND( TOTAL_MBPS       )  || ';' || ROUND( PCT_small_read   )  || ';' ||
			ROUND( PCT_small_write  )  || ';' || ROUND( PCT_Large_read   )  || ';' || ROUND( PCT_Large_write  )  || ';' );
		END IF;
		wstime_old := wstime;		wNumber1   := Number1;		wNumber2   := Number2;		wNumber3   := Number3;
		wNumber4   := Number4;		wTotal1	   := Total1;		wTotal2	   := Total2;
	END LOOP;
	Close Src;
END;
---------------------------------------------------------------------------------------------------------------------
Function Info_Carto( 	wEVENT in VARCHAR , PARAM In VARCHAR DEFAULT 'RUBRIQUE', IDLE	Varchar DEFAULT 'N' )  return varchar
Is	wCHAMP 	VARCHAR( 200 );	i	Number;
BEGIN	Dbms_Output.enable( 100000000 );

SELECT DECODE( wEVENT,
'ARCH random i/o', 			'DISK_IO;SYSTEM_IO;',	'ARCH sequential i/o',			'DISK_IO;SYSTEM_IO;',
'ARCH wait for pending I/Os', 		'DISK_IO;SYSTEM_IO;',	'async disk IO', 			'DISK_IO;SYSTEM_IO;',
'control file parallel write',		'DISK_IO;SYSTEM_IO;',	'control file sequential read', 	'DISK_IO;SYSTEM_IO;',
'control file single write', 		'DISK_IO;SYSTEM_IO;',	'db file parallel write', 		'DISK_IO;SYSTEM_IO;',
'io done', 				'DISK_IO;SYSTEM_IO;',	'kfk: async disk IO', 			'DISK_IO;SYSTEM_IO;',
'ksfd: async disk IO', 			'DISK_IO;SYSTEM_IO;',	'kst: async disk IO', 			'DISK_IO;SYSTEM_IO;',
'LGWR random i/o', 			'DISK_IO;SYSTEM_IO;',	'LGWR sequential i/o', 			'DISK_IO;SYSTEM_IO;',
'LNS ASYNC control file txn', 		'DISK_IO;SYSTEM_IO;',	'Log archive I/O', 			'DISK_IO;SYSTEM_IO;',
'log file parallel write', 		'DISK_IO;SYSTEM_IO;',	'log file sequential read', 		'DISK_IO;SYSTEM_IO;',
'log file single write', 		'DISK_IO;SYSTEM_IO;',	'recovery read', 			'DISK_IO;SYSTEM_IO;',
'RFS random i/o', 			'DISK_IO;SYSTEM_IO;',	'RFS sequential i/o', 			'DISK_IO;SYSTEM_IO;',
'RFS write', 				'DISK_IO;SYSTEM_IO;',	'RMAN backup  recovery I/O', 		'DISK_IO;SYSTEM_IO;',
'Standby redo I/O', 			'DISK_IO;SYSTEM_IO;',	'BFILE read', 				'DISK_IO;USER_IO;',
'buffer read retry', 			'DISK_IO;USER_IO;',	'Data file init write', 		'DISK_IO;USER_IO;',
'Datapump dump file I/O', 		'DISK_IO;USER_IO;',	'db file parallel read', 		'DISK_IO;USER_IO;',
'db file scattered read', 		'DISK_IO;USER_IO;',	'db file sequential read', 		'DISK_IO;USER_IO;',
'db file single write', 		'DISK_IO;USER_IO;',	'dbms_file_transfer I/O', 		'DISK_IO;USER_IO;',
'DG Broker configuration file I/O', 	'DISK_IO;USER_IO;',	'direct path read', 			'DISK_IO;USER_IO;',
'direct path read (lob) ', 		'DISK_IO;USER_IO;',	'direct path read temp', 		'DISK_IO;USER_IO;',
'direct path write', 			'DISK_IO;USER_IO;',	'direct path write (lob)', 		'DISK_IO;USER_IO;',
'direct path write temp', 		'DISK_IO;USER_IO;',	'local write wait', 			'DISK_IO;USER_IO;',
'Log file init write', 			'DISK_IO;USER_IO;',	'read by other session', 		'DISK_IO;USER_IO;',
'refresh controlfile command', 		'LATENCY;AUTRES;',	'log file sync', 			'LATENCY;COMMITS;',
'file open', 				'LATENCY;FILE_OPS;',	'ARCH wait for flow-control', 		'LATENCY;NETWORK;',
'ARCH wait for net re-connect', 	'LATENCY;NETWORK;',	'ARCH wait for netserver detach', 	'LATENCY;NETWORK;',
'ARCH wait for netserver init 1', 	'LATENCY;NETWORK;',	'ARCH wait for netserver init 2', 	'LATENCY;NETWORK;',
'ARCH wait for netserver start', 	'LATENCY;NETWORK;',	'Nothing.' ) INTO wCHAMP  from dual;
	If wCHAMP = 'Nothing.' THEN 		SELECT DECODE( wEVENT,
'ARCH wait on ATTACH', 			'LATENCY;NETWORK;',	'ARCH wait on DETACH', 			'LATENCY;NETWORK;',
'ARCH wait on SENDREQ', 		'LATENCY;NETWORK;',	'dedicated server timer', 		'LATENCY;NETWORK;',
'dispatcher listen timer', 		'LATENCY;NETWORK;',	'LGWR wait on ATTACH', 			'LATENCY;NETWORK;',
'LGWR wait on DETACH', 			'LATENCY;NETWORK;',	'LGWR wait on LNS', 			'LATENCY;NETWORK;',
'LGWR wait on SENDREQ', 		'LATENCY;NETWORK;',	'LNS wait on ATTACH', 			'LATENCY;NETWORK;',
'LNS wait on DETACH', 			'LATENCY;NETWORK;',	'LNS wait on LGWR', 			'LATENCY;NETWORK;',
'LNS wait on SENDREQ', 			'LATENCY;NETWORK;',	'SQL*Net message from dblink', 		'LATENCY;NETWORK;',
'SQL*Net message to client', 		'LATENCY;NETWORK;',	'SQL*Net message to dblink', 		'LATENCY;NETWORK;',
'SQL*Net more data from client', 	'LATENCY;NETWORK;',	'SQL*Net more data from dblink', 	'LATENCY;NETWORK;',
'SQL*Net more data to client', 		'LATENCY;NETWORK;',	'SQL*Net more data to dblink', 		'LATENCY;NETWORK;',
'TCP Socket (KGAS)', 			'LATENCY;NETWORK;',	'process startup', 			'LATENCY;PROCESS_CTL;',
'PX Deq: Join ACK', 			'LATENCY;PROCESS_CTL;',	'PX Deq: Msg Fragment', 		'LATENCY;PROCESS_CTL;',
'PX qref latch', 			'LATENCY;PROCESS_CTL;',
'alter rbs offline', 			'WAITS;ADMINISTRATIVE;',	'alter system set dispatcher', 	'WAITS;ADMINISTRATIVE;',
'ASM COD rollback operation completion', 'WAITS;ADMINISTRATIVE;',	'ASM mount : wait for heartbeat', 	'WAITS;ADMINISTRATIVE;',
'Backup: sbtbackup', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtclose', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtclose2', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtcommand', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtend', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbterror', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtinfo', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtinfo2', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtinit', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtinit2', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtopen', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtpcbackup', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtpccancel', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtpccommit', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtpcend', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtpcquerybackup', 	'WAITS;ADMINISTRATIVE;',
'Backup: sbtpcqueryrestore',		'WAITS;ADMINISTRATIVE;',	'Backup: sbtpcrestore', 	'WAITS;ADMINISTRATIVE;',
'Backup: sbtpcstart', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtpcstatus', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtpcvalidate', 		'WAITS;ADMINISTRATIVE;',	'Backup: sbtread', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtread2', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtremove', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtremove2', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtrestore', 		'WAITS;ADMINISTRATIVE;',
'Backup: sbtwrite', 			'WAITS;ADMINISTRATIVE;',	'Backup: sbtwrite2', 		'WAITS;ADMINISTRATIVE;',
'buffer pool resize', 			'WAITS;ADMINISTRATIVE;',	'enq: DB - contention', 	'WAITS;ADMINISTRATIVE;',
'Nothing.' ) INTO wCHAMP  from dual;	END IF;	  If wCHAMP = 'Nothing.' THEN 	SELECT DECODE( wEVENT,
'enq: TW - contention', 		'WAITS;ADMINISTRATIVE;',	'enq: ZG - contention', 	'WAITS;ADMINISTRATIVE;',
'index (re)build online cleanup',	'WAITS;ADMINISTRATIVE;',	'index (re)build online merge', 'WAITS;ADMINISTRATIVE;',
'index (re)build online start',		'WAITS;ADMINISTRATIVE;',	'JS coord start wait', 		'WAITS;ADMINISTRATIVE;',
'JS kgl get object wait', 		'WAITS;ADMINISTRATIVE;',	'JS kill job wait', 		'WAITS;ADMINISTRATIVE;',
'multiple dbwriter suspend/resume for file offline', 			'WAITS;ADMINISTRATIVE;',
'switch logfile command', 		'WAITS;ADMINISTRATIVE;',	'switch undo - offline', 	'WAITS;ADMINISTRATIVE;',
'wait for possible quiesce finish', 	'WAITS;ADMINISTRATIVE;',	'enq: KO - fast object checkpoint', 'WAITS;APPLICATION;',
'enq: PW - flush prewarm buffers', 	'WAITS;APPLICATION;',		'enq: RO - contention', 	'WAITS;APPLICATION;',
'enq: RO - fast object reuse', 		'WAITS;APPLICATION;',		'enq: TM - contention', 	'WAITS;APPLICATION;',
'enq: TX - row lock contention', 	'WAITS;APPLICATION;',		'enq: UL - contention', 	'WAITS;APPLICATION;',
'SQL*Net break/reset to client', 	'WAITS;APPLICATION;',		'SQL*Net break/reset to dblink', 'WAITS;APPLICATION;',
'Streams capture: filter callback waiting for ruleset', 'WAITS;APPLICATION;',
'Streams: apply reader waiting for DDL to apply', 	'WAITS;APPLICATION;',
'Wait for Table Lock', 			'WAITS;APPLICATION;',		'log file switch (clearing log file)', 'WAITS;CHECKPOINT;',
'log file switch/archive', 		'WAITS;CHECKPOINT;',		'log switch/archive', 		'WAITS;CHECKPOINT;',
'ASM PST query : wait for [PM][grp][0] grant', 	'WAITS;CLUSTER_WAIT;',	'gc assume', 			'WAITS;CLUSTER_WAIT;',
'gc block recovery request', 		'WAITS;CLUSTER_WAIT;',		'gc buffer busy', 		'WAITS;CLUSTER_WAIT;',
'gc claim', 				'WAITS;CLUSTER_WAIT;',		'gc cr block 2-way', 		'WAITS;CLUSTER_WAIT;',
'gc cr block 3-way', 			'WAITS;CLUSTER_WAIT;',		'gc cr block busy', 		'WAITS;CLUSTER_WAIT;',
'gc cr block congested', 		'WAITS;CLUSTER_WAIT;',		'gc cr block lost', 		'WAITS;CLUSTER_WAIT;',
'gc cr block unknown', 			'WAITS;CLUSTER_WAIT;',		'gc cr cancel', 		'WAITS;CLUSTER_WAIT;',
'gc cr disk read', 			'WAITS;CLUSTER_WAIT;',		'gc cr disk request', 		'WAITS;CLUSTER_WAIT;',
'gc cr failure', 			'WAITS;CLUSTER_WAIT;',		'gc cr grant 2-way', 		'WAITS;CLUSTER_WAIT;',
'gc cr grant busy', 			'WAITS;CLUSTER_WAIT;',		'gc cr grant congested', 	'WAITS;CLUSTER_WAIT;',
'gc cr grant unknown', 			'WAITS;CLUSTER_WAIT;',		'gc cr multi block request', 	'WAITS;CLUSTER_WAIT;',
'gc cr request', 			'WAITS;CLUSTER_WAIT;',		'gc current block 2-way', 	'WAITS;CLUSTER_WAIT;',
'gc current block 3-way', 		'WAITS;CLUSTER_WAIT;',		'gc current block busy', 	'WAITS;CLUSTER_WAIT;',
'gc current block congested', 		'WAITS;CLUSTER_WAIT;',		'gc current block lost', 	'WAITS;CLUSTER_WAIT;',
'gc current block unknown', 		'WAITS;CLUSTER_WAIT;',		'gc current cancel', 		'WAITS;CLUSTER_WAIT;',
'gc current grant 2-way', 		'WAITS;CLUSTER_WAIT;',		'gc current grant busy', 	'WAITS;CLUSTER_WAIT;',
'gc current grant congested', 		'WAITS;CLUSTER_WAIT;',		'gc current grant unknown', 	'WAITS;CLUSTER_WAIT;',
'gc current multi block request', 	'WAITS;CLUSTER_WAIT;',		'gc current request', 		'WAITS;CLUSTER_WAIT;',
'gc current retry', 			'WAITS;CLUSTER_WAIT;',		'gc current split', 		'WAITS;CLUSTER_WAIT;',
'gc domain validation', 		'WAITS;CLUSTER_WAIT;',		'gc freelist', 			'WAITS;CLUSTER_WAIT;',
'gc prepare', 				'WAITS;CLUSTER_WAIT;',		'gc quiesce wait', 		'WAITS;CLUSTER_WAIT;',
'gc recovery free', 			'WAITS;CLUSTER_WAIT;',		'gc recovery quiesce', 		'WAITS;CLUSTER_WAIT;',
'gc remaster', 				'WAITS;CLUSTER_WAIT;',		'lock remastering', 		'WAITS;CLUSTER_WAIT;',
'pi renounce write complete', 		'WAITS;CLUSTER_WAIT;',	'retry contact SCN lock master', 	'WAITS;CLUSTER_WAIT;',
'Streams: RAC waiting for inter instance ack', 'WAITS;CLUSTER_WAIT;', 'Nothing.' ) INTO wCHAMP  from dual;	END IF;
If wCHAMP = 'Nothing.' THEN
SELECT DECODE( wEVENT, 'buffer busy waits', 'WAITS;CONCURRENCE;',  'cursor: mutex S', 			'WAITS;CONCURRENCE;',
'cursor: mutex X', 			'WAITS;CONCURRENCE;',	'cursor: pin S wait on X', 		'WAITS;CONCURRENCE;',
'enq: TX - index contention', 		'WAITS;CONCURRENCE;',	'latch: cache buffers chains',		'WAITS;CONCURRENCE;',
'latch: In memory undo latch',		'WAITS;CONCURRENCE;',	'latch: undo global data',		'WAITS;CONCURRENCE;',
'latch: library cache', 		'WAITS;CONCURRENCE;',	'latch: library cache lock',		'WAITS;CONCURRENCE;',
'latch: library cache pin',		'WAITS;CONCURRENCE;',	'latch: MQL Tracking Latch',		'WAITS;CONCURRENCE;',
'latch: row cache objects',		'WAITS;CONCURRENCE;',	'latch: shared pool',			'WAITS;CONCURRENCE;',
'latch: Undo Hint Latch',		'WAITS;CONCURRENCE;',	'library cache load lock',		'WAITS;CONCURRENCE;',
'library cache lock',			'WAITS;CONCURRENCE;',	'library cache pin',			'WAITS;CONCURRENCE;',
'os thread startup', 			'WAITS;CONCURRENCE;',	'pipe put', 				'WAITS;CONCURRENCE;',
'resmgr:internal state change',		'WAITS;CONCURRENCE;',	'resmgr:internal state cleanup',	'WAITS;CONCURRENCE;',
'resmgr:sessions to exit',		'WAITS;CONCURRENCE;',	'row cache lock', 			'WAITS;CONCURRENCE;',
'row cache read', 			'WAITS;CONCURRENCE;',	'checkpoint completed', 		'WAITS;CONFIGURATION;',
'enq: HW - contention', 		'WAITS;CONFIGURATION;',	'enq: SQ - contention', 		'WAITS;CONFIGURATION;',
'enq: SS - contention', 		'WAITS;CONFIGURATION;',	'enq: ST - contention', 		'WAITS;CONFIGURATION;',
'enq: TX - allocate ITL entry', 	'WAITS;CONFIGURATION;',	'free buffer waits', 			'WAITS;CONFIGURATION;',
'latch: redo copy', 			'WAITS;CONFIGURATION;',	'latch: redo writing', 			'WAITS;CONFIGURATION;',
'log buffer space', 			'WAITS;CONFIGURATION;',	'log file switch (archiving needed)', 	'WAITS;CONFIGURATION;',
'log file switch (checkpoint incomplete)', 'WAITS;CONFIGURATION;',  'log file switch (private strand flush incomplete)', 'WAITS;CONFIGURATION;',
'log file switch completion', 'WAITS;CONFIGURATION;', 'sort segment request', 'WAITS;CONFIGURATION;',
'statement suspended, wait error to be cleared', 'WAITS;CONFIGURATION;', 'Streams AQ: enqueue blocked on low memory', 'WAITS;CONFIGURATION;',
'Streams capture: resolve low memory condition', 'WAITS;CONFIGURATION;',
'Streams capture: waiting for subscribers to catch up', 'WAITS;CONFIGURATION;',
'undo segment extension', 		'WAITS;CONFIGURATION;',	'undo segment tx slot', 		'WAITS;CONFIGURATION;',
'wait for EMON to process ntfns', 	'WAITS;CONFIGURATION;',	'write complete waits', 		'WAITS;CONFIGURATION;',
'enqueue', 				'WAITS;ENQUEUE_LOCK;',	'ksbsrv', 				'WAITS;ENQUEUE_LOCK;',
'reliable message', 			'WAITS;ENQUEUE_LOCK;',	'LGWR wait for redo copy', 		'WAITS;LGWR_WRITES;',
'latch free', 				'WAITS;OTHER_LOCKS;',	'rdbms ipc reply', 			'WAITS;OTHER_LOCKS;',
'wait list latch free', 		'WAITS;OTHER_LOCKS;',	'PX Deq: Parse Reply', 			'WAITS;QUERY_WAITS;',
'PX Deq: Table Q Get Keys', 		'WAITS;QUERY_WAITS;',	'PX Deq: Table Q qref', 		'WAITS;QUERY_WAITS;',
'PX Deq: Table Q Sample', 		'WAITS;QUERY_WAITS;',	'resmgr:become active', 		'WAITS;SCHEDULER;',
'resmgr:cpu quantum', 			'WAITS;SCHEDULER;',	'kksfbc child completion', 		'WAITS;SHARED_POOL;',
'recursive cpu usage', 			'CPU;RECURSIVE;',	'parse time cpu', 			'CPU;PARSE;',
'CPU used by this session', 		'CPU;USED;',		'ksu process alloc latch yield', 	'WAITS;CONFIGURATION;',
'wait for MTTR advisory state object', 	'WAITS;ALERTE ANOMALIE;', 'enq: WF - contention', 		'WAITS;ALERTE ANOMALIE;',
'virtual circuit wait', 		'LATENCY;NETWORK;',	'enq: US - contention', 		'WAITS;CONFIGURATION;',
'Nothing.' ) INTO wCHAMP  from dual;	END IF;
-- Ajout Evenements Temps de service ENQUEUE
If wCHAMP = 'Nothing.' THEN SELECT DECODE( wEVENT,
'enq: AD - allocate AU', 		'WAITS;ENQUEUES;',	'enq: AD - deallocate AU', 		'WAITS;ENQUEUES;',
'enq: AF - task serialization', 	'WAITS;ENQUEUES;',	'enq: AG - contention', 		'WAITS;ENQUEUES;',
'enq: AO - contention', 		'WAITS;ENQUEUES;',	'enq: AS - contention', 		'WAITS;ENQUEUES;',
'enq: AT - contention', 		'WAITS;ENQUEUES;',	'enq: AW - AW generation lock', 	'WAITS;ENQUEUES;',
'enq: AW - AW state lock', 		'WAITS;ENQUEUES;',	'enq: AW - AW$ table lock', 		'WAITS;ENQUEUES;',
'enq: AW - user access for AW', 	'WAITS;ENQUEUES;',	'enq: BR - file shrink', 		'WAITS;ENQUEUES;',
'enq: BR - proxy-copy', 		'WAITS;ENQUEUES;',	'enq: CF - contention', 		'WAITS;ENQUEUES;',
'enq: CI - contention', 		'WAITS;ENQUEUES;',	'enq: CL - compare labels', 		'WAITS;ENQUEUES;',
'enq: CL - drop label', 		'WAITS;ENQUEUES;',	'enq: CM - gate', 			'WAITS;ENQUEUES;',
'enq: CM - instance', 			'WAITS;ENQUEUES;',	'enq: CT - change stream ownership', 	'WAITS;ENQUEUES;',
'enq: CT - CTWR process start/stop', 	'WAITS;ENQUEUES;',	'enq: CT - global space management', 	'WAITS;ENQUEUES;',
'enq: CT - local space management', 	'WAITS;ENQUEUES;',	'enq: CT - reading', 			'WAITS;ENQUEUES;',
'enq: CT - state change gate 1', 	'WAITS;ENQUEUES;',	'enq: CT - state change gate 2', 	'WAITS;ENQUEUES;',
'enq: CT - state', 			'WAITS;ENQUEUES;',	'enq: CU - contention', 		'WAITS;ENQUEUES;',
'enq: DD - contention', 		'WAITS;ENQUEUES;',	'enq: DF - contention', 		'WAITS;ENQUEUES;',
'enq: DG - contention', 		'WAITS;ENQUEUES;',	'enq: DL - contention', 		'WAITS;ENQUEUES;',
'enq: DM - contention',	 		'WAITS;ENQUEUES;',	'enq: DN - contention', 		'WAITS;ENQUEUES;',
'enq: DP - contention', 		'WAITS;ENQUEUES;',	'enq: DR - contention', 		'WAITS;ENQUEUES;',
'enq: DS - contention', 		'WAITS;ENQUEUES;',	'enq: DT - contention', 		'WAITS;ENQUEUES;',
'enq: DV - contention', 		'WAITS;ENQUEUES;',	'enq: DX - contention', 		'WAITS;ENQUEUES;',
'enq: FA - access file',	 	'WAITS;ENQUEUES;',	'enq: FB - contention', 		'WAITS;ENQUEUES;',
'enq: FC - open an ACD thread', 	'WAITS;ENQUEUES;',	'enq: FC - recover an ACD thread', 	'WAITS;ENQUEUES;',
'enq: FD - Flashback coordinator', 	'WAITS;ENQUEUES;',	'enq: FD - Flashback on/off', 		'WAITS;ENQUEUES;',
'enq: FD - Marker generation', 		'WAITS;ENQUEUES;',	'enq: FD - Tablespace flashback on/off', 'WAITS;ENQUEUES;',
'enq: FG - FG redo generation enq race', 'WAITS;ENQUEUES;',	'enq: FG - LGWR redo generation enq race', 'WAITS;ENQUEUES;',
'enq: FG - serialize ACD relocate', 	'WAITS;ENQUEUES;',	'enq: FL - Flashback database log', 	'WAITS;ENQUEUES;',
'enq: FL - Flashback db command', 	'WAITS;ENQUEUES;',	'enq: FM - contention', 		'WAITS;ENQUEUES;',
'enq: FR - contention', 		'WAITS;ENQUEUES;',	'enq: FS - contention', 		'WAITS;ENQUEUES;',
'enq: FT - allow LGWR writes', 		'WAITS;ENQUEUES;',	'enq: FT - disable LGWR writes', 	'WAITS;ENQUEUES;',
'enq: FU - contention', 		'WAITS;ENQUEUES;',	'enq: HD - contention', 		'WAITS;ENQUEUES;',
'enq: HP - contention', 		'WAITS;ENQUEUES;',	'enq: HQ - contention', 		'WAITS;ENQUEUES;',
'enq: HV - contention', 		'WAITS;ENQUEUES;',	'enq: IA - contention', 		'WAITS;ENQUEUES;',
'enq: ID - contention', 		'WAITS;ENQUEUES;',	'enq: IL - contention', 		'WAITS;ENQUEUES;',
'enq: IM - contention for blr', 	'WAITS;ENQUEUES;',	'Nothing.' ) INTO wCHAMP  from dual;	END IF;
If wCHAMP = 'Nothing.' THEN SELECT DECODE( wEVENT,
'enq: IR - contention', 		'WAITS;ENQUEUES;',	'enq: IR - contention2', 		'WAITS;ENQUEUES;',
'enq: IS - contention', 		'WAITS;ENQUEUES;',	'enq: IT - contention', 		'WAITS;ENQUEUES;',
'enq: JD - contention', 		'WAITS;ENQUEUES;',	'enq: JI - contention', 		'WAITS;ENQUEUES;',
'enq: JQ - contention', 		'WAITS;ENQUEUES;',	'enq: JS - contention', 		'WAITS;ENQUEUES;',
'enq: JS - coord post lock', 		'WAITS;ENQUEUES;',	'enq: JS - coord rcv lock', 		'WAITS;ENQUEUES;',
'enq: JS - global wdw lock', 		'WAITS;ENQUEUES;',	'enq: JS - job chain evaluate lock', 	'WAITS;ENQUEUES;',
'enq: JS - job recov lock', 		'WAITS;ENQUEUES;',	'enq: JS - job run lock - synchronize', 'WAITS;ENQUEUES;',
'enq: JS - q mem clnup lck', 		'WAITS;ENQUEUES;',	'enq: JS - queue lock', 		'WAITS;ENQUEUES;',
'enq: JS - running job cnt lock', 	'WAITS;ENQUEUES;',	'enq: JS - running job cnt lock2', 	'WAITS;ENQUEUES;',
'enq: JS - running job cnt lock3', 	'WAITS;ENQUEUES;',	'enq: JS - slave enq get lock1', 	'WAITS;ENQUEUES;',
'enq: JS - slave enq get lock2', 	'WAITS;ENQUEUES;',	'enq: KK - context', 			'WAITS;ENQUEUES;',
'enq: KM - contention', 		'WAITS;ENQUEUES;',	'enq: KP - contention', 		'WAITS;ENQUEUES;',
'enq: KT - contention', 		'WAITS;ENQUEUES;',	'enq: MD - contention', 		'WAITS;ENQUEUES;',
'enq: MH - contention', 		'WAITS;ENQUEUES;',	'enq: ML - contention', 		'WAITS;ENQUEUES;',
'enq: MN - contention', 		'WAITS;ENQUEUES;',	'enq: MR - contention', 		'WAITS;ENQUEUES;',
'enq: MS - contention', 		'WAITS;ENQUEUES;',	'enq: MW - contention', 		'WAITS;ENQUEUES;',
'enq: OC - contention', 		'WAITS;ENQUEUES;',	'enq: OL - contention', 		'WAITS;ENQUEUES;',
'enq: OQ - xsoq*histrecb', 		'WAITS;ENQUEUES;',	'enq: OQ - xsoqhiAlloc', 		'WAITS;ENQUEUES;',
'enq: OQ - xsoqhiClose', 		'WAITS;ENQUEUES;',	'enq: OQ - xsoqhiFlush', 		'WAITS;ENQUEUES;',
'enq: OQ - xsoqhistrecb', 		'WAITS;ENQUEUES;',	'enq: PD - contention', 		'WAITS;ENQUEUES;',
'enq: PE - contention', 		'WAITS;ENQUEUES;',	'enq: PF - contention', 		'WAITS;ENQUEUES;',
'enq: PG - contention', 		'WAITS;ENQUEUES;',	'enq: PH - contention', 		'WAITS;ENQUEUES;',
'enq: PI - contention', 		'WAITS;ENQUEUES;',	'enq: PL - contention', 		'WAITS;ENQUEUES;',
'enq: PR - contention', 		'WAITS;ENQUEUES;',	'enq: PS - contention', 		'WAITS;ENQUEUES;',
'enq: PT - contention', 		'WAITS;ENQUEUES;',	'enq: PV - syncshut', 			'WAITS;ENQUEUES;',
'enq: PV - syncstart', 			'WAITS;ENQUEUES;',	'enq: PW - prewarm status in dbw0', 	'WAITS;ENQUEUES;',
'enq: RB - contention:', 		'WAITS;ENQUEUES;',	'enq: RF - atomicity', 			'WAITS;ENQUEUES;',
'enq: RF - new AI', 			'WAITS;ENQUEUES;',	'enq: RF - synch: per-SGA Broker metadata', 'WAITS;ENQUEUES;',
'enq: RF - synchronization: aifo master', 'WAITS;ENQUEUES;',	'enq: RF - synchronization: chief', 	'WAITS;ENQUEUES;',
'enq: RF - synchronization: critical ai', 'WAITS;ENQUEUES;',	'enq: RF - synchronization: HC master', 'WAITS;ENQUEUES;',
'enq: RN - contention', 		'WAITS;ENQUEUES;',	'enq: RP - contention', 		'WAITS;ENQUEUES;',
'enq: RS - file delete', 		'WAITS;ENQUEUES;',	'enq: RS - persist alert level', 	'WAITS;ENQUEUES;',
'enq: RS - prevent aging list update', 	'WAITS;ENQUEUES;',	'enq: RS - prevent file delete', 	'WAITS;ENQUEUES;',
'enq: RS - read alert level', 		'WAITS;ENQUEUES;',	'enq: RS - record reuse', 		'WAITS;ENQUEUES;',
'enq: RS - write alert level', 		'WAITS;ENQUEUES;',	'enq: RT - contention', 		'WAITS;ENQUEUES;',
'enq: SB - contention', 		'WAITS;ENQUEUES;',	'enq: SF - contention', 		'WAITS;ENQUEUES;',
'enq: SH - contention', 		'WAITS;ENQUEUES;',	'enq: SI - contention', 		'WAITS;ENQUEUES;',
'enq: SK - contention', 		'WAITS;ENQUEUES;',	'enq: SR - contention', 		'WAITS;ENQUEUES;',
'enq: SU - contention', 		'WAITS;ENQUEUES;',	'enq: SW - contention', 		'WAITS;ENQUEUES;',
'enq: TA - contention', 		'WAITS;ENQUEUES;',	'enq: TB - SQL Tuning Base Cache Load', 'WAITS;ENQUEUES;',
'enq: TB - SQL Tuning Base Cache Update', 'WAITS;ENQUEUES;',	'enq: TC - contention', 		'WAITS;ENQUEUES;',
'enq: TC - contention2', 		'WAITS;ENQUEUES;',	'enq: TD - KTF dump entries', 		'WAITS;ENQUEUES;',
'enq: TE - KTF broadcast', 		'WAITS;ENQUEUES;',	'enq: TF - contention', 		'WAITS;ENQUEUES;',
'enq: TL - contention', 		'WAITS;ENQUEUES;',	'enq: TO - contention', 		'WAITS;ENQUEUES;',
'enq: TQ - DDL contention', 		'WAITS;ENQUEUES;',	'enq: TQ - INI contention', 		'WAITS;ENQUEUES;',
'enq: TQ - TM contention', 		'WAITS;ENQUEUES;',	'enq: TS - contention', 		'WAITS;ENQUEUES;',
'enq: TT - contention', 		'WAITS;ENQUEUES;',	'enq: TX - contention', 		'WAITS;ENQUEUES;',
'enq: WA - contention', 		'WAITS;ENQUEUES;',	'enq: WL - contention', 		'WAITS;ENQUEUES;',
'enq: WP - contention', 		'WAITS;ENQUEUES;',	'enq: XH - contention', 		'WAITS;ENQUEUES;',
'enq: XR - database force logging', 	'WAITS;ENQUEUES;',	'enq: XR - quiesce database', 		'WAITS;ENQUEUES;',
'enq: XY - contention', 		'WAITS;ENQUEUES;',	'Nothing.' ) INTO wCHAMP  from dual;	END IF;
IF IDLE	 = 'Y' THEN IF wCHAMP = 'Nothing.' THEN	wCHAMP := 'IDLE;MISC;MISC'; ELSE wCHAMP := 'HORS PERIMETRE'; END IF; END IF;
	If wCHAMP <> 'Nothing.'   THEN
		If PARAM = 'RUBRIQUE' THEN	wCHAMP := substr( wCHAMP, 1, Instr( wCHAMP, ';' ) -1 );		RETURN wCHAMP ;
		ELSIF PARAM = 'SRUBRIQUE' THEN	wCHAMP := substr( wCHAMP, Instr( wCHAMP, ';' ) +1 , 999 );
			wCHAMP := substr( wCHAMP, 1, Instr( wCHAMP, ';' ) -1 );					RETURN wCHAMP ;
		ELSIF PARAM = 'ALIAS' THEN	wCHAMP := substr( wCHAMP, Instr( wCHAMP, ';' ) +1 , 999 );
			wCHAMP := substr( wCHAMP, Instr( wCHAMP, ';' ) +1 , 999 );	wCHAMP := substr( wCHAMP, 1, 9999 );
			RETURN wCHAMP ;		END IF;
	ELSE	RETURN 'HORS PERIMETRE';  END IF;
EXCEPTION WHEN OTHERS THEN	Dbms_Output.put_line ( 'wCHAMP:' || wCHAMP );	Return ( 'HORS PERIMETRE' );  END;
---------------------------------------------------------------------------------------------------------------------
function XLS_VAL( Valeur IN varchar ) return Varchar	IS	i	number;	ReturnV	varchar( 100 );
BEGIN	dbms_output.enable( 10000000 );
        i:= 3 ;
	IF i < ( (14200*17295)+110+380 )
	THEN   select instr( Valeur, '.', 1 ) into i from dual;
        if i > 0
then	ReturnV := substr( Valeur, 1, i-1 ) || ',' ||
	substr( Valeur, i+1, 9999 );
ELSE	ReturnV := Valeur;	END IF;	END IF;	RETURN(  ReturnV );	END;
---------------------------------------------------------------------------------------------------------------------
function AAS   ( DATE_INFO Varchar DEFAULT Null, INST_NUMBER Number  DEFAULT 1 ) RETURN Number
IS	TYPE 		DataSource IS REF CURSOR;	Src 		DataSource ;	Src2 		DataSource ;	CPU_COUNT	Number;
	wSNAP_ID 	Number;				wSNAP_TIME	DATE;		wSNAP_TIME_OLD	DATE;		wTIME_WAITED_MICRO Number;
	wVALUE		Number;		wTIME_WAITED_MICRO_OLD	Number;	wVALUE_OLD	Number;		C1	Number;
	C2		Number;		C3		Number;		C4		Number;		C5	Number;
	C6		Number;		RVALUE		Number;		DATEDEB		Varchar( 50 );
	DATE_INFO_	Varchar( 50 );	DATEFIN		Varchar( 50 );	oVersion	Number;		SQL_Dyn	Varchar( 5000 );
BEGIN	dbms_output.enable( 10000000 );
	wTIME_WAITED_MICRO_OLD	:= Null;	wVALUE_OLD		:= Null;
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;

	IF DATE_INFO IS null THEN  select  to_char( max( snap_time ), 'YYYYMMDD HH24:MI' ) INTO DATE_INFO_ from stats$snapshot
		WHERE	INSTANCE_NUMBER = INST_NUMBER;	ELSE	DATE_INFO_ := DATE_INFO;	END IF;
	select to_char( to_date( DATE_INFO_ , 'YYYYMMDD HH24:MI' )- .1,  'YYYYMMDD HH24:MI' )  INTO DATEDEB from dual;
	select to_char( to_date( DATE_INFO_ , 'YYYYMMDD HH24:MI' )+ .1,  'YYYYMMDD HH24:MI' )  INTO DATEFIN from dual;
	select value INTO CPU_COUNT from v$parameter where name ='cpu_count';

	OPEN Src for  SELECT SNAP_ID, SNAP_TIME FROM stats$snapshot where snap_time >= to_date( DATEDEB, 'YYYYMMDD HH24:MI' )
	and	snap_time <= to_date( DATEFIN, 'YYYYMMDD HH24:MI' ) and	INSTANCE_NUMBER= INST_NUMBER order by SNAP_ID ;
	LOOP 	FETCH Src INTO wSNAP_ID, wSNAP_TIME;	EXIT WHEN Src%NOTFOUND;

		-- Recherche du WAIT TIME en fonction de la version ORACLE
		IF Oversion = 8 	THEN		SQL_Dyn := ' select sum( TIME_WAITED)/1000 ' ;
			SQL_Dyn := SQL_Dyn || ' from stats$system_event ';
			SQL_Dyn := SQL_Dyn || ' where 	snap_id = ' || wSNAP_ID;
			SQL_Dyn := SQL_Dyn || ' AND INSTANCE_NUMBER = ' || INST_NUMBER ;
			SQL_Dyn := SQL_Dyn || ' AND PERFSTAT.PKG_STATS.Info_Carto( event , ''RUBRIQUE'' )  != ''HORS PERIMETRE'' ';
		ELSE	SQL_Dyn := ' select sum( TIME_WAITED_MICRO)/1000000 ' ;
			SQL_Dyn := SQL_Dyn || ' from stats$system_event ';
			SQL_Dyn := SQL_Dyn || ' where 	snap_id = ' || wSNAP_ID;
			SQL_Dyn := SQL_Dyn || ' AND INSTANCE_NUMBER = ' || INST_NUMBER ;
			SQL_Dyn := SQL_Dyn || ' AND PERFSTAT.PKG_STATS.Info_Carto( event , ''RUBRIQUE'' )  != ''HORS PERIMETRE'' ';
		END IF;		OPEN Src2 FOR SQL_Dyn;	FETCH Src2 INTO wTIME_WAITED_MICRO;	Close Src2;

		-- Recherche du temps CPU
		Select value INTO wVALUE from stats$sysstat where name = 'CPU used by this session' AND snap_id = wSNAP_ID;

		IF 	wTIME_WAITED_MICRO_OLD	Is NULL AND	wVALUE_OLD Is NULL
		THEN	wTIME_WAITED_MICRO_OLD	:= wTIME_WAITED_MICRO;	wVALUE_OLD := wVALUE;	wSNAP_TIME_OLD := wSNAP_TIME;
		ELSE	C1 := (wVALUE - wVALUE_OLD) / (86400*(wSNAP_TIME - wSNAP_TIME_OLD));	C1 := C1/100;	C2 := C1/CPU_COUNT;
			C3 := (wTIME_WAITED_MICRO - wTIME_WAITED_MICRO_OLD)/ (86400*(wSNAP_TIME - wSNAP_TIME_OLD));
			C4 := C3/CPU_COUNT;	C5 := C1+C3;	C6 := C2+C4;	wTIME_WAITED_MICRO_OLD	:= wTIME_WAITED_MICRO;
			wVALUE_OLD := wVALUE;			wSNAP_TIME_OLD := wSNAP_TIME;
			IF DATE_INFO_ = To_char( wSNAP_TIME, 'YYYYMMDD HH24:MI' ) THEN	RVALUE := Round( C6, 4);	EXIT;	END IF;
		END IF;
	END LOOP;	RETURN( NVL( RVALUE,0 )  );
EXCEPTION WHEN OTHERs THEN	RETURN( 0 );	End;

---------------------------------------------------------------------------------------------------------------------
procedure SYNCHRO_PLAN_ARO
(	SYNCHRO_TYPE	Varchar DEFAULT 'STATSPACK'
)
IS
	SQL_Dyn			Varchar( 10000 );
	Oversion		Number;
	TYPE 			DataSource IS REF CURSOR;
	Src 			DataSource ;
	wHASH_VALUE		Number;
	wSQL_ID			Varchar( 50 );
	wPLAN_HASH_VALUE	Number;
	wNB			Number;
	Min_Snap_Time 		Varchar( 50 );
	Max_Snap_Time 		Varchar( 50 );
	wLIGNE			Varchar( 300 );
Begin
	dbms_output.enable( 1000000 );
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;

	select to_char( snap_time, 'DD/MM/YYYY' ) INTO Min_Snap_Time from stats$snapshot
	where snap_id = (select min( SNAP_ID) from Perfstat.Stats$SQL_Summary);
	select to_char( snap_time, 'DD/MM/YYYY' ) INTO Max_Snap_Time from stats$snapshot
	where snap_id = (select max( SNAP_ID) from Perfstat.Stats$SQL_Summary);

	IF Oversion  < 10 THEN

		IF SYNCHRO_TYPE IN ('ALL', 'STATSPACK' ) THEN
		BEGIN
			SQL_Dyn := ' SELECT DISTINCT HASH_VALUE, PLAN_HASH_VALUE ' ;
			SQL_Dyn := SQL_Dyn || ' FROM perfstat.STATS$SQL_PLAN_USAGE sq ' ;
			SQL_Dyn := SQL_Dyn || ' where EXISTS ( SELECT 1 From Perfstat.ARO_Plan_Table o ' ;
			SQL_Dyn := SQL_Dyn || ' where o.HASH_VALUE = sq.HASH_VALUE )' ;
			SQL_Dyn := SQL_Dyn || ' AND   NOT EXISTS ( SELECT 1 From Perfstat.ARO_Plan_Table o ' ;
			SQL_Dyn := SQL_Dyn || ' where o.HASH_VALUE = sq.HASH_VALUE AND o.PLAN_HASH_VALUE = sq.PLAN_HASH_VALUE )' ;
			wNB := 0;
			Open Src for SQL_Dyn;
			LOOP
				FETCH Src INTO wHASH_VALUE, wPLAN_HASH_VALUE;
				EXIT WHEN Src%NOTFOUND;

				PKG_STATS.Modify_AROplan( wHASH_VALUE, wPLAN_HASH_VALUE, 'OK' );

				wNB := wNB + 1;

				IF wNB = 1 THEN
--				dbms_output.put_line (
--				'+==================================================================================================================+' );
				dbms_output.put_line (
				'| Synchronisation PLAN                                 ______________________________                              |' );
				dbms_output.put_line (
				'|                                                     |   Perfstat.ARO_Plan_Table    |                             |' );
				dbms_output.put_line (
				'|                                                     |______________________________|                             |' );
				dbms_output.put_line (
				'|       Source         P¿riode                        | HASH_VALUE  |   |  PLAN      |                             |' );
				dbms_output.put_line (
				'|   +=============+===================================|=============|   |============|                             |' );
				wLIGNE := '|   |  STATSPACK  |  ' || Min_Snap_Time  || ' au ' || Max_Snap_Time  || '         | ';
				ELSE
					wLIGNE :=  '|   |             |                                   | ';
				END IF;

				wLIGNE := wLIGNE || RPAD( wHASH_VALUE, 12 ) || '|   | ' ||
					RPAD( wPLAN_HASH_VALUE, 11 ) 	|| '|' || Rpad ( ' ' , 19 ) || '          |' ;

				dbms_output.put_line ( wLIGNE );

			END LOOP;
			Close Src;

		IF wNB > 0 THEN
		dbms_output.put_line ( '|   |_____________|___________________________________|_____________|   |____________|===> +' ||
		To_char( wNB, '999' ) || ' plan(s)           |' );
		END IF;


		EXCEPTION WHEN OTHERS THEN Null; END;
		END IF;
	ELSE


		IF SYNCHRO_TYPE IN ('ALL', 'STATSPACK' ) THEN
		BEGIN
			SQL_Dyn := ' SELECT DISTINCT SQL_ID, PLAN_HASH_VALUE ' ;
			SQL_Dyn := SQL_Dyn || ' FROM perfstat.STATS$SQL_PLAN_USAGE sq ' ;
			SQL_Dyn := SQL_Dyn || ' where EXISTS ( SELECT 1 From Perfstat.ARO_Plan_Table o ' ;
			SQL_Dyn := SQL_Dyn || ' where o.SQL_ID = sq.SQL_ID )' ;
			SQL_Dyn := SQL_Dyn || ' AND   NOT EXISTS ( SELECT 1 From Perfstat.ARO_Plan_Table o ' ;
			SQL_Dyn := SQL_Dyn || ' where o.SQL_ID = sq.SQL_ID AND o.PLAN_HASH_VALUE = sq.PLAN_HASH_VALUE )' ;
			wNB := 0;
			Open Src for SQL_Dyn;
			LOOP
				FETCH Src INTO wSQL_ID, wPLAN_HASH_VALUE;
				EXIT WHEN Src%NOTFOUND;

				PKG_STATS.Modify_AROplan( wSQL_ID, wPLAN_HASH_VALUE, 'OK' );

				wNB := wNB + 1;

				IF wNB = 1 THEN
				dbms_output.put_line (
				'+========================================================================================================+' );
				dbms_output.put_line (
				'| Synchronisation PLAN                                 ______________________________                    |' );
				dbms_output.put_line (
				'|                                                     |   Perfstat.ARO_Plan_Table    |                   |' );
				dbms_output.put_line (
				'|                                                     |______________________________|                   |' );
				dbms_output.put_line (
				'|       Source         Période                        | SQL_ID      |   |  PLAN      |                   |' );
				dbms_output.put_line (
				'|   +=============+===================================|=============|   |============|                   |' );
				wLIGNE := '|   |  STATSPACK  |  ' || Min_Snap_Time  || ' au ' || Max_Snap_Time  || '         | ';
				ELSE
					wLIGNE :=  '|   |             |                                   | ';
				END IF;

				wLIGNE := wLIGNE || RPAD( wSQL_ID, 12 ) || '|   | ' ||
					RPAD( wPLAN_HASH_VALUE, 11 ) 	|| '|' || Rpad ( ' ' , 19 ) || '|' ;

				dbms_output.put_line ( wLIGNE );

			END LOOP;
			Close Src;

		IF wNB > 0 THEN
		dbms_output.put_line ( '|   |_____________|___________________________________|_____________|   |____________|===> +' || To_char( wNB, '999' ) || ' plan(s) |' );
		END IF;


		EXCEPTION WHEN OTHERS THEN Null; END;
		END IF;


		IF SYNCHRO_TYPE IN ('ALL', 'AWR' ) THEN
		BEGIN
			SQL_Dyn := 'INSERT INTO PERFSTAT.ARO_PLAN_TABLE ';
			SQL_Dyn := SQL_Dyn || ' ( SQL_ID, PLAN_HASH_VALUE,HASH_VALUE ) SELECT ' ;
			SQL_Dyn := SQL_Dyn || ' distinct SQL_ID, PLAN_HASH_VALUE,HASH_VALUE ' ;
			SQL_Dyn := SQL_Dyn || ' from SYS.DBA_HIST_SQLSTAT sPU ' ;
			SQL_Dyn := SQL_Dyn || ' where SQL_ID IN ' ;
			SQL_Dyn := SQL_Dyn || ' ( select distinct SQL_ID FROM PERFSTAT.ARO_PLAN_TABLE ) ' ;
			SQL_Dyn := SQL_Dyn || ' AND not exists ( SELECT 1 FROM PERFSTAT.ARO_PLAN_TABLE pt ' ;
			SQL_Dyn := SQL_Dyn || ' WHERE pt.SQL_ID = sPU.SQL_ID ' ;
			SQL_Dyn := SQL_Dyn || ' and pt.PLAN_HASH_VALUE = sPU.PLAN_HASH_VALUE )' ;
			EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN Null; END;
		END IF;
	END IF;

	IF wNB > 0 THEN
		dbms_output.put_line ( '|                                                            ||                ||                                  |' );
		dbms_output.put_line ( '|    __ Analyses ____________________________________________//________________//____                              |' );
		dbms_output.put_line ( '|   |             |                                                                  |                             |' );
		dbms_output.put_line ( '|   |    PLAN     |   exec Perfstat.PKG_STATS.Info_plan ( Facultatif,    Facultatif )  |                             |' );
		dbms_output.put_line ( '|   |_____________|__________________________________________________________________|                             |' );
		dbms_output.put_line ( '|                                                                                                                  |' );
		dbms_output.put_line ( '|   exec Perfstat.PKG_STATS.Synchro_Plan_ARO                                                                         |' );
		dbms_output.put_line ( '|                                                                                                                  |' );
		dbms_output.put_line ( '+==================================================================================================================+' );
	END IF;

END;
---------------------------------------------------------------------------------------------------------------------
procedure check_ARO_Plan
(	DATEDEB		IN varchar,
	DATEFIN		IN varchar,
	LSTMODE		IN varchar 	DEFAULT 'CSV',
	PARAM		IN varchar DEFAULT 'DISK_READS',
	TOP		IN NUMBER 	DEFAULT 20,
	ShowSQL		IN Varchar 	Default 'N',
	ExplainP	IN Varchar 	Default 'N',
	INSTANCE	IN NUMBER	DEFAULT Null,
	FILTRE		IN VARCHAR	DEFAULT Null,
	MODULE		IN VARCHAR	DEFAULT Null,
	HASHVALUE	IN NUMBER	DEFAULT Null,
	PLANSTAT	IN VARCHAR	DEFAULT 'N',
	ZOOM		IN VARCHAR	DEFAULT Null,
	PCT_MIN		IN NUMBER 	DEFAULT 1,
	AUTO		IN VARCHAR	DEFAULT 'N'
)
IS
	TYPE Element_Analytique IS RECORD
	(	HASH_VALUE	Varchar( 20 ),
		MODULE		Varchar( 100 ),
		DISK_READS	Number,
		BUFFER_GETS	Number,
		CPU_TIME	Number,
		ELAPSED_TIME	Number,
		EXECUTIONS	Number,
		Conso		Number
	);
	Type 	Matrice_analytique IS TABLE OF Element_Analytique index by binary_integer ;
	ANALYTIK 		Matrice_analytique;

	a			number;
	amax			number;
	TYPE			DataSource IS REF CURSOR;
	Src 			DataSource ;
	Src2 			DataSource ;
	Src3 			DataSource ;
	SQL_Dyn2		Varchar( 1000 );
	SQL_Dyn3		Varchar( 1000 );
	SQL_Dyn			Varchar( 32767 );
	SQL_Dyn_Sel		Varchar( 32767 );
	SQL_Dyn_Sel2 		Varchar( 32767 );
	SQL_Dyn_Group 		Varchar( 32767 );
	SQL_Dyn_Group2		Varchar( 32767 );
	SQL_Dyn_Final		Varchar( 32767 );
	SQL_Dyn_Tmp		Varchar( 32767 );
	wPARAM			VARCHAR(25);
	TotalConso		Number;
	RATIO			Number;
	Echantillon		Number;
	oVersion		Number;
	wModule			Varchar( 100 );
	wModuleConso		Number;
	wModuleCPU_TIME		Number;
	wModuleELAPSED_TIME 	Number;
	wModuleEXECUTIONS	Number;
	wCHAINE 		Varchar( 10000 );
	wCHAINE2 		Varchar( 10000 );
	i			Number;
	j			Number;
	k			Number;
	wSTIME          	Varchar( 20 );
	wHASH_VALUE     	Varchar( 30 );
	wBUFFER_GETS		Number;
	wCPU_TIME		Number;
	wELAPSED_TIME		Number;
	wEXECUTIONS		Number;
	wEXTRACT		Varchar( 100 );
	wOLD_HASH		Number;
	wBORNE_MINI		Varchar( 40 );
	wDEBUG			Number;
	wDIV 			Number;
	wDELAY			Number;
	NB_PLAN			Number;
	wLEVEL			Number;
	wExplainP		Varchar( 5 );
	SPLAN			Varchar( 5 );
	TXT			Varchar( 1000 );
	ELight			Number;
	wDateLimit		Date;
	HMIN			Varchar( 25 );
	HMAX			Varchar( 25 );
	wPLAN_HASH_VALUE	Number;
	wSTATUS			Varchar( 5 );
	wCOMMAND		Varchar( 200 );
	TotalConsoOK		Number;
	RANG_Max		Number;
	ANO_HASH		Varchar( 20 );
	ANO_PLAN		Number;
	ANO_CONSO		Number;
	wGRP			Varchar(2);
	NbOK			Number;
	NbKO			Number;
	NbNull			Number;
Begin
	-----------------------------------------------------------------
	-- Initialisations
	-----------------------------------------------------------------
	dbms_output.enable( 10000000 );
	wDEBUG := 0;

	HMIN := substr( ZOOM, 1, instr( ZOOM , '-', 1 )-1 ) ;
	HMAX := substr( ZOOM, instr( ZOOM, '-', 1 )+1, 99 ) ;

	select perfstat.PKG_STATS.CheckVal('TOPSQL', LSTMODE ) INTO wDateLimit from dual;
	IF wDateLimit < sysdate THEN
		dbms_output.put_line('ARO Security ACTIVE : Fonctionnalite indisponible.');
		GOTO FIN;
	END IF;


	IF PARAM  IN ( 'ARO' , 'ALL' ) THEN

--	dbms_output.put_line( '|-----------------------------------------------------------------------+------------------------------------------+' );
--	dbms_output.put_line( '| Analyse qualitative                <---- ARO : Suivi plan Avancé --->      <--------  STATSPACK  ------------>   |' );
--	dbms_output.put_line( '|                                                                                                      	           |');
--	dbms_output.put_line( '|                                         Plans               Status             Stats$SQL_Summary                 |' );
--	dbms_output.put_line( '|                                      -----------        -------------       --------------------------           |' );
--	dbms_output.put_line( '|     Grp   Axes d''analyse             Nb      Sample      OK   KO   ??       HASH_VALUE    PLAN            (%)    |');
--	dbms_output.put_line( '|   +-----+------------------------+-------+---------+   +----+----+----+   +-------------+-------------+-------+  |' );

		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN, 'EXTRACT', 'DISK_READS', TOP, ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN, 'EXTRACT', 'BUFFER_GETS', TOP, ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );

--	dbms_output.put_line( '|   + - - + - - - - - - - - - - - -+ - - - + - - - - +   + - -+ - -+ - -+   + - - - - - - + - - - - - - + - - - +  |' );

		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN, 'EXTRACT', 'CPU_TIME', TOP, ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN, 'EXTRACT', 'ELAPSED_TIME', TOP, ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
else
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN, 'EXTRACT', PARAM, TOP, ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
	END IF;

	IF PARAM  = 'ALL' THEN
		dbms_output.put_line( '|   + - - + - - - - - - - - - - - -+ - - - + - - - - +   + - -+ - -+ - -+   + - - - - - - + - - - - - - + - - - +  |' );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN,'EXTRACT','JAVA_EXEC_TIME', TOP, ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN,'EXTRACT','APPLICATION_WAIT_TIME', TOP, ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
		dbms_output.put_line( '|   + - - + - - - - - - - - - - - -+ - - - + - - - - +   + - -+ - -+ - -+   + - - - - - - + - - - - - - + - - - +  |' );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN,'EXTRACT','CLUSTER_WAIT_TIME',TOP,ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN,'EXTRACT','PLSQL_EXEC_TIME',TOP,ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
		dbms_output.put_line( '|   + - - + - - - - - - - - - - - -+ - - - + - - - - +   + - -+ - -+ - -+   + - - - - - - + - - - - - - + - - - +  |' );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN,'EXTRACT','USER_IO_WAIT_TIME',TOP,ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM, PCT_MIN, AUTO );
		perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB,DATEFIN,'EXTRACT','CONCURRENCY_WAIT_TIME',TOP,ShowSQL,
			ExplainP,INSTANCE,FILTRE,MODULE,HASHVALUE,PLANSTAT,ZOOM , PCT_MIN, AUTO );
	END IF;


--	IF PARAM  IN ( 'ARO' , 'ALL' ) THEN
--	dbms_output.put_line( '|   +-----+------------------------+-------+---------+   +----+----+----+   +-------------+-------------+-------+  |' );
--	dbms_output.put_line( '|                                                                                                      	           |' );
--	dbms_output.put_line( '+------------------------------------------------------------------------------------------------------------------+' );
--		GOTO FIN;
--	END IF;

	IF substr(PARAM, 1, 5) = 'RATIO' THEN
		wPARAM := substr(PARAM, 6, 50);
		RATIO  := 1;
	ELSE	wPARAM := PARAM;
		RATIO  := 0;
	END IF;

	select to_number( substr( VERSION, 1, instr( VERSION, '.' )-1 )  ) INTO Oversion FROM v$instance;
	select to_char( to_date(  DATEDEB, 'YYYYMMDD HH24:MI' ) - (1440/1440), 'YYYYMMDD HH24:MI' ) INTO wBORNE_MINI from dual;

	SELECT MAx( SNAP_LEVEL ) INTO wLEVEL
	from stats$snapshot
	Where	SNAP_TIME between to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) AND to_date( DATEFIN, 'YYYYMMDD HH24:MI' );


--	dbms_output.put_line( 'wLEVEL   :' || wLEVEL );
--	dbms_output.put_line( 'ExplainP :' || ExplainP );

	IF Oversion = 8
	THEN	wDIV := 1000;
	ELSE	wDIV := 1000000;
	END IF;

	IF upper( LSTMODE ) != 'EXTRACT' THEN
		dbms_output.put_line( ' ARO Tuning : ' || PERFSTAT.PKG_STATS.version );
		dbms_output.put_line( '--- TOP ' || TOP || ' HASH_VALUE selon le critere ' || PARAM || ' --- ( CPU_TIME et ELAPSED_TIME en secondes) ');
		dbms_output.put_line( '-------------------------------------------------------------------------------------------------' );

		IF FILTRE Is NOT NULL THEN
		dbms_output.put_line( '! ! ! ATTENTION : Cette restitution ne contient que les SQL de type : ' || FILTRE || '%' );
		dbms_output.put_line( '-------------------------------------------------------------------------------------------------' );
		END IF;

		IF ExplainP = 'Y'
		THEN
			IF wLEVEL > 5
			THEN
				dbms_output.put_line( '* Le Niveau Max de STATSPACK est : ' ||  to_char(wLEVEL, '9' ) ||
					' (Suivi PLAN ACTIF)'  );
				SPLAN     := 'Y';
				wExplainP := 'N';
			ELSE
				dbms_output.put_line( '* Le Niveau Max de STATSPACK est : ' ||  to_char(wLEVEL, '9' ) ||
					' - Plan(s) en memoire UNIQUEMENT'  );
				SPLAN     := 'N';
				wExplainP := 'Y';
			END IF;
			dbms_output.put_line(
			'-------------------------------------------------------------------------------------------------' );
		ELSE
			SPLAN 	  := 'N';
			wExplainP := 'N';
		END IF;

	END IF;
	----------------------------------------------------------------------------------------------------------------------------------
	IF 	Oversion <=9 THEN
		SQL_Dyn_Sel2 :=  'select  hash_value, ';
	ELSE
		SQL_Dyn_Sel2 :=  'select  SQL_ID, ';
	END IF;

	SQL_Dyn_Sel2 :=  SQL_Dyn_Sel2 || ' sum(' || wPARAM || '_inc)' || wPARAM || ',' ;

	IF 	Oversion <=9 THEN
		SQL_Dyn_Sel :=  'select  hash_value, '''',   ';
	ELSE
		SQL_Dyn_Sel :=  'select  SQL_ID, '''',   ';
	END IF;

	SQL_Dyn_Sel :=  SQL_Dyn_Sel || ' sum(' || wPARAM || '_inc)' || wPARAM || ',' ;

	----------------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  ' sum(cpu_time_inc) cpu_timez, ';
	SQL_Dyn :=  SQL_Dyn || ' sum(elapsed_time_inc) elapsed_timez, ';
	SQL_Dyn :=  SQL_Dyn || ' sum(executions_inc) executionsz ';
	SQL_Dyn :=  SQL_Dyn || ' from    (select ';
	SQL_Dyn :=  SQL_Dyn || '  ss.snap_time stime, ';

	IF 	Oversion >=10 THEN
		SQL_Dyn :=  SQL_Dyn || ' sq.SQL_ID, ';
	END IF;

	SQL_Dyn :=  SQL_Dyn || ' sq.hash_value, sq.module, ';
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.disk_reads, lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.disk_reads, sq.disk_reads - lag(sq.disk_reads, 1, sq.disk_reads) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.disk_reads) disk_reads_inc, decode(greatest(sq.buffer_gets, lag(sq.buffer_gets, 1, sq.buffer_gets)  ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.buffer_gets, sq.buffer_gets - lag(sq.buffer_gets, 1, sq.buffer_gets) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.buffer_gets) buffer_gets_inc, ';
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.executions, lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.executions, sq.executions - lag(sq.executions, 1, sq.executions) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.executions) executions_inc, ';

	-- Cpu Time -----------------------------------------------------------------------------------------------------
	IF Oversion  = 8
	THEN
		SQL_Dyn :=  SQL_Dyn || ' 0 cpu_time_inc, ';
	ELSE
		SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.cpu_time, lag(sq.cpu_time, 1, sq.cpu_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value ';
		SQL_Dyn :=  SQL_Dyn || ' order by sq.snap_id)), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.cpu_time, sq.cpu_time - lag(sq.cpu_time, 1, sq.cpu_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.cpu_time)/' || wDIV || ' cpu_time_inc, ';
	END IF;

	-- Sorts --------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.sorts, lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.sorts, sq.sorts - lag(sq.sorts, 1, sq.sorts) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.sorts) sorts_inc, ';

	-- JAVA_EXEC_TIME -----------------------------------------------------------------------------------------------
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.JAVA_EXEC_TIME, lag(sq.JAVA_EXEC_TIME, 1, sq.JAVA_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.JAVA_EXEC_TIME, sq.JAVA_EXEC_TIME - lag(sq.JAVA_EXEC_TIME, 1, sq.JAVA_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.JAVA_EXEC_TIME) JAVA_EXEC_TIME_inc, ';
	END IF;

	-- APPLICATION_WAIT_TIME ----------------------------------------------------------------------------------------
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.APPLICATION_WAIT_TIME, lag(sq.APPLICATION_WAIT_TIME, 1, sq.APPLICATION_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.APPLICATION_WAIT_TIME, sq.APPLICATION_WAIT_TIME - lag(sq.APPLICATION_WAIT_TIME, 1, sq.APPLICATION_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.APPLICATION_WAIT_TIME) APPLICATION_WAIT_TIME_inc, ';
	END IF;

	-- CONCURRENCY_WAIT_TIME ----------------------------------------------------------------------------------------
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.CONCURRENCY_WAIT_TIME, lag(sq.CONCURRENCY_WAIT_TIME, 1, sq.CONCURRENCY_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CONCURRENCY_WAIT_TIME, sq.CONCURRENCY_WAIT_TIME - lag(sq.CONCURRENCY_WAIT_TIME, 1, sq.CONCURRENCY_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CONCURRENCY_WAIT_TIME) CONCURRENCY_WAIT_TIME_inc, ';
	END IF;

	-- CLUSTER_WAIT_TIME --------------------------------------------------------------------------------------------
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.CLUSTER_WAIT_TIME, lag(sq.CLUSTER_WAIT_TIME, 1, sq.CLUSTER_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CLUSTER_WAIT_TIME, sq.CLUSTER_WAIT_TIME - lag(sq.CLUSTER_WAIT_TIME, 1, sq.CLUSTER_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.CLUSTER_WAIT_TIME) CLUSTER_WAIT_TIME_inc, ';
	END IF;

	-- USER_IO_WAIT_TIME --------------------------------------------------------------------------------------------
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.USER_IO_WAIT_TIME, lag(sq.USER_IO_WAIT_TIME, 1, sq.USER_IO_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.USER_IO_WAIT_TIME, sq.USER_IO_WAIT_TIME - lag(sq.USER_IO_WAIT_TIME, 1, sq.USER_IO_WAIT_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.USER_IO_WAIT_TIME) USER_IO_WAIT_TIME_inc, ';
	END IF;

	-- PLSQL_EXEC_TIME ----------------------------------------------------------------------------------------------
	IF Oversion  >= 10 THEN
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.PLSQL_EXEC_TIME, lag(sq.PLSQL_EXEC_TIME, 1, sq.PLSQL_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PLSQL_EXEC_TIME, sq.PLSQL_EXEC_TIME - lag(sq.PLSQL_EXEC_TIME, 1, sq.PLSQL_EXEC_TIME) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PLSQL_EXEC_TIME) PLSQL_EXEC_TIME_inc, ';
	END IF;

	-- Fetches ------------------------------------------------------------------------------------------------------
	IF Oversion  = 8
	THEN
		SQL_Dyn :=  SQL_Dyn || ' 0 FETCHES_inc, ';
	ELSE
		SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.FETCHES, lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.FETCHES, sq.FETCHES - lag(sq.FETCHES, 1, sq.FETCHES) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.FETCHES) FETCHES_inc, ';
	END IF;

	-- loads --------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.LOADS, lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.LOADS, sq.LOADS - lag(sq.LOADS, 1, sq.LOADS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.LOADS) LOADS_inc, ';

	-- parse_calls --------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.PARSE_CALLS, lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PARSE_CALLS, sq.PARSE_CALLS - lag(sq.PARSE_CALLS, 1, sq.PARSE_CALLS) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.PARSE_CALLS) PARSE_CALLS_inc, ';
	-- rows_processed -----------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.ROWs_PROCESSED, lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.ROWs_PROCESSED, sq.ROWs_PROCESSED - lag(sq.ROWs_PROCESSED, 1, sq.ROWs_PROCESSED) ';
	SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
	SQL_Dyn :=  SQL_Dyn || ' sq.ROWs_PROCESSED) ROWs_PROCESSED_inc, ';

	-- Elapsed time   -----------------------------------------------------------------------------------------------
	IF Oversion  = 8
	THEN
		SQL_Dyn :=  SQL_Dyn || ' 0 elapsed_time_inc ';
	ELSE
		SQL_Dyn :=  SQL_Dyn || ' decode(greatest(sq.elapsed_time, lag(sq.elapsed_time, 1, sq.elapsed_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id)), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.elapsed_time, sq.elapsed_time - lag(sq.elapsed_time, 1, sq.elapsed_time) ';
		SQL_Dyn :=  SQL_Dyn || ' over(partition by sq.hash_value order by sq.snap_id), ';
		SQL_Dyn :=  SQL_Dyn || ' sq.elapsed_time)/' || wDIV || ' elapsed_time_inc ';
	END IF;

	-----------------------------------------------------------------------------------------------------------------
	SQL_Dyn :=  SQL_Dyn || ' from stats$sql_summary sq, stats$snapshot ss ';
	SQL_Dyn :=  SQL_Dyn || ' where ';
	SQL_Dyn :=  SQL_Dyn || ' ss.snap_time between to_date( ''' || wBORNE_MINI || ''', ''YYYYMMDD HH24:MI'' ) ';
	SQL_Dyn :=  SQL_Dyn || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';

	IF INSTANCE Is not NULL THEN	SQL_Dyn :=  SQL_Dyn || ' and ( ss.instance_number = ' || INSTANCE || ' ) ';	END IF;
	SQL_Dyn :=  SQL_Dyn || ' and sq.dbid = ss.dbid ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.instance_number = ss.instance_number ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.snap_id = ss.snap_id ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.executions between 0 and 999999999999999 ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.disk_reads between 0 and 999999999999999 ';
	SQL_Dyn :=  SQL_Dyn || ' and sq.buffer_gets between 0 and 999999999999999 ';
	-----------------------------------------------------------------------------------------------------------------
	IF Oversion  > 8
	THEN
		SQL_Dyn :=  SQL_Dyn || ' and sq.cpu_time between 0 and 999999999999999 ';
		SQL_Dyn :=  SQL_Dyn || ' and sq.elapsed_time between 0 and 999999999999999 ';
	END IF;
	-----------------------------------------------------------------------------------------------------------------------
	IF HASHVALUE Is NOT Null THEN 	SQL_Dyn :=  SQL_Dyn || ' and sq.HASH_VALUE = ' || HASHVALUE ; 	END IF;
	IF MODULE Is not null THEN
		IF MODULE = 'NON RENSEIGNE'
		THEN	SQL_Dyn :=  SQL_Dyn || ' and sq.module Is null ';
		ELSE	SQL_Dyn :=  SQL_Dyn || ' and sq.module = ''' || MODULE || ''' ';
		END IF;
	END IF;
	IF FILTRE IS NOT NULL THEN 	SQL_Dyn :=  SQL_Dyn || ' and upper( sq.TEXT_SUBSET ) like ''' || FILTRE || '%''';	END IF;
	SQL_Dyn :=  SQL_Dyn || ' ) ';

	------------------------------------------------------------------------------------------------------------------------
	SQL_Dyn := SQL_Dyn  || ' where stime >= to_date( ''' || DATEDEB || ''', ''YYYYMMDD HH24:MI'' ) ';

	IF ZOOM Is NOT Null THEN
		SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) >= ''' || HMIN || '''';
		SQL_Dyn :=  SQL_Dyn || ' and to_char( stime, ''HH24:MI'' ) <= ''' || HMAX || '''';
	END IF;
	------------------------------------------------------------------------------------------------------------------------

	IF 	Oversion <=9 THEN
		SQL_Dyn_Group2 :=  ' group by hash_value ';
	ELSE
		SQL_Dyn_Group2 :=  ' group by SQL_ID ';
	END IF;

	SQL_Dyn_Group2 :=  SQL_Dyn_Group2 || ' having sum(' ||  wPARAM || '_inc) > 0 ';


	IF 	Oversion <=9 THEN
		SQL_Dyn_Group :=  ' group by hash_value  ';
	ELSE
		SQL_Dyn_Group :=  ' group by SQL_ID ';
	END IF;


	SQL_Dyn_Group :=  SQL_Dyn_Group || ' having sum(' ||  wPARAM || '_inc) > 0 ';


	IF RATIO = 0
	THEN	SQL_Dyn_Group :=  SQL_Dyn_Group || ' order by ' || wPARAM || ' desc ';
	ELSE	SQL_Dyn_Group :=  SQL_Dyn_Group || ' order by ' || wPARAM || '/DECODE( sum(executions_inc) ,0, 1, sum(executions_inc)) desc ';
	END IF;

	SQL_Dyn_Final := SQL_Dyn_Sel || ' ' || SQL_Dyn || ' ' || SQL_Dyn_Group ;

	IF wDEBUG = 1 OR wDEBUG = 9 THEN
		dbms_output.put_line( substr( SQL_Dyn_Final,   1, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final, 201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final, 401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final, 601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final, 801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,1001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,1201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,1401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,1601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,1801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,2801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,3001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,3201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,3401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,3601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,3801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,4001, 200 ));

		dbms_output.put_line( substr( SQL_Dyn_Final,4201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,4401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,4601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,4801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,5001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,5201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,5401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,5601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,5801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,6001, 200 ));

		dbms_output.put_line( substr( SQL_Dyn_Final,6201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,6401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,6601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,6801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,7001, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,7201, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,7401, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,7601, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,7801, 200 ));
		dbms_output.put_line( substr( SQL_Dyn_Final,8001, 200 ));
	END IF;


	-----------------------------------------------------------------
	-- Chargement des donnees analytiques et calcul du total conso
	-----------------------------------------------------------------
	TotalConso := 0;
	OPEN src for SQL_Dyn_Final;
	a := 1;
	LOOP
		FETCH src INTO	analytik(a).HASH_VALUE, analytik(a).MODULE, analytik(a).CONSO,
		analytik(a).CPU_TIME, analytik(a).ELAPSED_TIME, analytik(a).EXECUTIONS;
		EXIT WHEN Src%NOTFOUND;

		IF analytik(a).EXECUTIONS = 0 THEN
			analytik(a).EXECUTIONS := 1;
		END IF;

		TotalConso := TotalConso + analytik(a).Conso ;
		a := a + 1;
	END LOOP;
	amax := a;
	Close Src;

	-----------------------------------------------------------------
	-- Affichage du TOP x HASH_VALUE
	-----------------------------------------------------------------
	If upper( LSTMODE ) != 'EXTRACT' THEN
		wChaine := 'No;     Hash_Value;' || rpad( wPARAM, 15 ) || ';  EXECUTIONS;    CPU_TIME;ELAPSED_TIME;%TOTAL(' || wPARAM || ');';
		IF RATIO = 1 THEN
			wChaine := wChaine || wPARAM || '/EXEC' || ';';
		END IF;

		wChaine := wChaine ||   'NbPLAN(STATS$)';
		dbms_output.put_line( wChaine );
	END IF;

	a := 1;
	Echantillon := 0;
	While a < amax
	LOOP
		if a <= TOP then

			If upper( LSTMODE ) = 'EXTRACT' THEN
				select 'TU5;' || INSTANCE_NAME || ';' || HOST_NAME || ';' INTO wEXTRACT from v$instance;
				wEXTRACT := wEXTRACT || DATEDEB || ';' || INSTANCE || ';' || wPARAM;

			ELSE

				IF Oversion  >= 10 THEN
					SQL_Dyn_Tmp := 'select count(*) from ( ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' select	pu.SQL_ID, pu.plan_hash_value ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' from	stats$sql_plan_usage	pu, ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' stats$snapshot		ss ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' Where 	pu.dbid = ss.dbid ';

					IF INSTANCE Is NOT NULL THEN
						SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and	ss.instance_number = ' || INSTANCE;
					END IF;

					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and ss.snap_time between to_date( ''' || DATEDEB ;
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ''', ''YYYYMMDD HH24:MI'' ) ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and pu.instance_number = ss.instance_number ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and pu.snap_id = ss.snap_id ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || '	and pu.SQL_ID = ''' || analytik(a).HASH_VALUE || ''' ' ;
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' group by pu.SQL_ID, pu.plan_hash_value )';

--					dbms_output.put_line( substr( SQL_Dyn_Tmp,   1, 200 ));
--					dbms_output.put_line( substr( SQL_Dyn_Tmp, 201, 200 ));
--					dbms_output.put_line( substr( SQL_Dyn_Tmp, 401, 200 ));
--					dbms_output.put_line( substr( SQL_Dyn_Tmp, 601, 200 ));
--					dbms_output.put_line( substr( SQL_Dyn_Tmp, 801, 200 ));
--					dbms_output.put_line( substr( SQL_Dyn_Tmp,1001, 200 ));


					OPEN Src3 FOR SQL_Dyn_Tmp;
					FETCH Src3 INTO NB_Plan;
					Close Src3;

				ELSE
					SQL_Dyn_Tmp := 'select count(*) from ( ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' select	pu.HASH_VALUE, pu.plan_hash_value ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' from	stats$sql_plan_usage	pu, ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' stats$snapshot		ss ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' Where 	pu.dbid = ss.dbid ';

					IF INSTANCE Is NOT NULL THEN
						SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and	ss.instance_number = ' || INSTANCE;
					END IF;

					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and ss.snap_time between to_date( ''' || DATEDEB ;
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ''', ''YYYYMMDD HH24:MI'' ) ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and to_date( ''' || DATEFIN || ''', ''YYYYMMDD HH24:MI'' ) ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and pu.instance_number = ss.instance_number ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' and pu.snap_id = ss.snap_id ';
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || '	and pu.HASH_VALUE = ' || analytik(a).HASH_VALUE;
					SQL_Dyn_Tmp := SQL_Dyn_Tmp || ' group by pu.HASH_VALUE, pu.plan_hash_value )';

					OPEN Src3 FOR SQL_Dyn_Tmp;
					FETCH Src3 INTO NB_Plan;
					Close Src3;

				END IF;

				wCHAINE  := rpad( to_char( a , '009' ), 5 ) 			|| ';' ;
				wCHAINE  := wCHAINE  || LPAD( analytik(a).HASH_VALUE, 13 )	|| ';' ||
						LPAD( TO_char( analytik(a).Conso,'999999999999' ), 15 ) || ';' ||
					To_char( analytik(a).EXECUTIONS, '99999999999' )	|| ';' ;


				wCHAINE2 := To_char( analytik(a).CPU_TIME,    '999999999.99' )	|| ';' ;
				SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
				wCHAINE  := wCHAINE  || wCHAINE2 ;

				wCHAINE2 := To_char( analytik(a).ELAPSED_TIME, '999999999.99' )	|| ';' ;
				SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
				wCHAINE  := wCHAINE  || wCHAINE2 ;

				wCHAINE2 := To_char( 100*analytik(a).Conso/TotalConso, '999.99' ) ;
				SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
				wCHAINE  := wCHAINE  || wCHAINE2 ;

				IF RATIO = 1 THEN
					wCHAINE2 := To_char( analytik(a).Conso / analytik(a).EXECUTIONS,    '999999999.99' ) ;
					SELECT  PERFSTAT.PKG_STATS.XLS_VAL ( wCHAINE2 ) into wCHAINE2 FROM DUAL;
					wCHAINE  := wCHAINE  || ';' || wCHAINE2 ;
				END IF;

				If upper( LSTMODE ) <> 'EXTRACT' THEN
					IF Oversion  >= 9 THEN
						dbms_output.put_line( wCHAINE || '; ' || NB_Plan || ' plan(s) execution ' );
					ELSE
						dbms_output.put_line( wCHAINE || '; '   );
					END IF;
				END IF;


			END IF;
			Echantillon := Echantillon + (100*analytik(a).Conso/TotalConso);
		END IF;
		a := a + 1;
	END LOOP;

	NbOK	:= 0;
	NbKO	:= 0;
	NbNull	:= 0;

	If upper( LSTMODE ) != 'EXTRACT' THEN
		dbms_output.put_line(
		'+-----+---------------------+-----------------------+--------------------------------------------------> Echantillon=' ||
		round(Echantillon) || '% ' );

		IF Oversion  >  9
		THEN	dbms_output.put_line( '| N¿  | SQL_ID              |    Plan Hash Value    |' );
		ELSE	dbms_output.put_line( '| N¿  | Hash Value          |    Plan Hash Value    |' );
		END IF;
		dbms_output.put_line( '+ - - + - - - - - - - - - - + - - - - - - - - - - - + - -+' );

	END IF;



	RANG_Max := Null;
	TotalConsoOK := 0;

	a := 1;
	Echantillon := 0;
	While a <= TOP
	LOOP

		IF LSTMODE != 'EXTRACT' THEN
			dbms_output.put_line( '|' || to_char( a, '009' ) || ' | ' ||
			rpad( analytik(a).HASH_VALUE, 20 ) || '|                       |    |' );
		END IF;

		SQL_Dyn := 'select distinct PLAN_HASH_VALUE ';
		IF Oversion  >= 10
		THEN	SQL_Dyn := SQL_Dyn || ' from perfstat.stats$sql_plan_usage where SQL_ID=''' || analytik(a).HASH_VALUE || ''' ';
		ELSE	SQL_Dyn := SQL_Dyn || ' from perfstat.stats$sql_plan_usage where HASH_VALUE=' || analytik(a).HASH_VALUE;
		END IF;

		Open Src for SQL_DYN;
		LOOP

			wCOMMAND  := Null;
			FETCH SRC INTO wPLAN_HASH_VALUE;
			EXIT WHEN Src%NOTFOUND;


			wSTATUS := Null;
			BEGIN
				SQL_Dyn3 := ' select STATUS from PERFSTAT.ARO_PLAN_TABLE ';
				IF Oversion  >= 10
				THEN	SQL_Dyn3 := SQL_Dyn3 || ' where  SQL_ID=''' || analytik(a).HASH_VALUE || ''' ' ;
				ELSE	SQL_Dyn3 := SQL_Dyn3 || ' where  HASH_VALUE=' || analytik(a).HASH_VALUE ;
				END IF;
				SQL_Dyn3 := SQL_Dyn3 || ' and PLAN_HASH_VALUE=' || wPLAN_HASH_VALUE;
				Open Src3 For SQL_Dyn3;
				FETCH Src3 INTO wSTATUS;
				Close Src3;
			EXCEPTION WHEN NO_DATA_FOUND THEN 	wSTATUS := 'NO';	END;

			IF AUTO ='Y' AND ( wSTATUS = 'NO' OR wSTATUS Is Null )
			THEN
				IF (100*analytik(a).Conso/TotalConso) > PCT_MIN
				THEN
--					dbms_output.put_line( 'TotalConso     :' || TotalConso        );
--					dbms_output.put_line( 'Conso          :' || analytik(a).Conso );
--					dbms_output.put_line( '%TotalConso    :' || 100*analytik(a).Conso/TotalConso        );
					Perfstat.PKG_STATS.Modify_AROplan( analytik(a).HASH_VALUE, wPLAN_HASH_VALUE, 'OK' );
					wSTATUS := 'OK';
				END IF;
			END IF;


			IF wSTATUS = 'NO' THEN
				wCOMMAND := 'exec Perfstat.PKG_STATS.INSERT_PLAN_ARO ( ''' ||
				analytik(a).HASH_VALUE || ''', '|| wPLAN_HASH_VALUE || ')';

			ELSIF wSTATUS is null THEN
				wCOMMAND := 'exec Perfstat.PKG_STATS.Modify_AROplan( ''' ||
				analytik(a).HASH_VALUE || ''', '|| wPLAN_HASH_VALUE || ' , ''OK'' )';
				NbNull	:= NbNull + 1;
			ELSIF wSTATUS = 'OK' THEN
				NbOK	:= NbOK + 1;
			ELSIF wSTATUS = 'OK' THEN
				NbKO	:= NbKO + 1;
			END IF;

			IF wSTATUS = 'NO' or wSTATUS is null THEN
				IF RANG_Max is null THEN
					RANG_Max := a;
					ANO_HASH := analytik(a).HASH_VALUE;
					ANO_PLAN := wPLAN_HASH_VALUE ;
					ANO_CONSO := analytik(a).Conso;
				END IF;
			END IF;


			wSTATUS := NVL( wSTATUS, '  ' );

			IF LSTMODE != 'EXTRACT' THEN
				dbms_output.put_line( '|     |                     |     ' ||
					to_char( wPLAN_HASH_VALUE, '9999999999999999' ) || ' | '  || wSTATUS || ' | '  || wCOMMAND );
			END IF;

		END LOOP;
		Close Src;


		IF RANG_Max is null THEN   TotalConsoOK := TotalConsoOK + analytik(a).Conso; 	END IF;
		IF LSTMODE != 'EXTRACT' THEN
			dbms_output.put_line( '+ - - + - - - - - - - - - - + - - - - - - - - - - - + - -+' );
		END IF;

		a := a + 1;

	END LOOP;

	IF RANG_Max is null
	THEN	RANG_Max := TOP;
	ELSE	RANG_Max := RANG_Max - 1;
	END IF;

	SELECT DECODE( PARAM, 	'DISK_READS',  ' 1', 'CPU_TIME', ' 2', 'JAVA_EXEC_TIME', ' 4', 'CLUSTER_WAIT_TIME', ' 8',
				'USER_IO_WAIT_TIME',	'16', '  ' ) INTO wGRP FROM DUAL;


	IF LSTMODE ='EXTRACT' THEN
		wCHAINE := '|   |  ' || wGRP  || ' | ' || RPAD( PARAM, 22) || ' |' || to_char( RANG_Max, '999' ) || '   |   ' ;
		wCHAINE := wCHAINE || to_char( round(100*TotalConsoOK/TotalConso, 1), '99' ) || '%  |   |' ;
		wCHAINE := wCHAINE || to_char( NbOK	, '999' ) || '|' ;
		wCHAINE := wCHAINE || to_char( NbKO	, '999' ) || '|' ;
		wCHAINE := wCHAINE || to_char( NbNull , '999' ) || '|   | ' ;
		wCHAINE := wCHAINE || Rpad( NVL( ANO_HASH, ' ' ), 11 )	|| ' | ' ;
		wCHAINE := wCHAINE || Rpad( NVL( TO_char(ANO_PLAN) , ' ' ), 11 )	|| ' |' ;
		wCHAINE := wCHAINE || NVL( To_char( round(100*ANO_CONSO/TotalConso, 1)  , '999.9' ), '      ') || ' |  |' ;

		dbms_output.put_line( wCHAINE );
	END IF;



	<<FIN>>
	Null;

EXCEPTION WHEN NO_DATA_FOUND THEN
		IF LSTMODE != 'EXTRACT' THEN
			dbms_output.put_line ( 'Pas de donnees avec ce parametrage' );
		END IF;
	WHEN OTHERS THEN
		IF LSTMODE != 'EXTRACT' THEN
			dbms_output.put_line ( 'Erreur detectee' );
			dbms_output.put_line ( sqlcode  );
		END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure MODIFY_AROPLAN
(	SQL_ID		Varchar,
	PLAN_HASH_VALUE Number,
	STATUS		Varchar,
	COMMENT		Varchar	 DEFAULT Null
)
IS
	SQL_Dyn		Varchar( 10000 );
	Oversion	Number;
Begin
	dbms_output.enable( 1000000 );
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;

	-------------------------------------------------------------------------------------------------------------
	-- Ajout de l'information dans la table de suivi, si elle n'y est pas
	-------------------------------------------------------------------------------------------------------------
	BEGIN
		perfstat.PKG_STATS.INSERT_PLAN_ARO( SQL_ID, PLAN_HASH_VALUE );
		Commit;
	EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line ( 'ERROR INSERT' );
		dbms_output.put_line ( sqlcode  );
		dbms_output.put_line ( substr( sql_dyn,    1, 200 ));
		dbms_output.put_line ( substr( sql_dyn,  201, 200 ));
--		Null;
	END;


	-------------------------------------------------------------------------------------------------------------
	-- Modification du STATUS dans la table de suivi
	-------------------------------------------------------------------------------------------------------------
	BEGIN
		SQL_Dyn := 'UPDATE PERFSTAT.ARO_PLAN_TABLE SET STATUS = ''' || STATUS || ''' WHERE ';

		IF Oversion  < 10 THEN
			SQL_Dyn := SQL_Dyn || ' HASH_VALUE = ''' ;
		ELSE
			SQL_Dyn := SQL_Dyn || ' SQL_ID = ''' ;
		END IF;

		SQL_Dyn := SQL_Dyn || SQL_ID || ''' and  PLAN_HASH_VALUE = ''' || PLAN_HASH_VALUE || ''' ';


		EXECUTE IMMEDIATE SQL_Dyn;
		Commit;
	EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line ( 'ERROR UPDATE' );
		dbms_output.put_line ( sqlcode  );
		dbms_output.put_line ( substr( sql_dyn,    1, 200 ));
		dbms_output.put_line ( substr( sql_dyn,  201, 200 ));
--	Null;
	END;

	-------------------------------------------------------------------------------------------------------------
	-- Modification du COMMENTAIRE dans la table de suivi
	-------------------------------------------------------------------------------------------------------------
	IF COMMENT Is NOT Null THEN
	BEGIN
		SQL_Dyn := 'UPDATE PERFSTAT.ARO_PLAN_TABLE SET COMMENTAIRE = ''' || COMMENT || ''' WHERE ';

		IF Oversion  < 10 THEN
			SQL_Dyn := SQL_Dyn || ' HASH_VALUE = ''' ;
		ELSE
			SQL_Dyn := SQL_Dyn || ' SQL_ID = ''' ;
		END IF;

		SQL_Dyn := SQL_Dyn || SQL_ID || ''' and  PLAN_HASH_VALUE = ''' || PLAN_HASH_VALUE || ''' ';



		EXECUTE IMMEDIATE SQL_Dyn;
		Commit;
	EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line ( 'ERROR UPDATE' );
		dbms_output.put_line ( substr( sql_dyn,    1, 200 ));
		dbms_output.put_line ( substr( sql_dyn,  201, 200 ));
		dbms_output.put_line ( sqlcode  );
--		Null;
	END;
	END IF;

END;
---------------------------------------------------------------------------------------------------------------------
procedure INSERT_PLAN_ARO
( 	SQL_ID		Varchar,
	PLAN_HASH_VALUE	Number	)
IS
	SQL_Dyn		Varchar( 10000 );
	Oversion	Number;
Begin
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	dbms_output.enable( 1000000 );


	if Oversion < 10 THEN
		BEGIN
			SQL_Dyn := 'INSERT INTO PERFSTAT.ARO_PLAN_TABLE ';
			SQL_Dyn := SQL_Dyn || ' ( HASH_VALUE, PLAN_HASH_VALUE ) VALUES ( ''' ;
			SQL_Dyn := SQL_Dyn || SQL_ID || ''', ''' || PLAN_HASH_VALUE	|| ''')';

			EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN
		dbms_output.put_line ( 'ERROR INSERT' );
		dbms_output.put_line ( sqlcode );
		dbms_output.put_line ( substr( SQL_Dyn,   1, 200 ));
		dbms_output.put_line ( substr( SQL_Dyn, 201, 200 ));
--Null;
		END;
	ELSE
		BEGIN
			SQL_Dyn := 'INSERT INTO PERFSTAT.ARO_PLAN_TABLE ';
			SQL_Dyn := SQL_Dyn || ' ( SQL_ID, PLAN_HASH_VALUE ) VALUES ( ''' ;
			SQL_Dyn := SQL_Dyn || SQL_ID || ''', ''' || PLAN_HASH_VALUE	|| ''')';

			EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN Null; END;
	END IF;
	Commit;
END;

---------------------------------------------------------------------------------------------------------------------
procedure SUIVI_PLAN_ARO
IS
	SQL_Dyn		Varchar( 10000 );
	Oversion	Number;
Begin
	dbms_output.enable( 1000000 );

	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;

	if Oversion < 10 THEN
		BEGIN
			SQL_Dyn := 'create table PERFSTAT.ARO_PLAN_TABLE ';
			SQL_Dyn := SQL_Dyn || ' ( HASH_VALUE Varchar( 20 ), ';
			SQL_Dyn := SQL_Dyn || ' PLAN_HASH_VALUE Number, ';
			SQL_Dyn := SQL_Dyn || ' STATUS Varchar( 2 ), ';			
			SQL_Dyn := SQL_Dyn || ' HASH_VALUE Number, ';
			SQL_Dyn := SQL_Dyn || ' COMMENTAIRE Varchar( 1000 ) ';
			SQL_Dyn := SQL_Dyn || ' ) ';
			EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN Null; END;

		BEGIN
			SQL_Dyn := 'create unique index PERFSTAT.ARO_PLAN_TABLE_I1 ';
			SQL_Dyn := SQL_Dyn || ' on PERFSTAT.ARO_PLAN_TABLE (HASH_VALUE, PLAN_HASH_VALUE)';
			EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN Null; END;
	ELSE
		BEGIN
			SQL_Dyn := 'create table PERFSTAT.ARO_PLAN_TABLE ';
			SQL_Dyn := SQL_Dyn || ' ( SQL_ID Varchar( 20 ), ';
			SQL_Dyn := SQL_Dyn || ' PLAN_HASH_VALUE Number, ';
			SQL_Dyn := SQL_Dyn || ' STATUS Varchar( 2 ), ';			
			SQL_Dyn := SQL_Dyn || ' HASH_VALUE Number, ';
			SQL_Dyn := SQL_Dyn || ' COMMENTAIRE Varchar( 1000 ) ';
			SQL_Dyn := SQL_Dyn || ' ) ';
			EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN Null; END;

		BEGIN
			SQL_Dyn := 'create unique index PERFSTAT.ARO_PLAN_TABLE_I1 ';
			SQL_Dyn := SQL_Dyn || ' on PERFSTAT.ARO_PLAN_TABLE (SQL_ID, PLAN_HASH_VALUE)';
			EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN Null; END;
	END IF;



	BEGIN
		SQL_Dyn := 'ALTER table PERFSTAT.ARO_PLAN_TABLE ADD FIRST_DATE DATE DEFAULT sysdate';
		EXECUTE IMMEDIATE SQL_Dyn;
		EXCEPTION WHEN OTHERS THEN Null;
	END;
END;
Procedure DiagSQL
(	DATEDEB		Varchar 	DEFAULT Null,
	DATEFIN		Varchar 	DEFAULT Null,
	PARAM		Varchar 	DEFAULT 'ARO',
	TOP		Number 		DEFAULT 100,
	ZOOM		Varchar 	DEFAULT NULL,
	PCT_MIN		Number 		DEFAULT 1,
	AUTO		Varchar		DEFAULT 'N'
)
is
	oVersion	Number;
	wDAY		Varchar( 20 );
	wNB		Number;
	wNBP		Number;
	wMoyenne	Number;
	wNbOK		Number;
	wNbKO		Number;
	wNbNull		Number;
	SQL_Dyn		Varchar( 20000 );
	poc		number;
	TYPE 		DataSource IS REF CURSOR;
	Src 		DataSource ;
	wOPTIM		Varchar( 100 );
	wCURSOR		Varchar( 100 );
	wHISTO		Number;
	DATEDEB_	Varchar( 30 );
	DATEFIN_	Varchar( 30 );
	ZOOM_		Varchar( 30 );
	wCOMMANDE	Varchar( 300 );
	wVERSION 	Varchar(20);
	wObj		Number;
begin
	dbms_output.enable( 1000000 );
	select substr( VERSION, 1, instr( VERSION, '.' )-1 ) 	INTO Oversion FROM v$instance;
	Select To_char( sysdate, 'DD/MM/YYYY' ) INTO wDAY FROM DUAL;

	select count(*) INTO wNB from dba_tables where table_name='ARO_PLAN_TABLE' and owner='PERFSTAT';

	ZOOM_    := '           ';

	IF DATEDEB IS NULL
	THEN	SELECT To_char( sysdate  , 'DD/MM/YYYY' ) INTO DATEDEB_ FROM DUAL;
	ELSE	SELECT To_char( to_date( DATEDEB , 'YYYYMMDD' )  , 'DD/MM/YYYY' ) INTO DATEDEB_ FROM DUAL;
	END IF;

	IF DATEFIN Is NUll
	THEN	SELECT To_char( sysdate+1, 'DD/MM/YYYY' ) INTO DATEFIN_ FROM DUAL;
	ELSE	SELECT To_char( to_date( DATEFIN , 'YYYYMMDD' )  , 'DD/MM/YYYY' ) INTO DATEFIN_ FROM DUAL;
	END IF;
	SELECT PERFSTAT.PKG_STATS.Version INTO wVERSION FRom Dual;

	dbms_output.put_line( '+-----/-----------------------------------------------------------------+' );
	dbms_output.put_line( 'ARO  /                 - SuperVision ' || PKG_STATS.version || RPAD( ' -', 30 ) ||
		' |  _____ Période de suivi _______  ' );
	dbms_output.put_line( wVERSION || '/                                                                   | |                              |' );

	IF wNB = 0 THEN
		dbms_output.put_line( '___/               Suivi PLAN Avancé : INACTIF                          | |  DATEDEB : ' ||
		DATEDEB_ || '        |' );
	ELSE
		dbms_output.put_line( '___/               Suivi PLAN Avancé : ACTIF                            | |  DATEDEB : ' ||
		DATEDEB_ || '        |' );
	END IF;

	dbms_output.put_line( '| /                                                                     | |  DATEFIN : ' ||
		DATEFIN_ || '        |' );
	dbms_output.put_line( '|/                                                          Oracle ' ||
		To_char( Oversion, '99' ) || '  | |  ZOOM    : ' || ZOOM_ || '       |' );

	dbms_output.put_line( '|                                                                       | |______________________________|' );
	--select to_char ( sysdate, chr(57+17) ) - ((6789*361)+5171) into poc from dual;

	--if poc < 0 THEN
	IF Oversion <= 9
	THEN	SQL_Dyn := 'Select	count(distinct HASH_VALUE) Nb,';
	ELSE	SQL_Dyn := 'Select	count(distinct SQL_ID) Nb,';
	END IF;
	SQL_Dyn := SQL_Dyn || ' count(PLAN_HASH_VALUE) Nbplans,';

	IF Oversion <= 9
	THEN	SQL_Dyn := SQL_Dyn || ' round( count(PLAN_HASH_VALUE)/count(distinct HASH_VALUE) , 2 ) moyenne,';
	ELSE	SQL_Dyn := SQL_Dyn || ' round( count(PLAN_HASH_VALUE)/count(distinct SQL_ID) , 2 ) moyenne,';
	END IF;
	SQL_Dyn := SQL_Dyn || ' Sum( to_number( DECODE( STATUS, ''OK'', ''1'', ''0'' ) ) ) NbOK,';
	SQL_Dyn := SQL_Dyn || ' Sum( to_number( DECODE( STATUS, ''KO'', ''1'', ''0'' ) ) ) NbKO,';
	SQL_Dyn := SQL_Dyn || ' Sum( to_number( DECODE( STATUS, Null, ''1'', ''0'' ) ) ) NbNull';
	SQL_Dyn := SQL_Dyn || ' From	Perfstat.ARO_Plan_Table';

	select VALUE INTO wOPTIM from v$parameter where NAME='optimizer_mode';
	select VALUE INTO wCURSOR from v$parameter where NAME='cursor_sharing';
	select count(*) INTO wHISTO from dba_tab_col_statistics where NUM_BUCKETS > 1 ;


	IF wOPTIM <> 'CHOOSE' OR wHISTO > 0 THEN

		dbms_output.put_line( '|- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -|' );
		dbms_output.put_line( '| Analyse contexte (Anomalies de parametrage)                           |' );
		dbms_output.put_line( '|                                                                       |' );

		IF  wOPTIM <> 'CHOOSE' THEN
			dbms_output.put_line( '|     optimizer_mode = |' || wOPTIM || '                                             |' );
		END IF;

		IF wCURSOR = 'EXACT' THEN
			dbms_output.put_line( '|     cursor_sharing = EXACT                                            |' );
		END IF;

		IF wCURSOR = 'EXACT' AND  wHISTO > 0  THEN
			dbms_output.put_line( '|     cursor_sharing = EXACT  ET Histogrammes présents                  |' );
		END IF;

		IF wCURSOR = 'FORCE'  AND  wHISTO > 0  THEN
			dbms_output.put_line( '|     cursor_sharing = FORCE  ET Histogrammes présents                  |' );
		END IF;
		dbms_output.put_line( '|                                                                       |' );
	END IF;


	select 	count(*) INTO wObj
	from 	dba_segments
	where 	TABLESPACE_NAME NOT IN ( 'SYSTEM', 'SYSAUX' )
	AND	SEGMENT_TYPE NOT IN ('SPACE HEADER', 'TYPE2 UNDO' )
	AND 	OWNER IN ('SYS', 'SYSTEM' );


	IF wObj > 0 THEN

		dbms_output.put_line( '|- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -|' );
		dbms_output.put_line( '| Analyse stockage SYS / SYSTEM                                         |' );
		dbms_output.put_line( '|                                                                       |' );
		dbms_output.put_line( '|     Données SYSTEM en dehors du tablespace SYSTEM                     |' );
		dbms_output.put_line( '|                                                                       |' );

	END IF;

	BEGIN
		OPEN Src FOR SQL_DYN;
		Fetch Src INTO wNB, wNBP, wMoyenne, wNbOK, wNbKO, wNbNull;
		Close Src;
	EXCEPTION WHEN OTHERS THEN wNB := 0; END;

--	IF wNB > 0  THEN
	dbms_output.put_line( '|-----------------------------------------------------------------------|' ||
			'------------------------------------------+' );
	dbms_output.put_line( '| Analyse quantitative                                                                     Perfstat.ARO_Plan_Table |' );
	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '|                                    Nb Plans                                                                      |' );
	dbms_output.put_line( '|             Nb Traitements          Suivis   Moyenne     OK   KO   ??                                            |' );
	dbms_output.put_line( '|         + - - - - - - - - - - - -+ - - - - + - - - +   +----+----+----+                                          |' );
	dbms_output.put_line( '|         |       ' || to_char( NVL(wNB,0), '999' ) ||
				'             |   ' || to_char( NVL( wNBP,0 ), '999' ) ||
				'  | ' || to_char( NVL(wMoyenne,0) , '9.9' )  || '  |   |' ||
				to_char( NVL(wNbOK,0 ), '999' ) || '|' ||
				to_char( NVL(wNbKO,0 ), '999' ) || '|' ||
				to_char( NVL(wNbNull,0 ), '999' ) || '|                                          |' );
	dbms_output.put_line( '|         +------------------------+---------+-------+   +----+----+----+                                          |' );
	dbms_output.put_line( '|                                                                                                                  |' );
--	END IF;


--	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '| Calibrage automatique INACTIF (AUTO=''N'')                                                                         |' );
	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '|                   PARAM                  TOP                STATUS                  PCT_MIN                      |' );
	dbms_output.put_line( '|         +------------------------+-----------------+   +--------------+   +---------------------------+          |' );
	dbms_output.put_line( '|         | ' || RPAD( PARAM, 22 ) ||
		' |       ' || RPAD( To_char( TOP), 4 ) || '      |   |       OK     |   |    ' ||
		Lpad(To_char(PCT_MIN, '999.0' ), 8) || ' %             |          |' );
	dbms_output.put_line( '|         +------------------------+-----------------+   +--------------+   +---------------------------+          |' );
	dbms_output.put_line( '|                                                                                                                  |' );

	SELECT count(*) INTO wNB  FROM SYS.dba_tables WHERE owner='PERFSTAT' and table_name ='ARO_PLAN_TABLE';
	IF wNB = 0 THEN
		dbms_output.put_line( '|- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -|' );
		dbms_output.put_line( '| Préconisations : INITIALISER, puis CALIBRER LE SUIVI PLAN AVANCE      |  _____ Préconisations _________ ' );
		dbms_output.put_line( '|                                                                       | |                              |' );
		dbms_output.put_line( '|       exec Perfstat.PKG_STATS.Suivi_Plan_ARO                            | |  1. Initialiser le suivi     |' );
		dbms_output.put_line( '|       exec Perfstat.PKG_STATS.Diagsql( AUTO=>''Y'' )                         | |  2. Calibrer le suivi        |' );
		dbms_output.put_line( '|                                                                       | |______________________________|' );
	END IF;


	IF DATEDEB IS NULL
	THEN	SELECT To_char( sysdate  , 'YYYYMMDD' ) INTO DATEDEB_ FROM DUAL;
	ELSE	DATEDEB_ := DATEDEB;
	END IF;

	IF DATEFIN Is NUll
	THEN	SELECT To_char( sysdate+1, 'YYYYMMDD' ) INTO DATEFIN_ FROM DUAL;
	ELSE	DATEFIN_ := DATEFIN;
	END IF;

--	SELECT To_char( sysdate, 'YYYYMMDD' ), To_char( sysdate+1, 'YYYYMMDD' ) INTO DATEDEB_ , DATEFIN_  FROM DUAL;
	dbms_output.put_line( '|------------------------------------------------------------------------------------------------------------------+' );
	dbms_output.put_line( '| Analyse qualitative                <---- ARO : Suivi plan Avancé --->      <--------  STATSPACK  ------------>   |' );
	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '|                                         Plans               Status             Stats$SQL_Summary                 |' );
	dbms_output.put_line( '|                                      -----------        -------------       --------------------------           |' );

	IF Oversion  <= 9 THEN
	dbms_output.put_line( '|     Grp   Axes d''analyse             Nb      Sample      OK   KO   ??       HASH_VALUE    PLAN            (%)    |' );
	ELSE
	dbms_output.put_line( '|     Grp   Axes d''analyse             Nb      Sample      OK   KO   ??       SQL_ID        PLAN            (%)    |' );
	END IF;

	dbms_output.put_line( '|   +-----+------------------------+-------+---------+   +----+----+----+   +-------------+-------------+-------+  |' );
	perfstat.PKG_STATS.Check_ARO_Plan( DATEDEB_, DATEFIN_, 'EXTRACT', PARAM, TOP, 'N', 'N', Null, Null, Null, Null, 'N', ZOOM, PCT_MIN, AUTO );
	dbms_output.put_line( '|   +-----+------------------------+-------+---------+   +----+----+----+   +-------------+-------------+-------+  |' );
	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '+==================================================================================================================+' );


	dbms_output.put_line( '| Préconisations                                                                                                   |' );
	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '|   * Calibrage automatique ARO                                                                                    |' );
	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.DiagSql( ''' || DATEDEB_ || ''', ''' ||
			DATEFIN_ || ''', AUTO=>''Y'' )                                            |' );

	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.autoDiagSql( AUTO=>''Y'' )                                                                |' );

	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '|   * Calibrage automatique par axe d''analyse ( CPU_TIME & TOP 60 )                                                |' );
	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.DiagSql( ''' || DATEDEB_ || ''', ''' ||
			DATEFIN_ || ''', PARAM=>''CPU_TIME'', TOP=>60, AUTO=>''Y'' )                |' );
	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '|   * Calibrage manuel par axe ( DISK_READS )                                                                      |' );
	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.Check_ARO_Plan( ''' || DATEDEB_ || ''', ''' ||
			DATEFIN_ || ''', ''CSV'', ''DISK_READS'', 100 )                   |' );
	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '|   * Calibrage manuel                                                                                             |' );
	IF Oversion  <= 9 THEN
	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.Modify_AROplan( HASH_VALUE , PLAN_HASH_VALUE , [STATUS] , [COMMENT] )                |' );
	ELSE
	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.Modify_AROplan( SQL_ID, PLAN_HASH_VALUE , [STATUS] , [COMMENT] )                     |' );
	END IF;
	dbms_output.put_line( '|                                                                                                                  |' );
--	dbms_output.put_line( '|   * Controler le calibrage                                                                                       |' );
--	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.Diag                                                                                 |' );
--	dbms_output.put_line( '|                                                                                                                  |' );
	dbms_output.put_line( '+==================================================================================================================+' );

	-- lancement de la Synchronisation
	Perfstat.PKG_STATS.Synchro_Plan_ARO;

--	dbms_output.put_line( '*=======================================================================+' );


	wCOMMANDE := '';
	IF DATEDEB IS NOT Null THEN
		wCOMMANDE := wCOMMANDE || ', DATEDEB=>''' || DATEDEB || ''' ';
	END IF;

	IF DATEFIN IS NOT Null THEN
		wCOMMANDE := wCOMMANDE || ', DATEFIN=>''' || DATEFIN || ''' ';
	END IF;

	IF PARAM <> 'ARO' THEN
		wCOMMANDE := wCOMMANDE || ', PARAM=>''' || PARAM || ''' ';
	END IF;

	IF TOP	<> 100 THEN
		wCOMMANDE := wCOMMANDE || ', TOP=>' || TOP ;
	END IF;

	IF ZOOM	Is Not NULL THEN
		wCOMMANDE := wCOMMANDE || ', ZOOM=>''' || ZOOM || ''' ';
	END IF;

	IF PCT_MIN	<> 1 THEN
		wCOMMANDE := wCOMMANDE || ', PCT_MIN=>' || PCT_MIN ;
	END IF;

	IF AUTO <> 'N' THEN
		wCOMMANDE := wCOMMANDE || ', AUTO=>''' || AUTO || ''' ' ;
	END IF;

	dbms_output.put_line( '| Rappel de commande                                                                                               |' );
	dbms_output.put_line( '|       exec Perfstat.PKG_STATS.DiagSql( ' || RPAD(substr(wCOMMANDE,2,999) || ' )', 79) || '|'  );
	dbms_output.put_line( '+------------------------------------------------------------------------------------------------------------------+' );

	--END IF;
END;
---------------------------------------------------------------------------------------------------------------------
procedure AUTODIAGSQL
(	DATEDEB		Varchar 	DEFAULT Null,
	DATEFIN		Varchar 	DEFAULT Null,
	PARAM		Varchar 	DEFAULT 'OAR',
	TOP		Number 		DEFAULT 100,
	ZOOM		Varchar 	DEFAULT NULL,
	PCT_MIN		Number 		DEFAULT 1,
	AUTO		Varchar		DEFAULT 'N' 	)
IS
	TYPE 		DataSource IS REF CURSOR;
	Src 		DataSource ;
	wstime		Date;
	SQL_Dyn		Varchar( 10000 );

BEGIN
	dbms_output.enable( 100000000 );

	Open Src FOR
	select distinct ( trunc( snap_time )) from perfstat.stats$snapshot
	WHERE	( DATEDEB Is null OR snap_time >= to_date( DATEDEB, 'YYYYMMDD' ) )
	AND	( DATEFIN Is Null Or snap_time <= to_date( DATEFIN, 'YYYYMMDD' ) )
	order by 1;

	LOOP
		FETCH Src INTO wstime ;
		EXIT WHEN Src%NOTFOUND;

		SQL_Dyn := 'BEGIN PERFSTAT.PKG_STATS.DiagSql( ''' || to_char( wstime, 'YYYYMMDD' ) || ''', ''';
		SQL_Dyn := SQL_Dyn || to_char( wstime +1 , 'YYYYMMDD' ) || ''', ''' ;
		SQL_Dyn := SQL_Dyn || PARAM	 || ''', ' ;
		SQL_Dyn := SQL_Dyn || TOP	|| ', ''' ;
		SQL_Dyn := SQL_Dyn || ZOOM	|| ''', ' ;
		SQL_Dyn := SQL_Dyn || PCT_MIN	|| ', ''' ;
		SQL_Dyn := SQL_Dyn || AUTO	|| '''' ;
		SQL_Dyn := SQL_Dyn || '); END;';

--		dbms_output.put_line ( SQL_Dyn );
		EXECUTE IMMEDIATE SQL_Dyn;
	END LOOP;
END;
---------------------------------------------------------------------------------------------------------------------
procedure Info_Plan
(	SQL_ID			Varchar	DEFAULT Null,
	PLAN_HASH_VALUE		Number	DEFAULT Null,
	HASH_VALUE		Number	DEFAULT Null
)
IS
	TYPE 	       	DataSource IS REF CURSOR;
	Src 	       	DataSource ;
	SQL_DYN		Varchar( 10000 );
	wSTATUS		Varchar( 5 );
	wSTATUS2	Varchar( 5 );
	wCOMMENT	Varchar( 10000 );
	wNB		Number;
	wDEBUG Number;
	wLIGNE1		Varchar( 100 );
	wLIGNE2		Varchar( 100 );
	Oversion	Number;
	wHASH		Varchar( 50 );
	wHASH_OLD	Varchar( 50 );
	wPLAN_HASH_VALUE Number;
   wVERSION	Varchar( 20 );
BEGIN
	dbms_output.enable( 100000000 );
	select to_number( substr( VERSION, 1, instr( VERSION, '.' )-1 )  ) INTO Oversion FROM v$instance;
	wDEBUG:=1;

	IF ( SQL_ID is NOt NULL OR HASH_VALUE Is not Null ) AND PLAN_HASH_VALUE Is not null THEN
	-------------------------------------------------------------------------------------------------------------------
		SQL_DYN := ' Select count(*) from perfstat.ARO_plan_table ';
		SQL_DYN := SQL_DYN || ' WHERE PLAN_HASH_VALUE = ' || PLAN_HASH_VALUE;
		
		
		IF SQL_ID Is NOT Null	  THEN	SQL_DYN := SQL_DYN || ' AND (SQL_ID = ''' || SQL_ID || ''' ' ;	END IF;
		IF HASH_VALUE Is NOT Null THEN	SQL_DYN := SQL_DYN || ' OR HASH_VALUE = ' || HASH_VALUE || ' )'; ELSE SQL_DYN := SQL_DYN || ')';	END IF;
		IF wDEBUG = 1 OR wDEBUG = 9 THEN
			dbms_output.put_line( substr( SQL_Dyn,   1, 200 ));	dbms_output.put_line( substr( SQL_Dyn, 201, 200 ));
		END IF;
		Open Src For SQL_Dyn;
		FETCH Src INTO wNB;
		Close Src;
		dbms_output.put_line( wNB);	
		IF wNB > 0
		THEN	wLIGNE1 := 'Ce plan est suivi ';

			SQL_DYN := ' Select STATUS, COMMENTAIRE from perfstat.ARO_plan_table ';
			SQL_DYN := SQL_DYN || ' WHERE PLAN_HASH_VALUE = ' || PLAN_HASH_VALUE;
			IF SQL_ID Is NOT Null	  THEN	SQL_DYN := SQL_DYN || ' AND (SQL_ID = ''' || SQL_ID || ''' ' ;	END IF;
			IF HASH_VALUE Is NOT Null THEN	SQL_DYN := SQL_DYN || ' OR HASH_VALUE = ' || HASH_VALUE ;	ELSE SQL_DYN := SQL_DYN || ')'; END IF;

			Open Src For SQL_Dyn;
			FETCH Src INTO wSTATUS, wCOMMENT;
			Close Src;

			IF wSTATUS is null
			THEN	wLIGNE1 := wLIGNE1  || ' (status=INDEFINI)' ;
				wLIGNE2 := 'exec Perfstat.PKG_STATS.MODIFY_AROPLAN( ' || NVL( SQL_ID, HASH_VALUE) || ', ' || PLAN_HASH_VALUE  || ', ''OK'' ) ';
			ELSE
				wLIGNE1 := wLIGNE1  || ' (status=' || wSTATUS || ')' ;

				SELECT DECODE( wSTATUS, 'OK', 'KO', 'KO', 'OK', 'NA' ) 	INTO wSTATUS2  FROM DUAL;
				wLIGNE2 := 'exec Perfstat.PKG_STATS.MODIFY_AROPLAN( ''' || NVL( SQL_ID, HASH_VALUE) || ''', ' ||
					PLAN_HASH_VALUE  || ', ''' || wSTATUS2 || ''' ) ';
			END IF;

		ELSE	wLIGNE1 := 'Ce plan est INCONNU';
			wSTATUS	:= Null;
			wCOMMENT:= Null;
			wLIGNE2 := 'exec Perfstat.PKG_STATS.INSERT_PLAN_ARO( ''' || NVL( SQL_ID, HASH_VALUE) || ''', ' || PLAN_HASH_VALUE || ' ) ';
		END IF;
		-----------------------------------------------------------------------------------------------------------
		dbms_output.put_line( '- SuperVision ' || PKG_STATS.version || ' - ' || 'Suivi PLAN Avancé'   ||  ' : ' || wLIGNE1);
		IF wCOMMENT Is Not Null THEN
			dbms_output.put_line( wCOMMENT );
		END IF;
		dbms_output.put_line( wLIGNE2  );
	ELSE
		wLIGNE1 :=  ' ' ;
		wLIGNE2 :=  ' ' ;
		dbms_output.put_line( 'TABLEAU' );

		IF Oversion <= 9
		THEN	SQL_DYN := ' select HASH_VALUE, ';
		ELSE	SQL_DYN := ' select SQL_ID, ';
		END IF;

		SQL_DYN := SQL_DYN || ' PLAN_HASH_VALUE, STATUS, COMMENTAIRE from perfstat.ARO_plan_table ';
		SQL_DYN := SQL_DYN || ' WHERE 1=1 ';

		IF (Oversion>=10) AND (SQL_ID is Not null) THEN
			SQL_DYN := SQL_DYN || ' AND SQL_ID = ''' || SQL_ID || ''' ';
			wLIGNE1 := '         SQL_ID = ' || SQL_ID;
		END IF;

		IF PLAN_HASH_VALUE is not null THEN
			SQL_DYN := SQL_DYN || ' AND PLAN_HASH_VALUE = ' || PLAN_HASH_VALUE;
			wLIGNE2 := 'PLAN_HASH_VALUE = ' || PLAN_HASH_VALUE;
		END IF;

		IF (Oversion <= 9) AND (HASH_VALUE is not null) THEN
			SQL_DYN := SQL_DYN || ' AND HASH_VALUE = ' || HASH_VALUE;
			wLIGNE1 := '     HASH_VALUE = ' || HASH_VALUE;
		END IF;
		SELECT PERFSTAT.PKG_STATS.Version INTO wVERSION FRom Dual;
		dbms_output.put_line( '------------------------------------------------------------------------+' );
		dbms_output.put_line( '     /     SuperVision                                        INFO_PLAN |' );
		dbms_output.put_line( wVERSION ||' /                    ' || RPAD( wLIGNE1, 47 ) || '|' );
		dbms_output.put_line( '___/                     ' || RPAD( wLIGNE2, 47 ) || '|' );

		IF (Oversion>=10)
		THEN
			dbms_output.put_line( '| SQL_ID                                                                |' );
		ELSE
			dbms_output.put_line( '| HASH_VALUE                                                            |' );
		END IF;

		dbms_output.put_line( '|      PLAN_HASH_VALUE  Status  COMMENTAIRES                            |' );
		dbms_output.put_line( '+=======================+==+============================================+' );

		wHASH_OLD := ' ';
		Open Src For SQL_DYN;
		LOOP
			FETCH Src INTO wHASH, wPLAN_HASH_VALUE, wSTATUS, wCOMMENT;
			EXIT WHEN Src%NOTFOUND;

			IF wHASH_OLD <> wHASH THEN
				dbms_output.put_line( '| ' || RPAD( wHASH, 22 )  || '|  |                                            |' );
				wHASH_OLD := wHASH;
			END IF;

			dbms_output.put_line( '|      ' || RPAD( wPLAN_HASH_VALUE, 17 )  || '|' ||
				NVL(wSTATUS, '??') || '|' || Rpad( NVL( wCOMMENT, ' ' ), 44 ) || '|'  );
		END LOOP;
		Close Src;
		dbms_output.put_line( '+-----------------------+--+--------------------------------------------+' );


	END IF;

EXCEPTION WHEN NO_DATA_FOUND THEN		
			dbms_output.put_line ( 'Pas de donnees avec ce parametrage' );
		
	WHEN OTHERS THEN
			dbms_output.put_line ( 'Erreur detectee' );
			dbms_output.put_line ( sqlcode  );
		
END;
---------------------------------------------------------------------------------------------------------------------
End;