SELECT 'sp_helptext '''+sch.name+'.'+ OBJECT_NAME(id)+''''
    FROM SYSCOMMENTS s 
            inner join sys.procedures p on
                  p.object_id = s.id 
            inner join sys.schemas sch on
                  p.schema_id = sch.schema_id
    WHERE [text] LIKE '%ASCII%' 
   -- AND OBJECTPROPERTY(id, 'IsProcedure') = 1 
    GROUP BY 'sp_helptext '''+sch.name+'.'+ OBJECT_NAME(id)+''''
