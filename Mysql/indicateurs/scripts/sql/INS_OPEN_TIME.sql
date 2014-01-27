BEGIN 
    OPEN ? FOR SELECT count(*)
    FROM v$thread T
    WHERE 
    TO_NUMBER (
        (TO_CHAR(SYSDATE,'J')    - TO_CHAR(T.open_time,'J'))    * 1440 + 
        (TO_CHAR(SYSDATE,'HH24') - TO_CHAR(T.open_time,'HH24')) * 60   +  
        (TO_CHAR(SYSDATE,'MI')   - TO_CHAR(T.open_time,'MI'))
    ) < <p>VDebut</p> OR 
    TO_NUMBER (
        (TO_CHAR(SYSDATE,'J')    - TO_CHAR(T.open_time,'J'))    * 1440 + 
        (TO_CHAR(SYSDATE,'HH24') - TO_CHAR(T.open_time,'HH24')) * 60   +  
        (TO_CHAR(SYSDATE,'MI')   - TO_CHAR(T.open_time,'MI'))
    ) > <p>VDelai</p>  ; 
end ;