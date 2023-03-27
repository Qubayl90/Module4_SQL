--------------------------------------- SQL Day 1 Homework ----------------------------------------------
--1. How many actors are there with the last name ‘Wahlberg’?
select count(actor_id) from actor where last_name = 'Wahlberg'
--Answer: 2

--2. How many payments were made between $3.99 and $5.99?
select count(payment_id) from payment where (amount>=3.99 and amount<=5.99)
--Answer: 0

--3. What film does the store have the most of? (search in inventory)
select * from inventory
select film_id, count(*) mycount from inventory group by film_id order by mycount desc
select film_id, count(*) mycount from inventory group by film_id order by mycount desc limit 1
select film_id, count(*) from inventory group by film_id having count(*) = (select count(*) mycount from inventory group by film_id order by mycount desc limit 1)
-- Answer: There are 72 movies with amx count of 8


--4. How many customers have the last name ‘William’?
select * from customer where last_name = 'William'
select * from customer where last_name = 'Williams'
select count(customer_id)  from customer where last_name = 'Williams'
--Answer: There is only one customer having last_name as 'Williams', and zero customers with last_name as William
 	

--5. What store employee (get the id) sold the most rentals?
select * from rental
select staff_id, count(*) mycount from rental group by staff_id order by mycount desc
select staff_id, count(*) mycount from rental group by staff_id order by mycount desc limit 1
select staff_id, count(*) from rental group by staff_id having count(*) = (select count(*) mycount from rental group by staff_id order by mycount desc limit 1)
--Answer: Staff_id 1 has the most rentals


--6. How many different district names are there?
select * from address
select count(distinct district) from address
--Answer: There are total 378 different districts 


--7. What film has the most actors in it? (use film_actor table and get film_id)
select film_id, count(*) mycount from film_actor group by film_id order by mycount desc
select count(*) mycount from film_actor group by film_id order by mycount desc limit 1
select film_id, count(*) from film_actor group by film_id having count(*) = (select count(*) mycount from film_actor group by film_id order by mycount desc limit 1)
-- Answer: Film id 508 has most numbers of actors that is 15


--8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
select count(*) from customer where store_id = 1 and last_name like '%es'
-- Answer: There are 13 such customers


--9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
--with ids between 380 and 430? (use group by and having > 250)
select amount, count(*) as Number_of_Rentals from payment where customer_id between 380 and 430 group by amount
select amount, count(*) as Number_of_Rentals from payment where customer_id between 380 and 430 group by amount having count(*) >250
--Answer: There are three such payment amounts


--10. Within the film table, how many rating categories are there? And what rating has the most movies total?
select rating, count(*) from film group by rating
select rating, count(*) from film group by rating having count(*) = (select count(*) from film group by rating order by count(*) desc limit 1) 
-- Answer: There are 5 rating categories and rating 'PG-13' has most movies that is total 223




------------------------------------------------- Practice---------------------------------------------------------
-- First Query
SELECT * FROM public.actor;

--first_name, last_name
select FIRST_NAME, LAST_NAME from actor

--first_name: Nick
select FIRST_NAME, LAST_NAME from actor where first_name like 'Nick'
select FIRST_NAME, LAST_NAME from actor where first_name = 'Nick'

-- first_name that starts with a J, using like, where and a wildcard
select FIRST_NAME, LAST_NAME from actor where first_name like 'J%'

-- first_name that starts with a K and has exactly two letters after K
select FIRST_NAME, ACTOR_ID from actor where first_name like 'K__'

-- first_name that starts with a K and ends with th
select FIRST_NAME, ACTOR_ID from actor where first_name like 'K__%th'
select FIRST_NAME, ACTOR_ID from actor where first_name like 'K%__th'
select FIRST_NAME, ACTOR_ID from actor where first_name like 'K__%in'

--Comparing operators
select * from payment

-- paid amount greater than $2
select * from payment where amount > 2.00

-- amount less than <7.99
select * from payment where amount < 7.99
select * from payment where amount <= 7.99
select * from payment where amount >= 2.00

-- not equal to zero and order it in decscending order
select * from payment where amount <> 0.00 order by amount desc

-- SQL Aggregate functions - Sum, avg,min and max
-- sum of amounts paid are greater than 5.99
select sum(amount) from payment where amount>5.99
--avg of amount greater than 5.99
select avg(amount) from payment where amount>5.99
-- count of amount greater than 5.99
select count(amount) from payment where amount>5.99
--Count of Distinct amounts paid greater than 5.99
select count(distinct amount) from payment where amount>5.99
--Min amounts greater than 7.99
select min(amount) as min_num_payments from payment where amount>7.99
--Max amounts greater than 7.99
select max(amount) as max_num_payments from payment where amount>7.99

-- group by 
select amount from payment where amount = 16.99
-- Query to display different amounts grouped together and conunt the amounts
select amount, count(amount) from payment group by amount order by amount
select amount from payment group by amount order by amount
--customer id with summed amounts for each customer_id 
select customer_id, sum(amount)from payment group by customer_id order by customer_id desc


