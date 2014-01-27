     BEGIN 
	 OPEN ? FOR select 
 sysdate RES_DATE,owner TABLESCHEMA, table_name TABLENAME,count(column_name) NB from 
dba_tab_columns 
 where   table_name not like 'BIN$%' 
and owner not in ('SYS', 'DBSNMP', 'OUTLN', 'PERFSTAT', 'SYSTEM', 'XDB')
and owner  in (<p>Schema</p>)
 having count(column_name) > <p>NbCol</p>
group by owner,table_name
order by nb desc;
 end;