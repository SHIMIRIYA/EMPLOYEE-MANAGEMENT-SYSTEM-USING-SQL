use route_corp;
-- PART A
-- 1 . HR wants to track leave applications. Create a table leave_requests with an auto-numbered request
-- ID, the employee who applied (must be a real employee in the company), leave type (only Sick,
-- Casual or Paid), start date, number of days (compulsory, and must be between 1 and 30), a reason,
-- and an approval status that is "Pending" unless stated otherwise.
create table LEAVE_REQUESTS(
request_id int primary key Auto_increment,
emp_id int not null,
leave_type enum('sick','casual','paid') not null,
start_date date ,
numbers_of_days int not null ,
check(numbers_of_days between 1 and 30),
reason varchar (150),
approval_status varchar(20) default 'pending',
foreign key(emp_id) references employees(emp_id)
);
drop table leave_requests;
--  2 Add 6 leave requests for different employees. For at least two of them, don't mention the status at all.
insert into LEAVE_REQUESTS(emp_id,leave_type,start_date,numbers_of_days,reason,approval_status)
values
(1,'Sick','2026-11-10',2,'Fever','approved'),
(2,'Casual','2026-11-12',1,'Personal work','pending'),
(3,'paid','2026-11-15',3,'Family function','approved'),
(4,'Sick','2026-11-18',2,'Health issue','Pending');
select * from LEAVE_REQUESTS;
insert into leave_requests(emp_id,leave_type,start_date,numbers_of_days,reason)
values
(5,'Casual','2026-11-20',1,'Personal work'),
(6,'Paid','2026-11-22',3,'vaction');
select * from leave_requests;
--  3 Two new people joined today. Add them to the employees table (one in the Sales department, one in
-- IT). Don't specify their status or bonus.
insert into employees (first_name,last_name,email,phone,city,dept_id,job_title,salary,join_date)
values
('Aflah','p','aflahP@gmail.com','9875461325','Malappuram',3,'Sales Executive',40000,'2026-11-09' ),
('Fawaz','Hussain','fawaz@gmail.com','7562314785','calicut',1,'Software Developer',50000,'2026-11-09');
--  4 Display everything in the leave requests table.
select * from employees;
 
 -- PART B
 --  5 add a column to employees to store each person's blood group.
 alter table employees add column BLOOD_GROUP varchar(10);
describe employees;
-- 6 Some job titles are longer than 40 characters in the company's new naming plan. Increase that
-- column's size to 60.
alter table employees modify column job_title varchar(60);
describe employees;
-- 7 rename the location column in departments to office city.
alter table departments rename column location to office_city;
describe departments;
select * from departments;
-- 8The blood group column is no longer needed. Remove it.
alter table employees drop column BLOOD_GROUP;
select * from employees;

-- PART C
-- 9 show the name ,city and salary of everyone  who works in kochi.
select First_name,Last_name,City,Salary
from employees
where city ='kochi';
 
 -- 10 List all the cities where the company has employees,with no repeats
 select distinct city from employees;
 
 -- 11 1. Find employees in Sales who earn more than ₹34,000.
 select First_name,Last_name,dept_id,salary
 from employees where dept_id =3 and salary >34000;
 
-- 12. Find employees who are either in Bengaluru or earn above ₹80,000.
select First_name,Last_name,city,salary 
from employees where city ='Bengaluru' or salary>80000;

-- 13. Show everyone who is not currently Active.
select First_name,Last_name,status
from employees where status !='Active';
-- 14. List employees who joined between January 2021 and December 2022.
select First_name,Last_name,Join_date
from employees where join_date between '2021-01-01' and '2022-12-31';

-- 15. Show employees whose salary is between ₹40,000 and ₹60,000.
select First_name,Last_name,Salary
from employees where salary between 40000 and 60000;

-- 16. Show employees from Kochi, Kottayam or Kozhikode only.
select First_name,Last_name,City
from employees where city in('Kochi','Kottayam','kozhikode');
-- 17. Find all employees whose first name starts with the letter 'S'.
select First_name from employees where First_name like 'S%';

