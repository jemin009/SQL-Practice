--1
"""
 — Customer Spending 
For every customer, find: 
 customer ID  
 full name  
 country  
 number of invoices  
 total spending  
 average invoice value  
Show only customers whose total spending is greater than 40.
"""
select
	c.customer_id,
	c.first_name,
	c.last_name,
	c.country,
	count(distinct i.invoice_id) as num_of_invoices,
	sum(i.total) as total_spending,
	avg(i.total) as avg_invoice_value
from customer c

join invoice i
on c.customer_id = i.customer_id
group by 1,2,3,4
having sum(i.total) > 40;

--2
"""
— Country Revenue 
For every country, find: 
 country  
 number of customers  
 number of invoices  
 total revenue  
 average invoice value  
Sort by total revenue highest to lowest.
"""
select
	c.country,
	count(distinct c.customer_id) as num_of_customers,
	count(distinct i.invoice_id) as num_of_invoices,
	sum(i.total) as total_revenue,
	avg(i.total) as avg_invoice_value
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1
order by 4 desc;

--3
"""
— Genre Performance 
For every genre, find: 
 genre name  
 distinct tracks  
 total copies sold  
 total revenue  
 average revenue per track  
Show only genres with more than 20 tracks.
"""
select
	g.genre_id,
	count(distinct t.track_id) as tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.quantity * il.unit_price) as total_revenue,
	sum(il.quantity * il.unit_price) * 1.0 / count(distinct t.track_id) as avg_revenue_per_track
from genre g

join track t
on g.genre_id = t.genre_id

join invoice_line il
on t.track_id = il.track_id

group by 1

having count(distinct t.track_id) > 20;

--4
"""
— Artist Performance 
For every artist, find: 
 artist name  
 total albums  
 distinct tracks  
 total copies sold  
 total revenue  
Show only artists with more than 10 tracks.
"""
select 
	ar.artist_id,
	ar.name,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.quantity * il.unit_price) as total_revenue
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id 

join invoice_line il
on t.track_id = il.track_id

group by 1,2
having count(distinct t.track_id) > 10;

--5
"""
— Media Type Analysis 
For every media type, calculate: 
 media type name  
 distinct tracks  
 total copies sold  
 total revenue  
 percentage of overall revenue  
 revenue rank  
Rank from highest revenue to lowest.
"""
select 
	mt.media_type_id,
	count(distinct t.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.quantity * il.unit_price) as total_revenue,
	round(((sum(il.quantity * il.unit_price) * 100.0 / sum(sum(il.quantity * il.unit_price)) over())::numeric),2) as revenue_per,
	rank() over(order by sum(il.quantity * il.unit_price) desc)
from media_type mt

join track t
on mt.media_type_id = t.media_type_id

join invoice_line il
on t.track_id = il.track_id

group by 1
order by 4 desc;

--6
"""
— Monthly Revenue 
For every year and month, calculate: 
 year  
 month  
 distinct customers  
 invoices  
 total revenue  
 average invoice value  
Sort chronologically.
"""
select 
	extract (year from invoice_date) as year_,
	extract (month from invoice_date) as month_,
	count(distinct c.customer_id) as total_customers,
	count(distinct i.invoice_id) as total_invoices,
	sum(i.total) as total_revenue,
	avg(i.total) as avg_invoice_value
from customer c

join invoice i
on c.customer_id = i.customer_id 

group by 1,2;

--7
"""
— Above-Average Customers 
Find customers whose total spending is greater than the average customer's total 
spending. 
Return: 
 customer ID  
 customer name  
 total spending  
 spending rank 
"""
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(i.total) AS total_spending
    FROM customer c
	
    JOIN invoice i
    ON c.customer_id = i.customer_id
	
    GROUP BY 1,2
)

SELECT
    customer_id,
    customer_name,
    total_spending,
    RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
FROM customer_spending

WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_spending
)

ORDER BY spending_rank;

--8
"""
— Playlist Analysis 
For every playlist, calculate: 
 playlist name  
 distinct tracks  
 total duration in minutes  
 average track duration  
 shortest track  
 longest track  
Show only playlists containing more than 50 tracks.
"""
select 
	p.playlist_id,
	p.name,
	count(distinct t.track_id) as total_tracks,
	sum(t.milliseconds / 1000.0 / 60.0) as total_duration_minutes,
	sum(t.milliseconds / 1000.0 / 60.0) / count(distinct t.track_id) as avg_track_duration,
	min(t.milliseconds / 1000.0 / 60.0) as shortest_track,
	max(t.milliseconds / 1000.0 / 60.0) as longest_track
from playlist p

join playlist_track pt
on p.playlist_id = pt.playlist_id

join track t
on pt.track_id = t.track_id

group by 1,2
having count(distinct t.track_id) > 50;

--9
"""
— Top Track 
Find the track(s) with the highest total revenue. 
Return: 
 track name  
 artist name  
 album name  
 genre  
 total copies sold  
 total revenue  
If there is a tie, return all tied tracks.
"""
WITH track_revenue AS (
    select 
	t.track_id,
	t.name,
	ar.name,
	al.title,
	g.name,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue
from artist ar

join album al
on ar.artist_id = al.artist_id 

join track t
on al.album_id = t.album_id 

join genre g 
on t.genre_id = g.genre_id 

join invoice_line il
on t.track_id = il.track_id

group by 1,2,3,4,5

)

SELECT *
FROM track_revenue
WHERE total_revenue = (
    SELECT MAX(total_revenue)
    FROM track_revenue
);

select 
	t.track_id,
	t.name,
	ar.name,
	al.title,
	g.name,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue
from artist ar

join album al
on ar.artist_id = al.artist_id 

join track t
on al.album_id = t.album_id 

join genre g 
on t.genre_id = g.genre_id 

join invoice_line il
on t.track_id = il.track_id

group by 1,2,3,4,5;

--10
"""
— Artist Revenue Efficiency 
For every artist, calculate: 
 artist name  
 total albums  
 total tracks  
 total copies sold  
 total revenue  
 revenue percentage of overall revenue  
 revenue rank  
 average revenue per album  
 average revenue per track  
Sort by total revenue descending.
"""
select 
	ar.artist_id,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric),2) as revenue_per,
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank,
	sum(il.unit_price * il.quantity) / count(distinct al.album_id) as avg_revenue_per_album,
	sum(il.unit_price * il.quantity) / count(distinct t.track_id) as avg_revenue_per_track
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id 

join invoice_line il
on t.track_id = il.track_id



