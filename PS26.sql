--1
"""
Display each customer's: 
 Customer ID  
 Full Name  
 Number of Invoices  
 Total Spending  
 Average Invoice  
 Highest Invoice  
 Customer Category  
o Platinum (>80)  
o Gold (50–80)  
o Silver (<50)  
Order by Total Spending (Highest first). 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	count(distinct i.invoice_id) as num_of_invoices,
	sum(i.total) as total_spending,
	avg(i.total) as average_invoice,
	max(i.total) as highest_invoice,
	case
		when sum(i.total) > 80 then 'Platinum'
		when sum(i.total) between 50 and 80 then 'Gold'
		else 'Silver'
	end as Customer_category
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3;

--2
"""
Display each artist's: 
 Artist Name  
 Total Albums  
 Total Tracks  
 Total Revenue  
 Average Revenue per Track  
 Revenue Rank  
"""
select 
	ar.artist_id,
	ar.name,
	count(distinct al.album_id) as total_albums,
	count(distinct tr.track_id) as total_tracks,
	sum(il.unit_price * il.quantity) as total_revenue,
	sum(il.unit_price * il.quantity) * 1.0 / count(distinct tr.track_id) as avg_revenue_per_track,
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank
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
Display each genre's: 
 Genre Name  
 Total Tracks  
 Total Copies Sold  
 Total Revenue  
 Average Selling Price per Track Sold 
"""
select 
	g.genre_id,
	g.name,
	count(distinct t.track_id) as total_tracks,
	sum(il.quantity) as total_copies_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	sum(il.unit_price * il.quantity) * 1.0 / sum(il.quantity) as avg_selling_price 
from genre g

join track t
on g.genre_id = t.genre_id

join invoice_line il
on t.track_id = il.track_id 

group by 1,2;

--4
"""
Display monthly sales report. 
Show: 
 Year  
 Month  
 Number of Customers  
 Number of Invoices  
 Total Revenue  
 Average Invoice  
Order chronologically. 
"""
select 
	extract (year from i.invoice_date) as year_,
	extract (month from i.invoice_date) as month_,
	count(distinct c.customer_id) as num_of_customers,
	count(i.total) as num_of_invoices,
	sum(i.total) as total_revenue,
	avg(i.total) as average_invoice
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2;

--5
"""
Display each playlist. 
Show: 
 Playlist Name  
 Number of Tracks  
 Total Duration (Minutes)  
 Average Track Duration  
 Longest Track Duration  
"""
select 
	p.playlist_id,
	p.name,
	count(distinct t.track_id) as num_of_tracks,
	sum(t.milliseconds / 1000.0 / 60) as total_duration_minutes,
	avg(t.milliseconds / 1000.0 / 60) as avg_track_duration,
	max(t.milliseconds / 1000.0 / 60) as lonhgest_track_duration
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
 Total Revenue  
 Revenue %  
 Revenue Rank  
"""
select 
	mt.media_type_id,
	mt.name,
	count(distinct t.track_id) as total_tracks,
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
Display customers who have spent more than the average customer spending. 
Show: 
 Customer ID  
 Full Name  
 Total Spending  
Hint: Requires HAVING. 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	sum(i.total) as total_spending
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3
HAVING SUM(i.total) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT SUM(total) AS customer_total
        FROM invoice
        GROUP BY customer_id
    ) x
);

--8
"""
Display genres having more than 30 tracks. 
Show: 
 Genre Name  
 Number of Tracks  
 Total Revenue  
Use HAVING. 
"""
select 
	g.genre_id,
	g.name,
	count(distinct t.track_id) as num_of_tracks,
	sum(il.unit_price * il.quantity) as total_revenue
from genre g

join track t
on g.genre_id = t.genre_id 

join invoice_line il
on t.track_id = il.track_id

group by 1,2
having count(distinct t.track_id) > 30;

--9
"""
Display artists having more than 10 tracks. 
Show: 
 Artist Name  
 Total Tracks  
 Total Albums  
 Total Revenue  
Use HAVING. 
"""
select 
	ar.artist_id,
	ar.name,
	count(distinct t.track_id) as total_tracks,
	count(distinct al.album_id) as total_albums,
	sum(il.unit_price * il.quantity) as total_revenue
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id 

join invoice_line il
on t.track_id = il.track_id

group by 1,2
having count(distinct t.track_id) > 10;

--10
"""
Display each artist. 
Show: 
 Artist Name  
 Total Revenue  
 Revenue %  
 Revenue Rank  
 Total Albums  
 Total Tracks  
 Average Revenue per Album  
"""
select 
	ar.artist_id,
	ar.name,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric),2) as revenue_per,
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tracks,
	sum(il.unit_price * il.quantity) * 1.0 / count(distinct al.album_id) as avg_revenue_per_album
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2;