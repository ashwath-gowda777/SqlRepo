/*3. Write a query to find for each date the number of different products sold and their names. 
Column names: (sell_date, product)
Data: ('2020-05-30', 'Headphones'),
('2020-06-01','Pencil'),
('2020-06-02','Mask'),
('2020-05-30','Basketball'),
('2020-06-01','Book'),
('2020-06-02', ' Mask '),
('2020-05-30','T-Shirt')
	Create table product_details with above data and find the above result
	Output:
*/

-- Create the product_details table
CREATE TABLE product_details (
    sell_date DATE,
    product VARCHAR(50)
);

-- Insert data into product_details table
INSERT INTO product_details (sell_date, product) VALUES
('2020-05-30', 'Headphones'),
('2020-06-01', 'Pencil'),
('2020-06-02', 'Mask'),
('2020-05-30', 'Basketball'),
('2020-06-01', 'Book'),
('2020-06-02', ' Mask '),
('2020-05-30', 'T-Shirt');

select*from product_details;

SELECT
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    STUFF((
        SELECT ', ' + product
        FROM product_details p
        WHERE p.sell_date = pd_outer.sell_date
        FOR XML PATH('')), 1, 2, '') AS product_list
FROM
    product_details pd_outer
GROUP BY
    sell_date;

--or

/* SELECT sell_date,
    COUNT(DISTINCT product) AS num_sold,
    STRING_AGG(DISTINCT product, ', ') AS product_list
FROM 
    product_details
GROUP BY 
    sell_date;*/ --This query is Not supported in my system


