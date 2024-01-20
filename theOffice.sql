CREATE TABLE EmployeeDemographics
(EmployeeID int, 
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

Create Table EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int)

insert into EmployeeDemographics Values 
(1001, 'Jim', 'Halpert', 26, 'Male'),
(1002, 'Pam', 'Beesly', 26, 'Female'),
(1003, 'Dwight', 'Schrute', 35, 'Male'),
(1004, 'Angela', 'Martin', 29, 'Female'),
(1005, 'Toby', 'Flenderson', 41, 'Male'),
(1006, 'Michael', 'Scott', 39, 'Male'),
(1007, 'Meredith', 'Palmer', 45, 'Female'),
(1008, 'Stanley', 'Hudson',53, 'Male'),
(1009, 'Kevin', 'Malone', 36,'Male'),
(1010, 'Creed', 'Bratton', 79, 'Male'),
(1011, 'Kelly', 'Kapoor', 23, 'Female'),
(1012, 'Andy', 'Bernard', 31, 'Male'),
(1013, 'Erin', 'Hannon', 19, 'Female'),
(1014, 'Ryan', 'Howard', 26, 'Male'),
(1015, 'Holly', 'Flax', 32, 'Female'),
(1016, 'Oscar', 'Martinez', 32, 'Male'),
(1017, 'Phyllis', 'Vance', 39,'Female'),
(1018, 'Darryl', 'Philbin',33,'Male')

insert into EmployeeSalary Values 
(1001, 'Sales Represantative', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Sales Representative', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Sales Representative', 48000),
(1009, 'Accountant', 42000),
(1010, 'Quality Assurance', 51000),
(1011, 'Customer Service Representative', 37000),
(1012, 'Regional Director of Sales', 58000),
(1013, 'Receptionist', 34000),
(1014, 'Temp', 30000),
(1015, 'HR', 48000),
(1016, 'Accountant', 50000),
(1017, 'Sales Representative', 50000),
(1018, 'Warehouse Foreman', 36000)


select * from SQLTutorial.dbo.EmployeeDemographics
where Age >= 30

select * from SQLTutorial.dbo.EmployeeDemographics
where Age <= 32 and gender = 'Male'

select * from SQLTutorial.dbo.EmployeeDemographics
where FirstName in ( 'Jim', 'Michael', 'Creed')


select * from SQLTutorial.dbo.EmployeeDemographics
where LastName like '%S%'

select Gender, count (Gender) as GenderCount 
from SQLTutorial.dbo.EmployeeDemographics
group by Gender


select Gender, count (Gender) as GenderCount 
from SQLTutorial.dbo.EmployeeDemographics
where Age> 32
group by Gender
order by GenderCount Desc


select * from SQLTutorial.dbo.EmployeeDemographics
order by Age desc, Gender desc
  -- OR --

select * from SQLTutorial.dbo.EmployeeDemographics
order by 4 desc, 5 desc


select * from SQLTutorial.dbo.EmployeeDemographics
full outer join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


select EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary  from SQLTutorial.dbo.EmployeeDemographics
inner join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

select EmployeeDemographics. EmployeeID, FirstName, LastName, Salary
from SQLTutorial.dbo.EmployeeDemographics
inner join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	where FirstName <> 'Michael'
	Order by Salary desc

select JobTitle, avg(salary)
from SQLTutorial.dbo.EmployeeDemographics
inner join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	where JobTitle = 'Sales Representative'
	group by JobTitle


select FirstName, LastName, JobTitle, Salary,
	case 
		when JobTitle = 'Sales Representative' Then Salary + (Salary * .10)
		when JobTitle = 'Accountant' then Salary + (Salary * .05)
		when JobTitle = 'HR' then Salary + (Salary * .000001)
		else Salary + (Salary *.03)
	end as SalaryAfterRaise
from SQLTutorial.dbo.EmployeeDemographics
join SQLTutorial.dbo.EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT JobTitle, avg(Salary)
from SQLTutorial.dbo.EmployeeDemographics
join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle
having avg(salary) > 45000
order by Avg(Salary)

select *
from SQLTutorial.dbo.EmployeeDemographics

update SQLTutorial.dbo.EmployeeDemographics
set Age = 31, Gender = 'Female'
where EmployeeID = 1012

delete from SQLTutorial.dbo.EmployeeDemographics
where EmployeeID = 1005

select Demo.EmployeeID, Sal.Salary
from [SQLTutorial].[dbo].[EmployeeDemographics] Demo
join [SQLTutorial].[dbo].[EmployeeSalary] as Sal
	on Demo.EmployeeID =  Sal.EmployeeID

 select FirstName, LastName, Gender, Salary,
	count(gender) over (Partition BY Gender) as TotalGender
 from sqltutorial..EmployeeDemographics dem
join SQLTutorial..EmployeeSalary sal
	on dem.EmployeeID = sal.EmployeeID

select  Gender, count(gender) 
 from sqltutorial..EmployeeDemographics dem
join SQLTutorial..EmployeeSalary sal
	on dem.EmployeeID = sal.EmployeeID
group by Gender

with CTE_Employee as 
(select FirstName, LastName, Gender, Salary,
	count(gender) over (Partition BY Gender) as TotalGender,
	avg(salary) over (Partition BY Gender) as AvgSalary
 from SQLTutorial..EmployeeDemographics emp
join SQLTutorial..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
where Salary > '45000'
)
select FirstName, AvgSalary from CTE_Employee

Select * from #temp_Employee

insert into #temp_Employee Values (
'1001', 'HR', '45000')

insert into #temp_Employee
select * from SQLTutorial. .EmployeeSalary



Drop table if exists #Temp_Employee2

CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

Insert into #Temp_Employee2
Select JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
from SQLTutorial. .EmployeeDemographics emp
join SQLTutorial. .EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
group by JobTitle

select * from #Temp_Employee2



CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

select EmployeeID, trim(EmployeeID) as IDTRIM
from EmployeeErrors


select EmployeeID, ltrim(EmployeeID) as IDTRIM
from EmployeeErrors


select EmployeeID, rtrim(EmployeeID) as IDTRIM
from EmployeeErrors

select LastName, Replace(LastName, '- Fired', '') as LastNameFixed
from EmployeeErrors


select err.FirstName, dem.FirstName
from EmployeeErrors err
join EmployeeDemographics dem
	on err.FirstName = dem.FirstName

select SUBSTRING(err.FirstName,1,3), SUBSTRING(dem.FirstName,1,3)
from EmployeeErrors err
join EmployeeDemographics dem
	on SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

select FirstName, LOWER(FirstName)
from EmployeeErrors

select FirstName, upper(FirstName)
from EmployeeErrors

Create procedure Temp_Employee
as 
create table #temp_employee (
JobTitle varchar(100),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

insert into #temp_employee
select JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
from SQLTutorial. .EmployeeDemographics emp
join SQLTutorial. .EmployeeSalary sal
	on emp.EmployeeID =  sal.EmployeeID
group by JobTitle

select * from #temp_employee

exec Temp_Employee


select EmployeeID, Salary, (Select AVG(Salary) from EmployeeSalary) as AllAvgSalary
from EmployeeSalary


select EmployeeID, Salary,  AVG(Salary) over() as AllAvgSalary
from EmployeeSalary


select a.EmployeeID, AllAvgSalary
From (select EmployeeID, Salary,  AVG(Salary) over() as AllAvgSalary
from EmployeeSalary) a


select EmployeeID, JobTitle, Salary
from EmployeeSalary
where EmployeeID in (
		Select EmployeeID
		From EmployeeDemographics
		where Age > 30)
