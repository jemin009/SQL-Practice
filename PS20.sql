--1. List all artists along with their albums. Include artists even if they don't have any albums.
select 
	ar.name,
	al.title
from artist ar
left join album al
on ar.artist_id = al.artist_id

--2. List all customers and the number of invoices they have. Include customers with zero invoices. 
select 
	c.first_name,
	c.last_name,
	count(i.invoice_id) as total_invoice 
from customer c 
left join invoice i
on c.customer_id = i.customer_id
group by 1,2

--3. Show every playlist with the number of tracks it contains. Include playlists with no tracks. 
select 
	p.name,
	count(t.track_id) as total_tracks
from playlist p 

left join playlist_track pt 
on p.playlist_id = pt.playlist_id

left join track t
on pt.track_id = t.track_id

group by 1

--4. Display all employees and the number of customers assigned to each employee. Include employees with no customers. 
select 
	e.first_name,
	e.last_name,
	count(c.customer_id) as total_customer_assigned
from employee e

left join customer c
on e.employee_id = c.support_rep_id

group by 1,2

--5. List every genre and the number of tracks in each genre. Include genres even if they have zero tracks. 
select 
	g.name,
	count(t.track_id) as total_tracks
from genre g

left join track t
on g.genre_id = t.genre_id

group by 1

--6. Show all albums and their artists. Include albums even if no matching artist exists. 
select 
	al.title,
	ar.name
from album al
left join artist ar
on al.artist_id = ar.artist_id

--7. Display all tracks and the playlists they belong to. Include tracks that are not part of any playlist. 
select 
	t.name,
	p.name
from track t

left join playlist_track pt
on t.track_id = pt.track_id

left join playlist p
on pt.playlist_id = p.playlist_id

--8. Show all customers and invoices using a FULL JOIN. 
select 
	c.first_name,
	c.last_name,
	i.total
from customer c 
full join invoice i
on c.customer_id = i.customer_id

--9. Show all playlists and playlist tracks using a FULL JOIN. 
select 
	p.name,
	t.name
from playlist p

full join playlist_track pt
on p.playlist_id = pt.playlist_id

full join track t
on pt.track_id = t.track_id 

--10. Display all media types and tracks using a RIGHT JOIN. 
select 
	m.name,
	t.name
from media_type m

right join track t
on m.media_type_id = t.media_type_id

--11. Assign a ROW_NUMBER() to every customer ordered by first_name. 
SELECT
    first_name,
    ROW_NUMBER() OVER(ORDER BY first_name) AS row_num
FROM customer;

--12. Rank customers by total spending using RANK(). 
select
	c.first_name,
	sum(i.total) as total_spent,
	rank() over(order by sum(i.total) desc) as ran
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1

--13. Rank artists by the number of tracks using DENSE_RANK(). 
select 
	a.name,
	count(t.track_id) as total_track,
	dense_rank() over(order by count(t.track_id) desc) as ran
from artist a

join album al
on a.artist_id = al.artist_id

join track t
on al.album_id = t.album_id

group by 1

--14. Assign a ROW_NUMBER() to tracks within each album ordered by milliseconds (longest first). 
SELECT
    alb.title,
    t.name,
    t.milliseconds,
    ROW_NUMBER() OVER(PARTITION BY alb.album_id ORDER BY t.milliseconds DESC) AS row_num
FROM album alb

JOIN track t
ON alb.album_id = t.album_id;

--15. Rank invoices by total amount using RANK(). 
select 	
	invoice_id,
	total,
	rank() over(order by total desc) as rank_num
from invoice 

--16. Assign a ROW_NUMBER() to albums within each artist ordered alphabetically by album title. 
select 
	alb.title,
	a.name,
	row_number() over(partition by a.name order by alb.title) as row_num
from album alb
join artist a 
on alb.artist_id = a.artist_id

--17. Find the top-selling 5 customers using DENSE_RANK(). 
select 
	c.first_name,
	c.last_name,
	sum(i.total) as total_sales,
	rank() over(order by sum(i.total) desc) as rank_num
from customer c 
join invoice i
on c.customer_id = i.customer_id
group by 1,2
limit 5

--18. Rank genres by total sales amount using RANK(). 
SELECT
    g.name,
    SUM(il.unit_price * il.quantity) AS total_sales,
    RANK() OVER( ORDER BY SUM(il.unit_price * il.quantity) DESC ) AS rank_num
FROM genre g

JOIN track t
ON g.genre_id = t.genre_id

JOIN invoice_line il
ON t.track_id = il.track_id

GROUP BY 1

--19. Assign a ROW_NUMBER() to tracks within each genre ordered alphabetically by track name. 
select 
	t.name,
	g.name,
	row_number() over(partition by g.name order by t.name) as row_num
from track t
join genre g
on t.genre_id = g.genre_id

--20. For every customer, rank their invoices by invoice total (highest invoice first) using ROW_NUMBER() partitioned by customer. 
SELECT
    c.first_name,
    c.last_name,
    SUM(i.total) AS invoice_total,
    ROW_NUMBER() OVER(ORDER BY SUM(i.total) DESC) AS row_num
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY 1,2
    