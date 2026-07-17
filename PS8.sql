-- Create table products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    sku_code VARCHAR(20) UNIQUE,
    price DECIMAL(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    category VARCHAR(50),
    added_on DATE,
    last_update TIME,
    price_tag VARCHAR(20)
);

-- Insert Values products
INSERT INTO products (product_id,name,sku_code,price,stock_quantity,is_available,category,added_on,last_update,price_tag) VALUES
(1,'Wireless Mouse','WM123456',699.99,50,TRUE,'Electronics','2026-05-21','06:02:03','Morerate'),
(2,'Mechanical Keyboard','MK987654',2499.00,30,TRUE,'Electronics','2026-05-21','06:02:03','Expensive'),
(3,'Gaming Headset','GH456789',1899.50,20,TRUE,'Electronics','2026-05-21','06:02:03','Expensive'),
(4,'USB Cable','UC112233',199.00,100,TRUE,'Accessories','2026-05-21','06:02:03','Cheap'),
(5,'Laptop Stand','LS445566',899.99,15,TRUE,'Accessories','2026-05-21','06:02:03','Morerate'),
(6,'Smart Watch','SW778899',4999.00,10,TRUE,'Wearables','2026-05-21','06:02:03','Expensive'),
(7,'Bluetooth Speaker','BS665544',1599.00,25,TRUE,'Audio','2026-05-21','06:02:03','Expensive'),
(8,'Office Chair','OC223344',7499.99,5,TRUE,'Furniture','2026-05-21','06:02:03','Expensive'),
(9,'Study Table','ST556677',5999.00,7,TRUE,'Furniture','2026-05-21','06:02:03','Expensive'),
(10,'LED Monitor','LM998877',12499.00,8,TRUE,'Electronics','2026-05-21','06:02:03','Expensive');

--Create table orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

--Insert values orders
INSERT INTO orders
(order_id, product_id, quantity, order_date, customer_name, payment_method)
VALUES
(101,1,2,'2026-06-01','Rahul','UPI'),
(102,3,1,'2026-06-02','Amit','Credit Card'),
(103,2,1,'2026-06-03','Neha','Cash'),
(104,5,3,'2026-06-03','Riya','UPI'),
(105,7,2,'2026-06-04','Karan','Debit Card'),
(106,4,5,'2026-06-05','Priya','Cash'),
(107,8,1,'2026-06-06','Rohan','Credit Card'),
(108,6,2,'2026-06-07','Sneha','UPI'),
(109,9,1,'2026-06-08','Vikram','Net Banking'),
(110,10,1,'2026-06-09','Pooja','Debit Card'),
(111,1,1,'2026-06-10','Ankit','UPI'),
(112,2,2,'2026-06-11','Meera','Cash'),
(113,3,1,'2026-06-12','Yash','Credit Card'),
(114,5,1,'2026-06-13','Isha','UPI'),
(115,7,2,'2026-06-14','Arjun','Net Banking');

select * from products;
select * from orders;
------------------------------------------------------------------------------------------ 

-- 1.
''' 
Show: 
	product_name 
	price 
	price_label 
Rules: 
	Expensive → price > 10000  
	Affordable → otherwise  
'''
select 
	product_name,
	price,
	case
		when price > 10000 then 'Expensive'
		else 'Affordable'
	end as Price_label
from products;

-- 2.
'''
Show: 
	product_name 
	stock_quantity 
	stock_status 
Rules: 
	In Stock → stock_quan ty > 20  
	Low Stock → otherwise 
'''
select 
	product_name,
	stock_quantity,
	case 
		when stock_quantity > 20 then 'In Stock'
		else 'Low Stock'
	end as stock_status
from products;

-- 3.
'''
Show: 
	product_name 
	category 
	category_type 
Rules: 
	Tech → Electronics  
	Non-Tech → all other categories  
'''
select 
	product_name,
	category,
	case 
		when category = 'Electronics' then 'Tech'
		else 'Non-Tech'
	end as category_type
from products;

-- 4.
'''
Show: 
	product_name 
	price 
	price_range 
Rules: 
	Premium → price > 15000  
	Standard → price between 5000 and 15000  
	Budget → below 5000
'''
select 
	product_name,
	price,
	case 
		when price > 15000 then 'Premium'
		when price between 5000 and 15000 then 'Standard'
		else 'Budget'
	end as price_range
from products;

-- 5.
'''
Show: 
	product_name 
	stock_quantity 
	inventory_level 
Rules: 
	High → stock_quan ty > 50  
	Medium → stock_quan ty between 20 and 50  
	Low → below 20  
'''
select 
	product_name,
	stock_quantityselect 
	case 
		when stock_quantity > 50 then 'High'
		when stock_quantity between 20 and 50 then 'Medium'
		else 'Low'
	end as inventory_level
from products;

-- 6.
'''
Show: 
	product_name 
	price 
	discount_label 
Rules: 
	Eligible → price > 10000  
	Not Eligible → otherwise  
'''
select 
	product_name,
	price,
	case 
		when price > 10000 then 'Eligible'
		else 'Not Eligible'
	end as discount_label
