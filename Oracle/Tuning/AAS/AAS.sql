--set serveroutput on;
DECLARE
TYPE DataSource
IS
    REF
    CURSOR;
        CODE        VARCHAR(32767) DEFAULT 'AAS';
        INSTANCEN   NUMBER DEFAULT 1 ;
        DATE_INFO   VARCHAR(32767) DEFAULT NULL;
        INST_NUMBER NUMBER DEFAULT 1;
        Src DataSource ;
        Src2 DataSource ;
        CPU_COUNT              NUMBER;
        wSNAP_ID               NUMBER;
        wSNAP_TIME             DATE;
        wSNAP_TIME_OLD         DATE;
        wTIME_WAITED_MICRO     NUMBER;
        wVALUE                 NUMBER;
        wTIME_WAITED_MICRO_OLD NUMBER;
        wVALUE_OLD             NUMBER;
        C1                     NUMBER;
        C2                     NUMBER;
        C3                     NUMBER;
        C4                     NUMBER;
        C5                     NUMBER;
        C6                     NUMBER;
        RVALUE                 NUMBER;
        DATEDEB                VARCHAR( 50 );
        DATE_INFO_             VARCHAR( 50 );
        DATEFIN                VARCHAR( 50 );
        oVersion               NUMBER;
        SQL_Dyn                VARCHAR( 5000 );
        wEVENT                 VARCHAR(32627) ;
        wCHAMP                 VARCHAR( 200 );
        i                      NUMBER;
        PARAM                  VARCHAR(32627) DEFAULT 'RUBRIQUE';
        IDLE                   VARCHAR(32627) DEFAULT 'N';
        wDATEDEB               VARCHAR( 50 );
        wDATEFIN               VARCHAR( 50 );
        wVersion_Tuning        VARCHAR( 50 );
        wVersion_CP            VARCHAR( 50 );
        wVersion_SPV           VARCHAR( 50 );
        wVersion_Carto         VARCHAR( 50 );
        wSTATUS                VARCHAR( 500 );
        wEXEC                  NUMBER;
    BEGIN
        wTIME_WAITED_MICRO_OLD := NULL;
        wVALUE_OLD             := NULL;
        SELECT SUBSTR( VERSION, 1, instr( VERSION, '.' )-1 )
        INTO Oversion
        FROM v$instance;
    IF DATE_INFO IS NULL THEN
        SELECT TO_CHAR( MAX( snap_time ), 'YYYYMMDD HH24:MI' )
        INTO DATE_INFO_
        FROM stats$snapshot
        WHERE INSTANCE_NUMBER = INST_NUMBER;
    ELSE
        DATE_INFO_ := DATE_INFO;
    END IF;
    SELECT TO_CHAR( to_date( DATE_INFO_ , 'YYYYMMDD HH24:MI' )- .1, 'YYYYMMDD HH24:MI' )
    INTO DATEDEB
    FROM dual;
    SELECT TO_CHAR( to_date( DATE_INFO_ , 'YYYYMMDD HH24:MI' )+ .1, 'YYYYMMDD HH24:MI' )
    INTO DATEFIN
    FROM dual;
    wEVENT:='event';
    SELECT DECODE( wEVENT, 'ARCH random i/o', 'DISK_IO;SYSTEM_IO;', 'ARCH sequential i/o', 'DISK_IO;SYSTEM_IO;', 'ARCH wait for pending I/Os', 'DISK_IO;SYSTEM_IO;', 'async disk IO', 'DISK_IO;SYSTEM_IO;', 'control file parallel write', 'DISK_IO;SYSTEM_IO;', 'control file sequential read', 'DISK_IO;SYSTEM_IO;', 'control file single write', 'DISK_IO;SYSTEM_IO;', 'db file parallel write', 'DISK_IO;SYSTEM_IO;', 'io done', 'DISK_IO;SYSTEM_IO;', 'kfk: async disk IO', 'DISK_IO;SYSTEM_IO;', 'ksfd: async disk IO', 'DISK_IO;SYSTEM_IO;', 'kst: async disk IO', 'DISK_IO;SYSTEM_IO;', 'LGWR random i/o', 'DISK_IO;SYSTEM_IO;', 'LGWR sequential i/o', 'DISK_IO;SYSTEM_IO;', 'LNS ASYNC control file txn', 'DISK_IO;SYSTEM_IO;', 'Log archive I/O', 'DISK_IO;SYSTEM_IO;', 'log file parallel write', 'DISK_IO;SYSTEM_IO;', 'log file sequential read', 'DISK_IO;SYSTEM_IO;', 'log file single write', 'DISK_IO;SYSTEM_IO;', 'recovery read', 'DISK_IO;SYSTEM_IO;', 'RFS random i/o', 'DISK_IO;SYSTEM_IO;',
        'RFS sequential i/o', 'DISK_IO;SYSTEM_IO;', 'RFS write', 'DISK_IO;SYSTEM_IO;', 'RMAN backup  recovery I/O', 'DISK_IO;SYSTEM_IO;', 'Standby redo I/O', 'DISK_IO;SYSTEM_IO;', 'BFILE read', 'DISK_IO;USER_IO;', 'buffer read retry', 'DISK_IO;USER_IO;', 'Data file init write', 'DISK_IO;USER_IO;', 'Datapump dump file I/O', 'DISK_IO;USER_IO;', 'db file parallel read', 'DISK_IO;USER_IO;', 'db file scattered read', 'DISK_IO;USER_IO;', 'db file sequential read', 'DISK_IO;USER_IO;', 'db file single write', 'DISK_IO;USER_IO;', 'dbms_file_transfer I/O', 'DISK_IO;USER_IO;', 'DG Broker configuration file I/O', 'DISK_IO;USER_IO;', 'direct path read', 'DISK_IO;USER_IO;', 'direct path read (lob) ', 'DISK_IO;USER_IO;', 'direct path read temp', 'DISK_IO;USER_IO;', 'direct path write', 'DISK_IO;USER_IO;', 'direct path write (lob)', 'DISK_IO;USER_IO;', 'direct path write temp', 'DISK_IO;USER_IO;', 'local write wait', 'DISK_IO;USER_IO;', 'Log file init write', 'DISK_IO;USER_IO;',
        'read by other session', 'DISK_IO;USER_IO;', 'refresh controlfile command', 'LATENCY;AUTRES;', 'log file sync', 'LATENCY;COMMITS;', 'file open', 'LATENCY;FILE_OPS;', 'ARCH wait for flow-control', 'LATENCY;NETWORK;', 'ARCH wait for net re-connect', 'LATENCY;NETWORK;', 'ARCH wait for netserver detach', 'LATENCY;NETWORK;', 'ARCH wait for netserver init 1', 'LATENCY;NETWORK;', 'ARCH wait for netserver init 2', 'LATENCY;NETWORK;', 'ARCH wait for netserver start', 'LATENCY;NETWORK;', 'Nothing.' )
    INTO wCHAMP
    FROM dual;
    DBMS_OUTPUT.PUT_LINE('wCHAMP :=>> ' || wCHAMP);
    IF wCHAMP = 'Nothing.' THEN
        SELECT DECODE( wEVENT, 'ARCH wait on ATTACH', 'LATENCY;NETWORK;', 'ARCH wait on DETACH', 'LATENCY;NETWORK;', 'ARCH wait on SENDREQ', 'LATENCY;NETWORK;', 'dedicated server timer', 'LATENCY;NETWORK;', 'dispatcher listen timer', 'LATENCY;NETWORK;', 'LGWR wait on ATTACH', 'LATENCY;NETWORK;', 'LGWR wait on DETACH', 'LATENCY;NETWORK;', 'LGWR wait on LNS', 'LATENCY;NETWORK;', 'LGWR wait on SENDREQ', 'LATENCY;NETWORK;', 'LNS wait on ATTACH', 'LATENCY;NETWORK;', 'LNS wait on DETACH', 'LATENCY;NETWORK;', 'LNS wait on LGWR', 'LATENCY;NETWORK;', 'LNS wait on SENDREQ', 'LATENCY;NETWORK;', 'SQL*Net message from dblink', 'LATENCY;NETWORK;', 'SQL*Net message to client', 'LATENCY;NETWORK;', 'SQL*Net message to dblink', 'LATENCY;NETWORK;', 'SQL*Net more data from client', 'LATENCY;NETWORK;', 'SQL*Net more data from dblink', 'LATENCY;NETWORK;', 'SQL*Net more data to client', 'LATENCY;NETWORK;', 'SQL*Net more data to dblink', 'LATENCY;NETWORK;', 'TCP Socket (KGAS)', 'LATENCY;NETWORK;',
            'process startup', 'LATENCY;PROCESS_CTL;', 'PX Deq: Join ACK', 'LATENCY;PROCESS_CTL;', 'PX Deq: Msg Fragment', 'LATENCY;PROCESS_CTL;', 'PX qref latch', 'LATENCY;PROCESS_CTL;', 'alter rbs offline', 'WAITS;ADMINISTRATIVE;', 'alter system set dispatcher', 'WAITS;ADMINISTRATIVE;', 'ASM COD rollback operation completion', 'WAITS;ADMINISTRATIVE;', 'ASM mount : wait for heartbeat', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtbackup', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtclose', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtclose2', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtcommand', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtend', 'WAITS;ADMINISTRATIVE;', 'Backup: sbterror', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtinfo', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtinfo2', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtinit', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtinit2', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtopen', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcbackup', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpccancel',
            'WAITS;ADMINISTRATIVE;', 'Backup: sbtpccommit', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcend', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcquerybackup', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcqueryrestore', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcrestore', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcstart', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcstatus', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtpcvalidate', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtread', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtread2', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtremove', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtremove2', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtrestore', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtwrite', 'WAITS;ADMINISTRATIVE;', 'Backup: sbtwrite2', 'WAITS;ADMINISTRATIVE;', 'buffer pool resize', 'WAITS;ADMINISTRATIVE;', 'enq: DB - contention', 'WAITS;ADMINISTRATIVE;', 'Nothing.' )
        INTO wCHAMP
        FROM dual;
    END IF;
    DBMS_OUTPUT.PUT_LINE('wCHAMP :=>> ' || wCHAMP);
    IF wCHAMP = 'Nothing.' THEN
        SELECT DECODE( wEVENT, 'enq: TW - contention', 'WAITS;ADMINISTRATIVE;', 'enq: ZG - contention', 'WAITS;ADMINISTRATIVE;', 'index (re)build online cleanup', 'WAITS;ADMINISTRATIVE;', 'index (re)build online merge', 'WAITS;ADMINISTRATIVE;', 'index (re)build online start', 'WAITS;ADMINISTRATIVE;', 'JS coord start wait', 'WAITS;ADMINISTRATIVE;', 'JS kgl get object wait', 'WAITS;ADMINISTRATIVE;', 'JS kill job wait', 'WAITS;ADMINISTRATIVE;', 'multiple dbwriter suspend/resume for file offline', 'WAITS;ADMINISTRATIVE;', 'switch logfile command', 'WAITS;ADMINISTRATIVE;', 'switch undo - offline', 'WAITS;ADMINISTRATIVE;', 'wait for possible quiesce finish', 'WAITS;ADMINISTRATIVE;', 'enq: KO - fast object checkpoint', 'WAITS;APPLICATION;', 'enq: PW - flush prewarm buffers', 'WAITS;APPLICATION;', 'enq: RO - contention', 'WAITS;APPLICATION;', 'enq: RO - fast object reuse', 'WAITS;APPLICATION;', 'enq: TM - contention', 'WAITS;APPLICATION;', 'enq: TX - row lock contention',
            'WAITS;APPLICATION;', 'enq: UL - contention', 'WAITS;APPLICATION;', 'SQL*Net break/reset to client', 'WAITS;APPLICATION;', 'SQL*Net break/reset to dblink', 'WAITS;APPLICATION;', 'Streams capture: filter callback waiting for ruleset', 'WAITS;APPLICATION;', 'Streams: apply reader waiting for DDL to apply', 'WAITS;APPLICATION;', 'Wait for Table Lock', 'WAITS;APPLICATION;', 'log file switch (clearing log file)', 'WAITS;CHECKPOINT;', 'log file switch/archive', 'WAITS;CHECKPOINT;', 'log switch/archive', 'WAITS;CHECKPOINT;', 'ASM PST query : wait for [PM][grp][0] grant', 'WAITS;CLUSTER_WAIT;', 'gc assume', 'WAITS;CLUSTER_WAIT;', 'gc block recovery request', 'WAITS;CLUSTER_WAIT;', 'gc buffer busy', 'WAITS;CLUSTER_WAIT;', 'gc claim', 'WAITS;CLUSTER_WAIT;', 'gc cr block 2-way', 'WAITS;CLUSTER_WAIT;', 'gc cr block 3-way', 'WAITS;CLUSTER_WAIT;', 'gc cr block busy', 'WAITS;CLUSTER_WAIT;', 'gc cr block congested', 'WAITS;CLUSTER_WAIT;', 'gc cr block lost', 'WAITS;CLUSTER_WAIT;',
            'gc cr block unknown', 'WAITS;CLUSTER_WAIT;', 'gc cr cancel', 'WAITS;CLUSTER_WAIT;', 'gc cr disk read', 'WAITS;CLUSTER_WAIT;', 'gc cr disk request', 'WAITS;CLUSTER_WAIT;', 'gc cr failure', 'WAITS;CLUSTER_WAIT;', 'gc cr grant 2-way', 'WAITS;CLUSTER_WAIT;', 'gc cr grant busy', 'WAITS;CLUSTER_WAIT;', 'gc cr grant congested', 'WAITS;CLUSTER_WAIT;', 'gc cr grant unknown', 'WAITS;CLUSTER_WAIT;', 'gc cr multi block request', 'WAITS;CLUSTER_WAIT;', 'gc cr request', 'WAITS;CLUSTER_WAIT;', 'gc current block 2-way', 'WAITS;CLUSTER_WAIT;', 'gc current block 3-way', 'WAITS;CLUSTER_WAIT;', 'gc current block busy', 'WAITS;CLUSTER_WAIT;', 'gc current block congested', 'WAITS;CLUSTER_WAIT;', 'gc current block lost', 'WAITS;CLUSTER_WAIT;', 'gc current block unknown', 'WAITS;CLUSTER_WAIT;', 'gc current cancel', 'WAITS;CLUSTER_WAIT;', 'gc current grant 2-way', 'WAITS;CLUSTER_WAIT;', 'gc current grant busy', 'WAITS;CLUSTER_WAIT;', 'gc current grant congested', 'WAITS;CLUSTER_WAIT;',
            'gc current grant unknown', 'WAITS;CLUSTER_WAIT;', 'gc current multi block request', 'WAITS;CLUSTER_WAIT;', 'gc current request', 'WAITS;CLUSTER_WAIT;', 'gc current retry', 'WAITS;CLUSTER_WAIT;', 'gc current split', 'WAITS;CLUSTER_WAIT;', 'gc domain validation', 'WAITS;CLUSTER_WAIT;', 'gc freelist', 'WAITS;CLUSTER_WAIT;', 'gc prepare', 'WAITS;CLUSTER_WAIT;', 'gc quiesce wait', 'WAITS;CLUSTER_WAIT;', 'gc recovery free', 'WAITS;CLUSTER_WAIT;', 'gc recovery quiesce', 'WAITS;CLUSTER_WAIT;', 'gc remaster', 'WAITS;CLUSTER_WAIT;', 'lock remastering', 'WAITS;CLUSTER_WAIT;', 'pi renounce write complete', 'WAITS;CLUSTER_WAIT;', 'retry contact SCN lock master', 'WAITS;CLUSTER_WAIT;', 'Streams: RAC waiting for inter instance ack', 'WAITS;CLUSTER_WAIT;', 'Nothing.' )
        INTO wCHAMP
        FROM dual;
    END IF;
    DBMS_OUTPUT.PUT_LINE('wCHAMP :=>> ' || wCHAMP);
    IF wCHAMP = 'Nothing.' THEN
        SELECT DECODE( wEVENT, 'buffer busy waits', 'WAITS;CONCURRENCE;', 'cursor: mutex S', 'WAITS;CONCURRENCE;', 'cursor: mutex X', 'WAITS;CONCURRENCE;', 'cursor: pin S wait on X', 'WAITS;CONCURRENCE;', 'enq: TX - index contention', 'WAITS;CONCURRENCE;', 'latch: cache buffers chains', 'WAITS;CONCURRENCE;', 'latch: In memory undo latch', 'WAITS;CONCURRENCE;', 'latch: undo global data', 'WAITS;CONCURRENCE;', 'latch: library cache', 'WAITS;CONCURRENCE;', 'latch: library cache lock', 'WAITS;CONCURRENCE;', 'latch: library cache pin', 'WAITS;CONCURRENCE;', 'latch: MQL Tracking Latch', 'WAITS;CONCURRENCE;', 'latch: row cache objects', 'WAITS;CONCURRENCE;', 'latch: shared pool', 'WAITS;CONCURRENCE;', 'latch: Undo Hint Latch', 'WAITS;CONCURRENCE;', 'library cache load lock', 'WAITS;CONCURRENCE;', 'library cache lock', 'WAITS;CONCURRENCE;', 'library cache pin', 'WAITS;CONCURRENCE;', 'os thread startup', 'WAITS;CONCURRENCE;', 'pipe put', 'WAITS;CONCURRENCE;', 'resmgr:internal state change',
            'WAITS;CONCURRENCE;', 'resmgr:internal state cleanup', 'WAITS;CONCURRENCE;', 'resmgr:sessions to exit', 'WAITS;CONCURRENCE;', 'row cache lock', 'WAITS;CONCURRENCE;', 'row cache read', 'WAITS;CONCURRENCE;', 'checkpoint completed', 'WAITS;CONFIGURATION;', 'enq: HW - contention', 'WAITS;CONFIGURATION;', 'enq: SQ - contention', 'WAITS;CONFIGURATION;', 'enq: SS - contention', 'WAITS;CONFIGURATION;', 'enq: ST - contention', 'WAITS;CONFIGURATION;', 'enq: TX - allocate ITL entry', 'WAITS;CONFIGURATION;', 'free buffer waits', 'WAITS;CONFIGURATION;', 'latch: redo copy', 'WAITS;CONFIGURATION;', 'latch: redo writing', 'WAITS;CONFIGURATION;', 'log buffer space', 'WAITS;CONFIGURATION;', 'log file switch (archiving needed)', 'WAITS;CONFIGURATION;', 'log file switch (checkpoint incomplete)', 'WAITS;CONFIGURATION;', 'log file switch (private strand flush incomplete)', 'WAITS;CONFIGURATION;', 'log file switch completion', 'WAITS;CONFIGURATION;', 'sort segment request',
            'WAITS;CONFIGURATION;', 'statement suspended, wait error to be cleared', 'WAITS;CONFIGURATION;', 'Streams AQ: enqueue blocked on low memory', 'WAITS;CONFIGURATION;', 'Streams capture: resolve low memory condition', 'WAITS;CONFIGURATION;', 'Streams capture: waiting for subscribers to catch up', 'WAITS;CONFIGURATION;', 'undo segment extension', 'WAITS;CONFIGURATION;', 'undo segment tx slot', 'WAITS;CONFIGURATION;', 'wait for EMON to process ntfns', 'WAITS;CONFIGURATION;', 'write complete waits', 'WAITS;CONFIGURATION;', 'enqueue', 'WAITS;ENQUEUE_LOCK;', 'ksbsrv', 'WAITS;ENQUEUE_LOCK;', 'reliable message', 'WAITS;ENQUEUE_LOCK;', 'LGWR wait for redo copy', 'WAITS;LGWR_WRITES;', 'latch free', 'WAITS;OTHER_LOCKS;', 'rdbms ipc reply', 'WAITS;OTHER_LOCKS;', 'wait list latch free', 'WAITS;OTHER_LOCKS;', 'PX Deq: Parse Reply', 'WAITS;QUERY_WAITS;', 'PX Deq: Table Q Get Keys', 'WAITS;QUERY_WAITS;', 'PX Deq: Table Q qref', 'WAITS;QUERY_WAITS;', 'PX Deq: Table Q Sample',
            'WAITS;QUERY_WAITS;', 'resmgr:become active', 'WAITS;SCHEDULER;', 'resmgr:cpu quantum', 'WAITS;SCHEDULER;', 'kksfbc child completion', 'WAITS;SHARED_POOL;', 'recursive cpu usage', 'CPU;RECURSIVE;', 'parse time cpu', 'CPU;PARSE;', 'CPU used by this session', 'CPU;USED;', 'ksu process alloc latch yield', 'WAITS;CONFIGURATION;', 'wait for MTTR advisory state object', 'WAITS;ALERTE ANOMALIE;', 'enq: WF - contention', 'WAITS;ALERTE ANOMALIE;', 'virtual circuit wait', 'LATENCY;NETWORK;', 'enq: US - contention', 'WAITS;CONFIGURATION;', 'Nothing.' )
        INTO wCHAMP
        FROM dual;
    END IF;
    DBMS_OUTPUT.PUT_LINE('wCHAMP :=>> ' || wCHAMP);
    -- Ajout Evenements Temps de service ENQUEUE
    IF wCHAMP = 'Nothing.' THEN
        SELECT DECODE( wEVENT, 'enq: AD - allocate AU', 'WAITS;ENQUEUES;', 'enq: AD - deallocate AU', 'WAITS;ENQUEUES;', 'enq: AF - task serialization', 'WAITS;ENQUEUES;', 'enq: AG - contention', 'WAITS;ENQUEUES;', 'enq: AO - contention', 'WAITS;ENQUEUES;', 'enq: AS - contention', 'WAITS;ENQUEUES;', 'enq: AT - contention', 'WAITS;ENQUEUES;', 'enq: AW - AW generation lock', 'WAITS;ENQUEUES;', 'enq: AW - AW state lock', 'WAITS;ENQUEUES;', 'enq: AW - AW$ table lock', 'WAITS;ENQUEUES;', 'enq: AW - user access for AW', 'WAITS;ENQUEUES;', 'enq: BR - file shrink', 'WAITS;ENQUEUES;', 'enq: BR - proxy-copy', 'WAITS;ENQUEUES;', 'enq: CF - contention', 'WAITS;ENQUEUES;', 'enq: CI - contention', 'WAITS;ENQUEUES;', 'enq: CL - compare labels', 'WAITS;ENQUEUES;', 'enq: CL - drop label', 'WAITS;ENQUEUES;', 'enq: CM - gate', 'WAITS;ENQUEUES;', 'enq: CM - instance', 'WAITS;ENQUEUES;', 'enq: CT - change stream ownership', 'WAITS;ENQUEUES;', 'enq: CT - CTWR process start/stop', 'WAITS;ENQUEUES;',
            'enq: CT - global space management', 'WAITS;ENQUEUES;', 'enq: CT - local space management', 'WAITS;ENQUEUES;', 'enq: CT - reading', 'WAITS;ENQUEUES;', 'enq: CT - state change gate 1', 'WAITS;ENQUEUES;', 'enq: CT - state change gate 2', 'WAITS;ENQUEUES;', 'enq: CT - state', 'WAITS;ENQUEUES;', 'enq: CU - contention', 'WAITS;ENQUEUES;', 'enq: DD - contention', 'WAITS;ENQUEUES;', 'enq: DF - contention', 'WAITS;ENQUEUES;', 'enq: DG - contention', 'WAITS;ENQUEUES;', 'enq: DL - contention', 'WAITS;ENQUEUES;', 'enq: DM - contention', 'WAITS;ENQUEUES;', 'enq: DN - contention', 'WAITS;ENQUEUES;', 'enq: DP - contention', 'WAITS;ENQUEUES;', 'enq: DR - contention', 'WAITS;ENQUEUES;', 'enq: DS - contention', 'WAITS;ENQUEUES;', 'enq: DT - contention', 'WAITS;ENQUEUES;', 'enq: DV - contention', 'WAITS;ENQUEUES;', 'enq: DX - contention', 'WAITS;ENQUEUES;', 'enq: FA - access file', 'WAITS;ENQUEUES;', 'enq: FB - contention', 'WAITS;ENQUEUES;', 'enq: FC - open an ACD thread',
            'WAITS;ENQUEUES;', 'enq: FC - recover an ACD thread', 'WAITS;ENQUEUES;', 'enq: FD - Flashback coordinator', 'WAITS;ENQUEUES;', 'enq: FD - Flashback on/off', 'WAITS;ENQUEUES;', 'enq: FD - Marker generation', 'WAITS;ENQUEUES;', 'enq: FD - Tablespace flashback on/off', 'WAITS;ENQUEUES;', 'enq: FG - FG redo generation enq race', 'WAITS;ENQUEUES;', 'enq: FG - LGWR redo generation enq race', 'WAITS;ENQUEUES;', 'enq: FG - serialize ACD relocate', 'WAITS;ENQUEUES;', 'enq: FL - Flashback database log', 'WAITS;ENQUEUES;', 'enq: FL - Flashback db command', 'WAITS;ENQUEUES;', 'enq: FM - contention', 'WAITS;ENQUEUES;', 'enq: FR - contention', 'WAITS;ENQUEUES;', 'enq: FS - contention', 'WAITS;ENQUEUES;', 'enq: FT - allow LGWR writes', 'WAITS;ENQUEUES;', 'enq: FT - disable LGWR writes', 'WAITS;ENQUEUES;', 'enq: FU - contention', 'WAITS;ENQUEUES;', 'enq: HD - contention', 'WAITS;ENQUEUES;', 'enq: HP - contention', 'WAITS;ENQUEUES;', 'enq: HQ - contention', 'WAITS;ENQUEUES;',
            'enq: HV - contention', 'WAITS;ENQUEUES;', 'enq: IA - contention', 'WAITS;ENQUEUES;', 'enq: ID - contention', 'WAITS;ENQUEUES;', 'enq: IL - contention', 'WAITS;ENQUEUES;', 'enq: IM - contention for blr', 'WAITS;ENQUEUES;', 'Nothing.' )
        INTO wCHAMP
        FROM dual;
    END IF;
    DBMS_OUTPUT.PUT_LINE('wCHAMP :=>> ' || wCHAMP);
    IF wCHAMP = 'Nothing.' THEN
        SELECT DECODE( wEVENT, 'enq: IR - contention', 'WAITS;ENQUEUES;', 'enq: IR - contention2', 'WAITS;ENQUEUES;', 'enq: IS - contention', 'WAITS;ENQUEUES;', 'enq: IT - contention', 'WAITS;ENQUEUES;', 'enq: JD - contention', 'WAITS;ENQUEUES;', 'enq: JI - contention', 'WAITS;ENQUEUES;', 'enq: JQ - contention', 'WAITS;ENQUEUES;', 'enq: JS - contention', 'WAITS;ENQUEUES;', 'enq: JS - coord post lock', 'WAITS;ENQUEUES;', 'enq: JS - coord rcv lock', 'WAITS;ENQUEUES;', 'enq: JS - global wdw lock', 'WAITS;ENQUEUES;', 'enq: JS - job chain evaluate lock', 'WAITS;ENQUEUES;', 'enq: JS - job recov lock', 'WAITS;ENQUEUES;', 'enq: JS - job run lock - synchronize', 'WAITS;ENQUEUES;', 'enq: JS - q mem clnup lck', 'WAITS;ENQUEUES;', 'enq: JS - queue lock', 'WAITS;ENQUEUES;', 'enq: JS - running job cnt lock', 'WAITS;ENQUEUES;', 'enq: JS - running job cnt lock2', 'WAITS;ENQUEUES;', 'enq: JS - running job cnt lock3', 'WAITS;ENQUEUES;', 'enq: JS - slave enq get lock1', 'WAITS;ENQUEUES;',
            'enq: JS - slave enq get lock2', 'WAITS;ENQUEUES;', 'enq: KK - context', 'WAITS;ENQUEUES;', 'enq: KM - contention', 'WAITS;ENQUEUES;', 'enq: KP - contention', 'WAITS;ENQUEUES;', 'enq: KT - contention', 'WAITS;ENQUEUES;', 'enq: MD - contention', 'WAITS;ENQUEUES;', 'enq: MH - contention', 'WAITS;ENQUEUES;', 'enq: ML - contention', 'WAITS;ENQUEUES;', 'enq: MN - contention', 'WAITS;ENQUEUES;', 'enq: MR - contention', 'WAITS;ENQUEUES;', 'enq: MS - contention', 'WAITS;ENQUEUES;', 'enq: MW - contention', 'WAITS;ENQUEUES;', 'enq: OC - contention', 'WAITS;ENQUEUES;', 'enq: OL - contention', 'WAITS;ENQUEUES;', 'enq: OQ - xsoq*histrecb', 'WAITS;ENQUEUES;', 'enq: OQ - xsoqhiAlloc', 'WAITS;ENQUEUES;', 'enq: OQ - xsoqhiClose', 'WAITS;ENQUEUES;', 'enq: OQ - xsoqhiFlush', 'WAITS;ENQUEUES;', 'enq: OQ - xsoqhistrecb', 'WAITS;ENQUEUES;', 'enq: PD - contention', 'WAITS;ENQUEUES;', 'enq: PE - contention', 'WAITS;ENQUEUES;', 'enq: PF - contention', 'WAITS;ENQUEUES;', 'enq: PG - contention',
            'WAITS;ENQUEUES;', 'enq: PH - contention', 'WAITS;ENQUEUES;', 'enq: PI - contention', 'WAITS;ENQUEUES;', 'enq: PL - contention', 'WAITS;ENQUEUES;', 'enq: PR - contention', 'WAITS;ENQUEUES;', 'enq: PS - contention', 'WAITS;ENQUEUES;', 'enq: PT - contention', 'WAITS;ENQUEUES;', 'enq: PV - syncshut', 'WAITS;ENQUEUES;', 'enq: PV - syncstart', 'WAITS;ENQUEUES;', 'enq: PW - prewarm status in dbw0', 'WAITS;ENQUEUES;', 'enq: RB - contention:', 'WAITS;ENQUEUES;', 'enq: RF - atomicity', 'WAITS;ENQUEUES;', 'enq: RF - new AI', 'WAITS;ENQUEUES;', 'enq: RF - synch: per-SGA Broker metadata', 'WAITS;ENQUEUES;', 'enq: RF - synchronization: aifo master', 'WAITS;ENQUEUES;', 'enq: RF - synchronization: chief', 'WAITS;ENQUEUES;', 'enq: RF - synchronization: critical ai', 'WAITS;ENQUEUES;', 'enq: RF - synchronization: HC master', 'WAITS;ENQUEUES;', 'enq: RN - contention', 'WAITS;ENQUEUES;', 'enq: RP - contention', 'WAITS;ENQUEUES;', 'enq: RS - file delete', 'WAITS;ENQUEUES;',
            'enq: RS - persist alert level', 'WAITS;ENQUEUES;', 'enq: RS - prevent aging list update', 'WAITS;ENQUEUES;', 'enq: RS - prevent file delete', 'WAITS;ENQUEUES;', 'enq: RS - read alert level', 'WAITS;ENQUEUES;', 'enq: RS - record reuse', 'WAITS;ENQUEUES;', 'enq: RS - write alert level', 'WAITS;ENQUEUES;', 'enq: RT - contention', 'WAITS;ENQUEUES;', 'enq: SB - contention', 'WAITS;ENQUEUES;', 'enq: SF - contention', 'WAITS;ENQUEUES;', 'enq: SH - contention', 'WAITS;ENQUEUES;', 'enq: SI - contention', 'WAITS;ENQUEUES;', 'enq: SK - contention', 'WAITS;ENQUEUES;', 'enq: SR - contention', 'WAITS;ENQUEUES;', 'enq: SU - contention', 'WAITS;ENQUEUES;', 'enq: SW - contention', 'WAITS;ENQUEUES;', 'enq: TA - contention', 'WAITS;ENQUEUES;', 'enq: TB - SQL Tuning Base Cache Load', 'WAITS;ENQUEUES;', 'enq: TB - SQL Tuning Base Cache Update', 'WAITS;ENQUEUES;', 'enq: TC - contention', 'WAITS;ENQUEUES;', 'enq: TC - contention2', 'WAITS;ENQUEUES;', 'enq: TD - KTF dump entries',
            'WAITS;ENQUEUES;', 'enq: TE - KTF broadcast', 'WAITS;ENQUEUES;', 'enq: TF - contention', 'WAITS;ENQUEUES;', 'enq: TL - contention', 'WAITS;ENQUEUES;', 'enq: TO - contention', 'WAITS;ENQUEUES;', 'enq: TQ - DDL contention', 'WAITS;ENQUEUES;', 'enq: TQ - INI contention', 'WAITS;ENQUEUES;', 'enq: TQ - TM contention', 'WAITS;ENQUEUES;', 'enq: TS - contention', 'WAITS;ENQUEUES;', 'enq: TT - contention', 'WAITS;ENQUEUES;', 'enq: TX - contention', 'WAITS;ENQUEUES;', 'enq: WA - contention', 'WAITS;ENQUEUES;', 'enq: WL - contention', 'WAITS;ENQUEUES;', 'enq: WP - contention', 'WAITS;ENQUEUES;', 'enq: XH - contention', 'WAITS;ENQUEUES;', 'enq: XR - database force logging', 'WAITS;ENQUEUES;', 'enq: XR - quiesce database', 'WAITS;ENQUEUES;', 'enq: XY - contention', 'WAITS;ENQUEUES;', 'Nothing.' )
        INTO wCHAMP
        FROM dual;
    END IF;
    SELECT value INTO CPU_COUNT FROM v$parameter WHERE name ='cpu_count';
    OPEN Src FOR SELECT SNAP_ID,
    SNAP_TIME FROM stats$snapshot WHERE snap_time >= to_date( DATEDEB, 'YYYYMMDD HH24:MI' ) AND snap_time <= to_date( DATEFIN, 'YYYYMMDD HH24:MI' ) AND INSTANCE_NUMBER= INST_NUMBER order by SNAP_ID ;
    LOOP
        FETCH Src INTO wSNAP_ID, wSNAP_TIME;
        EXIT
    WHEN Src%NOTFOUND;
        -- Recherche du WAIT TIME en fonction de la version ORACLE
        IF Oversion  = 8 THEN
            SQL_Dyn := ' select sum( TIME_WAITED)/1000 ' ;
            SQL_Dyn := SQL_Dyn || ' from stats$system_event ';
            SQL_Dyn := SQL_Dyn || ' where  snap_id = ' || wSNAP_ID;
            SQL_Dyn := SQL_Dyn || ' AND INSTANCE_NUMBER = ' || INST_NUMBER ;
            --SQL_Dyn := SQL_Dyn || ' AND PERFSTAT.OAR_PKG.Info_Carto( event , ''RUBRIQUE'' )  != ''HORS PERIMETRE'' ';
            SQL_Dyn := SQL_Dyn || ' AND '' || wCHAMP ||''  != ''HORS PERIMETRE'' ';
        ELSE
            SQL_Dyn := ' select sum( TIME_WAITED_MICRO)/1000000 ' ;
            SQL_Dyn := SQL_Dyn || ' from stats$system_event ';
            SQL_Dyn := SQL_Dyn || ' where  snap_id = ' || wSNAP_ID;
            SQL_Dyn := SQL_Dyn || ' AND INSTANCE_NUMBER = ' || INST_NUMBER ;
            SQL_Dyn := SQL_Dyn || ' AND '' || wCHAMP ||''  != ''HORS PERIMETRE'' ';
        END IF;
        DBMS_OUTPUT.PUT_LINE(SQL_Dyn);
        DBMS_OUTPUT.PUT_LINE(wSNAP_TIME);
        OPEN Src2 FOR SQL_Dyn;
        FETCH Src2 INTO wTIME_WAITED_MICRO;
        CLOSE Src2;
        -- Recherche du temps CPU
        SELECT value
        INTO wVALUE
        FROM stats$sysstat
        WHERE name                  = 'CPU used by this session' AND snap_id = wSNAP_ID;
        IF wTIME_WAITED_MICRO_OLD  IS NULL AND wVALUE_OLD IS NULL THEN
            wTIME_WAITED_MICRO_OLD := wTIME_WAITED_MICRO;
            wVALUE_OLD             := wVALUE;
            wSNAP_TIME_OLD         := wSNAP_TIME;
        ELSE
            C1                     := (wVALUE             - wVALUE_OLD) / (86400*(wSNAP_TIME - wSNAP_TIME_OLD));
            DBMS_OUTPUT.PUT_LINE('C1=>' ||C1);
            C1                     := C1                  /100;
            DBMS_OUTPUT.PUT_LINE('C1/10=>' ||C1);
            C2                     := C1                  /CPU_COUNT;
            DBMS_OUTPUT.PUT_LINE('C2=>' ||C2);
            C3                     := (wTIME_WAITED_MICRO - wTIME_WAITED_MICRO_OLD)/ (86400*(wSNAP_TIME - wSNAP_TIME_OLD));
            DBMS_OUTPUT.PUT_LINE('C3=>' ||C3);
            C4                     := C3                  /CPU_COUNT;
            DBMS_OUTPUT.PUT_LINE('C4=>' ||C4);
            C5                     := C1                  +C3;
            DBMS_OUTPUT.PUT_LINE('C5=>' ||C5);
            C6                     := C2                  +C4;
            DBMS_OUTPUT.PUT_LINE('C6=>' ||C6);
            wTIME_WAITED_MICRO_OLD := wTIME_WAITED_MICRO;
            wVALUE_OLD             := wVALUE;
            wSNAP_TIME_OLD         := wSNAP_TIME;
            IF DATE_INFO_           = TO_CHAR( wSNAP_TIME, 'YYYYMMDD HH24:MI' ) THEN
                RVALUE             := ROUND( C6, 4);
                DBMS_OUTPUT.PUT_LINE('RVALUE=>' ||RVALUE);
                EXIT;
            END IF;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(DATEDEB);
    DBMS_OUTPUT.PUT_LINE(DATEFIN);
    DBMS_OUTPUT.PUT_LINE( NVL( RVALUE,0 ) );
    IF DATEDEB   IS NULL THEN
        wDATEDEB := TO_CHAR( sysdate-30, 'YYYYMMDD' );
    ELSE
        wDATEDEB := DATEDEB;
    END IF;
    IF DATEFIN   IS NULL THEN
        wDATEFIN := TO_CHAR( sysdate, 'YYYYMMDD' );
    ELSE
        wDATEFIN := DATEFIN ;
    END IF;
    IF CODE      = 'AAS' THEN
        SQL_DYN := 'BEGIN perfstat.stats_pkg.Rubrique_proc ( ''' || wDATEDEB || ''', ''' || wDATEFIN || ''', ''TQ'', ''YYYYMMDD HH24:MI'', ''Y'' ';
        SQL_DYN := SQL_DYN || ', INSTANCE=>' || INSTANCEN ;
        SQL_DYN := SQL_DYN || ' ); END;';
        DBMS_OUTPUT.PUT_LINE(SQL_DYN);
    END IF;
END;
/
