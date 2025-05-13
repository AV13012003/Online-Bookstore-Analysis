use OnlineBookstore;

DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Emali VARCHAR(100),
    phone VARCHAR(12),
    city VARCHAR (50), 
    Country VARCHAR(100)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    orders_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customer(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_date date,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Customer;
SELECT * FROM orders;


-- 1) Retrieve all books in the "Fiction" genre:
      select * from books
      where Genre = 'Fiction';
      


-- 2) Find books published after the year 1950:
      select * from books
      where Published_year>1950;
      
      

-- 3) List all customers from the Canada:
      select * from customers
      where city="canada";
      
      
      

-- 4) Show orders placed in November 2023:
select * from orders
where Order_Date between '2023-11-01' and '2023-11-30';



-- 5) Retrieve the total stock of books available:
select sum(stock) as total_stock
from books;




-- 6) Find the details of the most expensive book:
select * from books
order by price desc
limit 5;



-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where Quantity>1;




-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders
where Total_Amount>20;



-- 9) List all genres available in the Books table:
select distinct genre from books;



-- 10) Find the book with the lowest stock:
select * from books
order by Stock asc
limit 5;


-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as revenue
from orders;




-- Advance Questions : 




-- 1) Retrieve the total number of books sold for each genre:
select b.genre, sum(o.quantity) as total_book_sold
from orders o
join books b on o.Book_ID = b.Book_ID
group by b.genre;





-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as average_price
from books
where genre = 'fantasy';





-- 3) List customers who have placed at least 2 orders:
select o.customer_ID, c.name, count(order_ID) as order_count
from orders o
join customer c on o.Customer_ID = c.Customer_ID 
group by o.Customer_ID, c.name
having  count(order_ID)>=2;






-- 4) Find the most frequently ordered book:
select o.book_id,b.title, count(order_id) as order_count
from orders o
join books b on o.Book_ID=b.Book_ID
group by o.Book_ID, b.title
order by Order_count desc
limit 6;





-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre='fantasy'
order by price desc
limit 2;




-- 6) Retrieve the total quantity of books sold by each author:

select b.author, sum(o.quantity) as total_book_quantity
from orders o
join books b on o.Book_ID = b.Book_ID
group by b.Author;


-- 7) List the cities where customers who spent over $30 are located:
select  distinct c.city, Total_Amount
from orders o
join customer c on o.Customer_ID = c.Customer_ID
where o.Total_Amount > 30;



-- 8) Find the customer who spent the most on orders:

SELECT  c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customer c ON o.Customer_ID = c.customer_id
GROUP BY c.Customer_ID, c.name
ORDER BY total_spent DESC
LIMIT 1;








