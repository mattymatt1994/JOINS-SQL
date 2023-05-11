/* joins: select all the computers from the products table:

using the products table and the categories table, return the product name and the category name */
USE BestBuy;
SELECT products.Name AS 'Products', categories.Name as 'Category'
FROM products
inner JOIN categories ON products.CategoryID = categories.CategoryID
WHERE categories.name LIKE '%computers%';
/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
select name, price, rating
FROM products
inner join reviews ON products.ProductID = reviews.ProductID
where rating = 5;
-- What if the prompt asked what has the highest rating?
select max(distinct Rating)  
FROM reviews;
-- you could replace the 5 in the previous prompt with this query!
/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
-- SELECT e.FirstName AS Employee, SUM(s.Quantity) AS total FROM employees AS e 
-- inner JOIN sales AS s ON e.EmployeeID = s.EmployeeID group by e.EmployeeID 
-- ORDER BY total desc LIMIT 5;
select employees.EmployeeID,concat( FirstName,' ' , LastName) as 'Name', sum(Quantity) as 'Total Sales'
FROM employees
inner join sales ON employees.EmployeeID = sales.EmployeeID
group by employees.EmployeeID
order by sum(Quantity) DESC limit 5;
/* joins: find the name of the department, and the name of the category for Appliances and Games */
-- SELECT d.name AS Department, c.Name AS Category FROM categories AS c
-- INNER JOIN departments AS d ON d.DepartmentID = c.DepartmentID
-- WHERE c.Name = 'Appliances' OR c.Name LIKE 'Games';
select departments.Name, categories.name
FROM departments
left join categories ON departments.DepartmentID = categories.DepartmentID
where categories.name like '%Appliances%' or categories.name LIKE '%Games%';
/* joins: find the product name, total # sold, and total price sold,

 for Eagles: Hotel California --You may need to use SUM() */
-- SELECT p.name, SUM(s.Quantity) AS Quantity_sold, 
-- SUM(s.PricePerUnit * s.Quantity) AS total_price_sold 
-- FROM products as p inner JOIN sales as s 
-- ON p.ProductID=s.ProductID WHERE p.ProductID=97; 
select Name, sum(Quantity), sum(PricePerUnit * Quantity)
FROM products
left join sales ON products.ProductID = sales.ProductID
where Name Like '%Hotel%California%'
group by products.ProductID;
/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT name, Reviewer, Rating, Comment
FROM reviews
left join products ON products.ProductID = reviews.ProductID
where Name like '%Visio%' and Rating = (select min(distinct Rating)FROM reviews);
-- ------------------------------------------ Extra - May be difficult

/* Your goal is to write a query that serves as an employee sales report.

This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
select employees.EmployeeID,concat( FirstName, ' ', LastName) as 'Full Name', Name as 'Product', Quantity
FROM employees
inner join sales on employees.EmployeeID = sales.EmployeeID
left join products on sales.ProductID = products.ProductID
order by employees.EmployeeID, Product;