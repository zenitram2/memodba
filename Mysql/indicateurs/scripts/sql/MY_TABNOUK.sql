select sysdate() d,TABLE_SCHEMA ,TABLE_NAME
from (
SELECT TABLE_SCHEMA ,TABLE_NAME,count(COLUMN_NAME) nb
FROM INFORMATION_SCHEMA.columns
WHERE  column_key='UNI'
group by TABLE_SCHEMA ,TABLE_NAME
having count(COLUMN_NAME)=0)vue
order by TABLE_SCHEMA ,TABLE_NAME