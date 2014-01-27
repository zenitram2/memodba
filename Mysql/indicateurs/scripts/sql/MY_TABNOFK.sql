SELECT sysdate() d,TABLE_SCHEMA ,TABLE_NAME,TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES t
where not exists (
select  1
from INFORMATION_SCHEMA.KEY_COLUMN_USAGE  k
where
t.TABLE_SCHEMA=k.TABLE_SCHEMA and
t.TABLE_NAME=k.TABLE_NAME
)
and t.table_schema <> 'information_schema'
and table_type='BASE TABLE'