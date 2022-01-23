/* Use Komutu ile kullan�lacak db se�ilir.*/
use AdventureWorks2014

select * from Person.Person -- Select * ile t�m bilgileri �ekme i�lemi

select 
BusinessEntityID,
PersonType,
FirstName,
LastName
from Person.Person  -- select i�lemi ile istenilen de�erleri result olarak alma i�lemi

select 
ProductNumber,
Name,
Color,
ProductID
from Production.Product  -- �rnek ��lem

select Title,FirstName + ' ' + LastName from Person.Person -- + operat�r� ile birle�tirme

-- As kullanara Kolon isimini de�itirme kullanmadan de�i�tirme ve Kolon isminde bo�luk b�rakma
select Title as Unvan,FirstName �sim, LastName Soyisim, FirstName +' '+ LastName [�sim Soyisim] from Person.Person 

select top 10 BusinessEntityID,FirstName,LastName from Person.Person -- top kulluan�m� 

-- Top kullan�m� �rnek
select top 10 BusinessEntityID,FirstName +' '+ LastName Fullname from Person.Person

--Top kullan�m� y�zdesel �rnek
select top 10 percent BusinessEntityID,FirstName +' '+ LastName Fullname from Person.Person

--Where kullan�m� sorguda �art kullan�m� Select*from Tablo_ad� where �art
select * from Person.Person
where
PersonType = 'EM'

select * from Person.Person
where
FirstName='Ken'

select Name,ProductNumber,Color from Production.Product
where 
Color = 'Black'
-------------------------------------------------
-- And ve or Kullan�m�
select * from Production.Product
where
SizeUnitMeasureCode = 'CM' and
WeightUnitMeasureCode='LB' and
ReorderPoint=375

select ProductID,Name,ProductNumber,Color,Size from Production.Product
where
Color='Blue' or Color='Multi' or
Size='40'

-- operat�r kullan�mlar� 
select * from Production.Product
where
SafetyStockLevel < 500

select * from Production.Product
where
SafetyStockLevel > 500

select * from Production.Product
where
SafetyStockLevel >= 500

select * from Production.Product
where
SafetyStockLevel != 500

------�rnekler------

select top 10 * from Production.Product
where
Color='Black' or Color='Yellow'

select Name +' '+ ProductNumber,Color,ProductID from Production.Product
where
Color='Multi' and StandardCost > 6

select top 10 percent *from Production.Product
where
ListPrice > 0

select * from HumanResources.Employee--- like �rnekleri
where
NationalIDNumber like '%96%' and
JobTitle like 'research%' and
Gender = 'M'

select * from Sales.SalesOrderDetail ---- like �rnekleri
where
ProductID > 100 and ProductID < 1000 and
CarrierTrackingNumber like '%AE'

select * from Production.Product
where 
ProductNumber
in -- i�eriyorsa
(
'FR-R92B-58',
'FR-R92B-62',
'FR-R92B-44',
'FR-R92B-48',
'FR-R92B-56',
'FR-R92B-60',
'FR-R92B-42'
)

select * from Production.Product
where 
ProductNumber
not in -- i�ermiyorsa
(
'FR-R92B-58',
'FR-R92B-62',
'FR-R92B-44',
'FR-R92B-48',
'FR-R92B-56',
'FR-R92B-60',
'FR-R92B-42'
)

select * from Production.Product
where
ProductNumber like '%20%'
order by ProductID asc --- A-Z ye veya k���kten b�y��e s�ralama

select * from Production.Product
where
ProductNumber like '%20%'
order by ProductID desc --- Z-A ye veya b�y�kten k����e s�ralama

select * from Production.Product
where
ProductNumber like '%20%' --- Z-A ye veya b�y�kten k����e s�ralama
order by Name desc

select * from Production.Product
where
ProductNumber like '%20%' 
order by Name  --- A-Z ye veya k���kten b�y��e s�ralama

select Color, Sum(SafetyStockLevel), AVG(ListPrice) from Production.Product
where Color is not null
group by Color
having Color !='Red'  --Group by having kullan�m� 

select * from Production.Product
where 
ProductID in
(
select distinct ProductID from Sales.SalesOrderDetail --- distinct ile m�kerrer kay�tlardan kurtulmak
)
order by ProductID

select * from Production.Product
where
ProductID >=1 and ProductID <=500 --between komutu olmadan aral�ktan de�er �ekme

select * from Production.Product
where
ProductID between 1 and 500 --between komutu ile aral�ks�z de�er �ekme

select * from Person.Person inner join HumanResources.Employee on Person.BusinessEntityID = Employee.BusinessEntityID

select 
PP.BusinessEntityID,
PP.FirstName,
PP.LastName,
PP.MiddleName,
HRE.BirthDate,
HRE.JobTitle,
HRE.MaritalStatus
from Person.Person as PP inner join HumanResources.Employee HRE on PP.BusinessEntityID = HRE.BusinessEntityID
where
MiddleName is not null
order by BusinessEntityID -- inner join �rnek kullan�m�

select PP.ProductID,PP.Color,PP.Name,PP.ListPrice,SS.* from Production.Product as PP left join Sales.SalesOrderDetail SS on PP.ProductID=SS.ProductID
where Color is not null
order by pp.ProductID -- left join �rnke kullan�m�

select PP.Color,sum(SS.UnitPrice) from Production.Product as PP left join Sales.SalesOrderDetail SS on PP.ProductID=SS.ProductID
where Color is not null
group by Color
--order by pp.ProductID -- left join �rnke kullan�m�

select * from Sales.SalesOrderDetail
where
ProductID = 317 -- left join �rne�i sa�lamas�

select pp.BusinessEntityID,pp.FirstName,pp.LastName,he.BirthDate,he.Gender  
from Person.Person pp inner join HumanResources.Employee he on pp.BusinessEntityID=he.BusinessEntityID

select BusinessEntityID, --subquery
FirstName,
LastName,
(select BirthDate from HumanResources.Employee where BusinessEntityID=Person.BusinessEntityID) as BD,
(select Gender from HumanResources.Employee where BusinessEntityID=Person.Person.BusinessEntityID) as GD
from Person.Person
where
(select BirthDate from HumanResources.Employee where BusinessEntityID=Person.BusinessEntityID) is not null

-- product listesisini getirdi�inde hepsinin product categorysi ve subcategorysi gelicek
select * from Production.Product
select * from Production.ProductCategory
select* from Production.ProductSubcategory

select  --- �rnekleme ikili join kullan�m�
PP.ProductID,
PP.Name,
PP.ListPrice,
PSC.Name,
PC.Name
from 
Production.Product PP  left join Production.ProductSubcategory PSC on PP.ProductSubcategoryID= PSC.ProductSubcategoryID
left join Production.ProductCategory PC on PSC.ProductCategoryID=PC.ProductCategoryID --- JO�N GRUPLAMA �RNKERLER�

select --- �rnkeleme specific bilgiyi �ekme i�leme
PSCN,
PCN,
sum(ListPrice) as ToplamUcret
from
(select 
PP.ProductID,
PP.Name,
PP.ListPrice,
PSC.Name PSCN,
PC.Name PCN
from 
Production.Product PP  left join Production.ProductSubcategory PSC on PP.ProductSubcategoryID= PSC.ProductSubcategoryID
left join Production.ProductCategory PC on PSC.ProductCategoryID=PC.ProductCategoryID) ResultTable
group by PCN,PSCN
having PSCN is not null --�rnek