/* Use Komutu ile kullanýlacak db seçilir.*/
use AdventureWorks2014

select * from Person.Person -- Select * ile tüm bilgileri çekme iþlemi

select 
BusinessEntityID,
PersonType,
FirstName,
LastName
from Person.Person  -- select iþlemi ile istenilen deðerleri result olarak alma iþlemi

select 
ProductNumber,
Name,
Color,
ProductID
from Production.Product  -- Örnek Ýþlem

select Title,FirstName + ' ' + LastName from Person.Person -- + operatörü ile birleþtirme

-- As kullanara Kolon isimini deðitirme kullanmadan deðiþtirme ve Kolon isminde boþluk býrakma
select Title as Unvan,FirstName Ýsim, LastName Soyisim, FirstName +' '+ LastName [Ýsim Soyisim] from Person.Person 

select top 10 BusinessEntityID,FirstName,LastName from Person.Person -- top kulluanýmý 

-- Top kullanýmý örnek
select top 10 BusinessEntityID,FirstName +' '+ LastName Fullname from Person.Person

--Top kullanýmý yüzdesel örnek
select top 10 percent BusinessEntityID,FirstName +' '+ LastName Fullname from Person.Person

--Where kullanýmý sorguda þart kullanýmý Select*from Tablo_adý where þart
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
-- And ve or Kullanýmý
select * from Production.Product
where
SizeUnitMeasureCode = 'CM' and
WeightUnitMeasureCode='LB' and
ReorderPoint=375

select ProductID,Name,ProductNumber,Color,Size from Production.Product
where
Color='Blue' or Color='Multi' or
Size='40'

-- operatör kullanýmlarý 
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

------Örnekler------

select top 10 * from Production.Product
where
Color='Black' or Color='Yellow'

select Name +' '+ ProductNumber,Color,ProductID from Production.Product
where
Color='Multi' and StandardCost > 6

select top 10 percent *from Production.Product
where
ListPrice > 0

select * from HumanResources.Employee--- like Örnekleri
where
NationalIDNumber like '%96%' and
JobTitle like 'research%' and
Gender = 'M'

select * from Sales.SalesOrderDetail ---- like Örnekleri
where
ProductID > 100 and ProductID < 1000 and
CarrierTrackingNumber like '%AE'

select * from Production.Product
where 
ProductNumber
in -- içeriyorsa
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
not in -- içermiyorsa
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
order by ProductID asc --- A-Z ye veya küçükten büyüðe sýralama

select * from Production.Product
where
ProductNumber like '%20%'
order by ProductID desc --- Z-A ye veya büyükten küçüðe sýralama

select * from Production.Product
where
ProductNumber like '%20%' --- Z-A ye veya büyükten küçüðe sýralama
order by Name desc

select * from Production.Product
where
ProductNumber like '%20%' 
order by Name  --- A-Z ye veya küçükten büyüðe sýralama

select Color, Sum(SafetyStockLevel), AVG(ListPrice) from Production.Product
where Color is not null
group by Color
having Color !='Red'  --Group by having kullanýmý 

select * from Production.Product
where 
ProductID in
(
select distinct ProductID from Sales.SalesOrderDetail --- distinct ile mükerrer kayýtlardan kurtulmak
)
order by ProductID

select * from Production.Product
where
ProductID >=1 and ProductID <=500 --between komutu olmadan aralýktan deðer çekme

select * from Production.Product
where
ProductID between 1 and 500 --between komutu ile aralýksýz deðer çekme

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
order by BusinessEntityID -- inner join örnek kullanýmý

select PP.ProductID,PP.Color,PP.Name,PP.ListPrice,SS.* from Production.Product as PP left join Sales.SalesOrderDetail SS on PP.ProductID=SS.ProductID
where Color is not null
order by pp.ProductID -- left join örnke kullanýmý

select PP.Color,sum(SS.UnitPrice) from Production.Product as PP left join Sales.SalesOrderDetail SS on PP.ProductID=SS.ProductID
where Color is not null
group by Color
--order by pp.ProductID -- left join örnke kullanýmý

select * from Sales.SalesOrderDetail
where
ProductID = 317 -- left join örneði saðlamasý

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

-- product listesisini getirdiðinde hepsinin product categorysi ve subcategorysi gelicek
select * from Production.Product
select * from Production.ProductCategory
select* from Production.ProductSubcategory

select  --- örnekleme ikili join kullanýmý
PP.ProductID,
PP.Name,
PP.ListPrice,
PSC.Name,
PC.Name
from 
Production.Product PP  left join Production.ProductSubcategory PSC on PP.ProductSubcategoryID= PSC.ProductSubcategoryID
left join Production.ProductCategory PC on PSC.ProductCategoryID=PC.ProductCategoryID --- JOÝN GRUPLAMA ÖRNKERLERÝ

select --- örnkeleme specific bilgiyi çekme iþleme
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
having PSCN is not null --Örnek