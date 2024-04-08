-- Description: Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table 
-- Solucioton:

SELECT
  products.product_name as name_product,
  suppliers.company_name as name_company,
  categories.category_name as name_category
FROM 
  products
JOIN 
  suppliers ON products.supplier_id = suppliers.supplier_id
JOIN 
  categories ON products.category_id = categories.category_id;


-- Description: Show the category_name and the average product unit price for each category rounded to 2 decimal places.
-- Solucioton: 
SELECT
  categories.category_name AS category_name,
  ROUND(AVG(products.unit_price), 2) AS average_unit_price
FROM categories
JOIN products ON products.category_id = categories.category_id
GROUP BY categories.category_name;


-- Description: Show the city, company_name, contact_name from the customers and suppliers table merged together. Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
-- Solucioton:
SELECT
  city,
  company_name,
  contact_name,
  'customers' AS source_table
FROM customers
UNION
SELECT
  city,
  company_name,
  contact_name,
  'suppliers' AS source_table
FROM suppliers;

-- Description: 
-- Solucioton:
-- Description: 
-- Solucioton:
-- Description: 
-- Solucioton: