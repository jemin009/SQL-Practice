-- 1. 
"""
Create a CTE named customer_invoice that returns: 
 customer_id  
 first_name  
 last_name  
 total invoice amount  
Then display all records. 
"""
with customer_invoice as (
	select 
		c.customer_id,
		c.first_name,
		c.last_name,
		sum(i.total) as total_invoice
	from customer c
	join invoice i
	on c.customer_id = i.customer_id
	group by 1,2,3
)
select * from customer_invoice;

-- 2.
"""
Create a CTE named artist_sales that returns: 
 artist_id  
 artist_name  
 total sales amount  
Display the top selling artist.
"""
with artist_sales as (
	select 
		ar.artist_id,
		ar.name,
		sum(il.unit_price * il.quantity) as total_sales
	from artist ar
	
	join album al
	on ar.artist_id = al.artist_id

	join track tr
	on al.album_id = tr.album_id

	join invoice_line il
	on tr.track_id = il.track_id

	group by 1,2
	order by 3 desc
	limit 1
)
select * from artist_sales;

-- 3.
"""
Create a CTE named genre_tracks that returns: 
 genre_name  
 total number of tracks  
Display all genres.
"""
with genre_tracks as (
	select 
		g.name,
		count(t.track_id) as total_track
	from genre g
	join track t
	on g.genre_id = t.genre_id
	group by 1
)
select * from genre_tracks;

-- 4.
"""
Create a CTE named album_tracks that returns: 
 album_title  
 total tracks  
Display the Top 5 albums having the highest number of tracks.
"""
with album_tracks as (
	select 
		a.title,
		count(t.track_id) as total_track
	from album a
	join track t
	on a.album_id = t.album_id
	group by 1
	order by 2 desc
	limit 5
)		
select * from album_tracks;

-- 5.
"""
Create a CTE named customer_spending that returns: 
 customer_id  
 customer_name  
 total_spent  
Display the customer who spent the most.
"""
with customer_spending as (
	select
		c.customer_id,
		c.first_name,
		c.last_name,
		sum(i.total) as total_spent
	from customer c
	join invoice i
	on c.customer_id = i.customer_id
	group by 1,2,3
	order by 4 desc
	limit 1
)
select * from customer_spending;

-- 6.
"""
Create a CTE named country_invoice that returns: 
 billing_country  
 total invoices  
Display all countries ordered by invoice count.
"""
with country_invoice as (
	select 
		billing_country,
		count(invoice_id) as total_invoices
	from invoice
	group by 1
	order by 2 desc
)
select * from country_invoice;

-- 7.
"""
Create a CTE named genre_sales that returns: 
 genre_name  
 total sales amount  
Display the highest selling genre.
"""
with genre_sales as (
	select 
		g.name,
		sum(il.unit_price * il.quantity) as total_sales_amount
	from genre g
	
	join track t
	on g.genre_id = t.genre_id

	join invoice_line il
	on t.track_id = il.track_id

	group by 1
	order by 2 desc
	limit 1
)
select * from genre_sales;

-- 8.
"""
Create a CTE named artist_tracks that returns: 
 artist_name  
 total tracks  
Display the Top 10 artists by track count.
"""
with artist_tracks as (
	select 
		a.name,
		count(t.track_id) as total_tracks
	from artist a
	
	join album alb
	on a.artist_id = alb.artist_id

	join track t
	on alb.album_id = t.album_id

	group by 1
	order by 2 desc
	limit 10
)
select * from artist_tracks;

-- 9.
"""
Create a CTE named invoice_average that returns: 
 invoice_id  
 invoice_total  
Using the CTE, display invoices greater than the average invoice amount.
"""
with invoice_average as (
	select
		invoice_id,
		total as invoice_total
	from invoice 
	group by 1
	order by 2
)
select * from invoice_average
where invoice_total > (select avg(invoice_total) from invoice_average) 

-- 10.
"""
Create a CTE named long_tracks that returns: 
 track_name  
 milliseconds  
Using the CTE, display tracks longer than 400000 milliseconds. 
"""
with long_tracks as (
	select 
		name,
		milliseconds
	from track
	order by 2 desc
)
select * from long_tracks
where milliseconds > 400000;

