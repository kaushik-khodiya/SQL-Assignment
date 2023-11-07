-- SQL Assignment by Kaushik Khodiya, Last updated on 07 Nov 2023.

use hr;

-- 1. Display all information in the tables EMP and DEPT.
select * from employees;
select * from departments;

-- 2. Display only the hire date and employee name for each employee.
select first_name, Last_name, hire_date from employees;

-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title
select concat(first_name, ", ", job_id) as "Employee and title" from hr.employees;

-- 4. Display the hire date, name and department number for all clerks.
select hire_date, first_name, last_name, department_id from hr.employees where job_id like "%clerk";

-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT
select concat(employee_id, ",", first_name, ",", last_name, ",", email, ",", phone_number, ",", hire_date, ",", job_id, ",", salary) as "the output" from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000.
select * from employees where salary > 20000  ;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date.
select concat(first_name," ",last_name) as "Name", start_date as "Start Date"
from employees join job_history using (job_id);

-- 8. Display the names and hire dates of all employees in the order they were hired.
select first_name , last_name, hire_date from employees  order by hire_date;

-- 9. Display the names and salaries of all employees in reverse salary order.
select first_name, last_name, salary from employees order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.
select first_name, department_id, commission_pct, salary from employees
where salary and commission_pct is not null order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager.
select last_name, job_title from employees join jobs using (job_id) where manager_id is null;

-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select job_title, last_name, salary from jobs join employees using (job_id)
where job_title like "%stock_clerk" and salary not in (2500,3500,5000);

-- 13.Display the maximum, minimum and average salary and commission earned.
select max(salary), min(salary), avg(salary),max(commission_pct), min(commission_pct), avg(commission_pct) from employees;

-- 14.Display the department number, total salary payout and total commission payout for each department.
select department_id, sum(salary), sum(commission_pct) from employees group by department_id;

-- 15.Display the department number and number of employees in each department.
select department_id, count(*) from employees group by department_id having count(*);

-- 16. Display the department number and total salary of employees in each department
select department_id, sum(salary) from employees group by department_id;

-- 17. Display the employee's name who doesn't earn a commission. Order the result set without using the column name
select first_name, last_name, commission_pct from employees where commission_pct is null order by 1;

-- 18.Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately
select first_name as "Name", department_id, commission_pct,
case
when commission_pct is NULL then "No Commission" 
else commission_pct
end
as "Commission Remark"
from employees;

-- 19.Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately 
select first_name, salary, commission_pct,
case
when commission_pct is NULL then "no commission" 
else commission_pct*2
end
as "Commission Remark"
from employees;

-- 20.Display the employee's name, department id who have the first name same as another employee in the same department
select first_name, department_id, count(first_name) AS "Name Count" from employees
group by department_id, first_name having count(first_name)>1;

-- 21.Display the sum of salaries of the employees working under each Manager.
select manager_id, sum(salary) from employees group by manager_id;

-- 22. Select the Managers name, the count of employees working under and the department ID of the manager.
select m.first_name, count(e.employee_id) from employees as e join employees as m 
on e.manager_id=m.employee_id group by m.employee_id;

-- 23 Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!
select m.last_name as "Manager name", e.last_name as "Employee name", e.department_id, e.salary
from employees as e join employees as m on e.manager_id = m.employee_id
where e.last_name like "_a%";
-- group by m.last_name;

-- 24. Display the average of sum of the salaries and group the result with the department id. Order the result with the department id.
select avg(salary), sum(salary), department_id from employees
group by department_id order by department_id;

-- 25. Select the maximum salary of each department along with the department id.
select max(salary) , department_id from employees
where department_id group by department_id;

-- 26. Display the commission, if not null display 10% of salary, if null display a default value 1
select commission_pct,
case 
when commission_pct > 0 then 0.1 * salary
when commission_pct IS NULL then "1"
end
as "Commission"
from employees;

-- 27. Write a query that displays the employee's last names only from the string's 2-5th position 
-- with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.
select concat(upper(substring(last_name,2,1)), substring(last_name , 3,3)) as "New Last Name"
from employees;

-- 28. Write a query that displays the employee's first name and last name along with a " in
-- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the
-- month on which the employee has joined.
select concat( first_name ," - ", last_name) as "employee name", monthname(start_date) as "month"
from employees join job_history using (employee_id);

-- 29. Write a query to display the employee's last name and if half of the salary is greater than
-- ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of
-- 1500 each. Provide each column an appropriate label
select last_name, salary,
case
when  salary / 2 > 10000 then salary + (salary * 0.10) + 1500
else salary + (salary * 0.115) + 1500
end
as "New Salary"
from employees;

-- 30. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end,
-- department id, salary and the manager name all in Upper case, if the Manager name
-- consists of 'z' replace it with '$!
select concat(substring(e.employee_id,1,2), "00" ,substring(e.employee_id,3), "E") 
as "Updated ID", e.department_id, e.salary, REPLACE(upper(m.last_name), "Z", "$") as "New Name"
from employees as e join employees as m on e.manager_id = m.employee_id;

