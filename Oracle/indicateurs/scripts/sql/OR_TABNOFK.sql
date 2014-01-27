     BEGIN 
	 OPEN ? FOR  select sysdate RES_DATE, owner      TABLESCHEMA, table_name TABLENAME ,' '    TABLETYPE
from sys.all_tables
where temporary = 'N'
and substr(table_name,1,4) != 'BIN$'
and substr(table_name,1,3) != 'DR$'
and (owner,table_name) not in (select owner, table_name from sys.all_constraints
where constraint_type = 'R')
and owner not in ('SYS', 'DBSNMP', 'OUTLN', 'PERFSTAT', 'SYSTEM', 'XDB')
and owner  in (<p>Schema</p>);
end;
 