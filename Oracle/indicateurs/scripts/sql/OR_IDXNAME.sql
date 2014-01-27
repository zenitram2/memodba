     BEGIN 
	 OPEN ? FOR  select sysdate RES_DATE,TABLESCHEMA,TABLENAME,INDEXNAME,NB from (
  select table_owner TABLESCHEMA, table_name TABLENAME, index_name INDEXNAME,count(column_name) NB 
  from dba_ind_columns
  where table_name not like 'BIN$%' 
  and table_owner not in ('SYS', 'DBSNMP', 'OUTLN', 'PERFSTAT', 'SYSTEM', 'XDB')
  and table_owner  in (<p>Schema</p>)
    and index_name  not in ( select constraint_name from   all_constraints where CONSTRAINT_TYPE in ('P','R'))
  group by table_owner, table_name  , index_name);
end;
 