-- 31. Write a query that displays the employee's last names with the first letter capitalized and
-- all other letters lowercase, and the length of the names, for all employees whose name
-- starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names
select concat(upper(left(last_name, 1)), substring(last_name, 2)) as "New Last Name", length(last_name) as "Name Length" from employees
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%' order by last_name;

-- 32. Create a query to display the last name and salary for all employees. Format the salary to
-- be 15 characters long, left-padded with $. Label the column SALARY
select last_name, lpad(concat('$', salary), 15, '$') as salary from employees;

-- 33. Display the employee's name if it is a palindrome
select last_name,
case 
when last_name = reverse(last_name) then "Palindrome"
else "Not Pelindrome"
end
from employees;

-- 34. Display First names of all employees with initcaps.
select concat(upper(substring(First_name,1,1)), lower(substring(First_name,2))) AS "Name" from employees;

-- 35. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.
select substring_index(substring_index (street_address," ", 2)," ",-1) as "street"  from locations;

-- 36. Extract first letter from First Name column and append it with the Last Name. Also add
-- "@systechusa.com" at the end. Name the column as e-mail address. All characters should
-- be in lower case. Display this along with their First Name.
select concat(lower(substring(First_name,1,1)), lower(Last_name), "@systechusa.com") as "Emaail Address", First_name from employees;

-- 37. Display the names and job titles of all employees with the same job as Trenna.
select first_name, job_title from employees join jobs using (job_id) where first_name like "%Trenna";

-- 38. Display the names and department name of all employees working in the same city as Trenna.
select first_name, city from employees join departments using (department_id) join locations using (location_id)
where city= (select  distinct city from employees join departments using (department_id) join locations using (location_id)
where first_name like "%Trenna");

-- 39. Display the name of the employee whose salary is the lowest.
select first_name, salary from employees where salary = (select min(salary) from employees);

-- 40. Display the names of all employees except the lowest paid.
select first_name, salary from employees where salary <> (select min(salary) from employees);

-- 41. Write a query to display the last name, department number, department name for all employees.
select last_name, department_id, department_name from employees join departments using (department_id);

-- 42. Create a unique list of all jobs that are in department 4. Include the location of the department in the output.
select distinct(job_id), department_id, location_id
from departments join locations using (location_id) join jobs 
where department_id= 40;

-- 43.  Write a query to display the employee last name,department name,location id and city of all employees who earn commission.
select last_name, department_name, location_id, city, commission_pct
from employees join departments using (department_id) join locations using (location_id)
where commission_pct is not null;

-- 44. Display the employee last name and department name of all employees who have an 'a' in their last name
select last_name, department_name
from employees join departments using (department_id)
where last_name like "%a%";

-- 45. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA.
select last_name, job_id, department_name, country_name
from employees join departments using (department_id) join locations using (location_id) join countries
where country_name like "%atlanta";

-- 46. Display the employee last name and employee number along with their manager's last name and manager number.
select e.employee_id, e.last_name, m.employee_id, m.last_name "manager last name"
from employees as e join employees as m on e.manager_id=m.employee_id;

-- 47. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager).
select e.employee_id, e.last_name , m.employee_id, m.last_name as "manager last name"
from employees as e left join employees as m on e.manager_id=m.employee_id;

-- 48. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee.
select last_name, department_id, department_name from employees join departments using (department_id) 
where department_name=(select  department_name from employees join departments using (department_id) where last_name like  "hall");

-- 49. Create a query that displays the name,job,department name,salary,grade for all employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)
select first_name, job_id, department_name, salary,
  case
  when salary >= 5000 then "A"
  when salary >=3000 then "B"
  when salary < 3000 then "C"
  end
  "Grade"
  from employees join departments using (department_id);
  
-- 50. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date
select E.first_name as "employee_name", E.hire_date , M.first_name as "manger_name", M.hire_date 
from employees as E join employees as M on E.manager_id=M.employee_id
where E.hire_date < M.hire_date;

-- 51. Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who received an amount of 2000 in bonus.
select employee_id, concat(first_name," ",last_name) as "NAME", job_title, commission_pct, salary
from employees join jobs using (job_id)
where job_title like "sales%"  and commission_pct=0.20;

-- 52. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A.
select first_name, department_id, state_province, street_address, country_id,
case
when street_address is not null then "N/A"
end
"address "
from employees join departments using (department_id) join locations using (location_id)
where country_id like "CA" ;

-- 55. A. Write a query to display employees and their manager details. Fetch employee id,
-- employee first name, and manager id, manager name.
-- B. Display the employee id and employee name of employees who do not have manager.

SELECT e1.employee_id AS "Employee ID",
      e1.first_name AS "Employee First Name",
      e1.manager_id AS "Manager ID",
      e2.first_name AS "Manager First Name"
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;

select employee_id, first_name
from employees
where manager_id is null;

-- 62. Write a query to display the last name and hire date of any employee in the same department as SALES.
select last_name, hire_date, department_name
from employees join departments using (department_id)
where department_name like "SALES";

-- 63. Create a query to display the employee numbers and last names of all employees who
-- earn more than the average salary. Sort the results in ascending order of salary.
select employee_id, last_name, avg(salary)
from employees
where salary > (select avg(salary) from employees)
group by employee_id
order by salary asc;

