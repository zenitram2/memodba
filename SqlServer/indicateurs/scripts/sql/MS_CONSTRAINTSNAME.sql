select CAST(GETDATE() AS datetime) d,s.name,t.name,k.name,k.type 
from <p>Database</p>.sys.key_constraints k
join     <p>Database</p>.sys.schemas s
on k.schema_id=s.schema_id
INNER JOIN <p>Database</p>.sys.tables t 
    ON k.parent_object_id = t.object_id 
union all
select CAST(GETDATE() AS datetime) d,s.name,t.name,k.name,k.type 
FROM  <p>Database</p>.sys.foreign_keys k
join     <p>Database</p>.sys.schemas s
on k.schema_id=s.schema_id
INNER JOIN <p>Database</p>.sys.tables t 
    ON k.parent_object_id = t.object_id     
order by k.type,t.name, k.name;