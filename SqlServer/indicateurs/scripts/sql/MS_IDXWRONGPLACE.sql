SELECT CAST(GETDATE() AS datetime) d,s.[name] 'schema', o.[name] 'name' , o.[type] 'objecttype', ISNULL(i.[name],'') 'index_name', ISNULL(i.[index_id],0) 'indexid' , f.[name] 'filegroups'
FROM sys.indexes i
INNER JOIN sys.filegroups f
ON i.data_space_id = f.data_space_id
INNER JOIN sys.all_objects o
ON i.[object_id] = o.[object_id]
join     sys.schemas s
on o.schema_id=s.schema_id
WHERE i.data_space_id = f.data_space_id 
AND o.type = 'U' 
ORDER by f.name;