     BEGIN 	 
	 OPEN ? FOR  SELECT DISTINCT sysdate RES_DATE,
       constraint_name CONSTRAINT_NAME,
	 '' TABLECATALOG,
       child_owner TABLESCHEMA,
       child_table TABLENAME,
       constraint_columns COLUMNNAME,
       '' REF_TABLECATALOG,
       parent_owner REF_TABLESCHEMA,
       parent_table REF_TABLENAME,
	   '' REF_COLUMNNAME
  FROM (SELECT parent_owner,
               parent_table,
               child_owner,
               child_table,
               constraint_name,
               index_owner,
               index_name,
               MAX(CASE WHEN (cons_column_list = indx_column_list) THEN 1 ELSE 0 END)
                 OVER (PARTITION BY child_owner, child_table, parent_owner, parent_table, constraint_name) AS fk_indexed_p
          FROM (SELECT r.r_owner AS parent_owner,
                       c.table_name AS parent_table,
                       r.owner AS child_owner,
                       r.table_name AS child_table,
                       r.constraint_name,
                       i.index_owner,
                       i.index_name,
                       -- ordered list of columns for the constraint
                       LISTAGG(c.column_name,',')
                         WITHIN GROUP (ORDER BY c.column_name)
                         OVER (PARTITION BY r.owner, r.table_name, r.r_owner, c.table_name, r.constraint_name, i.index_owner, i.index_name) AS cons_column_list,
                       -- ordered list of columns for the index
                       LISTAGG(i.column_name,',')
                         WITHIN GROUP (ORDER BY i.column_name)
                         OVER (PARTITION BY r.owner, r.table_name, r.r_owner, c.table_name, r.constraint_name, i.index_owner, i.index_name) AS indx_column_list
                  FROM DBA_CONSTRAINTS r
                  JOIN DBA_CONS_COLUMNS c ON (c.owner = r.r_owner AND c.constraint_name = r.r_constraint_name)
                  LEFT OUTER
                  JOIN DBA_IND_COLUMNS i ON (c.owner = i.table_owner AND r.table_name = i.table_name AND c.position = i.column_position)
                 WHERE r.r_owner NOT IN ('SYS', 'DBSNMP', 'OUTLN', 'PERFSTAT', 'SYSTEM', 'XDB')
                   AND constraint_type = 'R'
                   ))
  JOIN (SELECT DISTINCT
               owner AS child_owner,
               table_name AS child_table,
               constraint_name,
               LISTAGG(column_name,',')
                 WITHIN GROUP (ORDER BY position)
                 OVER (PARTITION BY owner, constraint_name, table_name) AS constraint_columns
          FROM DBA_CONS_COLUMNS) USING (child_owner, child_table, constraint_name)
 WHERE fk_indexed_p = 0
 ORDER BY parent_owner, parent_table, child_owner, child_table, constraint_name;
end;
 