SELECT sysdate() d,
TABLE_SCHEMA,TABLE_NAME ,count( COLUMN_NAME) nb
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_KEY != ''
 group by table_schema,table_name
  having count(COLUMN_NAME)>=<p>NbIdx</p>
order by nb desc,TABLE_SCHEMA,TABLE_NAME ;