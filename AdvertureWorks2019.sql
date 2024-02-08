-- https://www.youtube.com/watch?v=hvQu2S2-SGI&list=PLj1BSELljSRi8IjHMVBpxFNKM4Aq-M2Zi&index=1&t=3992s
-- orden de escritura
-- SELECT
-- FROM
-- WHERE
-- GROUP BY 
-- HAVING
-- ORDER BY
--

--Orden de ejecución
-- FROM     -- DESDE DONDE
-- JOIN 
-- WHERE    -- FILTROS
-- HAVING   -- CUANDO --FILTRO
-- ORDER BY
-- TOP
-- SELECT



use AdventureWorks2022
use AdventureWorks2019

SELECT 'hola sql';

DECLARE @N INT = 12
SELECT @N;

SELECT * 
FROM Person.Person;

SELECT * FROM [HumanResources].[Employee]
WHERE NationalIDNumber != 295847284
AND
OrganizationLevel = 1;

SELECT * FROM [HumanResources].[Employee]
WHERE VacationHours > 95;

SELECT * FROM [HumanResources].[Employee]
WHERE VacationHours <= 95;

SELECT * FROM [HumanResources].[Employee]
WHERE VacationHours >= 60
AND VacationHours <= 70;
-- es lo mismo que
SELECT * FROM
HumanResources.Employee
WHERE VacationHours between 60 and 70;

SELECT * FROM
HumanResources.Employee
WHERE NationalIDNumber = 413787783
or NationalIDNumber = 360868122;
-- es lo contrario
SELECT * FROM
HumanResources.Employee
WHERE NationalIDNumber <> 413787783
or NationalIDNumber <> 360868122
SELECT * FROM
HumanResources.Employee
WHERE NationalIDNumber NOT IN (413787783, 360868122)

SELECT * FROM [HumanResources].[Employee]
WHERE JobTitle like 'S%'


-- second character in the last name is e
select firstname, LastName
FROM Person.Person
WHERE LastName LIKE N'_e%'

-- first character in lasr name is A, B OR C
SELECT FirstName, LastName
from Person.Person 
WHERE LastName like N'[ABC]%'

-- first character in lasr name is A through e
SELECT FirstName, LastName
from Person.Person 
WHERE LastName like N'[A - E]%'


-- first character of last name is A B or C
SELECT FirstNAME, LASTNAME
FROM pERSON.Person
WHERE LastName like N'[ABC]%';

-- First character in last name is not a through e
SELECT firstname, lastname
FROM Person.Person
WHERE LastName LIKE N'[^A-E]%';

---------------------------
-- ORDER BY
-- ordena de forma descendente
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName DESC

-- ordena de forma ascendente
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName ASC


-- order multiple fields
SELECT NationalidNumber, Vacationhours, birthdate
from HumanResources.Employee
--order by 2 desc, 3 asc; -- by position in select
ORDER BY VacationHours DESC, BirthDate ASC;

--------------------------------
-- TOP
-- shows first records
-- by units
SELECT TOP (10) NationalIDNumber, vacationHours, birthdate
from HumanResources.Employee
ORDER BY 2 DESC;

-- by %
SELECT TOP 10 percent NationalIDNumber, vacationHours, birthdate
from HumanResources.Employee
ORDER BY 2 DESC;

-- by units includes ties
SELECT TOP (10) WITH TIES NationalIDNumber, vacationHours, birthdate
from HumanResources.Employee
ORDER BY 2 DESC;

------------------------------

-- GROUP BY

SELECT YEAR(BirthDate) as "Año Nacimiento"
FROM HumanResources.Employee
ORDER BY 1;

SELECT YEAR(BirthDate) as "Año Nacimiento", COUNT(YEAR(BirthDate)) AS Cantidad
FROM HumanResources.Employee
GROUP BY YEAR(BirthDate)
ORDER BY 1;

-- AGREGATION FUNCIONS SUMM, MIN, MAX, AVG, 
-- COUNT
-- Cuenta cantida de registros
SELECT COUNT(1) as "Cantidad"
FROM HumanResources.Employee
ORDER BY 1;

SELECT TOP (5) with TIES Year(BirthDate) AS "Año Nacimiento", COUNT(1) as "Cantidad"
FROM HumanResources.Employee
GROUP BY YEAR(BirthDate)
ORDER BY 2 DESC
;

