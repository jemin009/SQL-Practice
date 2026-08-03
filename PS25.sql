--1 
"""
Show each customer's: 
 Customer ID  
 Full Name  
 Total Spending  
 Average Invoice Amount  
 Customer Category:  
o Platinum (> 70)  
o Gold (40–70)  
o Silver (< 40) 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	sum(i.total) as total_spending,
	avg(i.total) as avg_invoice_amount,
	case 
		when sum(i.total) > 70 then 'Platinum'
		when sum(i.total) between 40 and 70 then 'Gold'
		else 'Silver'
	end as Cuatomer_category
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3;

--2
"""
Show each artist's: 
 Artist Name  
 Total Albums  
 Total Tracks  
 Total Revenue  
 Revenue Rank (Highest revenue = Rank 1)  
"""
select 
	ar.artist_id,
	ar.name,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tracks,
	sum(il.unit_price * il.quantity) as total_revenue,
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id 

join invoice_line il
on t.track_id = il.track_id

group by 1,2;

--3
"""
Show each genre's: 
 Genre Name  
 Number of Tracks Sold  
 Total Revenue  
 Revenue Percentage of Overall Sales 
"""
select 
	g.genre_id,
	g.name,
	sum(distinct il.quantity) as tracks_sold,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric),2) as revenue_per
from genre g

join track t
on g.genre_id = t.genre_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2;

--4
"""
Show monthly revenue: 
 Year  
 Month  
 Number of Invoices  
 Total Revenue  
 Average Invoice Value 
"""
select 
	extract(year from invoice_date) as year_,
	extract(month from invoice_date) as month_,
	count(invoice_id) as number_of_invoices,
	sum(total) as total_revenue,
	avg(total) as avg_invoice_value
from invoice
group by 1,2;

--5
"""
Show each playlist: 
 Playlist Name  
 Number of Tracks  
 Total Duration (Minutes)  
 Average Track Duration (Minutes) 
"""
select 
	p.playlist_id,
	p.name,
	count(t.track_id) as num_of_tracks,
	sum(t.milliseconds/1000.0/60) as total_duration_Minutes,
	avg(t.milliseconds/1000.0/60) as total_duration_Minutes
from playlist p

join playlist_track pt
on p.playlist_id = pt.playlist_id

join track t
on pt.track_id = t.track_id

group by 1,2;

--6
"""
Show each media type: 
 Media Type Name  
 Total Tracks  
 Total Revenue  
 Revenue Percentage  
"""
select 
	mt.media_type_id,
	mt.name,
	count(distinct t.track_id) as total_tracks,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric),2) as revenue_per
from media_type mt

join track t
on mt.media_type_id = t.media_type_id 

join invoice_line il
on t.track_id = il.track_id 

group by 1,2;
	
--7
"""
Show each employee: 
 Employee Name  
 Customers Assigned  
 Total Revenue Generated  
 Revenue Rank  
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	count(distinct i.invoice_id) as num_of_invoices,
	sum(i.total) as total_spending,
	avg(i.total) as avg_invoice_value,
	rank() over(order by sum(i.total) desc) as customer_rank
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3
limit 5;

--8
"""
Show each customer: 
 Customer Name  
 Number of Invoices  
 Highest Invoice  
 Lowest Invoice  
 Average Invoice 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	count(i.invoice_id) as num_of_invoices,
	max(i.total) as highest_invoice,
	min(i.total) as lowest_invoice,
	avg(i.total) as avg_invoice
from customer c

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3;

--9
"""
Show each genre: 
 Genre Name  
 Shortest Track (Minutes)  
 Longest Track (Minutes)  
 Average Track Duration (Minutes) 
"""
select
	g.genre_id,
	g.name,
	min(t.milliseconds/1000.0/60) as shortest_track_minutes,
	max(t.milliseconds/1000.0/60) as longest_track_minutes,
	avg(t.milliseconds/1000.0/60) as average_track_minutes
from genre g

join track t
on g.genre_id = t.genre_id

group by 1,2;

--10
"""
Show each artist: 
 Artist Name  
 Total Revenue  
 Revenue Percentage  
 Revenue Rank  
 Total Albums  
"""
select 
	ar.artist_id,
	ar.name,
	sum(il.unit_price * il.quantity) as total_revenue,
	round(((sum(il.unit_price * il.quantity) * 100.0 / sum(sum(il.unit_price * il.quantity)) over())::numeric),2) as revenue_per,
	rank() over(order by sum(il.unit_price * il.quantity) desc) as revenue_rank,
	count(distinct al.album_id) as total_albums
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2;
