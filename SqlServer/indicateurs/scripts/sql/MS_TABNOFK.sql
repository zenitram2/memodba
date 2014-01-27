select CAST(GETDATE() AS datetime) d,s.name,t.name,'TABLE'
from
bAspin.sys.tables t 
    join     <p>Database</p>.sys.schemas s
on t.schema_id=s.schema_id
where t.object_id not in(
select t.object_id 
from 
<p>Database</p>.sys.tables t 
where  exists (select 1 from <p>Database</p>.sys.foreign_keys k
    where  k.parent_object_id = t.object_id ));