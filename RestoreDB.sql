-- This script restores  .bak files in the same 
-- If you are unsure of the current filepaths in use, you can query them from the database:

SELECT 
    MDF.database_id, 
    MDF.name, 
    MDF.physical_name as data_file, 
    LDF.physical_name as log_file, 
    db_size_mb = CAST((MDF.size * 8.0)/1024 AS DECIMAL(8,2)), 
    log_size_mb = CAST((LDF.size * 8.0 / 1024) AS DECIMAL(8,2))
FROM (SELECT * FROM sys.master_files WHERE type_desc = 'ROWS' ) MDF
JOIN (SELECT * FROM sys.master_files WHERE type_desc = 'LOG' ) LDF ON MDF.database_id = LDF.database_id



-- reswtaurar base dde datos .bak 
RESTORE DATABASE AdventureWorks2019
FROM DISK = 'D:\Bacaup\SQL Server Management Studio/AdventureWorks2019.bak'
WITH MOVE 'AdventureWorks2019' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA/AdventureWorks2019.mdf',
MOVE 'AdventureWorks2019_Log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA/AdventureWorks2019_Log.ldf'

RESTORE DATABASE AdventureWorks2022
FROM DISK = 'D:\Bacaup\SQL Server Management Studio/AdventureWorks2022.bak'
WITH MOVE 'AdventureWorks2022' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA/AdventureWorks2022.mdf',
MOVE 'AdventureWorks2022_Log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA/AdventureWorks2022_Log.ldf'

-- But read through the docs for the specific restoration sequence and parameters for your needs.