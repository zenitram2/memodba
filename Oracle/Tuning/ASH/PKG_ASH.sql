CREATE OR REPLACE PACKAGE            PERFSTAT."PKG_ASH"  AS
/*
 grant select on DBA_SCHEDULER_JOBS  to PERFSTAT;
 grant create session to PERFSTAT;
grant create table to PERFSTAT;
grant create procedure to PERFSTAT;
grant create job to PERFSTAT;
grant select on gv_$session to PERFSTAT;
grant select on v_$bgprocess to PERFSTAT;
grant select on gv_$sql to PERFSTAT;
grant select on dba_services to PERFSTAT;
 grant select on v_$instance  to PERFSTAT;

*/

--	procedure SUIVI_ASH;
	procedure JOB_ASH;
	procedure JOB_ACTIVE (ACTIVE IN BOOLEAN default True);
	PROCEDURE snap;
    PROCEDURE purge;
    PROCEDURE retention(jours NUMBER);
	procedure JOB_ETAT;
	
END;
/




create or replace PACKAGE BODY                              PERFSTAT."PKG_ASH"  AS

---------------------------------------------------------------------------------------------------------------------
procedure JOB_ETAT
is

	wOWNER varchar(50);
	wJOB_NAME varchar(50);
	wSTATE varchar(50);
	wSTART_DATE varchar(50);
	wREPEAT_INTERVAL varchar(50);
	wNEXT_RUN_DATE varchar(50);
	wRUN_COUNT varchar(50);

begin

	dbms_output.enable(1000000);

	Dbms_Output.Put_Line('-------------------- -------------------- --------------- -------------------- -------------------------------------------------- -------------------- ---------');
	Dbms_Output.Put_Line('OWNER                JOB_NAME             STATE           START_DATE           REPEAT_INTERVAL                                    NEXT_RUN_DATE         RUN_COUNT');
	Dbms_Output.Put_Line('-------------------- -------------------- --------------- -------------------- -------------------------------------------------- -------------------- ---------');


	select OWNER,job_name,state,to_char(START_DATE,'MM/DD/YYYY HH24:MI:SS') START_DATE,REPEAT_INTERVAL,to_char(NEXT_RUN_DATE,'MM/DD/YYYY HH24:MI:SS') NEXT_RUN_DATE,run_count 
	INTO	wOWNER, wJOB_NAME, wSTATE, wSTART_DATE, wREPEAT_INTERVAL, wNEXT_RUN_DATE, wRUN_COUNT
	from dba_scheduler_jobs 
	where job_name in ('SNAP_SUIVI_ASH');

	if wOWNER is not null then
		dbms_output.put_line( RPAD(  wOWNER , 21) ||  RPAD(  wJOB_NAME , 21) || RPAD(  wSTATE , 16) || RPAD(  wSTART_DATE , 21) || RPAD(  wREPEAT_INTERVAL , 51) || RPAD(  wNEXT_RUN_DATE , 21) || RPAD(  wRUN_COUNT , 10));
		
	end if; 
	select OWNER,job_name,state,to_char(START_DATE,'MM/DD/YYYY HH24:MI:SS') START_DATE,
	REPEAT_INTERVAL,
	to_char(NEXT_RUN_DATE,'MM/DD/YYYY HH24:MI:SS') NEXT_RUN_DATE,
	run_count 
	INTO	wOWNER, wJOB_NAME, wSTATE, wSTART_DATE, wREPEAT_INTERVAL, wNEXT_RUN_DATE, wRUN_COUNT
	from dba_scheduler_jobs 
	where job_name in ('PURGE SUIVI_ASH'); 

	if wOWNER is not null then
		dbms_output.put_line( RPAD(  wOWNER , 21) ||  RPAD(  wJOB_NAME , 21) || RPAD(  wSTATE , 16) || RPAD(  wSTART_DATE , 21) || RPAD(  wREPEAT_INTERVAL , 51) || RPAD(  wNEXT_RUN_DATE , 21) || RPAD(  wRUN_COUNT , 10));
	end if; 
	Dbms_Output.Put_Line('-------------------- -------------------- --------------- -------------------- -------------------------------------------------- -------------------- ---------');
 
END JOB_ETAT;

