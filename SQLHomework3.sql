--1. 

select distinct City
from Employees
where City in 
(select distinct City
from Customers)

--2.
--a

select distinct City
from Customers
where City not in 
(select distinct City
from Employees)

--b

select distinct c.City
from Customers as c
left join Employees as e 
on c.City = e.City
where e.City is Null

--3.

select p.ProductName, SUM(od.Quantity) as total
from Products as p
join [Order Details] as od
on p.ProductID = od.ProductID
group by p.ProductName

--4.

select c.City, SUM(od.Quantity) as total
from Customers as c
join Orders as o
on o.CustomerID = c.CustomerID
join [Order Details] as od
on o.OrderID = od.OrderID
group by c.City

--5.

select City, COUNT(CustomerID)
from Customers
group by City
having count(CustomerID) >= 2

--6.

select o.ShipCity, COUNT(p.ProductID)
from Orders as o
join [Order Details] as od
on o.OrderID = od.OrderID
join Products as p 
on p.ProductID = od.ProductID
group by o.ShipCity
having COUNT(p.ProductID) >= 2

--7.

select c.ContactName
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID
where c.City != o.ShipCity
group by c.ContactName

--8.

select top 5 p.ProductName, o.ShipCity, COUNT(od.Quantity), AVG(p.UnitPrice)
from Products as p
join [Order Details] as od
on p.ProductID = od.ProductID
join Orders as o
on o.OrderID  = od.OrderID
group by p.ProductName, o.ShipCity
order by COUNT(od.Quantity) desc

--9.
--a

select City
from Employees
where City not in 
(select ShipCity
from Orders)

--b
select distinct e.City
from Employees as e
left join Customers as c
on e.City = c.City
left join Orders as o
on o.CustomerID = c.CustomerID
where o.OrderID is Null

--10.

select distinct City
from(
(select top 1 c.City
from Customers as c
join Orders as o 
on c.CustomerID = o.CustomerID
join [Order Details] as od
on o.OrderID = od.OrderID
group by c.City
order by SUM(od.Quantity) desc)
union
(select top 1 e.City as City
from Employees as e
join Orders as o
on e.EmployeeID = o.EmployeeID
group by e.City
order by COUNT(o.OrderID) desc)
) as cities

--11. use ROW_NUMBER(), if two rows has same value, it will add 1 for the second value's rank record.