SELECT TOP (5) with TIES Year(BirthDate) AS "Año Nacimiento", COUNT(1) as "Cantidad"
FROM HumanResources.Employee
GROUP BY YEAR(BirthDate)
ORDER BY 2 DESC
;

SELECT 
Gender as "Gender",
Year(BirthDate) AS "Año Nacimiento", 
MONTH(BirthDate) AS "Mes Nacimiento",
COUNT(1) as "Cantidad", 
MAX(VacationHours) AS Maxim,
MIN(VacationHours) AS Minim,
AVG(VacationHours) AS Average,
SUM(VacationHours) AS Summary
FROM HumanResources.Employee
GROUP BY YEAR(BirthDate), MONTH(BirthDate), Gender
ORDER BY SUM(VacationHours) DESC
;

----------
-- current date GETDATE()
SELECT GETDATE()
GO
SELECT YEAR(GETDATE())
GO
SELECT MONTH(GETDATE())
GO
SELECT DAY(GETDATE())
GO
SELECT EOMONTH(GETDATE())
GO


-- https://www.youtube.com/watch?v=P6mpJjHZTaU&list=PLj1BSELljSRi8IjHMVBpxFNKM4Aq-M2Zi&index=2
-------------------------
-- HAVING
SELECT 
Year(BirthDate) AS "Año Nacimiento", 
COUNT(1) as "Cantidad", 
MAX(VacationHours) AS Maxim,
MIN(VacationHours) AS Minim,
AVG(VacationHours) AS Average,
SUM(VacationHours) AS Summary
FROM HumanResources.Employee
GROUP BY YEAR(BirthDate)
HAVING AVG(VacationHours) > 60
   AND AVG(VacationHours) < 70
ORDER BY SUM(VacationHours) DESC
;

SELECT 
Year(BirthDate) AS "Año Nacimiento", 
COUNT(1) as "Cantidad", 
MAX(VacationHours) AS Maxim,
MIN(VacationHours) AS Minim,
AVG(VacationHours) AS Average,
SUM(VacationHours) AS Summary
FROM HumanResources.Employee
WHERE MaritalStatus = 'S'
GROUP BY YEAR(BirthDate)
HAVING AVG(VacationHours) > 60
ORDER BY SUM(VacationHours) DESC
;

---- CASE
SELECT NationalIDNumber, JobTitle,
    CASE WHEN Gender = 'M' THEN 'Macho'
         WHEN Gender = 'f' THEN 'Femina'
         ELSE 'n/a'
    END AS SEXO
    FROM HumanResources.Employee;

SELECT TOP 10 NationalIDNumber, JobTitle,
    CASE WHEN Gender = 'M' THEN 'Macho'
         WHEN Gender = 'f' THEN 'Femina'
         ELSE 'n/a'
    END AS SEXO
FROM HumanResources.Employee
WHERE MaritalStatus = 'S'
ORDER BY NationalIDNumber

-- null
SELECT *
FROM Person.Person

SELECT *
FROM Person.Person
WHERE Title NOT IN ('Mr.', 'Ms.')

SELECT *
FROM Person.Person
WHERE Title NOT IN ('Mr.', 'Ms.')
OR Title IS NULL

select *
from Person.Person
WHERE Title NOT IN ('Mr.', 'Ms.')
OR Title IS NOT NULL;

-- coloca espacios en blando cuando es nulo
SELECT ISNULL(Title, ''), *
FROM Person.Person



-----------------------------
-- join

-- INNER JOIN - SOLO MUESTR LAS COINCIDENCIAS
SELECT  C.AccountNumber,
        H.DueDate,
        H.OrderDate,
        H.SalesOrderID
FROM Sales.Customer AS C
Inner JOIN Sales.SalesOrderHeader AS H
on C.CustomerID = H.CustomerID

--- LEFT JOIN - mUSTRA LÑOS DATOS DE LA TABLA DE LA IZQUIERDA Sales.Customer todo lo que esta en la izquierda (Sales.Customer) por mas que no este en la derecha (Sales.SalesOrderHeader)
SELECT  C.AccountNumber,
        H.DueDate,
        H.OrderDate,
        H.SalesOrderID
FROM Sales.Customer AS C
LEFT JOIN Sales.SalesOrderHeader AS H
ON c.CustomerID = H.CustomerID

---- Clientes que no tienen ordenes
SELECT  C.AccountNumber,
        H.DueDate,
        H.OrderDate,
        H.SalesOrderID