PROCEDURE purge
IS
  NB_ROWS NUMBER;
  DAYS    NUMBER := 7;
BEGIN
  dbms_application_info.set_module('PERFSTAT','PURGE ASH');
  SELECT value INTO days FROM PARAMETERS_ASH WHERE name='retention';
  DELETE FROM SUIVI_ASH WHERE sample_time < TRUNC(sysdate)-days;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20100,'ASH PURGE Error' || SUBSTR(SQLERRM, 1 , 1000));
END purge;

---------------------------------------------------------------------------------------------------------------------

PROCEDURE retention(
    JOURS NUMBER)
IS
BEGIN
  MERGE INTO PARAMETERS_ASH USING
  (SELECT 1 FROM dual
  ) ON (PARAMETERS_ASH.NAME = 'retention')
WHEN MATCHED THEN
  UPDATE SET value=JOURS WHEN NOT MATCHED THEN
  INSERT
    (name,value
    ) VALUES
    ('retention',JOURS
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20100,'SUIVI_ASH Error' || SUBSTR(SQLERRM, 1 , 1000));
END retention;



---------------------------------------------------------------------------------------------------------------------
PROCEDURE snap111
IS
BEGIN
  dbms_application_info.set_module('PERFSTAT','INSERT SUIVI_ASH');
  INSERT
  INTO SUIVI_ASH
    (
      INST_ID,
      SAMPLE_TIME,
      SESSION_ID,
      SESSION_SERIAL#,
      USER_ID,
      SQL_ID,
      SQL_CHILD_NUMBER,
      SQL_OPCODE,
      SQL_PLAN_HASH_VALUE,
      BLOCKING_SESSION,
      BLOCKING_SESSION_STATUS,
      EVENT#,
      P1,
      P2,
      P3,
      WAIT_TIME,
      CURRENT_OBJ#,
      CURRENT_FILE#,
      CURRENT_BLOCK#,
      PROGRAM,
      MODULE,
      ACTION,
      CLIENT_ID,
      SERVICE_HASH,
      SESSION_TYPE,
      SESSION_STATE,
      WAIT_CLASS_ID,
      BLOCKING_INST_ID,
      SQL_EXEC_ID,
      SQL_EXEC_START,
      PLSQL_ENTRY_OBJECT_ID,
      PLSQL_ENTRY_SUBPROGRAM_ID,
      PLSQL_OBJECT_ID,
      PLSQL_SUBPROGRAM_ID,
      MACHINE
    )
  SELECT s.INST_ID,
    SYSTIMESTAMP,
    s.SID,
    s.SERIAL#,
    s.USER#,
    s.SQL_ID,
    s.SQL_CHILD_NUMBER,
    q.COMMAND_TYPE,
    q.PLAN_HASH_VALUE,
    s.BLOCKING_SESSION,
    s.BLOCKING_SESSION_STATUS,
    s.EVENT#,
    s.P1,
    s.P2,
    s.P3,
    s.WAIT_TIME,
    (
    CASE
      WHEN s.state='WAITING'
      THEN s.ROW_WAIT_OBJ#
      ELSE -1
    END),
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P1text='file#'
      THEN s.P1
      ELSE -1
    END),
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P2text='block#'
      THEN s.P2
      ELSE -1
    END),
    s.PROGRAM,
    s.MODULE,
    s.ACTION,
    s.CLIENT_IDENTIFIER,
    decode(d.NAME_HASH,null,0,d.NAME_HASH),
    DECODE(TYPE,'USER','FOREGROUND','BACKGROUND'),
    DECODE(state,'WAITING','WAITING','ON CPU') ,
    DECODE(state,'WAITING',s.WAIT_CLASS_ID,null) ,
    s.BLOCKING_INSTANCE,
    s.SQL_EXEC_ID,
    s.SQL_EXEC_START,
    s.PLSQL_ENTRY_OBJECT_ID,
    s.PLSQL_ENTRY_SUBPROGRAM_ID,
    s.PLSQL_OBJECT_ID,
    s.PLSQL_SUBPROGRAM_ID,
    s.MACHINE
  FROM gv$session s, dba_services d,gv$sql q
  WHERE s.status    ='ACTIVE'
  AND ((s.state='WAITING' and s.wait_class !='Idle') or (s.state != 'WAITING'))
  and audsid <> userenv('SESSIONID')
  and paddr not in (select paddr from v$bgprocess where name='CJQ0')
  and s.sql_id=q.sql_id(+)
  and s.sql_child_number=q.child_number(+)
  and s.inst_id=q.inst_id(+)
  and s.service_name=d.name(+);

  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20100,'SUIVI_ASH Error' || SUBSTR(SQLERRM, 1 , 1000));
