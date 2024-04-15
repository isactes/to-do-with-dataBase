-- Description: Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late.Order by employee last_name, then by first_name, and then descending by number of orders.  
-- Solucioton:




--My solution 
SELECT
  employees.first_name,
  employees.last_name,
  sum(orders.order_id) AS num_orders,
  (
  	case
    	when orders.shipped_date <= orders.required_date then 'On Time'
    	else 'Late'
    end
  ) as shipped
FROM employees
JOIN orders ON orders.employee_id = employees.employee_id
GROUP BY
  employees.employee_id,
  employees.first_name,
  employees.last_name
ORDER BY
  employees.last_name,
  employees.first_name,
  num_orders DESC;





-- Description: 
-- Solucioton:
-- Description: 
-- Solucioton: