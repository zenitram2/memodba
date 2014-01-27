     BEGIN OPEN ? FOR select 
sysdate d,
owner  ,
TABLE_NAME TableName ,
Column_Name ColumnName,
data_type DataType,
data_length MaxLength,
nvl(data_precision,'') Precision,
nvl(data_scale,'') Scale,
decode(nullable,'Y',1,0) IsNullable,
' ' PrimaryKey,
' '  CollationName
from dba_tab_columns
where owner  in (<p>Schema</p>); end;