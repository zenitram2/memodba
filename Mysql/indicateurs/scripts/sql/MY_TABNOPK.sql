select sysdate() d,tables.table_schema SchemaName
, tables.table_name TableName
from information_schema.tables
left join (
select table_schema
, table_name
from information_schema.statistics
group by table_schema
, table_name
, index_name
having 
sum(
case 
when non_unique = 0 
and nullable != 'YES' then 1 
else 0 
end
) = count(*)
) puks
on tables.table_schema = puks.table_schema
and tables.table_name = puks.table_name
where puks.table_name is null
and tables.table_type = 'BASE TABLE'