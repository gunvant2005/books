drop table if exists CUSTOMERS;

create table books(
book_id serial primary key,
title varchar(100),
author varchar(100),
gener varchar(100),
 published_year int,
price numeric (10,2),
stock int
);


create table customers(
customer_id SERIAL PRIMARY KEY ,
name varchar(100),
email varchar(50),
phone vARCHAR (15),
CITY VARCHAR(150),
COUNTRY VARCHAR(100)
);

create table orders(
order_id SERIAL PRIMARY KEY,
customer_id  INT REFERENCES CUSTOMERS(CUSTOMER_ID),
book_id INT REFERENCES BOOKS(BOOK_ID),
order_date DATE ,
quantity INT,
total_amount NUMERIC (10,2)
);

SELECT *FROM BOOKS;
SELECT *FROM CUSTOMERS;
SELECT *FROM ORDERS;

SELECT * FROM BOOKS WHERE gener ='Fiction';

SELECT * FROM BOOKS WHERE published_year > 1950;

select *from customers where country like 'Canada';

select *from orders where order_date between '2023-11-01'and '2023-11-30';

select sum (stock) as total_stock from books ;
select  max (price) from books;
select *from orders where quantity > 1;

select *from orders where total_amount > 20;
select distinct gener from books; 
select * from books order by stock asc ;
select sum(total_amount) as total_revenue from orders 


select  b.gener,sum(o.quantity)
from books b
join orders o 
on o.book_id = b.book_id
group by b.gener;

select  avg(price) from books where gener = 'Fantasy';

select customer_id,count(order_id) from orders group by customer_id
having count(order_id) >= 2;

select b.title ,o.book_id,count(o.order_id) as order_count  
from orders o
join books b
on o.book_id = b.book_id
group by b.title,o.book_id order by order_count desc;

select title,gener,price 
from books  
where gener = 'Fantasy' 
order by price desc limit 3 ; 

select b.author ,sum(o.quantity) from books b
join orders o
on b.book_id = o.book_id
group by b.author ;

select distinct c.city ,o.total_amount from customers c
join orders o
on c.customer_id  = o.customer_id 
where o.total_amount > 30;

select  o.customer_id,c.name ,sum(o.total_amount) as total_spant from orders o
join customers c 
on o.customer_id = c.customer_id
group by  c.name,o.customer_id order by total_spant  desc limit 1;

select b.book_id,b.title,b.stock,coalesce(sum (o.quantity),0) AS order_quantity,
b.stock-coalesce(sum (o.quantity),0) AS remaining_stock
from books b
left join orders o 
on b.book_id = o.book_id
group by b.book_id;