FROM Sales.Customer AS C
LEFT JOIN Sales.SalesOrderHeader AS H
ON c.CustomerID = H.CustomerID
WHERE h.CustomerID is NULL
order BY c.AccountNumber

--- Right JOIN - Todo lo que esta a la derecha (Sales.SalesOrderHeader) por mas que no este en la izquierda (Sales.Customer)
SELECT  C.AccountNumber,
        H.DueDate,
        H.OrderDate,
        H.SalesOrderID
FROM Sales.Customer AS C
RIGHT JOIN Sales.SalesOrderHeader AS H
ON c.CustomerID = H.CustomerID

-- Right JOIN - combinar LEFT JOIN Y REIGHT JOIN
SELECT  C.AccountNumber,
        H.DueDate,
        H.OrderDate,
        H.SalesOrderID
FROM Sales.Customer AS C
FULL JOIN Sales.SalesOrderHeader AS H
ON c.CustomerID = H.CustomerID


-- CROSS JOIN - une dos tablas

DROP TABLE IF EXISTS dbo.T1
DROP TABLE IF EXISTS dbo.T2

CREATE TABLE dbo.T1 (nro INT)
CREATE TABLE dbo.T2 (nro INT)

INSERT INTO dbo.T1 (NRO)
VALUES (1), (2), (3)

INSERT INTO dbo.T2 (NRO)
VALUES (1), (2), (3)

SELECT * FROM T1
CROSS JOIN T2
CROSS JOIN t2 AS TX


------------------------------
-- SUB QUERY

-- scalar subqueries (must return ONE record)
--- declarar variables
DECLARE @MAXID AS INT = (select max(SalesOrderID)
                            FROM Sales.SalesOrderHeader);

SELECT SalesOrderId, Orderdate,CustomerID
from Sales.SalesOrderHeader
WHERE SalesOrderID = (SELECT MAX(SalesOrderID) FROM Sales.SalesOrderHeader);


--- multy valued  (can return more tha one record)
-- in 
SELECT SalesOrderID, orderdate, customerid
FROM Sales.SalesOrderHeader
WHERE TerritoryID IN (  SELECT TerritoryID 
                        FROM Sales.SalesTerritory
                        WHERE Name LIkE 'S%')
-- nAME NO SE PUEDE PONER EN SELECT DA ERROR
-- not in
SELECT *
FROM Sales.Customer
WHERE CustomerID NOT IN (SELECT CustomerID FROM Sales.SalesOrderHeader)

--- CORRELATED SUBQUERRIES
SELECT H.*
FROM Sales.SalesOrderHeader AS H
WHERE SalesOrderID = 
                    (SELECT MAX(h2.SalesOrderID)
                    FROM sALES.SalesOrderHeader as h2
                    WHERE h.CustomerID = H2.CustomerID)

-- Porcemntaje del total
SELECT 
    SalesOrderID, 
    OrderDate, 
    Subtotal, 
    CustomerID,
    (SELECT SUM(SubTotal)
        FROM Sales.SalesOrderHeader AS h2
        WHERE h.CustomerID = h2.CustomerID) AS TotalCliente,
    CAST(100.00 * SubTotal / (
        SELECT SUM(SubTotal)
        FROM Sales.SalesOrderHeader AS h2
        WHERE h.CustomerID = h2.CustomerID)
        AS decimal(18,2)
    ) AS PCt
FROM Sales.SalesOrderHeader AS h
ORDER BY h.CustomerID

--- EXISTS
SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Production.Product

-- PRODUCTOS COLOR SILVER VENDIDOS
SELECT 
    P.ProductID,
    p.Name,
    P.ProductNumber,
    p.Color
FROM Production.Product AS P
WHERE COLOR = N'Silver'
AND EXISTS
            (SELECT * FROM Sales.SalesOrderDetail as d
            WHERE d.ProductID = p.ProductID)

-- PRODUCTOS COLOR SILVER NO VENDIDOS
SELECT 
    P.ProductID,
    p.Name,
    P.ProductNumber,
    p.Color
FROM Production.Product AS P
WHERE COLOR = N'Silver'
AND not EXISTS
            (SELECT * FROM Sales.SalesOrderDetail as d
            WHERE d.ProductID = p.ProductID)

-- DERIVED Tables 
-- cuando se hace una consulta y en el select se hace una query

