CREATE DATABASE blinkit_analysis;
USE blinkit_analysis;
SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM blinkit_customers),2) AS percentage
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;
SELECT
    customer_segment,
    ROUND(AVG(avg_order_value),2) AS average_order_value
FROM blinkit_analysis.blinkit_customers
GROUP BY customer_segment
ORDER BY average_order_value DESC;
SELECT
    customer_segment,
    SUM(total_orders) AS total_orders
FROM blinkit_analysis.blinkit_customers
GROUP BY customer_segment
ORDER BY total_orders DESC;
SELECT
    customer_id,
    customer_name,
    customer_segment,
    total_orders,
    avg_order_value,
    ROUND(total_orders * avg_order_value,2) AS estimated_customer_value
FROM blinkit_analysis.blinkit_customers
ORDER BY estimated_customer_value DESC
LIMIT 10;
SELECT
    DATE_FORMAT(registration_date,'%Y-%m') AS registration_month,
    COUNT(*) AS new_customers
FROM blinkit_analysis.blinkit_customers
GROUP BY registration_month
ORDER BY registration_month;
SELECT
    area,
    COUNT(*) AS total_customers
FROM blinkit_analysis.blinkit_customers
GROUP BY area
ORDER BY total_customers DESC;
SELECT
    customer_segment,
    ROUND(
        AVG(total_orders * avg_order_value),
        2
    ) AS estimated_customer_value
FROM blinkit_analysis.blinkit_customers
GROUP BY customer_segment
ORDER BY estimated_customer_value DESC;
SELECT
    area,
    ROUND(AVG(avg_order_value),2) AS average_order_value
FROM blinkit_analysis.blinkit_customers
GROUP BY area
ORDER BY average_order_value DESC
LIMIT 5;
SELECT
    customer_segment,
    ROUND(AVG(total_orders * avg_order_value),2) AS estimated_customer_value,
    RANK() OVER(
        ORDER BY AVG(total_orders * avg_order_value) DESC
    ) AS segment_rank
FROM blinkit_analysis.blinkit_customers
GROUP BY customer_segment;
SELECT
    customer_name,
    total_orders,
    avg_order_value,
    ROUND(total_orders * avg_order_value,2) AS estimated_customer_value,

    CASE
        WHEN total_orders * avg_order_value >= 5000 THEN 'High Value'
        WHEN total_orders * avg_order_value >= 2500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_category

FROM blinkit_analysis.blinkit_customers
ORDER BY estimated_customer_value DESC;