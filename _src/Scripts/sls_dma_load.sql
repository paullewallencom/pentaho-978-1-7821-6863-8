-- --------------------------
-- AGILE INPUT
-- --------------------------

SELECT 
s.sale_id
, s.date
, s.customer_id
, s.lens_id
, s.sales_channel_id
, s.amount
, sc.sales_channel
, l.name
, l.year
, lc.lens_category
, l.focal_length_min
, l.focal_length_max
, l.aperture_max
, l.aperture_min
, l.focusing_distance_min
, l.filter_size
, c.name
, c.address
, c.city
FROM 
sls_raw.sale s
LEFT JOIN
sls_raw.sales_channel sc
ON
sc.sales_channel_id = s.sales_channel_id
LEFT JOIN
sls_raw.lens l
ON
s.lens_id = l.lens_id
LEFT JOIN
sls_raw.lens_category lc
ON
l.lens_category_id = lc.lens_category_id
LEFT JOIN
sls_raw.customer c
ON
s.customer_id = c.customer_id
;



-- --------------------------
-- DMA INPUT
-- --------------------------

SELECT
l.lens_id
, l.name AS lens_name
, l.year AS lens_year
, l.lens_category_id
, lc.lens_category
, l.focal_length_min
, l.focal_length_max
, l.aperture_max
, l.aperture_min
, l.focusing_distance_min
, l.filter_size
FROM
sls_raw.lens l
LEFT JOIN
sls_raw.lens_category lc
ON
l.lens_category_id = lc.lens_category_id
;

SELECT
customer_id
, name AS customer_name
, address
, city
, last_updated
FROM 
sls_raw.customer
;

SELECT 
s.sale_id
, s.date AS sale_date
, s.customer_id
, s.lens_id
, s.amount AS sales
, sc.sales_channel
FROM 
sls_raw.sale s
LEFT JOIN
sls_raw.sales_channel sc
ON
sc.sales_channel_id = s.sales_channel_id
ORDER BY sale_date ASC
;