SELECT * FROM 
    ( SELECT * FROM Sales.SalesOrderHeader
    WHERE CustomerID = 29825) as ventas




-- no toma v1 porque no se permite reusar alias
SELECT * FROM
    (select COUNT(1) as Cantidad,
    YEAR(orderdate) as año
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate)
    ) as v1
    LEFT JOIN v1 as v2
    ON
    v1.año = v2.año + 1

-- correccion

SELECT  v1.año,
        v1.cantidad,
        ISNULL(v2.cantidad,0) AS cantidaañoanterior
        FROM
            (select COUNT(1) as cantidad,
            YEAR(orderdate) as año
            FROM Sales.Salesorderheader
            group by YEAR(orderdate)
            ) as v1
        left JOIN
            (select COUNT(1) as cantidad,
            YEAR(orderdate) as año
            FROM Sales.Salesorderheader
            group by YEAR(orderdate)
            ) as v2
        ON
        v1.año = v2.año +1
        ORDER BY v1.año

-- Tablas derivadas CTE

WITH datos AS
    (SELECT COUNT(1) as Cantidad,
    YEAR(orderdate) as año
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate))
select * from datos;

WITH datos AS
    (SELECT COUNT(1) as Cantidad,
    YEAR(orderdate) as año
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate))
select  datos.año, 
        datos.Cantidad,
        ISNULL(DATOS2.cantidad,0) as cantidadañoanterior
from datos
LEFT JOIN datos as DATOS2
ON datos.año = datos2.año + 1
ORDER by datos.año

--- Multiples CTE

with c1 AS
    (select COUNT(1) as Cantidad,
    YEAR(orderdate) as año
    FROM Sales.SalesOrderHeader
    ), 
    c2 AS
    (select año, COUNT (DISTINCT Customerid) as CantidadClientes
    from c1 
    group by año) 
SELECT * FROM c2
where cantidadclientes > 2000

-- recursive cte

if OBJECT_ID('dbo.empleados') is not null
drop table dbo.empleados
GO
CREATE TABLE dbo.empleados (id int not null,
                            jefeid int,
                            Nombre varchar (300),
                            puesto varchar(300))
GO

INSERT into dbo.empleados VALUES(100,null,' kjd ddfgjjkf','catush')

-- mostramos organigrama hasta el nivel 2
with reporte (id, jefeid, Nombre, puesto) AS (
    SELECT id, jefeid, Nombre, puesto, 0 as nivel
    FROM dbo.empleados
    WHERE jefeid is null -- traemos todos los que no tienen jefes
    union ALL
    SELECT e.id, e.jefeid, e.Nombre, e.puesto, nivel + 1
    FROM dbo.empleados e
    INNER join reporte d
    on e.jefeid = d.id
)
SELECT  reporte.id, 
        reporte.jefeid, 
        reporte.Nombre, 
        reporte.puesto, 
        empleados.Nombre as jefeNombre, 
        empleados.puesto as jefepuesto
FROM reporte
left JOIN dbo.empleados ON reporte.jefeid = empleados.id
WHERE nivel <= 2

-- https://www.youtube.com/watch?v=-Vx5ngZZK2s&list=PLj1BSELljSRi8IjHMVBpxFNKM4Aq-M2Zi&index=3

-- UNION | UNION ALL - para que funcione debe haber las misma cantidad de campos en la consulta

drop table if exists T1
drop table if exists T2

CREATE TABLE DBO.T1 (NRO INT)
CREATE TABLE DBO.T2 (NRO INT, C2 INT)

INSERT INTO dbo.T1 VALUES (1), (2), (6)
INSERT INTO DBO.T2 (NRO, C2) VALUES (9, 100), (2, 100), (3, 100), (4, 100)

SELECT * FROM T1
SELECT * FROM T2

-- UNION 

SELECT NRO FROM T1
UNION
SELECT NRO FROM T2

SELECT NRO FROM T1
UNION
SELECT C2 FROM T2

SELECT NRO, 0 AS C2 FROM T1
UNION
SELECT NRO, C2 FROM T2
ORDER BY NRO


-- UNION ALL
SELECT NRO FROM T1
UNION ALL
SELECT NRO FROM T2

-- INTERSECT & EXCEPT
-- INTERSECT
SELECT NRO FROM T1
INTERSECT
SELECT NRO FROM T2
-- EXCEPT -- PRIMERO HAY QUE PONER LA TABLA QUE SE VA A COMPARAR
SELECT NRO FROM T1
EXCEPT
SELECT NRO FROM T2

