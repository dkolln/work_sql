select schema_id, name, create_date 
from sys.tables
where create_date < getdate() -30
order by schema_id, name


select * from sys.schemas


Use Utility
select  s.name, t.name, t.create_date 
from sys.tables t
inner join sys.schemas s
on t.schema_id = s.schema_id
where create_date < getdate() -30 and s.name <> 'tsu'
order by t.schema_id, t.name
