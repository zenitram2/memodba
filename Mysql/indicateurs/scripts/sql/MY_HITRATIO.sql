SELECT '*perc_full_table_scans', ROUND(1-((P1.VARIABLE_VALUE+P2.VARIABLE_VALUE) /(P1.VARIABLE_VALUE +P2.VARIABLE_VALUE+P3.VARIABLE_VALUE+P4.VARIABLE_VALUE+P5.VARIABLE_VALUE+P6.VARIABLE_VALUE)),2) VARIABLE_VALUE
FROM INFORMATION_SCHEMA.GLOBAL_STATUS P1, INFORMATION_SCHEMA.GLOBAL_STATUS P2, INFORMATION_SCHEMA.GLOBAL_STATUS P3, INFORMATION_SCHEMA.GLOBAL_STATUS P4, INFORMATION_SCHEMA.GLOBAL_STATUS P5, INFORMATION_SCHEMA.GLOBAL_STATUS P6
WHERE P1. VARIABLE_NAME = 'handler_read_rnd_next'
AND P2.VARIABLE_NAME    = 'handler_read_rnd'
AND P3.VARIABLE_NAME    ='handler_read_first'
AND P4.VARIABLE_NAME    = 'handler_read_next'
AND P5.VARIABLE_NAME    ='handler_read_key'
AND P6.VARIABLE_NAME    ='handler_read_prev'
UNION
SELECT '*INNODB_CACHE_HIT_RATIO',ROUND((1 -(GS1.VARIABLE_VALUE / GS2.VARIABLE_VALUE)) * 100,2)
FROM INFORMATION_SCHEMA.GLOBAL_STATUS AS GS1 STRAIGHT_JOIN INFORMATION_SCHEMA.GLOBAL_STATUS AS GS2
WHERE GS1.VARIABLE_NAME = 'INNODB_BUFFER_POOL_READS'
AND GS2.VARIABLE_NAME   = 'INNODB_BUFFER_POOL_READ_REQUESTS'
UNION
SELECT '*MYISAM_CACHE_HIT_RATIO',ROUND((1 -(GS1.VARIABLE_VALUE / GS2.VARIABLE_VALUE)) * 100,2)
FROM INFORMATION_SCHEMA.GLOBAL_STATUS AS GS1 STRAIGHT_JOIN INFORMATION_SCHEMA.GLOBAL_STATUS AS GS2
WHERE GS1.VARIABLE_NAME = 'KEY_READS'
AND GS2.VARIABLE_NAME   = 'KEY_READ_REQUESTS'
UNION
SELECT '*QCACHE_CACHE_HIT_RATIO',ROUND((GS1.VARIABLE_VALUE / GS2.VARIABLE_VALUE) * 100,2)
FROM INFORMATION_SCHEMA.GLOBAL_STATUS AS GS1 STRAIGHT_JOIN INFORMATION_SCHEMA.GLOBAL_STATUS AS GS2
WHERE GS1.VARIABLE_NAME = 'QCACHE_HITS'
AND GS2.VARIABLE_NAME   = 'COM_SELECT'
ORDER BY 1;