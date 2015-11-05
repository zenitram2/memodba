
            SELECT s.INST_ID,
    SYSTIMESTAMP SAMPLE_TIME,
    s.SID SESSION_ID,
    s.SERIAL# SESSION_SERIAL#,
    s.USER# user_id,
    s.SQL_ID,
    s.SQL_CHILD_NUMBER,
    q.COMMAND_TYPE SQL_OPCODE,
    q.PLAN_HASH_VALUE SQL_PLAN_HASH_VALUE,
    s.BLOCKING_SESSION,
    s.BLOCKING_SESSION_STATUS,
    s.EVENT#,
    s.EVENT,
    s.P1,
    s.P2,
    s.P3,
    s.WAIT_TIME,
    (
    CASE
      WHEN s.state='WAITING'
      THEN s.ROW_WAIT_OBJ#
      ELSE -1
    END) CURRENT_OBJ#,
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P1text='file#'
      THEN s.P1
      ELSE -1
    END) CURRENT_FILE#,
    (
    CASE
      WHEN s.state='WAITING'
      AND s.P2text='block#'
      THEN s.P2
      ELSE -1
    END) CURRENT_BLOCK#,
    s.PROGRAM,
    s.MODULE,
    s.ACTION,
    s.CLIENT_IDENTIFIER CLIENT_ID,
    decode(d.NAME_HASH,null,0,d.NAME_HASH) SERVICE_HASH,
    DECODE(TYPE,'USER','FOREGROUND','BACKGROUND') SESSION_TYPE,
    DECODE(state,'WAITING','WAITING','ON CPU') SESSION_STATE,
    DECODE(state,'WAITING',s.WAIT_CLASS_ID,null) WAIT_CLASS_ID,
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