SELECT NRO FROM T2
EXCEPT
SELECT NRO FROM T1

-- RANKIN
--- ROW_NUMBER
SELECT  customerid, 
        subtotal, 
        ROW_NUMBER() OVER(order by subtotal desc) as rownum
FROM Sales.SalesOrderHeader
ORDER BY CustomerID

SELECT  customerid, 
        subtotal, 
        ROW_NUMBER() OVER(order by subtotal) as rownum,
        ROW_NUMBER() OVER(order by subtotal desc, OrderDate) as rownum2
FROM Sales.SalesOrderHeader
ORDER BY subtotal

-- PARTITIONING resetea el valor de rownum segun partition by
SELECT SalesOrderID,
        CustomerID,
        SubTotal,
        ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY subtotal) AS Rownum
        FROM Sales.SalesOrderHeader
        ORDER BY CustomerID;

-- PARTITIONING CON CTE

WITH C AS(
    SELECT SalesOrderID,
        CustomerID,
        SubTotal,
        ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY subtotal) AS Rownum
    FROM Sales.SalesOrderHeader
)
SELECT * FROM C WHERE Rownum <= 2

-- RANK  | DENSE_RANK

SELECT  customerid, 
        subtotal, 
        RANK() OVER(order by subtotal) as rank,
        DENSE_RANK() OVER(order by subtotal) as rankdense
FROM Sales.SalesOrderHeader
ORDER BY SubTotal



