--1. 
"""
Display each billing country with: 
 Total Revenue  
 Revenue Percentage  
"""
SELECT
    billing_country,
    SUM(total) AS total_revenue,
	ROUND((SUM(total) * 100.0/SUM(SUM(total)) OVER ())::numeric,2) AS revenue_percentage
FROM invoice
GROUP BY 1
ORDER BY 2 DESC;

--2
"""
Display each artist with: 
 Total Albums  
 Total Tracks  

(Use DISTINCT only if necessary.) 
"""
select 
	a.artist_id,
	a.name,
	count(distinct al.album_id) as total_albums,
	count(distinct t.track_id) as total_tracks
from artist a

join album al
on a.artist_id = al.artist_id

join track t
on al.album_id = t.album_id

group by 1,2;

--3
"""
Display each customer with: 
 Number of Invoices  
 Total Spending  
 Customer Category  
o Premium (>45)  
o Regular (25–45)  
o Basic (<25) 
"""
select 
	c.customer_id,
	count(distinct i.invoice_id) as number_of_invoices,
	sum(i.total) as total_spending,
	case 
		when sum(i.total) > 45 then 'Premium'
		when sum(i.total) between 25 and 45 then 'Regular'
		else 'Basic'
	end as Customer_category
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1
order by 3 desc;

--4
"""
Rank customers based on Total Spending. 
Display: 
 Customer Name  
 Total Spending  
 Rank  
"""
select 
	c.first_name,
	c.last_name,
	sum(i.total) as total_spending,
	rank() over(order by sum(i.total) desc) as rank_total_spending
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1,2;

--5
"""
Display each genre with: 
 Total Tracks  
 Number of Distinct Customers who purchased tracks from that genre 
"""
select 
	g.genre_id,
	g.name,
	count(distinct t.track_id) as total_tracks,
	count(distinct c.customer_id) as total_purchased
from genre g

join track t
on g.genre_id = t.genre_id

join invoice_line il
on t.track_id = il.track_id

join invoice i
on il.invoice_id = i.invoice_id

join customer c
on i.customer_id = c.customer_id

group by 1,2;

--6
"""
Display each playlist with: 
 Number of Tracks  
 Total Duration (Minutes)  
"""
select 
	p.playlist_id,
	p.name,
	count(distinct t.track_id) as number_of_tracks,
	sum(milliseconds / 1000 / 60) as total_duration_Minutes
from playlist p

join playlist_track pt
on p.playlist_id = pt.playlist_id

join track t
on pt.track_id = t.track_id

group by 1,2;

--7. Display yearly revenue using EXTRACT(). 
select 
	extract(year from invoice_date) as Year_,
	sum(total) as Revenue
from invoice
group by 1;

--8
"""
Display each media type with: 
 Total Revenue  
 Revenue Percentage
"""
select 
	mt.media_type_id,
	mt.name,
	sum(i.total) as total_revenue,
	round((sum(i.total) * 100.0 / sum(sum(i.total)) over())::numeric,2) as Revenue_percentage
from media_type mt

join track t
on mt.media_type_id = t.media_type_id

join invoice_line il
on t.track_id = il.track_id

join invoice i
on il.invoice_id = i.invoice_id

group by 1,2;

--9
"""
Display each employee with: 
 Customers Assigned  
 Total Revenue Generated  
 Revenue Rank  
"""
select 
	e.employee_id,
	e.first_name,
	e.last_name,
	count(distinct c.customer_id) as customer_assigned,
	sum(i.total) as total_revenue,
	rank() over(order by sum(i.total) desc) as revenue_rank
from employee e

join customer c
on e.employee_id = c.support_rep_id

join invoice i
on c.customer_id = i.customer_id

group by 1,2,3;

--10
"""
Display each artist with: 
 Total Albums  
 Total Tracks  
 Total Revenue  
 Revenue Percentage  
 Revenue Rank
"""
SELECT
    ar.artist_id,
    ar.name,
    COUNT(DISTINCT al.album_id) AS total_albums,
    COUNT(DISTINCT t.track_id) AS total_tracks,
    SUM(il.unit_price * il.quantity) AS total_revenue,
    ROUND((SUM(il.unit_price * il.quantity) * 100.0/SUM(SUM(il.unit_price * il.quantity)) OVER ())::numeric,2) AS revenue_percentage,
    RANK() OVER(ORDER BY SUM(il.unit_price * il.quantity) DESC) AS revenue_rank
FROM artist ar

JOIN album al
ON ar.artist_id = al.artist_id

JOIN track t
ON al.album_id = t.album_id

JOIN invoice_line il
ON t.track_id = il.track_id

GROUP BY 1,2
ORDER BY revenue_rank;