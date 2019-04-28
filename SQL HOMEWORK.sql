use sakila;

#1a)
Select first_name,last_name from actor;

#1b)
SELECT concat(first_name," ", last_name) AS Actor_Name
FROM actor;

#2a)
select actor_id,first_name,last_name
from actor
where first_name like "%Joe";

#2b)
select actor_id,first_name,last_name
from actor
where last_name like "%GEN%";

#2c)
select last_name,first_name,actor_id
from actor
where first_name or last_name like "%LI%";

#2d)
SELECT country_id,country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#4a)
SELECT last_name,COUNT(*) as Count 
FROM actor 
GROUP BY last_name;

#4b)
SELECT last_name,COUNT(*) as Count 
FROM actor 
GROUP BY last_name
having Count>1;

#4c)
select first_name, last_name
from actor
where first_name="HARPO";

#4d)
UPDATE actor
SET first_name="HARPO"
WHERE first_name="GROUCHO" and last_name="WILLIAMS";

#6a)
SELECT staff.first_name,staff.last_name,staff.address_id
FROM staff
INNER JOIN address ON
staff.address_id=address.address_id;

#6b)
SELECT first_name, last_name, SUM(amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id;

#6c)
select count(film_actor.actor_id) as actor_count,film_actor.film_id,film.title
from film_actor
inner join film on
film.film_id=film_actor.film_id
group by film.title;

#6d)
select count(*) as "# of Copies"
from inventory
where film_id in(
	select film_id
    from film
    where title="Hunchback Impossible"
    );
    
#6e)
select customer.customer_id,customer.first_name,customer.last_name,count(payment.amount) as "total paid"
from customer
inner join payment on
payment.customer_id=customer.customer_id
group by customer.last_name;

#7a)
select title
from film
where film_id in(
	select film_id
    from film 
    where language_id=1 and title like "K%" or title like "Q%"
    );
    
#7b)
select first_name,last_name
from actor
where actor_id in(
	select actor_id
    from film_actor
    where film_id in(
		select film_id
        from film
        where title="Alone Trip"
        )
        );

#7c)
SELECT country, last_name, first_name, email
FROM country c
LEFT JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';

#7d)
select title
from film
where film_id in(
select film_id
from film_category
where category_id in(
	select category_id
	from film_category
	where category_id in(
		select category_id
		from category
		where name='Family'
        )
        )
    );

#7e)
SELECT i.film_id, f.title, COUNT(r.inventory_id)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f 
ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;

#7f)
SELECT store.store_id, SUM(amount) as "amount in dollars"
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);

#7g)
SELECT s.store_id, city, country
FROM store s
INNER JOIN customer cu
ON s.store_id = cu.store_id
INNER JOIN staff st
ON s.store_id = st.store_id
INNER JOIN address a
ON cu.address_id = a.address_id
INNER JOIN city ci
ON a.city_id = ci.city_id
INNER JOIN country coun
ON ci.country_id = coun.country_id;

#7h)
SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

CREATE VIEW top_five_grossing_genres AS

SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

SELECT * FROM top_five_grossing_genres;

DROP VIEW top_five_grossing_genres;




        












