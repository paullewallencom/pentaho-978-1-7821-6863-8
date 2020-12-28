-- ------------------------------
-- AGILE
-- ------------------------------
DROP TABLE
agile.fact_sale
;

CREATE TABLE 
agile.fact_sale
(
lens_name VARCHAR(100)
, lens_year SMALLINT
, lens_category VARCHAR(70)
, focal_length_min SMALLINT
, focal_length_max SMALLINT
, aperture_max DOUBLE
, aperture_min DOUBLE
, focusing_distance_min SMALLINT
, filter_size SMALLINT
, lens_id BIGINT
, sale_id BIGINT
, sale_date DATE
, customer_id BIGINT
, sales_channel VARCHAR(70)
, sales_channel_id INT
, sales DOUBLE
, customer_name VARCHAR(70)
, address VARCHAR(255)
, city VARCHAR(70)
)
;

-- ------------------------------
-- DMA
-- ------------------------------

DROP TABLE
dma.fact_sale
;


CREATE TABLE 
dma.fact_sale 
(
  date_tk INT
, sale_id BIGINT
, sales_channel VARCHAR(70)
, lens_tk BIGINT
, customer_tk BIGINT
, sales DOUBLE
)
;

DROP TABLE
dma.dim_customer
;

CREATE TABLE 
dma.dim_customer 
(
customer_tk BIGINT
, version BIGINT
, date_from TIMESTAMP
, date_to TIMESTAMP
, customer_id BIGINT
, customer_name VARCHAR(100)
, address VARCHAR(255)
, city VARCHAR(30)
)
;

-- two tables for dim lens: 1) to use with Insert/Update step 2) for Dim Lookup/Update step

DROP TABLE
dma.dim_lens_simple 
;

CREATE TABLE 
dma.dim_lens_simple 
(
lens_tk BIGINT PRIMARY KEY AUTO_INCREMENT
, lens_id BIGINT
, lens_name VARCHAR(100)
, lens_year SMALLINT
, lens_category_id INT
, lens_category VARCHAR(70)
, focal_length_min SMALLINT
, focal_length_max SMALLINT
, aperture_min DOUBLE
, aperture_max DOUBLE
, focusing_distance_min SMALLINT
, filter_size SMALLINT
)
;


DROP TABLE
dma.dim_lens 
;

CREATE TABLE 
dma.dim_lens 
(
lens_tk BIGINT -- PDI takes care of creating auto incremented tk
, version BIGINT -- special system column
, date_from TIMESTAMP -- special system column
, date_to TIMESTAMP -- special system column
, lens_id BIGINT
, lens_name VARCHAR(100)
, lens_year SMALLINT
, lens_category_id INT
, lens_category VARCHAR(70)
, focal_length_min SMALLINT
, focal_length_max SMALLINT
, aperture_min DOUBLE
, aperture_max DOUBLE
, focusing_distance_min SMALLINT
, filter_size SMALLINT
)
;
 

DROP TABLE
dma.dim_date
;

CREATE TABLE 
dma.dim_date 
(
date_tk INT
, the_date DATE
, the_year SMALLINT
, the_quarter TINYINT
, the_month TINYINT
, the_week TINYINT
, day_of_year SMALLINT
, day_of_month TINYINT
, day_of_week TINYINT
)
;
-- --------------------------
-- CHECKS
-- --------------------------

SELECT * FROM agile.fact_sale;
SELECT * FROM dma.dim_lens_simple;
SELECT * FROM dma.dim_lens;
SELECT * FROM dma.dim_customer;
SELECT * FROM dma.dim_date;
SELECT * FROM dma.fact_sale;

-- cross check of scd type 2 works
SELECT 
f.date_tk
, c.customer_name
, c.date_from
, c.date_to
, c.version
FROM 
dma.fact_sale f 
INNER JOIN 
dma.dim_customer c 
ON 
f.customer_tk = c.customer_tk
ORDER BY date_tk ASC
;
