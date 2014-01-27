SELECT CAST(GETDATE() AS datetime) d,
     s.name,t.name,count(index_id) nb
FROM <p>Database</p>.sys.indexes ind 
INNER JOIN <p>Database</p>.sys.tables t 
    ON ind.object_id = t.object_id 
join     <p>Database</p>.sys.schemas s
on t.schema_id=s.schema_id
group by s.name,t.name
having count(index_id)>=<p>NbIdx</p>
order by nb desc,s.name,t.name;