END snap111;

---------------------------------------------------------------------------------------------------------------------
PROCEDURE snap112
IS
BEGIN
  
dbms_application_info.set_module('PERFSTAT','INSERT SUIVI_ASH');
  INSERT
  INTO SUIVI_ASH
    (
      INST_ID,
      SAMPLE_TIME,
      SESSION_ID,
      SESSION_SERIAL#,
      USER_ID,
      SQL_ID,
      SQL_CHILD_NUMBER,
      SQL_OPCODE,
      SQL_PLAN_HASH_VALUE,
      BLOCKING_SESSION,
      BLOCKING_SESSION_STATUS,
      EVENT#,
      P1,
      P2,
      P3,
      WAIT_TIME,
      CURRENT_OBJ#,
      CURRENT_FILE#,
      CURRENT_BLOCK#,
      PROGRAM,
      MODULE,
      ACTION,
      CLIENT_ID,
      SERVICE_HASH,
      SESSION_TYPE,
      SESSION_STATE,
      WAIT_CLASS_ID,
      BLOCKING_INST_ID,
      SQL_EXEC_ID,
      SQL_EXEC_START,
      PLSQL_ENTRY_OBJECT_ID,
      PLSQL_ENTRY_SUBPROGRAM_ID,
      PLSQL_OBJECT_ID,
      PLSQL_SUBPROGRAM_ID,
      MACHINE
    )
  SELECT s.INST_ID,
    SYSTIMESTAMP,
    s.SID,
    s.SERIAL#,
    s.USER#,
    s.SQL_ID,
    s.SQL_CHILD_NUMBER,
    q.COMMAND_TYPE,
    q.PLAN_HASH_VALUE,
    s.BLOCKING_SESSION,
    s.BLOCKING_SESSION_STATUS,
    s.EVENT#,
    s.P1,
    s.P2,
    s.P3,
    s.WAIT_TIME,
    (
    CASE
      WHEN s.state='WAITING'
      THEN s.ROW_WAIT_OBJ#
      ELSE -1
    END),
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P1text='file#'
      THEN s.P1
      ELSE -1
    END),
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P2text='block#'
      THEN s.P2
      ELSE -1
    END),
    s.PROGRAM,
    s.MODULE,
    s.ACTION,
    s.CLIENT_IDENTIFIER,
    decode(d.NAME_HASH,null,0,d.NAME_HASH),
    DECODE(TYPE,'USER','FOREGROUND','BACKGROUND'),
    DECODE(state,'WAITING','WAITING','ON CPU') ,
    DECODE(state,'WAITING',s.WAIT_CLASS_ID,null) ,
    s.BLOCKING_INSTANCE,
    s.SQL_EXEC_ID,
    s.SQL_EXEC_START,
    s.PLSQL_ENTRY_OBJECT_ID,
    s.PLSQL_ENTRY_SUBPROGRAM_ID,
    s.PLSQL_OBJECT_ID,
    s.PLSQL_SUBPROGRAM_ID,
    s.MACHINE
  FROM gv$session s, dba_services d,gv$sql q
  WHERE s.status    ='ACTIVE'
  AND ((s.state='WAITING' and s.wait_class !='Idle') or (s.state != 'WAITING'))
  and s.sid <> userenv('SID')
  and paddr not in (select paddr from v$bgprocess where name='CJQ0')
  and s.sql_id=q.sql_id(+)
  and s.sql_child_number=q.child_number(+)
  and s.inst_id=q.inst_id(+)
  and s.service_name=d.name(+);

  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20100,'SUIVI_ASH Error' || SUBSTR(SQLERRM, 1 , 1000));
END snap112;