WITH C AS (
    SELECT i.ProductID,
            p.Name,
            i.LocationID,
            i.Quantity,
            DENSE_RANK() OVER(PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS RANK
        FROM Production.ProductInventory as i
        INNER join Production.Product as p
        ON i.Productid = p.productid
        WHERE i.Locationid BETWEEN 3 and 4
    )
SELECT * FROM C
WHERE rank <= 2
ORDER BY LocationID

-- ntile --- divide en partes iguales

SELECT CustomerID,
        SubTotal,
        NTILE(5) OVER (order by subtotal) as rank
FROM Sales.SalesOrderHeader
order BY CustomerID

-- PIVOT  -- convierte filaas en columnas

SELECT DaysToManufacture, AVG(StandardCost) as AverageCost
FROM Production.Product
GROUP BY DaysToManufacture

SELECT  'Average Cost' AS CostSortedByProductiionDays,
        [0], [1], [2], [3], [4]
FROM
    (
        SELECT DaysToManufacture, StandardCost
        from Production.Product
    ) as Sourcetable
PIVOT
    (
        AVG(StandardCost)
        FOR DaysToManufacture IN ([0], [1], [2], [3], [4])
    ) as pivottable;

SELECT vendorID, 
        [250] as emp1, [251] as emp2, [252] as emp3, [253] as emp4, [254] as emp5
        FROM (
            select PurchaseOrderID, EmployeeID, VendorID
            FROM Purchasing.PurchaseOrderHeader) AS P
        PIVOT(
            COUNT (PurchaseOrderID)
            FOR eMPLOYEEID IN
            ([250], [251], [252], [253], [254])
        ) AS PVT
    ORDER BY PVT.VendorID


-- UNPIVOT
DROP TABLE IF EXISTS PVT

CREATE TABLE PVT (VendorID INT, Emp1 INT,Emp2 INT, Emp3 INT,Emp4 INT, Emp5 INT)

INSERT INTO PVT VALUES(1,4,3,5,4,4);
INSERT INTO PVT VALUES(2,4,1,5,5,5);
INSERT INTO PVT VALUES(3,4,3,5,4,4);
INSERT INTO PVT VALUES(4,4,2,5,5,4);
INSERT INTO PVT VALUES(5,4,1,5,5,5);

select * FROM PVT


SELECT VendorID, Employee, Orders
FROM(
    SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5
    from PVT 
) as p
UNPIVOT(
    Orders for Employee IN (Emp1, Emp2, Emp3, Emp4, Emp5)
) AS unpvt

USE AdventureWorks2019
-- table sample
SELECT *
FROM Sales.Customer TABLESAMPLE SYSTEM (10 PERCENT)

SELECT * FROM Sales.SalesOrderHeader TABLESAMPLE SYSTEM (10 PERCENT)
WHERE OrderDate >= '01/01/2011'

SELECT TOP 10 *
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '01/01/2011'


-- NEWID() --GENERA CARACTERES DE FORMA ALEATOREA 7e8ff7e6-7704-44c8-9a30-60c2f61d0115
SELECT NEWID()

-- PAGINATION
--- PAGINATION NATIVA (MAS EFICIENTE)

DECLARE @PageSize TINYINT = 50,
        @CurrentPage INT = 1

SELECT SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY SalesOrderID
OFFSET (@PageSize * (@CurrentPage - 1))
ROWS
FETCH NEXT @PageSize ROWS ONLY;

-- PAGINATION CON CTE
DECLARE @NumberOfRows TINYINT = 50,
        @PageNumber INT = 1;

WITH OrderedRows AS
( SELECT    ROW_NUMBER() OVER (ORDER BY ProductID) AS RowNumber, 
            ProductID, 
            Name,
            Size, Color
FROM Production.Product
)
SELECT ProductID, Name, Size, Color
FROM OrderedRows
WHERE RowNumber between (((@PageNumber - 1) * @NumberOfRows) + 1)
                and (@PageNumber * @NumberOfRows)
ORDER BY ProductID




-- DECLARE -- Declarar variables

DECLARE @i AS INT;
SET @i = 100
SELECT @i as i
GO


DECLARE @I AS INT = 100

--- asignacion de consultas --- debe revolver un solo valor


DECLARE @lastname AS varchar(250)
set @lastname = (SELECT lastname
                    FROM Person.Person
                    where BusinessEntityID = 1)

SELECT @lastname AS emplastname

--------- multiples variables

DECLARE @FirstName AS NVARCHAR(20), @LastName AS NVARCHAR(40);

SELECT
    @FirstName = firstname,
    @LastName = lastname
    FROM Person.Person
    WHERE BusinessEntityID = 1

SELECT @FirstName as Name, @lastname AS Lastname

-- FLOW ELEMENTS
--- IF ELSE

IF YEAR(GETDATE()) = 2021
    SELECT 'es 2021' AS es
ELSE
    SELECT 'NO ES 2021' as noes
GO

IF YEAR(GETDATE()) = 2021
    SELECT 'es 2021' AS es
ELSE IF YEAR(GETDATE()) = 2020
    SELECT ' NO es 2020' AS es
ELSE
    SELECT 'NO ES 2021 NI 2020' as noes
GO

IF YEAR(GETDATE()) = 2024
BEGIN
    PRINT 'HOLA'
    PRINT 'MUNDO'
END

-- WHILE
DECLARE @I AS INT;
SET @I = 1
WHILE @I <= 10
BEGIN
    PRINT @I
    SET @I = @I + 1;
END
GO

DECLARE @I AS INT;
SET @I = 1
WHILE @I <= 10
BEGIN
    PRINT @I
    SET @I+= 1;
END
GO

---- BREAK

DECLARE @I AS INT;
SET @I = 1
WHILE @I <= 10
BEGIN
IF @I  = 6 BREAK
    PRINT @I
    SET @I+= 1;
END
GO


---- CONTINUE

DECLARE @I AS INT;
SET @I = 0
WHILE @I < 10
BEGIN
    SET @I+= 1;
    IF @I = 6 CONTINUE;
    PRINT @I
END
GO


-- T-SQL FUNCTION

--- fechas AAAAMMMDD
SELECT GETDATE() as Fecha, GETUTCDATE() As FechaUTC

SELECT YEAR(GETDATE()) as Año,
        MONTH(GETDATE()) as mes,
        DAY(GETDATE()) AS Día,
        DATEPART(DW, GETDATE()) as dia_semana,
        DATEPART(week, GETDATE()) as Num_Semana_del_Año

SELECT YEAR(OrderDate) ASaño_orderdate, * FROM sales.SalesOrderHeader

SELECT DATEDIFF(DAY,'19770309', GETDATE()) as Dias,
        DATEDIFF(MONTH, '19770309', GETDATE()) as Meses,
        DATEDIFF(year, '19770309', GETDATE()) as Años,
        DATEDIFF(WEEK, '19770309', GETDATE()) as Semanas,
        DATEDIFF(WEEKDAY, '19770309', GETDATE()) as DiasSemanas

SELECT DATEADD(DAY, 1, '19770309') AS Un_dia_mas_al_cumpleaños,
        DATEADD(MONTH, -1, '19770309') AS Un_mes_menos_al_cumpleaños

SELECT EOMONTH('19770309') AS ultimo_diadel_mes

---- forma corecta de hace consultas en un rango de fechas

SELECT * 
FROM Sales.SalesOrderHeader
where OrderDate >= '20110101'
AND OrderDate <  '20120101'

-- CAST & CONVERT CAMBIAR TIPO DE DATOS
--- CAST
SELECT cast(GETDATE() as varchar(12))
SELECT cast('19770309' as varchar(12)) -- no funciona
--- CONVERT

SELECT CONVERT(varchar(12), GETDATE()) AS FECHA
SELECT CONVERT(varchar(10), GETDATE(), 112) AS FECHACONFORMATO
---- 112 FORMATO = aaaammdd
---- https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16


-- concatenar variable o valores
--- concatener characteres con numericos
DECLARE @int INT = 1,
    @n VARCHAR(100) = 'youareawesome'
SELECT @int + @n as respuesta; -- esto no fuinciona

DECLARE @intt INT = 1,
    @nt VARCHAR(100) = 'you are awesome'
SELECT @nt + ' number ' + CONVERT (varchar(10), @intt)as respuesta

--- concatenar valores con NULL

DECLARE @intn INT = 1,
    @nn VARCHAR(100) = NULL
SELECT CONVERT(varchar(10), @intn) + ISNULL(@nn,'')

--- CONCAT

DECLARE @INT INT = 1,
        @N VARCHAR(255) = NULL,
        @N2 DATETIME = GETDATE()

SELECT CONCAT (@INT, '-', @N, '-', @N2)


--- CONCAT_WS

SELECT CONCAT_WS('-', SalesOrderID, OrderDate)
FROM Sales.SalesOrderHeader

-- TRY_CONVERT
SELECT 
    CASE WHEN TRY_CONVERT(float, 12365.987) is NULL
    THEN 'cast falló'
    ELSE 'cast exitoso'
END as Result;


SET DATEFORMAT dmy;  
SELECT TRY_CONVERT(datetime2, '12/31/2010') AS Result;  
GO  

-- https://learn.microsoft.com/en-us/sql/t-sql/functions/try-convert-transact-sql?view=sql-server-ver16

-- choose --- si no hay valor en la posicion selecionada da resultado NULL

SELECT choose (5, 'manager', 'director', 'developer', 'tester') as Result

-- iif

DECLARE @A INT = 45, @B INT = 40;
SELECT [Result] = IIF(@A > @B, 'TRUE', 'FALSE')

-- LEFT (string)
SELECT LEFT(nAME,5), Name
FROM Production.Product
ORDER BY productid

--RIGHT (string)
SELECT right(nAME,5), Name
FROM Production.Product
ORDER BY productid


-- len (string) longitud de caracteres
SELECT len(nAME), Name
FROM Production.Product
ORDER BY productid


-- replicate (string) REPLICA CADENA DE CARACTERES N CANTIDAD DE VECES
SELECT REPLICATE('t', 5), Name
FROM Production.Product
ORDER BY productid

-- CHARINDEX (StRING)

DECLARE @document VARCHAR(64);
SELECT @document = 'noctilucent techtools '+ 'noctilucent homepage';
select charindex('noctilucent', @document);
GO
DECLARE @document VARCHAR(64);
SELECT @document = 'noctilucent techtools '+ 'noctilucent homepage';
select charindex('noctilucent', @document, 10);
GO
-- SUBSTRING (CAMPO O VARIABLE QUE TIENE EL VALOR, POSICION DE INICIO, CANTIDAD DE CAMPOS A TOMAR) (string) 
SELECT
    firstname, emailpromotion,
    SUBSTRING(FirstName, 1, 1) as Inicial,
    SUBSTRING(firstname, 3, 2) AS "tercer y cuarto caracter"
FROM Person.Person

---
DECLARE @MAIL VARCHAR(50) = 'noctilucent@techtools.COM'
DECLARE @POS INT = 0
SET @POS = CHARINDEX ('@', @MAIL)
SELECT @POS

SELECT SUBSTRING(@MAIL, 1, @POS -1) -- OBTIENE EL USUARIO
SELECT len(SUBSTRING(@MAIL, 1, @POS -1)) -- OBTIENE LA CANTIDAD DE CARACTERES DEL USUARIO