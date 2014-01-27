SELECT
sysdate()  d,TABLE_SCHEMA,TABLE_NAME,index_name,count(COLUMN_NAME)
FROM information_schema.statistics
group by TABLE_SCHEMA,TABLE_NAME,index_name
order by TABLE_SCHEMA,TABLE_NAME,index_name;