---------------------------------------------------------------------------------------------------------------------
PROCEDURE snap121
IS
BEGIN
  dbms_application_info.set_module('PERFSTAT','INSERT SUIVI_ASH');
  INSERT
  INTO SUIVI_ASH
    (
      INST_ID,
      SAMPLE_TIME,
      SESSION_ID,
      SESSION_SERIAL#,
      USER_ID,
      SQL_ID,
      SQL_CHILD_NUMBER,
      SQL_OPCODE,
      SQL_PLAN_HASH_VALUE,
      BLOCKING_SESSION,
      BLOCKING_SESSION_STATUS,
      EVENT#,
      P1,
      P2,
      P3,
      WAIT_TIME,
      CURRENT_OBJ#,
      CURRENT_FILE#,
      CURRENT_BLOCK#,
      PROGRAM,
      MODULE,
      ACTION,
      CLIENT_ID,
      SERVICE_HASH,
      SESSION_TYPE,
      SESSION_STATE,
      WAIT_CLASS_ID,
      BLOCKING_INST_ID,
      SQL_EXEC_ID,
      SQL_EXEC_START,
      PLSQL_ENTRY_OBJECT_ID,
      PLSQL_ENTRY_SUBPROGRAM_ID,
      PLSQL_OBJECT_ID,
      PLSQL_SUBPROGRAM_ID,
      MACHINE,
      CON_ID
    )
  SELECT s.INST_ID,
    SYSTIMESTAMP,
    s.SID,
    s.SERIAL#,
    s.USER#,
    s.SQL_ID,
    s.SQL_CHILD_NUMBER,
    q.COMMAND_TYPE,
    q.PLAN_HASH_VALUE,
    s.BLOCKING_SESSION,
    s.BLOCKING_SESSION_STATUS,
    s.EVENT#,
    s.P1,
    s.P2,
    s.P3,
    s.WAIT_TIME,
    (
    CASE
      WHEN s.state='WAITING'
      THEN s.ROW_WAIT_OBJ#
      ELSE -1
    END),
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P1text='file#'
      THEN s.P1
      ELSE -1
    END),
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P2text='block#'
      THEN s.P2
      ELSE -1
    END),
    s.PROGRAM,
    s.MODULE,
    s.ACTION,
    s.CLIENT_IDENTIFIER,
    decode(d.NAME_HASH,null,0,d.NAME_HASH),
    DECODE(TYPE,'USER','FOREGROUND','BACKGROUND'),
    DECODE(state,'WAITING','WAITING','ON CPU') ,
    DECODE(state,'WAITING',s.WAIT_CLASS_ID,null) ,
    s.BLOCKING_INSTANCE,
    s.SQL_EXEC_ID,
    s.SQL_EXEC_START,
    s.PLSQL_ENTRY_OBJECT_ID,
    s.PLSQL_ENTRY_SUBPROGRAM_ID,
    s.PLSQL_OBJECT_ID,
    s.PLSQL_SUBPROGRAM_ID,
    s.MACHINE,
    s.con_id
  FROM gv$session s, dba_services d,gv$sql q
  WHERE s.status    ='ACTIVE'
  AND ((s.state='WAITING' and s.wait_class !='Idle') or (s.state != 'WAITING'))
  and s.sid <> userenv('SID')
  and paddr not in (select paddr from v$bgprocess where name='CJQ0')
  and s.sql_id=q.sql_id(+)
  and s.sql_child_number=q.child_number(+)
  and s.inst_id=q.inst_id(+)
  and s.service_name=d.name(+);

  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20100,'SUIVI_ASH Error' || SUBSTR(SQLERRM, 1 , 1000));
END snap121;


---------------------------------------------------------------------------------------------------------------------
PROCEDURE snap

IS
Oversion	Number;

BEGIN

select  floor(to_number(regexp_replace(version,'\.',''))/1000)	INTO Oversion FROM v$instance;

case Oversion
	when 121 then
		snap121;
	when 112 then
		snap112;		
	when 111 then
		snap111;			
end case;

end snap;
---------------------------------------------------------------------------------------------------------------------

procedure JOB_ACTIVE (ACTIVE IN BOOLEAN default True)
IS
Begin

dbms_output.put_line('--Script a executer en dba--');
if ACTIVE then
	dbms_output.put_line('exec sys.dbms_scheduler.enable( ''"PERFSTAT"."SNAP_SUIVI_ASH"'' ); ');
