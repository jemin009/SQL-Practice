-- Create table 
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category TEXT,
    price NUMERIC(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    added_on DATE
);

-- Insert values
INSERT INTO products
(product_id, product_name, category, price, stock_quantity, is_available, added_on)
VALUES
(101, 'Wireless Mouse', 'Electronics', 1611.53, 79, FALSE, '2025-04-29'),
(102, 'Bluetooth Speaker', 'Electronics', 135.14, 23, TRUE, '2025-06-04'),
(103, 'Laptop Stand', 'Accessories', 1020.92, 161, FALSE, '2025-07-09'),
(104, 'USB-C Hub', 'Accessories', 408.39, 164, FALSE, '2025-05-12'),
(105, 'Notebook', 'Stationery', 1987.74, 116, TRUE, '2025-07-01'),
(106, 'Pen Set', 'Stationery', 1048.10, 150, TRUE, '2025-06-29'),
(107, 'Coffee Mug', 'Home & Kitchen', 1063.53, 76, FALSE, '2025-04-15'),
(108, 'LED Desk Lamp', 'Home & Kitchen', 239.10, 93, FALSE, '2025-05-23'),
(109, 'Yoga Mat', 'Fitness', 1514.86, 162, TRUE, '2025-05-05'),
(110, 'Water Bottle', 'Fitness', 420.99, 191, TRUE, '2025-05-09'),
(111, 'Smartphone', 'Electronics', 361.20, 200, FALSE, '2025-04-18'),
(112, 'Headphones', 'Electronics', 154.84, 178, TRUE, '2025-05-18'),
(113, 'Gaming Keyboard', 'Accessories', 103.24, 100, FALSE, '2025-04-19'),
(114, 'Monitor', 'Electronics', 305.20, 123, FALSE, '2025-05-20'),
(115, 'HDMI Cable', 'Accessories', 552.97, 105, TRUE, '2025-06-17'),
(116, 'Power Bank', 'Electronics', 831.88, 13, FALSE, '2025-07-01'),
(117, 'Backpack', 'Accessories', 1517.11, 64, TRUE, '2025-05-08'),
(118, 'Webcam', 'Electronics', 1428.30, 76, FALSE, '2025-06-11'),
(119, 'Desk Organizer', 'Home & Kitchen', 404.69, 136, FALSE, '2025-06-14'),
(120, 'Fitness Band', 'Fitness', 1451.69, 171, FALSE, '2025-05-06');

select * from products;

-----------------------------------------------------------------------------------------

-- 1. Show all products belonging to the same category as the 2nd highest priced product. 
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select max(price) from products
					where price < (select max(price) from products)));

-- 2. Show all products belonging to the same category as the 2nd lowest priced product. 
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select min(price) from products
					where price > (select min(price) from products)));

-- 3. Show all products belonging to the same category as the 4th highest priced product. 
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products)))));

-- 4. Show all products belonging to the same category as the 4th lowest priced product. 
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products)))));

-- 5. Show the category of the 3rd highest priced product. 
select 
	category
from products
where price = (select max(price) from products
				where price < (select max(price) from products
				where price < (select max(price) from products)));

-- 6. Show the category of the 3rd lowest priced product. 
select 
	category
from products
where price = (select min(price) from products
				where price > (select min(price) from products
				where price > (select min(price) from products)));

-- 7. Show all products whose category is the same as the highest priced product. 
select
	product_id,
	product_name,
	price
from products
where category = (select category from products
					where price = (select max(price) from products));

-- 8. Show all products whose category is the same as the lowest priced product. 
select
	product_id,
	product_name,
	price
from products
where category = (select category from products
					where price = (select min(price) from products));

-- 9. Show the product having the 5th highest price. 
select
	product_id,
	product_name,
	price
from products
where price = (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products)))));

-- 10. Show the product having the 5th lowest price. 
select
	product_id,
	product_name,
	price
from products
where price = (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products)))));

-- 11. Show all products cos ng more than the 3rd highest priced product. 
select
	product_id,
	product_name,
	price
from products
where price > (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products)));

-- 12. Show all products cos ng less than the 3rd lowest priced product. 
select
	product_id,
	product_name,
	price
from products
where price < (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products)));

-- 13. Show products from the category of the 2nd highest priced product, excluding that 
product itself. 
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select max(price) from products
					where price < (select max(price) from products)));

-- 14. Show products from the category of the 2nd lowest priced product, excluding that 
product itself. 
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select min(price) from products
					where price > (select min(price) from products)));

-- 15. Show all products belonging to the same category as the product with the highest 
stock quantity. 
select
	product_id,
	product_name,
	category,
	stock_quantity
from products
where category = (select category from products
					where stock_quantity = (select max(stock_quantity) from products));

-- 16. Show all products belonging to the same category as the product with the lowest 
stock quantity. 
select
	product_id,
	product_name,
	category,
	stock_quantity
from products
where category = (select category from products
					where stock_quantity = (select min(stock_quantity) from products));

-- 17. Show the category of the 4th highest priced product, then display all products from 
that category. 
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products
					where price < (select max(price) from products)))));

-- 18. Show the category of the 4th lowest priced product, then display all products from 
that category.
select
	product_id,
	product_name,
	category
from products
where category = (select category from products
					where price = (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products
					where price > (select min(price) from products)))));

-- 19. Show products whose price is greater than the 2nd highest priced product. 
select 
	product_id,
	product_name
from products
where price > (select max(price) from products
				where price < (select max(price) from products
				where price < (select max(price) from products)));

-- 20. Show products whose price is less than the 2nd lowest priced product. 
select 
	product_id,
	product_name
from products
where price < (select min(price) from products
				where price > (select min(price) from products));