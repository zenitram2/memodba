select CAST(GETDATE() AS datetime) d,s.name,t.name,ind.name,count(col.name)
FROM <p>Database</p>.sys.indexes ind 
INNER JOIN <p>Database</p>.sys.index_columns ic 
    ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
    INNER JOIN <p>Database</p>.sys.columns col 
    ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN <p>Database</p>.sys.tables t 
    ON ind.object_id = t.object_id 
join     <p>Database</p>.sys.schemas s
on t.schema_id=s.schema_id
group by s.name,t.name,ind.name
order by s.name,t.name,ind.name;