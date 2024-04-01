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


-- Description: 
-- Solucioton: