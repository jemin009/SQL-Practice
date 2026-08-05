--1
"""
Display each customer. 
Show: 
 Customer ID  
 Full Name  
 Total Invoices  
 Total Spending  
 Average Invoice  
 Revenue %  
 Spending Rank 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	count(i.invoice_id) as total_invoices,
	sum(i.total) as total_spending,
	avg(i.total) as average_invoice,
	round(((sum(i.total) * 100.0 / sum(sum(i.total)) over())::numeric),2) as revenue_per,
	rank() over(order by sum(i.total) desc) as spending_rank
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3;

--2
"""
Display each artist. 
Show: 
 Artist Name  
 Total Albums  
 Total Tracks  
 Total Copies Sold  
 Total Revenue  
 Average Revenue per Track  
"""
select 
	ar.artist_id,
	ar.name,
	count(distinct al.album_id) as total_albums,
	count(distinct tr.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	sum(il.unit_price * il.quantity)*1.0 / count(distinct tr.track_id) as avg_revenue_per_track
from artist ar

join album al
on ar.artist_id = al.artist_id

join track tr
on al.album_id = tr.album_id

join invoice_line il
on tr.track_id = il.track_id 

group by 1,2;

--3
"""
Display each genre. 
Show: 
 Genre Name  
 Total Tracks  
 Total Copies Sold  
 Average Copies Sold per Track  
 Total Revenue  
"""
select 
	g.genre_id,
	g.name,
	count(distinct t.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.quantity) * 1.0 / count(distinct t.track_id) as avg_copies_sole_per_track,
	sum(il.unit_price * il.quantity) as total_revenue
from genre g

join track t
on g.genre_id = t.genre_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2;

--4
"""
Create a yearly report. 
Show: 
 Year  
 Total Customers  
 Total Invoices  
 Total Revenue  
 Highest Invoice  
 Lowest Invoice  
Order by Year. 
"""
select 
	extract (year from i.invoice_date) as year_,
	count(distinct c.customer_id) as total_customers,
	count(i.invoice_id) as total_invoices,
	sum(i.total) as total_revenue,
	max(i.total) as highest_revenue,
	min(i.total) as lowest_revenue
from customer c

join invoice i 
on c.customer_id = i.customer_id

group by 1
order by 1;

--5
"""
Display each playlist. 
Show: 
 Playlist Name  
 Total Tracks  
 Total Duration (Minutes)  
 Average Duration  
 Shortest Track  
 Longest Track  
"""
select 
	p.playlist_id,
	p.name,
	count(distinct t.track_id) as total_tracks,
	sum(t.milliseconds / 1000.0 / 60) as total_duraion_minutes,
	avg(t.milliseconds / 1000.0 / 60) as avg_duraion_minutes,
	min(t.milliseconds / 1000.0 / 60) as shortest_track,
	max(t.milliseconds / 1000.0 / 60) as longest_track
from playlist p

join playlist_track pt
on p.playlist_id = pt.playlist_id

join track t
on pt.track_id = t.track_id

group by 1,2;

--6
"""
Display each media type. 
Show: 
 Media Type  
 Total Tracks  
 Total Copies Sold  
 Total Revenue  
 Revenue %  
 Revenue Rank  
"""
select 	
	mt.media_type_id,
	mt.name,
	count(distinct t.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric),2) as revenue_per,
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank
from media_type mt

join track t
on mt.media_type_id = t.media_type_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2;

--7
"""
Display customers whose total spending is greater than the overall average 
customer spending. 
Show: 
 Customer ID  
 Full Name  
 Total Spending  
 Number of Invoices  
Use a subquery. 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	sum(i.total) as total_spending,
	count(distinct i.invoice_id) as num_of_invoices
from customer c

join invoice i
on c.customer_id = i.customer_id 

group by 1,2,3
HAVING SUM(i.total) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT
            customer_id,
            SUM(total) AS customer_total
        FROM invoice
        GROUP BY customer_id
    ) x
);

--8
"""
Display artists whose total revenue is greater than the average revenue of all 
artists. 
Show: 
 Artist Name  
 Total Revenue  
 Total Albums  
 Total Tracks  
Use a subquery.
"""
select 
	ar.artist_id,
	ar.name,
	sum(il.unit_price * il.quantity) as total_albums,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tarcks
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t 
on al.album_id = t.album_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2
HAVING SUM(il.unit_price * il.quantity) >
(
    SELECT AVG(artist_revenue)
    FROM
    (
        SELECT
            ar.artist_id,
            SUM(il.unit_price * il.quantity) AS artist_revenue
        FROM artist ar
        JOIN album al
            ON ar.artist_id = al.artist_id
        JOIN track t
            ON al.album_id = t.album_id
        JOIN invoice_line il
            ON t.track_id = il.track_id
        GROUP BY ar.artist_id
    ) x
);

--9 
"""
Display genres whose: 
 Total Revenue > 100  
 AND Total Tracks > 20  

Show: 
 Genre Name  
 Total Tracks  
 Total Revenue  
 Revenue %  
Use HAVING. 
"""
select 
	g.genre_id,
	g.name,
	count(distinct t.track_id) as total_tracks,
	sum(il.unit_price * il.quantity) as total_revenue,
	ROUND(((SUM(il.unit_price * il.quantity) * 100.0 / SUM(SUM(il.unit_price * il.quantity)) OVER())::numeric),2) AS revenue_per
from genre g 

join track t
on g.genre_id = t.genre_id 

join invoice_line il
on t.track_id = il.track_id 

group by 1,2
having sum(il.unit_price * il.quantity) > 100 and count(distinct t.track_id) > 20;

--10
"""
Display each artist. 
Show: 
 Artist Name  
 Total Albums  
 Total Tracks  
 Total Copies Sold  
 Total Revenue  
 Revenue %  
 Revenue Rank  
 Average Revenue per Album  
 Average Revenue per Track 
"""
select 
	ar.artist_id,
	ar.name,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over()):numeric),2) as revenue_per,
	rank() over(order by sum(il.unit_price * il.quantity)) as revenue_rank,
	sum(il.unit_price * il.quantity) / count(distinct al.album_id) avg_revenue_per_album,
	sum(il.unit_price * il.quantity) / count(distinct t.track_id) avg_revenue_per_track
from 
			