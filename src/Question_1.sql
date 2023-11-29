/* SQL Assignment
1.Here is the Dataset for the below questions.
Gold members Data Set--Column names : (userid integer, signup_date)
('John','09-22-2017'), ('Mary','04-21-2017')

Users Data Set--Column names : (userid integer, signup_date)
('John','09-02-2014'), ('Michel','01-15-2015'), ('Mary','04-11-2014')

Sales Data Set-- Column names : (userid,created_date,product_id)
('John','04-19-2017',2), ('Mary','12-18-2019',1), ('Michel','07-20-2020',3), ('John','10-23-2019',2), ('John','03-19-2018',3), ('Mary','12-20-2016',2), ('John','11-09-2016',1), ('John','05-20-2016',3), ('Michel','09-24-2017',1), ('John','03-11-2017',2), ('John','03-11-2016',1), ('Mary','11-10-2016',1), ('Mary','12-07-2017',2)

Product Data Set--Column names : (product_id,product_name,price)
(1,'Mobile',980), (2,'Ipad',870), (3,'Laptop',330) */

--Questions on above Dataset 

--1.Create Database as ecommerce

Create database ecommerce;

--2.Create 4 tables (gold_member_users, users, sales, product) under the above database(ecommerce)
--3.Insert the values provided above with respective datatypes

--Table 1 created below

-- Creating the gold_member_users table with an auto-incrementing userid column in SQL Server
CREATE TABLE gold_member_users (
    userid INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50),
    signup_date DATE);


Insert into gold_member_users values('John','09-22-2017');
Insert into gold_member_users values('Mary','04-21-2017');

--Insert into gold_member_users values('Mary','04-jan-2017'); --to check how to delete
--delete from gold_member_users where userid = 'Mary';

select*from gold_member_users;

----Table 2 created below

create table users (
userid varchar(50),
signup_date DATE);

Insert into users values('John','09-02-2014');
Insert into users values('Michel','01-15-2015');
Insert into users values('Mary','04-11-2014');

select*from users;

----Table 3 created below

create table sales(
userid varchar(50),
created_date date,
product_id int);

Insert INTO SALES (userid,created_date,product_id)
values
('John','04-19-2017',2),
('Mary','12-18-2019',1),
('Michel','07-20-2020',3),
('John','10-23-2019',2),
('John','03-19-2018',3),

('Mary','12-20-2016',2),
('John','11-09-2016',1),
('John','05-20-2016',3),
('Michel','09-24-2017',1),

('John','03-11-2017',2),
('John','03-11-2016',1),
('Mary','11-10-2016',1),
('Mary','12-07-2017',2);


select*from sales;

----Table 4 created below

create table product(
product_id int,
product_name varchar(50),
price decimal(10,2));

Insert into product (product_id,product_name,price)
values
(1,'Mobile',980),
(2,'Ipad',870),
(3,'Laptop',330);


select*from product;

--4.Show all the tables in the same database(ecommerce)
select *
from INFORMATION_SCHEMA.TABLES;


--5.Count all the records of all four tables using single query
select 'gold_member_users' as Table_Name ,count(*) as Record_Count from gold_member_users 
union all
select 'users', count(*)  from users
union all
select 'sales',count(*) from sales
union all 
select 'product',count(*)  from product;


select*from gold_member_users;
select*from sales;
select*from users;
select*from product;

--6.What is the total amount each customer spent on ecommerce company
select s.userid as Customer_id,sum(p.price) as Total_amount_spent 
from sales s
Inner Join product p on s.product_id = p.product_id
Group by s.userid;

--7.Find the distinct dates of each customer visited the website: output should have 2 columns date and customer name 
select distinct s.created_date as Date, s.userid as Customer_name
from sales s;

--select distinct * from sales;

