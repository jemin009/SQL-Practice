
select * from products;

--1
select name,category from products;

--2
select * from products
where price>2000;

--3
select * from products
where category = 'Furniture';

--4
select * from products
order by price desc;

--5
select * from products
order by stock_quantity;

--6
select * from products
limit 5;

--7
select * from products
limit 5
offset 2;

--8
select distinct category from products;

--9
select category from products
group by category;

--10
select category, count(*) from products
group by category; 

--11
select category, count(*) from products
group by category
having count(*) > 2;

--12
select name as item_name, price as item_price from products;

--13
select * from products
where stock_quantity<10
and category='Electronics';

--14
select * from products
where price > 5000
or category='Furniture';

--15 
select category, avg(price) as average_price 
from products
group by category;