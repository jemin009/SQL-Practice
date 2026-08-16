--1
"""
— Customer Spending 
Har customer ka: 
 customer ID  
 customer name  
 total spending  
Find karo. 
"""
WITH customer_spending AS 
(
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(i.total) AS total_spending
    FROM customer c
	
    JOIN invoice i
        ON c.customer_id = i.customer_id
		
    GROUP BY 1,2
)

SELECT * FROM customer_spending;

--2
"""
— Above Average Customer 
Un customers ko find karo jinka total spending average customer spending se 
greater hai. 

Return: 
 customer ID  
 customer name  
 total spending  
"""
with customer_spending as
(
	select 
		c.customer_id,
		c.first_name || ' ' || c.last_name as customer_name,
		sum(i.total) as total_spending
	from customer c

	join invoice i
		on c.customer_id = i.customer_id 

	group by 1,2
)

select * from customer_spending
where total_spending > (select avg(total_spending) from customer_spending);

--3
"""
— Top Artist 
Har artist ka total revenue calculate karo aur highest revenue artist display karo.
"""
with artist_revenue as
(
	select 	
		ar.artist_id,
		ar.name,
		sum(il.unit_price * il.quantity) as total_revenue
	from artist ar

	join album al
		on ar.artist_id = al.artist_id

	join track t
		on al.album_id = t.album_id

	join invoice_line il
		on t.track_id = il.track_id

	group by 1,2
)

select * from artist_revenue
order by total_revenue desc
limit 1;

--4
"""
— Above Average Artist 
Un artists ko find karo jinka total revenue average artist revenue se greater hai. 

Return: 
 artist name  
 total revenue 
"""
with artist_revenue as
(
	select 	
		ar.artist_id as artist_id,
		ar.name as artist_name,
		sum(il.unit_price * il.quantity) as total_revenue
	from artist ar

	join album al
		on ar.artist_id = al.artist_id

	join track t
		on al.album_id = t.album_id

	join invoice_line il
		on t.track_id = il.track_id

	group by 1,2
)

select artist_name, total_revenue as total_revenue from artist_revenue
where total_revenue > (select avg(total_revenue) from artist_revenue);

--5
"""
— Top Track 
Har track ka total revenue calculate karo. 
Highest revenue wala track display karo. 
Agar tie ho to all tied tracks return karo.
"""
with track_revenue as 
(
	select
		t.track_id,
		t.name,
		sum(il.unit_price * il.quantity) as total_revenue
	from track t

	join invoice_line il
		on t.track_id = il.track_id 

	group by 1,2
)
select * from track_revenue
where total_revenue = (select max(total_revenue) from track_revenue);

--6
"""
— Top 5 Customers 
Har customer ka total spending calculate karo aur Top 5 customers display karo. 

Return: 
 customer name  
 total spending 
"""
WITH customer_spending AS 
(
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(i.total) AS total_revenue
    FROM customer c
	
    JOIN invoice i
        ON c.customer_id = i.customer_id
		
    GROUP BY 1,2
)

select * from customer_spending
ORDER BY total_revenue DESC
LIMIT 5;

--7
"""
 — Above Average Genre 
Har genre ka total revenue calculate karo. 
Sirf woh genres display karo jinka revenue average genre revenue se greater hai. 

Return: 
 genre name  
 total revenue 
"""
with genre_revenue as
(
	select
		g.genre_id,
		g.name as genre_name,
		sum(il.unit_price * il.quantity) as total_revenue
	from genre g

	join track t
		on g.genre_id = t.genre_id 

	join invoice_line il
		on t.track_id = il.track_id 

	group by 1,2
)

select genre_name, total_revenue  from genre_revenue
where total_revenue > (select avg(total_revenue) from genre_revenue);

--8
"""
— Customer Ranking 
Har customer ka total spending calculate karo. 

Return: 
 customer name  
 total spending  
 spending rank  
Highest spender = Rank 1.
"""
WITH customer_spending AS 
(
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(i.total) AS total_spending,
		rank() over(order by SUM(i.total) desc) as spending_rank
    FROM customer c
	
    JOIN invoice i
        ON c.customer_id = i.customer_id
		
    GROUP BY 1,2
)

select * from customer_spending;

--9
"""
— Above Average + Ranking 
Customers find karo jinka spending average customer spending se greater hai. 

Return: 
 customer name  
 total spending  
 spending rank 
"""
WITH customer_spending AS 
(
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(i.total) AS total_spending,
		rank() over(order by SUM(i.total) desc) as spending_rank
    FROM customer c
	
    JOIN invoice i
        ON c.customer_id = i.customer_id
		
    GROUP BY 1,2
)

select * from customer_spending
where total_spending > (select avg(total_spending) from customer_spending);

--10
"""
— Customer-Artist Spending  
Har customer + artist combination ka total spending calculate karo. 
Phir: 
1. Average customer-artist spending nikalo.  
2. Sirf average se greater combinations rakho.  
3. Spending ke basis par rank karo.  
4. Top 5 display karo.  

Return: 
 customer name  
 artist name  
 total spending  
 spending rank
"""
with total_spend as 
(
	select 
		c.customer_id,
		c.first_name || ' ' || c.last_name as customer_name,
		ar.artist_id,
		ar.name,
		sum(il.unit_price * il.quantity) as total_spending,
		rank() over(order by sum(il.unit_price * il.quantity) desc) as spending_rank
	from customer c

	join invoice i
		on c.customer_id = i.customer_id

	join invoice_line il
		on i.invoice_id = il.invoice_id

	join track t
		on il.track_id = t.track_id

	join album al
		on t.album_id = al.album_id 

	join artist ar
		on al.artist_id = ar.artist_id

	group by 1,2,3,4
)

select * from total_spend
where total_spending > (select avg(total_spending) from total_spend);