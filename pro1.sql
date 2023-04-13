

							--PROJECT 2 – QUERYING A LARGE RELATIONAL DATABASE.--
----------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------



--1 Get all the details from the person table including email ID, phone number, and phone number type

select 
p.[BusinessEntityID], p.[FirstName], p.[MiddleName], p.[LastName],
e.[EmailAddressID], e.[EmailAddress],
pp.[PhoneNumberTypeID], pp.[PhoneNumber]
from
[Person].[Person] p
inner join
[Person].[EmailAddress] as e
on
e.BusinessEntityID=p.BusinessEntityID
inner join
[Person].[PersonPhone] as pp
on
pp.BusinessEntityID=e.BusinessEntityID

----------------------------------------------------------------------------------------------------------------------------------------------

--2. Get the details of the sales header order made in May 2011
select * 
from
[Sales].[SalesOrderHeader]
where
year([orderdate])='2011'
and
month([orderdate])='05';

------------------------------------------------------------------------------------------------------------------------------------------

--3. Get the details of the sales details order made in the month of May 2011
select * from 
[Sales].[SalesOrderDetail] as sd
right join
[Sales].[SalesOrderHeader] as sh
on 
sd.SalesOrderID=sh.SalesOrderID
where
year([orderdate])='2011'
and
month([orderdate])='05';


------------------------------------------------------------------------------------------------------------------------------------------------

--4. Get the total sales made in May 2011

select
year([salesorderheader].[orderdate]) as sales_year,
month([salesorderheader].[orderdate]) as sales_month,
sum(subtotal) as total_sales
from
[sales].[salesorderheader]
where
year([salesorderheader].[orderdate])='2011'
and
month([salesorderheader].[orderdate])='05'
group by
year([orderdate]),
month([orderdate])

------------------------------------------------------------------------------------------------------------------------------------------------


--5. Get the total sales made in the year 2011 by month order by increasing sales
select
year([salesorderheader].[orderdate]) as sales_year,
month([salesorderheader].[orderdate]) as sales_month,
sum(subtotal) as total_sales,
dense_rank()
over
(order by sum(subtotal) desc) as sales_rank
from [sales].[salesorderheader]
where
year([salesorderheader].[orderdate])='2011'
group by
year([orderdate]),
month([orderdate])
order by total_sales;


---------------------------------------------------------------------------------------------------------------------------------------------

--6. Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'
select
year([salesorderheader].[orderdate]) as sales_year,
month([salesorderheader].[orderdate]) as sales_month,
sum(subtotal) as total_sales,
[person].[firstname] as customer_firstname,
[person].[lastname] as customer_lastname
from [sales].[salesorderheader],
[person].[person],
[sales].[customer]
where
[salesorderheader].[customerid]=[customer].[customerid]
and
[person].[businessentityid]=[customer].personid
and
firstname='gustavo'
and
lastname='achong'
group by
year([orderdate]),
month([orderdate]),
[person].[firstname],
[person].[lastname]
order by
year([orderdate]),
month([orderdate]);


	
--**END OF THE PROJECT**--