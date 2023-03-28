----------Week 5 - Wednesday Questions

--1. List all customers who live in Texas (use JOINs)
/*select * from "customer"
select * from address a where district = 'Texas'
select * from city c 
select * from country c2 

select customer_id, first_name, last_name from "customer" c 
full join address a 
on c.address_id = a.address_id 
where a.district = 'Texas'
*/

select customer_id, first_name, last_name, a.address, c2.city, a.district from "customer" c 
full join address a 
on c.address_id = a.address_id 
full join city c2
on a.city_id = c2.city_id 
where a.district = 'Texas'

--2. Get all payments above $6.99 with the Customer's Full Name
select p.payment_id, c.customer_id, c.first_name, c.last_name, p.amount from payment p 
inner join customer c 
on c.customer_id = p.customer_id 
where amount > 6.99

--3. Show all customers names who have made payments over $175(use subqueries)
SELECT *
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


--4. List all customers that live in Nepal (use the city table)
/*select * from "customer"
select * from address a where district = 'Texas'
select * from city c 
select * from country c2 where country = 'Nepal' 
*/
select customer_id, first_name, last_name, a.address, c2.city, a.district, c3.country 
from "customer" c 
full join address a 
on c.address_id = a.address_id 
full join city c2
on a.city_id = c2.city_id 
full join country c3
on c2.country_id = c3.country_id
where c3.country = 'Nepal'

--5. Which staff member had the most transactions?
/*select * from payment p
select * from staff
select staff_id, count(*) transactions from payment p group by staff_id order by transactions desc
select staff_id from payment p group by staff_id order by count(*) desc
select staff_id from payment p group by staff_id order by count(*) desc limit 1*/

select * from staff where staff_id in (select staff_id from payment p group by staff_id order by count(*) desc limit 1)
--Answer: Staff ID 2 that is Jon Stephens had the most transactions

--6. How many movies of each rating are there?
/*select * from movies m 
select * from movie_ratings mr 
select * from movies_scott_mcl msm 
select * from movie_ratings_scott_mcl mrsm 

select rating_id, count(*) movie_count from movies_scott_mcl msm group by msm.rating_id 
*/
/*
select mrsm.rating_id, count(*) movie_count 
from movies_scott_mcl msm 
full join movie_ratings_scott_mcl mrsm 
on msm.rating_id = mrsm.rating_id 
group by mrsm.rating_id 
*/
select mrsm.rating_id, count(msm.movie_id) as movie_count 
from movie_ratings_scott_mcl mrsm 
left join movies_scott_mcl msm 
on msm.rating_id = mrsm.rating_id 
group by mrsm.rating_id

select mrsm.rating_id, mrsm.rating_initials, mrsm.rating_description, count(msm.movie_id) as movie_count 
from movie_ratings_scott_mcl mrsm 
left join movies_scott_mcl msm 
on msm.rating_id = mrsm.rating_id 
group by mrsm.rating_id, mrsm.rating_initials, mrsm.rating_description


--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

/*select p.payment_id, c.customer_id, c.first_name, c.last_name, p.amount from payment p 
inner join customer c 
on c.customer_id = p.customer_id 
where amount > 6.99
*/

select c.customer_id, c.first_name, c.last_name from payment p 
inner join customer c 
on c.customer_id = p.customer_id 
where amount > 6.99
group by c.customer_id, c.first_name, c.last_name 
having count(*) <=1

------- or---------------- 

select p.payment_id, c.customer_id, c.first_name, c.last_name, p.amount from payment p 
inner join customer c 
on c.customer_id = p.customer_id 
where amount > 6.99 and c.customer_id in
(select c.customer_id from payment p 
inner join customer c 
on c.customer_id = p.customer_id 
where amount > 6.99
group by c.customer_id
having count(*) <=1)


--8. How many free rentals did our stores give away?
/*select * from rental r;
select * from payment p;

select r.rental_id, payment_id, amount
from rental r 
left join payment p 
on r.rental_id = p.rental_id 
where p.payment_id is null 
*/
select count(r.rental_id)
from rental r 
left join payment p 
on r.rental_id = p.rental_id 
where p.payment_id is null 