--8.Find the first product purchased by each customer using 3 tables(users, sales, product)
select u.userid AS Customer_ID, MIN(s.created_date) as First_Purchase, p.product_name as First_Product
from users u
Inner join sales s on u.userid = s.userid
Inner join product p on s.product_id =p.product_id
where s.created_date =(
      select min(created_date)
	  from sales s_inner
	  where s_inner.userid =u.userid)
	  group by u.userid, p.product_name;

--9.What is the most purchased item of each customer and how many times the customer has purchased it: 
--  output should have 2 columns count of the items as item_count and customer name
SELECT u.userid AS Customer_Name, p.product_name AS Most_Purchased_Item, COUNT(*) AS Item_Count
FROM users u
Inner JOIN sales s ON u.userid = s.userid
Inner JOIN product p ON s.product_id = p.product_id
GROUP BY u.userid, p.product_name
HAVING COUNT(*) = (
    SELECT MAX(Purchase_Count)
    FROM (
        SELECT COUNT(*) AS Purchase_Count
        FROM sales s_inner
        WHERE s_inner.userid = u.userid
        GROUP BY s_inner.product_id
    ) AS PurchaseCounts
);


--10.Find out the customer who is not the gold_member_user
SELECT u.userid AS Customer_ID
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM gold_member_users g
    WHERE g.userid = u.userid
) OR u.userid IS NULL;



--11.What is the amount spent by each customer when he was the gold_member user
SELECT g.userid AS Customer_ID, COALESCE(SUM(p.price), 0) AS Amount_Spent_As_GoldMember
FROM gold_member_users g
LEFT JOIN sales s ON g.userid = s.userid
LEFT JOIN product p ON s.product_id = p.product_id
GROUP BY g.userid;


--12.Find the Customers names whose name starts with M
select userid as customer_Name from users where userid like 'M%';

--13.Find the Distinct customer Id of each customer
select distinct userid as customer_id from users;

--14.Change the Column name from product table as price_value from price
Exec sp_rename 'product.price', 'price_value', 'COLUMN';

--Exec sp_rename 'product.price_value', 'price', 'COLUMN';

--15.Change the Column value product_name   Ipad to Iphone from product table
UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad';

select*from product;

--16.Change the table name of gold_member_users to gold_membership_users
EXEC sp_rename 'gold_member_users', 'gold_membership_users';
--select*from gold_membership_users;

--17.Create a new column  as Status in the table crate above gold_membership_users  the Status values should be 2 Yes and No if the user is gold member, 
--then status should be Yes else No.
ALTER TABLE gold_membership_users
ADD Status VARCHAR(3) default 'NO'; -- Adjust the length as per your requirement

UPDATE gold_membership_users
SET Status = 'Yes'

select*from gold_membership_users;


--18.Delete the users_ids 1,2 from users table and roll the back changes once both the rows are deleted one by one mention 
--the result when performed roll back
-- Start a transaction
BEGIN TRANSACTION;

-- Deleting the user with userid 1
DELETE FROM users WHERE userid = 'John';
SELECT * FROM users; -- Check the users table after the first deletion

-- Rollback the transaction after the first deletion
ROLLBACK;
SELECT * FROM users; -- Check the users table after rollback

-- Start a new transaction
BEGIN TRANSACTION;

-- Deleting the user with userid 2
DELETE FROM users WHERE userid = 'Michel';
SELECT * FROM users; -- Check the users table after the second deletion

-- Rollback the transaction after the second deletion
ROLLBACK;
SELECT * FROM users; -- Check the users table after rollback


--19.Insert one more record as same (3,'Laptop',330) as product table

INSERT INTO product (product_id, product_name, price_value)
SELECT product_id, product_name, price_value
FROM product
WHERE product_id = 3; -- Assuming the product_id 3 is the record you want to duplicate

--select*from product

--20.Write a query to find the duplicates in product table
SELECT product_name, COUNT(*) AS duplicate_count
FROM product
GROUP BY product_name
HAVING COUNT(*) > 1;

