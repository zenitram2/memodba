select CAST(GETDATE() AS datetime) d,s.name,t.name
from
<p>Database</p>.sys.tables t 
    join     <p>Database</p>.sys.schemas s
on t.schema_id=s.schema_id
where t.name not in(
select t.name
from <p>Database</p>.sys.key_constraints k
INNER JOIN <p>Database</p>.sys.tables t 
    ON k.parent_object_id = t.object_id 
    where k.type ='PK');