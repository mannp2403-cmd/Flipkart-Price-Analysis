create database flipkart;

use flipkart;

create table flip
(
uniq_id	 text(200),
crawl_timestamp	datetime, 
product_url	text(200),
product_name	text(200),
product_category_tree	text(200),
pid text(200),
retail_price	float,
discounted_price	float,
image	text(200),
is_FK_Advantage_product text(200),	
descriptionn text(200),
product_rating	float,
overall_rating	float,
brand	text(200),
product_specifications	text(200),
discount_amount	float,
discount_percentage	float,
primary_category   text(200)
);

show tables;

select * from flip;

drop table flip;

#top 5 most expensive category
SELECT 
    primary_category, 
    ROUND(AVG(retail_price), 2) AS average_retail_price,
    COUNT(*) AS total_products
FROM flip
WHERE retail_price IS NOT NULL 
AND retail_price > 0
AND primary_category IS NOT NULL
GROUP BY primary_category
HAVING total_products >= 5
ORDER BY average_retail_price DESC
LIMIT 5; 

#top 5 most highly rated brands
SELECT 
    brand, 
    ROUND(AVG(overall_rating), 2) AS average_rating,
    COUNT(*) AS total_products
FROM 
    flip
WHERE 
    brand IS NOT NULL 
    AND brand != ''
    AND overall_rating IS NOT NULL
GROUP BY 
    brand
HAVING 
    total_products >= 5  
ORDER BY 
    average_rating DESC, 
    total_products DESC
LIMIT 5;


#top 5 category giving dis
SELECT 
    primary_category, 
    ROUND(AVG(discount_percentage), 2) AS avg_discount_percent,
    ROUND(AVG(discount_amount), 2) AS avg_cash_saved,
    COUNT(*) AS total_products
FROM 
    flip
WHERE 
    primary_category IS NOT NULL 
    AND discount_percentage IS NOT NULL
    AND discount_percentage > 0
GROUP BY 
    primary_category
HAVING 
    total_products >= 10 -- Ensuring a solid sample size
ORDER BY 
    avg_discount_percent DESC
LIMIT 5;


SELECT 
    is_FK_Advantage_product,
    COUNT(*) AS total_products,
    ROUND(AVG(overall_rating), 2) AS avg_rating,
    ROUND(AVG(discount_percentage), 2) AS avg_discount_percent
FROM 
    flip
WHERE 
    is_FK_Advantage_product IS NOT NULL 
    AND is_FK_Advantage_product != ''
GROUP BY 
    is_FK_Advantage_product;
