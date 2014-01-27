select CAST(GETDATE() AS datetime) d,table_schema,table_name,count(column_name) as Nb from 
<p>Database</p>.INFORMATION_SCHEMA.COLUMNS
group by table_schema,table_name
having count(column_name) >=<p>NbCol</p>
order by nb desc;