-- 18. Find employees whose email is not a company email, meaning it doesn't end with routecorp.com.
select First_name,Last_name,Email
from employees where email not like '%@routecorp.com';
-- 19. Find employees whose last name contains "Menon" or whose job title contains the word "Manager".
select first_name,Last_name,job_title
from employees where last_name like '%Menon' or job_title like '%Manager';

-- 20. Show all employees ordered from highest salary to lowest. Where salaries match, show the earlier
-- joiner first.
select First_name,Salary,join_date
from employees order by salary desc,join_date asc;
-- 21. Show the 3 highest paid employees.
select First_name,Last_name,salary
from employees order by salary desc limit 3;

-- 22. Show the 5 most recently joined employees.
select First_name,job_title
from employees order by join_date desc limit 5;

-- 23. Find the Active employees in IT who earn more than ₹50,000 and have a bonus of at least 4%, sorted
-- by name.
select First_name,Last_name,Salary,Bonus_pct,dept_id
from employees where dept_id=1 and status ='active' and salary>55000 and bonus_pct>=4 order by first_name;

-- PART D
 -- 24 Create a "Full Name" column showing first and last name together, with city next to it separated by " |
-- ".
select concat(First_name,' ',Last_name,'|',city)as FULL_NAME from employees;

-- 25. HR needs short city codes. Show each employee's name with the first 3 letters of their city in capitals,
-- such as "TRI" or "KOC".
select First_name,Last_name,upper(left(city,3)) as city_code from employees;

-- 26. For privacy, show only the last 4 digits of each phone number along with the employee's name.
select first_name,last_name,right(phone,4) as Last_4_Digits from employees;
-- 27. Show each employee's email with "routecorp.com" replaced by "route.in".
select first_name,last_name,replace(email,'routecorp.com','route.in') as Updated_email from employees;

-- 28. Show each employee's job title with the word "Executive" shortened to "Exec".
select distinct First_name,Last_name,replace(job_title,'Executive','Exec') as updated_job_title from employees;
-- 29. Calculate each employee's bonus amount (salary × bonus %), rounded to the nearest rupee.
select first_name,last_name,round(salary * bonus_pct,0) as Bonus_Amount from employees;

-- 30. Show each salary in thousands, rounded down (₹62,000 → 62), and also rounded up to the next whole
-- thousand.
select first_name,salary,floor(salary/1000) as rounded_down,ceil(salary/1000) as rounded_up from employees;
-- 31. If every salary increases by 10% each year, show what Arun Kumar's (and everyone's) salary would be
-- after 3 years.
SELECT first_name, last_name, salary,
       ROUND(salary * POWER(1.10, 3), 2) AS salary_after_3_years
FROM employees;
-- 32. Calculate a "salary index" for each employee as the square root of their salary, rounded to 2 decimals.
SELECT first_name, last_name, salary,
       ROUND(SQRT(salary), 2) AS salary_index
FROM employees;
-- PART E 
-- 33. Give a 5% raise to everyone in the IT department.
UPDATE employees
SET salary = salary * 1.05
WHERE dept_id = 1;
describe employees;
-- 34. Anjali Das has returned from leave. Update her status, and also give her a bonus of 3%.
UPDATE employees
SET status = 'Active',
    salary = salary * 1.03
WHERE first_name = 'Anjali'
AND last_name = 'Das';
-- 35. Change the status of all employees who joined before 2018 to "Active" (in case it was missed).
UPDATE employees
SET status = 'Active'
WHERE join_date < '2018-01-01';
-- 36. Delete the employees who have resigned and have no leave requests.
DELETE FROM employees
WHERE status ='Resigned'
AND employee_id NOT IN (
    SELECT employee_id
    FROM leave_requests
);
-- 37. HR decides to wipe all test leave requests and start fresh. Clear that table completely but keep its
-- structure.
TRUNCATE TABLE leave_requests;
-- PART F 
-- 38. Remove the leave requests table from the database entirely.
DROP TABLE leave_requests;
-- 39. Try to remove the departments table. What happens, and why? Write your answer in a comment.
DROP TABLE departments;
-- cannot drop the departments table 
-- it is referened by a foreing key 