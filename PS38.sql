--Q1
/*
— Customer Invoice Summary 

Display each customer's ID, full name, number of invoices, and total spending.
Show only customers whose total spending is greater than 40. 

Tables: customer, invoice 
*/

select 
	c.customer_id,
	c.first_name || ' ' || c.last_name,
	count(i.invoice_id) as num_of_invoices,
	sum(i.total) as total_spending
from customer c
join invoice i
on c.customer_id = i.customer_id
group by 1,2
having sum(i.total) > 40;

--Q2
/*
— Top-Selling Tracks 

Find the 10 tracks with the highest total quantity sold. Display track name, track ID, and total quantity sold. 

Tables: track, invoice_line
*/

select 
	t.name,
	t.track_id,
	sum(il.quantity) as total_quantity_sold
from track t
join invoice_line il
on t.track_id = il.track_id

group by 1,2
order by 3 desc
limit 10;

--Q3
/*

*/


