--create table book--
CREATE TABLE books(
				Book_ID SERIAL PRIMARY KEY,	
				Title VARCHAR(100) NOT NULL,
				Author VARCHAR(50), 
				Genre VARCHAR(50),	
				Published_Year INT,
				Price NUMERIC(10,2),
				Stock INT
);

SELECT * from books;
drop table if exists books;


--create table customers--
CREATE TABLE customers(
		Customer_ID	INT,
		Name VARCHAR(100) NOT NULL,
		Email VARCHAR(100),
		Phone VARCHAR(15),
		City VARCHAR(100),
		Country VARCHAR(100)

);

SELECT * from customers;
drop table if exists customers;


---create table orders---
CREATE TABLE orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES customers(Customer_ID),
	Book_ID INT	REFERENCES books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

SELECT * from orders;

--alter
 ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

--1) Retrieve All Books In The "Fiction" genre:
select * from books
where Genre='Fiction';

--2)Find books published after the year 1950:
select * from books
where Published_Year>1950;

--3)List all the customers from Canada:
select * from customers
where Country='Canada';

--4)Show order placed in November:
select * from orders
where order_date between '2023-11-01' AND '2023-11-30';

--5)Retrieve the total stock of books available:
select sum(Stock) AS Total_Stock
from books;

--6)Find the details of most expensive books:
Select *from books order by price DESC;


--7)Show all customers who ordered more than 1 quantity of a book:
select * from orders
where quantity>1;

--8)retrieve all orders where the total amount exceeds $20:
select * from orders
where total_amount>20;

--9)List all genres available in the books table:
select Distinct genre From books;

---10) Find the book with the lowest stock:
select * from books
order by stock
limit 1;

--11)calculate the total revenue generated from all orders:
select sum(total_amount)as revenue
from orders;

--Advanced Questions :

--1)Retrive the total number of books sold for each genre:
 select * from orders;

 select b.Genre, o.Quantity
 from orders o
 join books b on o.book_id= b.book_id;

 --2)Find the average price of books in the "Fantasy" Genre:
 select AVG(price) as average_price
 from books
 where genre='Fantasy';

--3)List customers who have placed at least 2 orders:
select customer_id, count(order_id)as order_count
from orders
group by customer_id
having count(order_id)>=2;

--4)Find the most frequently ordered book:
select o.Book_id,b.title,count(o.order_id)as order_count
from orders o
join books b on o.book_id=b.book_id
group by o.Book_id,b.title
order by order_count desc limit 1;

--5)Show the top 3 most expensive books of fantasy genre:
select * from books
where genre = 'Fantasy'
order by price desc limit 3;

--6)Retrieve the total quantity of books sold by each author:
select b.author, sum(o.quantity)as total_books_sold
from orders o
join books b on o.book_id=b.book_id
group by b.author;

--7)List the cities where customers who spent over $30 are located:
select distinct c.city
from orders o
join customers c on o.customer_id=c.customer_id
where o.total_amount > 30;

--8)Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount)as total_spent
from orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_id,c.name
order by total_spent desc;

--9)Calculate the stock remaining after fulfilling all orders:
select b.book_id,b.title, b.stock, COALESCE(sum(quantity),0)as order_quantity
from books b
left join orders o on b.book_id=o.book_id
group by b.book_id;