from products;

-- 7.
'''
Show: 
	product_name 
	is_available 
	availability_status 
Rules: 
	Available  
	Not Available  
'''
select 
	product_name,
	is_available,
	case 
		when is_available then 'Available'
		else 'Not Available'
	end as availability_status
from products;

-- 8.
'''
Show: 
	product_name 
	price 
	tax_category 
Rules: 
	High Tax → price > 12000  
	Low Tax → otherwise  
'''
select 
	product_name,
	price,
	case 
		when price > 12000 then 'High Tax'
		else 'Low Tax'
	end as tax_category
from products;

-- 9.
'''
Show: 
	product_name 
	added_on 
	product_age 
Rules: 
	New Product → added in 2025 or later  
	Old Product → otherwise 
'''
select 
	product_name,
	added_on,
	case 
		when extract(year from added_on) >= 2025 then 'New Product'
		else 'Old Product'
	end as product_age
from products;

-- 10.
'''
Show: 
	product_name 
	price 
	stock_quantity 
	priority 
Rules: 
	High Priority → price > 10000 AND stock_quantity < 10  
	Normal → otherwise  
'''
select 
	product_name,
	price,
	stock_quantity,
	case 
		when price > 10000 and stock_quantity < 10 then 'High Priority'
		else 'Normal'
	end as priority
from products;

-- 11.
'''
Show: 
	customer_name 
	quantity 
	order_size 
Rules: 
	Bulk Order → quan ty >= 5  
	Normal Order → otherwise  
'''
select 
	customer_name,
	quantity,
	case
		when quantity >= 5 then 'Bulk Order' 
		else 'Normal Order'
	end as order_size 
from orders;

-- 12.
'''
Show: 
	customer_name 
	payment_method 
	payment_type 
Rules: 
	Digital → UPI/Card  
	Offline → others 
'''
select 
	customer_name,
	payment_method,
	case 
		when payment_method in ('UPI', 'Credit Card', 'Net Banking') then 'Digital'
		else 'Offline'
	end as payment_type
from orders;

-- 13.
'''
Show: 
	product_name 
	price 
	profit_segment 
Rules: 
	High Profit → price > 15000  
	Medium Profit → price between 5000 and 15000  
	Low Profit → below 5000 
'''
select 
	product_name,
	price,
	case 
		when price > 15000 then 'High Profit'
		when price between 5000 and 15000 then 'Medium Profit'
		else 'Low Profit'
	end as profit_segment
from products;

-- 14.
'''
Show: 
	product_name 
	category 
	department 
Rules: 
	Electronics → Tech Department  
	Furniture → Home Department  
	Others → General Department  
'''
select 
	product_name,
	category,
	case 
		when category = 'Electronics' then 'Tech Department'
		when category = 'Furniture' then 'Home Department'
		else 'General Department'
	end as department
from products;

-- 15.
'''
Show: 
	customer_name 
	quantity 
	shipping_type 
Rules: 
	Express → quan ty >= 5  
	Standard → otherwise  
'''
select 
	customer_name,
	quantity,
	case 
		when quantity >= 5 then 'Express'
		else 'Standard'
	end as shipping_type 
from orders;

-- 16.
'''
Show: 
	product_name 
	price 
	price_band 
Rules: 
	Luxury → price > 20000  
	Premium → price between 10000 and 20000  
	Economy → below 10000 
'''
select 
	product_name,
	price,
	case 
		when price > 20000 then 'Luxury'
		when price between 10000 and 20000 then 'Premium'
		else 'Economy'
	end as price_band
from products;

-- 17.
'''
Show: 
	product_name 
	stock_quantity 
	restock_needed 
Rules: 
	Yes → stock_quan ty < 10  
	No → otherwise  
'''
select 
	product_name,
	stock_quantity,
	case 
		when stock_quantity < 10 then 'Yes'
		else 'No'
	end as restock_needed
from products;

-- 18.
'''
Show: 
	product_name 
	price 
	offer_category 
Rules: 
	Festival Offer → price > 5000  
	Regular → otherwise 
'''
select 
	product_name,
	price,
	case 
		when price > 5000 then 'Festival Offer'
		else 'Regular'
	end as offer_category
from products;

-- 19.
'''
Show: 
	customer_name 
	payment_method 
	payment_score 
Rules: 
	Preferred → Card  
	Normal → others  
'''
select 
	customer_name,
	payment_method,
	case 
		when payment_method like '%Card%' then 'Preferred'
		else 'Normal'
	end as payment_score
from orders;

-- 20.
'''
Show: 
	product_name 
	price 
	stock_quantity 
	business_status 
Rules: 
	Star Product → price > 10000 AND stock_quan ty > 50  
	Growing Product → price > 5000  
	Normal Product → otherwise  
'''
select
	product_name,
	price,
	stock_quantity,
	case 
		when price > 10000 and stock_quantity > 50 then 'Star Product'
		when price > 5000 then 'Growing Product'
		else 'Normal Product'
	end as business_status
from products;