else
	dbms_output.put_line('exec sys.dbms_scheduler.disable( ''"PERFSTAT"."SNAP_SUIVI_ASH"'' ); ');
end if;

dbms_output.put_line('--Fin Script a executer en dba--');
end;

---------------------------------------------------------------------------------------------------------------------

procedure JOB_ASH
IS
Begin

dbms_output.put_line('--Script a executer en dba--');

dbms_output.put_line('BEGIN');
dbms_output.put_line('sys.dbms_scheduler.create_job( ');
dbms_output.put_line('job_name => ''"PERFSTAT"."SNAP_SUIVI_ASH"'',');
dbms_output.put_line('job_type => ''STORED_PROCEDURE'',');
dbms_output.put_line('job_action => ''"PERFSTAT"."PKG_ASH"."SNAP"'',');
dbms_output.put_line('repeat_interval => ''FREQ=SECONDLY;INTERVAL=10'',');
dbms_output.put_line('start_date => systimestamp,');
dbms_output.put_line('job_class => ''"DEFAULT_JOB_CLASS"'',');
dbms_output.put_line('comments => ''Simalution ash snap'',');
dbms_output.put_line('auto_drop => FALSE,');
dbms_output.put_line('enabled => FALSE);');
dbms_output.put_line('sys.dbms_scheduler.set_attribute( name => ''"PERFSTAT"."SNAP_SUIVI_ASH"'', attribute => ''job_weight'', value => 1); ');
dbms_output.put_line('sys.dbms_scheduler.set_attribute( name => ''"PERFSTAT"."SNAP_SUIVI_ASH"'', attribute => ''auto_drop'', value => TRUE); ');
dbms_output.put_line('sys.dbms_scheduler.enable( ''"PERFSTAT"."SNAP_SUIVI_ASH"'' ); ');
dbms_output.put_line('END;');
dbms_output.put_line('/');

dbms_output.put_line('BEGIN');
dbms_output.put_line('sys.dbms_scheduler.create_job( ');
dbms_output.put_line('job_name => ''"PERFSTAT"."PURGE SUIVI_ASH"'',');
dbms_output.put_line('job_type => ''STORED_PROCEDURE'',');
dbms_output.put_line('job_action => ''"PERFSTAT"."PKG_ASH"."PURGE"'',');
dbms_output.put_line('repeat_interval => ''FREQ=DAILY;BYHOUR=22;BYMINUTE=0;BYSECOND=0'',');
dbms_output.put_line('start_date => systimestamp,');
dbms_output.put_line('job_class => ''"DEFAULT_JOB_CLASS"'',');
dbms_output.put_line('comments => ''Purge suivi_ash table'',');
dbms_output.put_line('auto_drop => FALSE,');
dbms_output.put_line('enabled => FALSE);');

dbms_output.put_line('sys.dbms_scheduler.set_attribute( name => ''"PERFSTAT"."PURGE SUIVI_ASH"'', attribute => ''job_weight'', value => 1); ');
dbms_output.put_line('sys.dbms_scheduler.set_attribute( name => ''"PERFSTAT"."PURGE SUIVI_ASH"'', attribute => ''auto_drop'', value => TRUE); ');
dbms_output.put_line('sys.dbms_scheduler.enable( ''"PERFSTAT"."PURGE SUIVI_ASH"'' ); ');
dbms_output.put_line('END;');
dbms_output.put_line('/');

