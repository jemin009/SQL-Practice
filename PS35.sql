--1
"""
- Customer Country Analysis 
For each country, find: 
 country  
 number of customers  
 total revenue  
 average customer spending  
Show only countries with more than 5 customers.
"""
select 
	c.country,
	count(distinct c.customer_id) as num_of_customer,
	sum(i.total) as total_revenue,
	avg(i.total) as avg_customer_spending
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1

having count(distinct c.customer_id) > 5;

--2
"""
— Track Sales 
Find the top 10 tracks by copies sold. 
Return: 
 track name  
 artist name  
 genre  
 total copies sold  
 total revenue  
Sort by copies sold descending.
"""
select 
	t.track_id,
	t.name,
	ar.name,
	g.name,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id 

join invoice_line il
on t.track_id = il.track_id

join genre g
on g.genre_id = t.genre_id

group by 1,2,3,4

order by 5 desc

limit 10;

--3 
"""
— Above-Average Genres 
Find genres whose total revenue is greater than the average genre revenue. 
Return: 
 genre name  
 total tracks  
 total revenue  
 revenue rank 
"""
WITH genre_revenue AS (
    SELECT
        g.genre_id,
        g.name AS genre_name,
        COUNT(DISTINCT t.track_id) AS total_tracks,
        SUM(il.unit_price * il.quantity) AS total_revenue
    FROM genre g
	
    JOIN track t
        ON g.genre_id = t.genre_id
		
    JOIN invoice_line il
        ON t.track_id = il.track_id
		
    GROUP BY 1,2
)

SELECT
    genre_name,
    total_tracks,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank 
FROM genre_revenue

WHERE total_revenue > (SELECT AVG(total_revenue) FROM genre_revenue);

--4
"""
— Customer Ranking 
For every customer, calculate: 
 customer name  
 country  
 total spending  
 rank within their country  
The highest spender in each country should have rank 1.
"""
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.country,
    SUM(i.total) AS total_spending,
    RANK() OVER (PARTITION BY c.country ORDER BY SUM(i.total) DESC) AS rank_country
FROM customer c

JOIN invoice i
    ON c.customer_id = i.customer_id
	
GROUP BY 1,2,3;

--5
"""
— Artist Revenue Percentage 
For every artist, calculate: 
 artist name  
 total revenue  
 percentage of overall revenue  
Sort by revenue descending. 
"""
select 
	ar.name,
	sum(il.unit_price * il.quantity) as total_revenue,
	round((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric,2) as percentages_of_revenue
from artist ar

join album al
on ar.artist_id = al.artist_id 

join track t
on al.album_id = t.album_id 

join invoice_line il
on t.track_id = il.track_id

group by 1;

--6
"""
— Most Expensive Tracks 
Find tracks whose unit_price is equal to the maximum track price. 
Return: 
 track name  
 artist name  
 album name  
 unit price  
Return all ties.
"""
select 
	tr.name,
	ar.name,
	al.title,
	il.unit_price
from artist ar

join album al
on ar.artist_id = al.artist_id 

join track tr
on al.album_id = tr.album_id 

join invoice_line il
on tr.track_id = il.track_id 

WHERE il.unit_price = (SELECT MAX(unit_price) FROM invoice_line);

--7
"""
— Monthly Revenue Ranking 
For every year and month, calculate: 
 year  
 month  
 total revenue  
 revenue rank across all months  
Highest-revenue month should have rank 1. 
"""
SELECT 
    EXTRACT(YEAR FROM invoice_date) AS year_,
    EXTRACT(MONTH FROM invoice_date) AS month_,
    SUM(total) AS total_revenue,
    RANK() OVER(ORDER BY SUM(total) DESC) AS rank_
FROM invoice

GROUP BY 1, 2
ORDER BY 1, 2;

--8
"""
— Artist Performance 
For every artist, calculate: 
 artist name  
 number of albums  
 number of tracks  
 total copies sold  
 total revenue  
 average revenue per track  
Show only artists with more than 20 tracks. 
"""
select
	ar.name,
	count(distinct(al.album_id)) as number_of_albums,
	count(distinct(tr.track_id)) as number_of_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	sum(il.unit_price * il.quantity) / count(distinct(tr.track_id)) as avg_revenue_per_track
from artist ar

join album al
on ar.artist_id = al.artist_id 

join track tr
on al.album_id = tr.album_id 

join invoice_line il
on tr.track_id = il.track_id 

group by 1

having count(distinct(tr.track_id)) > 20;

--9
"""
— Customer Above Average 
Find customers whose total spending is greater than the average customer 
spending. 
Return: 
 customer ID  
 customer name  
 total spending  
 spending rank 
"""
with spending as(
	select 
		c.customer_id,
		c.first_name || ' ' || c.last_name as customer_name,
		sum(i.total) as total_spending,
		rank() over(order by sum(i.total) desc) as spending_rank
	from customer c

	join invoice i
	on c.customer_id = i.customer_id 

	group by 1,2		
)

SELECT *
FROM spending
WHERE total_spending > (SELECT AVG(total_spending) FROM spending);

--10
"""
— Business Challenge 
Find the artist with the highest revenue and return: 
 artist name  
 total albums  
 total tracks  
 total copies sold  
 total revenue  
 revenue percentage of overall revenue  
 revenue rank  
 average revenue per album  
 average revenue per track  
If multiple artists tie for the highest revenue, return all tied artists.
"""
select 
	ar.name,
	count(distinct(al.album_id)) as total_albums,
	count(distinct(tr.track_id)) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	round((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric,2) as revenue_per,
	rank() over(order by sum(il.unit_price * il.quantity)) as revenue_rank,
	sum(il.unit_price * il.quantity) / count(distinct(al.album_id)) as avg_revenue_per_album,
	sum(il.unit_price * il.quantity) / count(distinct(tr.track_id)),
from 