     BEGIN 
	 OPEN ? FOR select  sysdate RES_DATE, owner TABLESCHEMA,table_name TABLENAME ,count(index_name) NB 
 from dba_indexes
  where table_name not like 'BIN$%' 
  and owner not in ('SYS', 'DBSNMP', 'OUTLN', 'PERFSTAT', 'SYSTEM', 'XDB')
  and owner  in (<p>Schema</p>)
  group by owner, table_name
  having count(*) > <p>NbIdx</p>
  order by nb desc;
 end;