dbms_output.put_line('--Fin Script a executer en dba--');
end;
---------------------------------------------------------------------------------------------------------------------
--procedure SUIVI_ASH
--IS
--	SQL_Dyn		Varchar( 10000 );
--	Oversion	Number;
--Begin
--	dbms_output.enable( 1000000 );
--
--	select  floor(to_number(regexp_replace(version,'\.',''))/1000)	INTO Oversion FROM v$instance;
--
--	if Oversion >= 111 then
--		
--			BEGIN
--			
--				SQL_Dyn := 'create table PERFSTAT.suivi_ash(';
--				SQL_Dyn := SQL_Dyn || ' inst_id number,';
--				SQL_Dyn := SQL_Dyn || ' sample_id  number,';
--				SQL_Dyn := SQL_Dyn || ' sample_time timestamp(6),';
--				SQL_Dyn := SQL_Dyn || ' session_id number,';
--				SQL_Dyn := SQL_Dyn || ' session_serial#  number,';
--				SQL_Dyn := SQL_Dyn || ' user_id number,';
--				SQL_Dyn := SQL_Dyn || ' sql_id varchar2(13),';
--				SQL_Dyn := SQL_Dyn || ' sql_child_number number,';
--				SQL_Dyn := SQL_Dyn || ' sql_opcode number,';
--				SQL_Dyn := SQL_Dyn || ' sql_plan_hash_value number,';
--				SQL_Dyn := SQL_Dyn || ' blocking_session  number,';
--				SQL_Dyn := SQL_Dyn || ' blocking_session_status varchar2(11),';
--				SQL_Dyn := SQL_Dyn || ' xid raw(8),';
--				SQL_Dyn := SQL_Dyn || ' event# number,';
--				SQL_Dyn := SQL_Dyn || ' EVENT VARCHAR2(64),';
--				SQL_Dyn := SQL_Dyn || ' p1 number,';
--				SQL_Dyn := SQL_Dyn || ' p2 number,';
--				SQL_Dyn := SQL_Dyn || ' p3 number,';
--				SQL_Dyn := SQL_Dyn || ' wait_time number,';
--				SQL_Dyn := SQL_Dyn || ' time_waited number,';
--				SQL_Dyn := SQL_Dyn || ' current_obj# number,';
--				SQL_Dyn := SQL_Dyn || ' current_file# number,';
--				SQL_Dyn := SQL_Dyn || ' current_block# number,';
--				SQL_Dyn := SQL_Dyn || ' program varchar2(48),';
--				SQL_Dyn := SQL_Dyn || ' module varchar2(64),';
--				SQL_Dyn := SQL_Dyn || ' action varchar2(64),';
--				SQL_Dyn := SQL_Dyn || ' client_id varchar2(64),';
--				SQL_Dyn := SQL_Dyn || ' service_hash number,';
--				SQL_Dyn := SQL_Dyn || ' session_type varchar2(64),';
--				SQL_Dyn := SQL_Dyn || ' session_state varchar2(7),';
--				SQL_Dyn := SQL_Dyn || ' wait_class_id number,';
--				SQL_Dyn := SQL_Dyn || ' blocking_inst_id number,';
--				SQL_Dyn := SQL_Dyn || ' sql_exec_id number,';
--				SQL_Dyn := SQL_Dyn || ' sql_exec_start date,';
--				SQL_Dyn := SQL_Dyn || ' plsql_entry_object_id number,';
--				SQL_Dyn := SQL_Dyn || ' plsql_entry_subprogram_id number,';
--				SQL_Dyn := SQL_Dyn || ' plsql_object_id number,';
--				SQL_Dyn := SQL_Dyn || ' plsql_subprogram_id number,';
--				SQL_Dyn := SQL_Dyn || ' resource_consumer_group varchar2(64),';
--				SQL_Dyn := SQL_Dyn || ' machine varchar2(64),';
--				SQL_Dyn := SQL_Dyn || ' con_id number)';
--				SQL_Dyn := SQL_Dyn || ' pctfree 0 pctused 99;';
--
--			EXECUTE IMMEDIATE SQL_Dyn;
--        EXCEPTION WHEN OTHERS THEN Null;
--      END;
--
--		BEGIN
--			SQL_Dyn := 'create index PERFSTAT.suivi_ash_idx on PERFSTAT.suivi_ash (sample_time);';
--			
--			EXECUTE IMMEDIATE SQL_Dyn;
--        EXCEPTION WHEN OTHERS THEN Null;
--    END;
--	
--		BEGIN
--			
--				SQL_Dyn := 'create table PERFSTAT.parameters_ash (name varchar2(32), value number);';
--				EXECUTE IMMEDIATE SQL_Dyn;
--				EXCEPTION WHEN OTHERS THEN Null;
--		END;		
--				insert into parameters values ('retention',7);
--				commit;
--	else 
--		null;
--	end if;
--
--
--END;

---------------------------------------------------------------------------------------------------------------------
End;