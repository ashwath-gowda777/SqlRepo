/*4. Find the total salary of each department
Column names:(id_deptname, emp_name, salary)
Data: 
('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('22-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('44-BIO', 'AKSHAY', 10000)
 Create table dept_tbl with above data
*/

create table dept_tbl(
id_deptname varchar(50),
emp_name varchar(50),
salary int);

Insert into dept_tbl(id_deptname,emp_name,salary) values
('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('22-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('44-BIO', 'AKSHAY', 10000);

select id_deptname , sum(salary) as Total_salary from dept_tbl
group by id_deptname;
