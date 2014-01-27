     BEGIN 	 
	 OPEN ? FOR  select sysdate RES_DATE,owner TABLESCHEMA, table_name TABLENAME, CONSTRAINT_NAME CONSTRAINTNAME,CONSTRAINT_TYPE CONSTRAINTTYPE
            from all_constraints 
            where owner not in ('SYS', 'DBSNMP', 'OUTLN', 'PERFSTAT', 'SYSTEM', 'XDB')
			  and owner  in (<p>Schema</p>)
            and CONSTRAINT_TYPE in ('P','R');
end;
 