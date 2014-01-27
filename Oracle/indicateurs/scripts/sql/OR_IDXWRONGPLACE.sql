     BEGIN 	 	 
	 OPEN ? FOR  Select sysdate RES_DATE, table_owner TABLESCHEMA,TABLE_NAME TABLENAME,INDEX_TYPE OBJECTTYPE,INDEX_NAME INDEXNAME,' ' INDEXID,  tablespace_name FILEGROUPS
  From ALL_INDEXES I
 Where I.INDEX_TYPE <> 'LOB'
   And I.TABLESPACE_NAME Not Like '<p>PatternInd</p>%'
   And owner not in ('SYS', 'DBSNMP', 'OUTLN', 'PERFSTAT', 'SYSTEM', 'XDB')
   and owner  in (<p>Schema</p>);
end;
 