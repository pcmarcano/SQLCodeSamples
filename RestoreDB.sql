-- This querys funtcion is hoefuly import .bak files to any SQL server hosted in any OS local or in a network
-- and hopefully learn wtf this functions does

-- This script restores  .bak files in the same 
-- If you are unsure of the current filepaths in use, you can query them from the database:

drop AdventureWorks2022

DECLARE @dbname VARCHAR(100) = 'AdventureWorks2022', --filename without extention
    @fromdisk VARCHAR(1000) = NULL, 
    @withmove VARCHAR(1000) = NULL, 
    @move VARCHAR(1000) = NULL;
    -- NULL values should be replaced with filenames and paths

RESTORE DATABASE @dbname
FROM disk= 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\' + @dbname + '.bak'
WITH MOVE @dbname + '_data'
TO 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\' + @dbname + '.mdf',
MOVE @dbname + '_Log'
TO 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\' + @dbname + '.ldf'
,REPLACE





--https://www.datavail.com/blog/querying-the-sql-server-instance-and-os-level-details/
select @@version
-- Microsoft SQL Server 2022 (RTM-GDR) (KB5032968) - 16.0.1110.1 (X64) 	Nov  9 2023 22:31:58 	Copyright (C) 2022 Microsoft Corporation	Express Edition (64-bit) on Windows 10 Home Single Language 10.0 <X64> (Build 19045: )



SELECT 
    MDF.database_id, 
    MDF.name, 
    MDF.physical_name as data_file, 
    LDF.physical_name as log_file, 
    db_size_mb = CAST((MDF.size * 8.0)/1024 AS DECIMAL(8,2)), 
    log_size_mb = CAST((LDF.size * 8.0 / 1024) AS DECIMAL(8,2))
FROM (SELECT * FROM sys.master_files WHERE type_desc = 'ROWS' ) MDF
JOIN (SELECT * FROM sys.master_files WHERE type_desc = 'LOG' ) LDF ON MDF.database_id = LDF.database_id
WHERE MDF.name = 'master'

DECLARE @fd AS NVARCHAR(100)
SELECT @fd = log_file
FROM sys.master_files
WHERE name = 'master'
PRINT @fd





-- reswtaurar base dde datos .bak 
RESTORE DATABASE AdventureWorks2019
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup'
WITH MOVE 'AdventureWorks2019' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\AdventureWorks2019.mdf',
MOVE 'AdventureWorks2019_Log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\AdventureWorks2019_Log.ldf'

RESTORE DATABASE AdventureWorks2022
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup'
WITH MOVE 'AdventureWorks2022' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\AdventureWorks2022.mdf',
MOVE 'AdventureWorks2022_Log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\AdventureWorks2022_Log.ldf'

-- But read through the docs for the specific restoration sequence and parameters for your needs.


SELECT * FROM sys.databases
WHERE database_id = 1


USE [master]




SELECT CONCAT_WS('-', SalesOrderID, OrderDate)
FROM Sales.SalesOrderHeader

--****************************************************-- 
--Author: Timothy Ford (sqlagentman@yahoo.com)  
---------http://thesqlagentman.com 
-- returns nvarchar(4000) = dbo.fn_SQLServerBackupDir() 
--****************************************************-- 
IF OBJECT_ID('dbo.fn_SQLServerBackupDir') IS NOT NULL 
    DROP FUNCTION dbo.fn_SQLServerBackupDir 
GO 

CREATE FUNCTION dbo.fn_SQLServerBackupDir() 
RETURNS NVARCHAR(4000) 
AS 
BEGIN 

    DECLARE @path NVARCHAR(4000) 

   EXEC master.dbo.xp_instance_regread 
            N'HKEY_LOCAL_MACHINE', 
            N'Software\Microsoft\MSSQLServer\MSSQLServer',N'BackupDirectory', 
            @path OUTPUT,  
            'no_output' 
   RETURN @path 

END;

-- Como sacar la version de aqui y guardarlo en una variable
SELECT registry_key, value_name, value_data  
FROM sys.dm_server_registry  
WHERE value_name = N'CurrentVersion'
-- LEFT(N'CurrentVersion',3)
;  

SELECT registry_key, value_name, value_data  
FROM sys.dm_server_registry  
WHERE value_name = N'%data%'

WHERE registry_key LIKE N'%SuperSocketNetLib%'

;  