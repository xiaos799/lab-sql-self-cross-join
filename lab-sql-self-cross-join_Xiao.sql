use sakila;

#1 Get all pairs of actors that worked together.
select * from film_actor;

select fa1.actor_id, fa1.film_id, fa2.actor_id from film_actor fa1
join film_actor fa2
on fa1.film_id = fa2.film_id and fa1.actor_id != fa2.actor_id;

#2 Get all pairs of customers that have rented the same film more than 3 times.
select * from rental;
select * from inventory;

with cte as(
        select film_id, customer_id, count(rental_id) from inventory
        join rental using (inventory_id)
        group by film_id, customer_id
        having count(rental_id) = 3)
select * from 
(select distinct customer_id from cte) sub1
cross join 
(select distinct customer_id from cte) sub2;


#3 Get all possible pairs of actors and films.
select * from
(select distinct actor_id from actor) sub1
cross join
(select distinct film_id from film) sub2