-- 64. Write a query that displays the employee numbers and last names of all employees who
-- work in a department with any employee whose last name contains a' u 
select  distinct(department_id), last_name, employee_id
from employees join departments using (department_id)
where last_name like "%u%" ;

-- 65. Display the last name, department number, and job ID of all employees whose department location is america
select last_name, department_id, job_id, department_name, country_id, country_name
from employees join departments using (department_id) join locations using (location_id) join countries using(country_id)
where country_name like "%america";

-- 66. Display the last name and salary of every employee who reports to FILLMORE.
select m.last_name as "manager name",  e.salary, e.last_name as "employee name"
from employees as e join employees as m on e.manager_id=m.employee_id
where m.last_name like "King";

-- 67. Display the department number, last name, and job ID for every employee in the OPERATIONS department.
select department_id, last_name, job_id, department_name
from employees join departments using (department_id)
where department_name like "Operation%";

-- 68. Modify the above query to display the employee numbers, last names, and salaries of all
-- employees who earn more than the average salary and who work in a department with any
-- employee with a 'u'in their name.
select distinct(department_id) employee_id, last_name ,salary
from employees 
where salary < (select avg(salary) from employees) and last_name like "%u%";

-- 69. Display the names of all employees whose job title is the same as anyone in the sales dept.
select concat( first_name," ",last_name) "Name", job_title
from employees join jobs using (job_id)
where job_title like "%sales%";

-- 70. Write a compound query to produce a list of employees showing raise percentages,
-- employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise,
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are
-- given a 15% raise, and employees in department 6 are not given a raise.
select employee_id, salary, department_id,
case
when department_id = 10  then salary*"5%"
when department_id = 30 then salary*"5%"
when department_id = 20 then salary*"10%"
when department_id = 40 then salary*"15%"
when department_id = 50 then salary*"15%"
when department_id=60 then salary*1
end
"Raise%"
from employees
where department_id<=70;

-- 71. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries
select salary, last_name
from employees
order by salary desc
limit 3;

-- 72. Display the names of all employees with their salary and commission earned. Employees
-- with a null commission should have O in the commission column 
select  concat(first_name," ",last_name)"Name", salary, 
case
when commission_pct is null then "0"
end
" commission"
from employees;

-- 73. Display the Managers (name) with top three salaries along with their salaries and department information
select m.first_name , m.salary, dense_rank()over(order by salary desc)"RN", m.department_id
from employees as e join employees as m on e.manager_id=m.employee_id
group by m.employee_id
limit 3;

-- 74. 1) Find the date difference between the hire date and resignation_date for all the
-- employees. Display in no. of days, months and year(1 year 3 months 5 days).
-- Emp_ID Hire Date Resignation_Date
-- 1 1/1/2000 7/10/2013
-- 2 4/12/2003 3/8/2017
-- 3 22/9/2012 21/6/2015
-- 4 13/4/2015 NULL
-- 5 03/06/2016 NULL
-- 6 08/08/2017 NULL
-- 7 13/11/2016 NULL
 
select*, 
case
when resignation_date is not null then concat(floor(datediff(resignation_date,hire_date )/365), "year", 
 floor(datediff(resignation_date,hire_date )%365 /30), "month", floor(datediff(resignation_date,hire_date ) %365%30 ), "days")
 when resignation_date is null  then concat(floor(datediff(now(),hire_date )/365), "year", 
 floor(datediff(now(),hire_date )%365 /30), "month", floor(datediff(now(),hire_date ) %365%30 ), "days")
 end
"Duration"
from empdate;

-- 75. Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd,
-- yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)
SELECT hire_date, date_format(hire_date,"%m/%d/%y") as "formated hird_date", resignation_date,
case
when resignation_date is not null then date_format(resignation_date,"%M%D%Y")
else"dec,01th1900"
end
"formated resignation date"
from empdate;

-- 76. Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)
select emp_id, concat(floor(datediff(curdate(),hire_date)/365),'Years', floor(mod(datediff(curdate(),hire_date), 365)/30),'months') as 'Employee Experience' from empdate;




-- 53. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.
-- 54. Find the subcategories that have at least two different prices less than $15.alter
-- 56. A. Display the names of all products of a particular subcategory 15 and the names of their vendors.
-- 57. Find the products that have more than one vendor.
-- 58. Find all the customers who do not belong to any store
-- 59. Find sales prices of product 718 that are less than the list price recommended for that product.
-- 60. Display product number, description and sales of each product in the year 2001.
-- 61. Build the logic on the above question to extract sales for each category by year. Fetch
-- Use Getdate() as input date for the below three questions.
-- 77. Display the count of days in the previous quarter
-- 78. Fetch the previous Quarter's second week's first day's date
-- 79. Fetch the financial year's 15th week's dates (Format: Mon DD YYYY)
-- 80. Find out the date that corresponds to the last Saturday of January, 2015 using with clause.
-- Use Airport database for the below two question:
-- 81. Find the number of days elapsed between first and last flights of a passenger.
-- 82. Find the total duration in minutes and in seconds of the flight from Rostov to Moscow.