-- 11.
"""
Create a CTE named customer_purchase that returns: 
 customer_name  
 total purchases  
Display customers whose purchases are greater than 40.
"""
with customer_purchase as (
	select 
		c.first_name,
		c.last_name,
		sum(i.total) as total_purchase
	from customer c
	join invoice i
	on c.customer_id = i.customer_id 
	group by 1,2
	order by 3 desc
)
select * from customer_purchase
where total_purchase > 40;

-- 12.
"""
Create a CTE named employee_customer that returns: 
 employee_name  
 total customers handled  
Display all employees.
"""
with employee_customer as (
	select 
		e.first_name,
		e.last_name,
		count(c.customer_id) as total_customer
	from employee e
	left join customer c
	on e.employee_id = c.support_rep_id
	group by 1,2
	order by 3 desc
)
select * from employee_customer;

-- 13.
"""
Create a CTE named playlist_tracks that returns: 
 playlist_name  
 total tracks  
Display playlists ordered from highest to lowest tracks.
"""
with playlist_tracks as (
	select 
		p.name,
		count(pt.track_id) as total_tracks
	from playlist p
	join playlist_track pt
	on p.playlist_id = pt.playlist_id
	group by 1
	order by 2 desc
)
select * from playlist_tracks;

-- 14.
"""
Create a CTE named artist_album that returns: 
 artist_name  
 total albums  
Display artists having more than 5 albums.
"""
with artist_album as (
	select
		a.name,
		count(alb.album_id) as total_albums
	from artist a
	join album alb
	on a.artist_id = alb.artist_id
	group by 1
	order by 2 desc
)
select * from artist_album 
where total_albums > 5;

-- 15.
"""
Create a CTE named invoice_items that returns: 
 invoice_id  
 total_items  
Display invoices containing more than 5 purchased tracks. 
"""
with invoice_items as (
	select 	
		i.invoice_id,
		count(t.track_id) as total_items
	from invoice i

	join invoice_line il
	on i.invoice_id = il.invoice_id 

	join track t
	on il.track_id = t.track_id

	group by 1
	order by 2 desc
)
select * from invoice_items 
where total_items > 5;

-- 16.
"""
Create a CTE named customer_country that returns: 
 country  
 total customers  
Display countries having more than 3 customers.
"""
with customer_country as (
	select
		country,
		count(customer_id) as total_customer
	from customer
	group by 1
	order by 2 desc
)
select * from customer_country 
where total_customer > 3;

-- 17.
"""
Create a CTE named media_tracks that returns: 
 media_type  
 total tracks  
Display the media type containing the highest number of tracks.
"""
with media_tracks as (
	select 	
		m.name,
		count(t.track_id) as total_tracks
	from media_type m
	join track t
	on m.media_type_id = t.media_type_id 
	group by 1
	order by 2 desc
	limit 1
)
select * from media_tracks;

-- 18.
"""
Create a CTE named album_sales that returns: 
 album_title  
 total sales  
Display the Top 3 selling albums.
"""
with album_sales as (
	select
		alb.title,
		sum(il.unit_price * il.quantity) as total_sales
	from album alb

	join track t
	on alb.album_id = t.album_id

	join invoice_line il
	on t.track_id = il.track_id

	group by 1
	order by 2 desc
	limit 3
)

-- 19.
"""
Create a CTE named rock_artist that returns: 
 artist_name  
 total Rock tracks  
Display the artist having the highest number of Rock tracks.
"""
with rock_artist as (
	select 
		a.name,
		count(g.name) as total_rock_tracks
	from artist a

	join album alb 
	on a.artist_id= alb.artist_id 

	join track t
	on alb.album_id = t.album_id

	join genre g
	on t.genre_id = g.genre_id 

	where g.name = 'Rock'
	group by 1
)
SELECT * FROM rock_artist
ORDER BY 2 DESC
LIMIT 1;

-- 20.
"""
Create a CTE named customer_artist_spending that returns: 
 customer_name  
 artist_name  
 total_spent  
Display the Top 5 customer-artist combinations by spending. 
"""
with customer_artist_spending as (
	select 
		c.first_name,
		c.last_name,
		a.name,
		sum(i.total) as total_spent
	from customer c

	join invoice i
	on c.customer_id = i.customer_id

	join invoice_line il
	on i.invoice_id = il.invoice_id

	join track t
	on il.track_id = t.track_id

	join album alb
	on t.album_id = alb.album_id

	join artist a
	on alb.artist_id = a.artist_id

	group by 1,2,3
	order by 4 desc
	limit 5
)



