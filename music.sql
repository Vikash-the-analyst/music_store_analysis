---Q1. Who_is the senoir most employee based_on job title? ;

select first_name, last_name, title
from employee
order by levels desc
limit 1;

---Q2. Which country hsve most invoices? ;

select count(billing_country), billing_country from invoice
group by billing_country
order by billing_country desc
limit 1;

---Q3. What are top 3 values of total invoice? ;

select total from invoice
order by total desc
limit 3;

---Q4. Which city has the best customers? We would like to throw promotional music festival in the city We made the most money. Write the query that return one city that has the higest sum of invoice totals. Return the both city name and invoice totals. ;

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc;

---Answer - Prague city has best customer. ;

---Q5. Who is the best customer? The customer who has spent the most money will be declared	the best customer. Write a query the returns the person who has spent the most money? ;

select c.customer_id, c.first_name, c.last_name, sum(i.total) as invoice_total
from customer as c
join invoice as i
on c.customer_id = i.customer_id
group by c.customer_id,c.first_name, c.last_name
order by invoice_total desc
limit 1;

---Q6. Write a query to return email, first name, last name, genre of all Rock music listeners. Retturn your list alphabetically by email starting by A? ;

select distinct email, first_name, last_name
from customer
join invoice
on customer.customer_id=invoice.customer_id
join invoice_line
on invoice.invoice_id=invoice_line.invoice_id
where track_id in (
	select track_id from track
    join genre
    on track.genre_id = genre.genre_id
    where genre.name = "Rock"
)
order by email;

---Q7. Lets invite the artists who have written the most rock music in our dataset. Write a query that return artist name and total track count of the top 10 rock bands. ;

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album2
on album2.album_id=track.album_id
join artist
on artist.artist_id=album2.artist_id
join genre
on genre.genre_id=track.genre_id
where genre.name like "Rock"
group by artist_id, artist.name
order by number_of_songs desc
limit 10;

---Q8. Return all track names  that have a song length longer than the average length. Return the name and milliseconds for each track. Order by song length. ;

select name, milliseconds
from track
where milliseconds >(
	select avg(milliseconds) as avg_song_length
    from track
)
order by milliseconds desc;

---