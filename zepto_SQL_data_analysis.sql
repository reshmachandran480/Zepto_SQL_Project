-- Drop the table if it already exists
DROP TABLE IF EXISTS zepto;

-- Create a Table zepto 
CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INT,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

-- ------------------------------------------------------------
-- DATA EXPLORATION
-- ------------------------------------------------------------
-- count of rows
SELECT COUNT(*) FROM zepto;

-- sample data
SELECT * FROM zepto
LIMIT 10;

--  null values
SELECT* FROM zepto
WHERE category IS NULL
OR name IS NULL
OR mrp IS NULL
OR discountPercent IS NULL
OR availableQuantity IS NULL	
OR discountedSellingPrice IS NULL	
OR weightInGms IS NULL	
OR outOfStock IS NULL	
OR quantity IS NULL;

-- explore all the product categories available in the data
SELECT DISTINCT category 
FROM zepto
ORDER BY category;

-- check products in stock / out of stock
SELECT outofstock, COUNT(sku_id) FROM ZEPTO
GROUP BY outofstock;

-- product names present multipal times
SELECT name, COUNT(sku_id) as "number of SKUs" FROM zepto
GROUP BY name
HAVING COUNT(sku_id) >1 
ORDER BY count(sku_id) DESC;

-- ------------------------------------------------------------
-- DATA CLEANING
-- ------------------------------------------------------------
-- check for products  where the price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedsellingprice = 0; -- WE WILL NEED TO DELETE THIS ROW

-- delete the row where price = 0
DELETE FROM zepto
WHERE mrp = 0;

-- convert mrp from pasie to rupeese
 UPDATE zepto
 SET mrp = mrp/100.0,
 discountedsellingprice = discountedsellingprice/100.0;

-- ------------------------------------------------------------
 -- BUSINESS INSIGHTS
 -- ------------------------------------------------------------

-- 1Q. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountpercent FROM zepto
ORDER BY discountpercent DESC
LIMIT 10;

-- 2Q. What are the products with high MRP but out of stock 
SELECT DISTINCT name, mrp,outofstock
FROM zepto
WHERE outofstock = 'true' and mrp>300
ORDER BY mrp DESC;

-- 3Q. Calculate Estimated Revenue for each category
SELECT category, 
SUM(discountedsellingprice * quantity) AS total_revenue  
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- 4Q. Find all products where MRP is greater than 500 and discount is less than 10%
SELECT DISTINCT name, mrp, discountpercent FROM zepto
WHERE mrp > 500 AND discountpercent < 10.00
ORDER BY mrp DESC, discountpercent DESC;

-- 5Q. Identify the top 5 categories offering the highest average discount percentage.
SELECT category, 
ROUND(AVG(discountpercent),2) AS average_discount 
FROM zepto
GROUP BY category
ORDER BY average_discount DESC
LIMIT 5;

-- 6Q. Find the price per gram for products above 100g and sort by best value. 
SELECT DISTINCT name, 
discountedsellingprice, 
ROUND(discountedsellingprice/weightingms, 2) AS price_per_gm
FROM zepto
WHERE weightingms >=100 
ORDER BY price_per_gm;

-- 7Q.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightingms,
CASE WHEN weightingms < 1000 THEN 'Low'
     WHEN weightingms < 5000 THEN  'Medium'
	 ELSE 'Bulk'
	 END AS weight_category
FROM zepto;	 

-- Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;
