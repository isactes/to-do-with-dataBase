-- Description: Show the category_name and description from the categories table sorted by category_name.
-- Solucioton:
SELECT
  category_name,
  description
FROM categories

-- Description: Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
-- Solucioton:
SELECT
  contact_name,
  address,
  city
FROM customers
where
  country not in ('Germany', 'Mexico', 'Spain')

-- Description: Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
-- Solucioton:  
select
  order_date,
  shipped_date,
  customer_id,
  freight
from orders
where order_date in ("2018-02-26")


-- Description: Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date
-- Solucioton:  
select
  employee_id,
  order_id,
  customer_id,
  required_date,
  shipped_date
from orders
where required_date < shipped_date


-- Description: Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name
-- Solucioton:  
select
  city,
  company_name,
  contact_name
from customers
where city like '%L%'
order by contact_name

-- Description: Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
-- Solucioton:  
select
  company_name,
  contact_name,
  fax
from customers
where fax is not null


-- Description: Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
-- Solucioton:
select
  first_name,
  last_name,
  MAX(hire_date)
from employees
