--1 
"""
Display each playlist with: 
 Playlist Name  
 Number of Tracks  
Decide whether COUNT() or COUNT(DISTINCT) is appropriate. 
"""
select 
	p.playlist_id,
	p.name,
	count(distinct pl.track_id) as Number_of_tracks
from playlist p
join playlist_track pl
on p.playlist_id = pl.playlist_id
group by 1,2;

--2
"""
Display each genre with: 
 Genre Name  
 Total Revenue  
Decide which revenue column should be summed.
"""
select 
	g.genre_id,
	g.name,
	sum(il.unit_price * il.quantity) as total_revenue
from genre g

join track t
on g.genre_id = t.genre_id

join invoice_line il
on t.track_id = il.track_id

group by 1,2;

--3
"""
Display each customer with: 
 Customer Name  
 Average Invoice Amount  
Which table should provide the average? 
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	avg(i.total) as avg_invoice_amount
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1,2,3;

--4
"""
Display each genre with: 
 Shortest Track  
 Longest Track 
"""
select 
	g.genre_id,
	g.name,
	min(t.milliseconds) as shortest_track,
	max(t.milliseconds) as longest_track
from genre g
join track t
on g.genre_id = t.genre_id
group by 1,2;

--5
"""
Display each customer with: 
 Total Spending  
 Customer Category  
>60  → Pla num 
30–60 → Gold 
<30 → Silver
"""
select 
	c.customer_id,
	c.first_name,
	c.last_name,
	sum(i.total) as total_spending,
	case 
		when sum(i.total) > 60 then 'Platinum'
		when sum(i.total) between 30 and 60 then 'Gold'
		else 'Silver'
	end as Customer_category
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1,2,3;

--6
"""
Display monthly revenue. 
Output: 
 Year  
 Month  
 Revenue 
"""
select 	
	extract (year from invoice_date) as year_,
	extract (month from invoice_date) as month_,
	sum(total) as revenue
from invoice
group by 1,2;

--7
"""
Display each artist with: 
 Total Revenue  
 Revenue Rank 
"""
select 
	ar.artist_id,
	ar.name,
	sum(i.total) as total_revenue,
	rank() over(order by sum(i.total) desc) as revenue_rank
from artist ar

join album al
on ar.artist_id = al.artist_id

join track t
on al.album_id = t.album_id

join invoice_line il
on t.track_id = il.track_id

join invoice i
on il.invoice_id = i.invoice_id 

group by 1,2;

--8
"""
Display each media type with: 
 Revenue  
 Revenue % 
"""
select 
	m.media_type_id,
	m.name,
	sum(i.total) as revenue,
	ROUND(((SUM(i.total) * 100.0 / SUM(SUM(i.total)) OVER ())::numeric), 2) as revenue_per
from media_type m

join track t
on m.media_type_id = t.media_type_id

join invoice_line il
on t.track_id = il.track_id

join invoice i
on il.invoice_id = i.invoice_id

group by 1,2;

--9
"""
Display each employee with: 
 Customers Assigned  
 Revenue  
 Revenue Rank 
"""
select 
	e.employee_id,
	count(c.customer_id) as cust_assigned,
	sum(i.total) as revenue,
	rank() over(order by sum(i.total) desc) as revenue_rank
from employee e

JOIN customer c
ON e.employee_id = c.support_rep_id
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY 1,2,3
ORDER BY 4;

--10
"""
Display each artist with: 
 Artist Name  
 Total Albums  
 Total Tracks  
 Revenue  
 Revenue %  
 Revenue Rank 
"""
select 
	ar.name,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tracks,
	sum(i.total) as revenue,
	round(((sum(i.total) * 100.0 / sum(sum(i.total)) over())::numeric), 2) as revenue_per,
	RANK() OVER(ORDER BY SUM(i.total) DESC) AS revenue_rank
from artist ar

join album al
on ar.artist_id = al.artist_id 

join track t
on al.album_id = t.album_id 

join invoice_line il
on t.track_id = il.track_id

join invoice i
on il.invoice_id = i.invoice_id

group by 1;