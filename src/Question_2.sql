/* 2.Create a table persons with first_name, last_name,city and age and add a constraint where age < 21

1.Insert the  4 records with age less than 21 and atleast one record should have city value as “Mumbai”
2.Insert one more record which is greater than 21 and give the result
3.Add one more constraint in the same table where city = “Mumbai”
4.Insert one more record where city = “jaipur” and give the result
5.Drop both the Constraints.
6.Create view where city = ‘Mumbai’ */

--Create a table persons with first_name, last_name,city and age and add a constraint where age < 21
create table persons(
first_name varchar(50),
last_name varchar(50),
city varchar(50),
age int,
constraint check_age CHECK(age<21));

--1.Insert the  4 records with age less than 21 and atleast one record should have city value as “Mumbai”
Insert into persons(first_name,last_name,city,age)
values
('Ashwath','Gowda','Bengaluru',17),
('Tilak','Ganesh','Mysore',18),
('Rudresh','Raju','Tamil Nadu',19),
('kanhai','Kumi','Mumbai',20);

select*from persons;

--2.Insert one more record which is greater than 21 and give the result
Insert into persons values('Radha','krishna','Mangalore',23);
--Result: You will get an error because constraint is given less than (<21) for age.
--Error
/*Msg 547, Level 16, State 0, Line 29
The INSERT statement conflicted with the CHECK constraint "check_age". The conflict occurred in database "ecommerce", table "dbo.persons", column 'age'.*/


--3.Add one more constraint in the same table where city = “Mumbai”
ALTER TABLE persons 
ADD CONSTRAINT chk_persons CHECK(city = 'Mumbai');
--Result:You will get an error because conflict with existing data can result in errors if the data in the table doesn't meet the new constraint criteria.
--Error
/*Msg 547, Level 16, State 0, Line 36
The ALTER TABLE statement conflicted with the CHECK constraint "chk_persons". The conflict occurred in database "ecommerce", table "dbo.persons", column 'city'.*/

--4.Insert one more record where city = “jaipur” and give the result
Insert into persons values ('sravan','kumar','jaipur',16);

select*from persons;

--5.Drop both the Constraints.
alter table persons
drop constraint check_age;
--In above as i couldn't add the constraint where i got an error - I droped the constraint

--6.Create view where city = ‘Mumbai’ */
CREATE VIEW Mumbai_View
AS
SELECT *
FROM persons
WHERE city = 'Mumbai';

select*from Mumbai_View;

