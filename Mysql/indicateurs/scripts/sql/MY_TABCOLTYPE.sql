select 
sysdate() d,
TABLE_SCHEMA 'Owner' ,
TABLE_NAME 'TableName' ,
Column_Name 'ColumnName',
data_type 'DataType',
ifnull(character_maximum_length,'') 'MaxLength',
ifnull(numeric_precision,'') 'Precision',
ifnull(numeric_scale,'') 'Scale',
if(is_nullable='NO',0,1) 'IsNullable',
' ' PrimaryKey,
ifnull(collation_name,' ') as 'CollationName'
from information_schema.columns 
where TABLE_SCHEMA not in ('information_schema');