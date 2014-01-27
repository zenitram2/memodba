SELECT CAST(GETDATE() AS datetime) d,
    s.name 'Owner',
    ta.name  'TableName',
    c.name 'ColumnName',
    t.Name 'DataType',
    c.max_length 'MaxLength',
    c.precision 'Precision',
    c.scale  'Scale',
    c.is_nullable 'IsNullable',
    ISNULL(i.is_primary_key, 0) 'PrimaryKey',
    ISNULL(c.collation_name,'') 'CollationName'
FROM    
    <p>Database</p>.sys.columns c
INNER JOIN 
    <p>Database</p>.sys.types t ON c.system_type_id = t.system_type_id
LEFT OUTER JOIN 
    <p>Database</p>.sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    <p>Database</p>.sys.indexes i 
    ON ic.object_id = i.object_id AND ic.index_id = i.index_id
JOIN <p>Database</p>.sys.tables ta 
    ON c.object_id = ta.object_id 
join     <p>Database</p>.sys.schemas s
on ta.schema_id=s.schema_id
    order by ta.name;