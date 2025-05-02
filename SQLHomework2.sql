--1. 504 products

select COUNT(ProductID) as TotalNumOfProducts
from Production.Product

--2. 295 products

select COUNT(ProductSubcategoryID) from Production.Product

--3. 

select ProductSubcategoryID, COUNT(ProductSubcategoryID) as CountedProducts
from Production.Product
where ProductSubcategoryID is not Null
group by ProductSubcategoryID

--4. 209

select (count(ProductID) - COUNT(ProductSubcategoryID)) as ProductsNotHaveSubcategory
from Production.Product

--5. 

select SUM(Quantity) as SumOfQuantity
from Production.ProductInventory

--6. 

select ProductID, SUM(Quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having SUM(Quantity) < 100

--7.

select Shelf, ProductID, SUM(Quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by Shelf, ProductID
having SUM(Quantity) < 100

--8. 

select ProductID, AVG(Quantity) as AverageOfQuantity
from Production.ProductInventory
where LocationID = 10
group by ProductID

--9. 

select ProductID, Shelf,AVG(Quantity) as TheAvg
from Production.ProductInventory
where LocationID = 10
group by ProductID, Shelf

--10.

select ProductID, Shelf,AVG(Quantity) as TheAvg
from Production.ProductInventory
where LocationID = 10
group by ProductID, Shelf
having Shelf != 'N/A'

--11.

select Color, Class, Count(ProductID) as TheCount, AVG(ListPrice) as AvgPrice
from Production.Product
group by Color, Class
having Color is not Null and Class is not Null

--12.

select cr.Name as Country, sp.Name as Provice
from Person.StateProvince as sp join Person.CountryRegion as cr
on sp.CountryRegionCode = cr.CountryRegionCode

--13.

select cr.Name as Country, sp.Name as Provice
from Person.StateProvince as sp join Person.CountryRegion as cr
on sp.CountryRegionCode = cr.CountryRegionCode
where cr.Name in ('Germany', 'Canada')
order by cr.Name, sp.Name

use Northwind
go

--14.
select ProductName
from Products as p join 
[Order Details] as od
on p.ProductID = od.ProductID
join Orders as o
on o.OrderID = od.OrderID
where p.UnitsOnOrder > 0 and o.OrderDate >= DATEADD(YEAR, -27, GETDATE())
group by p.ProductName

--15.
select top 5 p.UnitsOnOrder, o.ShipPostalCode
from Products as p join 
[Order Details] as od
on p.ProductID = od.ProductID
join Orders as o
on o.OrderID = od.OrderID
where p.UnitsOnOrder != 0
order by p.UnitsOnOrder desc

--16.

select top 5 p.UnitsOnOrder, o.ShipPostalCode
from Products as p join 
[Order Details] as od
on p.ProductID = od.ProductID
join Orders as o
on o.OrderID = od.OrderID
where p.UnitsOnOrder != 0 and o.OrderDate >= DATEADD(YEAR, -27, GETDATE())
order by p.UnitsOnOrder desc

--17.

select City, COUNT(ContactName) as CustomersNumber
from Customers
group by city

--18.

select City, COUNT(ContactName) as CustomersNumber
from Customers
group by city
having COUNT(ContactName) > 2

--19.

select c.ContactName
from Customers as c 
join Orders as o 
on c.CustomerID = o.CustomerID
where o.OrderDate >= '1998-01-01'

--20.

select c.ContactName
from Customers as c 
join Orders as o 
on c.CustomerID = o.CustomerID
where o.OrderDate = (
select MAX(o.OrderDate)
from Orders as o
)

--21.

select c.ContactName, count(od.Quantity) as OrdersNumber
from Customers as c 
join Orders as o 
on c.CustomerID = o.CustomerID
join [Order Details] as od 
on od.OrderID = o.OrderID
group by c.ContactName

--22.

select c.ContactName, count(od.Quantity) as OrdersNumber
from Customers as c 
join Orders as o 
on c.CustomerID = o.CustomerID
join [Order Details] as od 
on od.OrderID = o.OrderID
group by c.ContactName
having count(od.Quantity) > 100

--23.

select s.CompanyName as [Supplier Company Name], sh.CompanyName as [Shipping Company Name]
from Suppliers as s
join Shippers as sh
on s.SupplierID = sh.ShipperID

--24.

select o.OrderDate, p.ProductName
from Products as p
join [Order Details] as od
on p.ProductID = od.ProductID
join Orders as o
on o.OrderID = od.OrderID
order by o.OrderDate

--25.

select e1.FirstName + ' ' + e1.LastName as e1, e2.FirstName + ' ' + e2.LastName as e2
from Employees as e1
join Employees as e2 
on e1.Title = e2.Title
where e1.EmployeeID != e2.EmployeeID

--26. 

select COUNT(ReportsTo)
from (
select FirstName, LastName, ReportsTo
from Employees where ReportsTo is not Null
) as c
group by FirstName
having COUNT(ReportsTo) >2

--27.

select City, CompanyName as Name, ContactName, 'Customer' as Type
from Customers 
union
select City, CompanyName as Name, ContactName, 'Supplier' as Type
from Suppliers