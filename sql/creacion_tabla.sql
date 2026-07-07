CREATE TABLE ventas_raw (
	row_id INT,
	order_id VARCHAR(20),
	order_date DATE,
	ship_date DATE,
	ship_mode VARCHAR(20),
	customer_id VARCHAR(15),
	customer_name VARCHAR(100),
	segment VARCHAR(20),
	country VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	postal_code VARCHAR(10),
	region VARCHAR(20),
	product_id VARCHAR(20),
	category VARCHAR(30),
	sub_category VARCHAR(30),
	product_name VARCHAR(200),
	sales NUMERIC(10,4),
	quantity INT,
	discount NUMERIC(4,2),
	profit NUMERIC(10,4)
);

SET datestyle = 'ISO, MDY';
ALTER DATABASE retail_db SET datestyle TO 'ISO, MDY';

SELECT COUNT(*) FROM ventas_raw;
SELECT * FROM ventas_raw LIMIT 10;
