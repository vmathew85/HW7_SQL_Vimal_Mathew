use sakila;

#1a
select first_name, last_name
from actor;

#1b
select concat(upper(first_name),upper(last_name)) AS 'Actor Name'
from actor;

#2a
select actor_id, first_name, last_name
from actor
where first_name = "Joe";

#2b
select actor_id, last_name, first_name
from actor
where last_name LIKE '%gen%';

#2c
select actor_id, first_name, last_name
from actor
where last_name LIKE '%LI%'
order by last_name asc, first_name asc;

#2d
select country_id, country
from country
where country in ("Afghanistan", "Bangladesh","China");

#3a
Alter table actor
add COLUMN Description BLOB After last_name;

#3b
Alter table actor
drop COLUMN Description;

#4a
select last_name, count(last_name)
from actor
group by last_name;

#4b
select last_name, count(last_name) AS 'Count_LastName'
from actor
group by last_name
having Count_LastName > 1;

#4c
Update actor
set first_name = "Harpo"
where first_name = "Groucho" and last_name = "Williams";

#4d
Update actor
set first_name = "GROUCHO"
where first_name = "HARPO" and last_name = "Williams";

#5a
show create table address;

#6a
select first_name, last_name, address
from staff inner join address on staff.address_id= address.address_id;

#6b
select first_name, last_name, sum(payment.amount) AS "Total Payment"
from staff inner join payment on staff.staff_id = payment.staff_id
where left(payment_date, 7) = "2005-08"
group by staff.staff_id;

#6c
select title, count(film_actor.actor_id) AS "Count of Actors"
from film inner join film_actor on film.film_id = film_actor.film_id
group by film.title;

#6d
Select title, count(inventory_id) AS "Count of Inv. Copies"
from film inner join inventory on film.film_id = inventory.film_id
where film.title = "Hunchback Impossible"
group by film.title;

#6e
select customer.first_name, customer.last_name, sum(payment.amount) as "Total Paid"
from customer inner join payment on customer.customer_id = payment.customer_id
group by customer.first_name, customer.last_name
order by customer.last_name asc;

#7a
select film.title
from film
WHERE film_id IN
(
  SELECT film_id
  FROM language
  WHERE language_id = 1
)
and left(title,1) = "K" OR left(title,1) = "Q";

#7b
select first_name, last_name
from actor
where actor_id in
( select actor_id 
from film_actor
where film_id in
( select film_id
from film
where title = "Alone Trip"
)
);

#7c
select first_name, last_name, email
from customer
where address_id in
(select address_id
from address
where city_id in 
(select city_id
from city 
where country_id in
(select country_id
from country 
where country = "Canada"
)));

#7d
select title
from film
where film_id in
(select film_id
from film_category
where category_id in
(select category_id
from category
where name = "Family"
));

#7e
SELECT Film.title, Count(Rental.rental_id) AS "Total Rentals"
FROM (Film INNER JOIN Inventory ON Film.film_id = Inventory.film_id) INNER JOIN Rental ON Inventory.inventory_id = Rental.inventory_id
GROUP BY Film.title
ORDER by Count(Rental.rental_id) DESC;

#7f
SELECT store.store_id, sum(payment.amount) AS "Total Business"
from (store inner join customer on store.store_id = customer.store_id) INNER JOIN payment on customer.customer_id=payment.customer_id
group by store.store_id;

#7g
SELECT Store.store_id, City.city, Country.country
FROM ((Store INNER JOIN Address ON Store.address_id = Address.address_id) INNER JOIN City ON Address.city_id = City.city_id) INNER JOIN Country ON City.country_id = Country.country_id;

#7h
SELECT Category.name, Sum(Payment.amount) AS "Gross Revenue"
FROM (((Category INNER JOIN Film_category ON Category.category_id = Film_category.category_id) INNER JOIN Inventory ON Film_category.film_id = Inventory.film_id) INNER JOIN Rental ON Inventory.inventory_id = Rental.inventory_id) INNER JOIN Payment ON Rental.rental_id = Payment.rental_id
GROUP BY Category.name
ORDER BY Sum(Payment.amount) DESC
Limit 5;

#8a
CREATE VIEW qry_grossrevcategory AS SELECT Category.name, Sum(Payment.amount) AS "Gross Revenue"
FROM (((Category INNER JOIN Film_category ON Category.category_id = Film_category.category_id) INNER JOIN Inventory ON Film_category.film_id = Inventory.film_id) INNER JOIN Rental ON Inventory.inventory_id = Rental.inventory_id) INNER JOIN Payment ON Rental.rental_id = Payment.rental_id
GROUP BY Category.name
ORDER BY Sum(Payment.amount) DESC
Limit 5;

#8b ... wasn't sure what you were looking for, so i have another answer included for 8b
show create view qry_grossrevcategory;

#8b v2
select *
from qry_grossrevcategory;

#8c
drop view qry_grossrevcategory;


