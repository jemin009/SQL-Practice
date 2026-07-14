select * from products;

--1
select upper(name) from products;

--2
select length(sku_code) from products;

--3
select name, left(sku_code,2) from products;

--4
select name, right(sku_code,4) from products;

--5
select concat(name,' - ',category) from products;

--6
select * from products
where category != 'Electronics'
and price > 1000;

--7
select * from products
where stock_quantity between 5 and 20;

--8
select * from products
where category in('Furniture','Audio','Wearables');

--9
select * from products
where name like 'B%';

--10
select * from products
where sku_code like '%44%';

--11
select count(*) from products;

--12
select sum(stock_quantity) from products;

--13
select min(price) as min_price, max(price) as max_price from products;

--14
select category, avg(price) as avg_price from products
group by category
having avg(price) > 3000;

--15
select upper(category) from products
order by category desc;

--16
select name, replace(sku_code,left(sku_code,2),'XX') from products;

--17
select concat_ws(' : ',name,category,sku_code) from products;

--18
select name,price from products
order by price
limit 1;

--19
select name,price from products
order by price desc
limit 1;

--20 
select category, count(name) from products
group by category
order by count(name) desc;
