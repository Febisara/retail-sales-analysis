-- Q1 Total positive sales and order value.
SELECT count(*) AS invoices,
 round(sum(invoice_value),2) AS gross_positive_sales_gbp,
 round(avg(invoice_value),2) AS average_invoice_gbp,
 count(DISTINCT customer_id) AS identified_customers
FROM invoice_totals;

-- Q2 Month-on-month change for complete months only.
WITH monthly AS (
 SELECT date_trunc('month',invoice_date)::date AS month,
 sum(invoice_value) AS sales
 FROM invoice_totals
 WHERE invoice_date >= DATE '2010-12-01'
   AND invoice_date < DATE '2011-12-01'
 GROUP BY 1
), changes AS (
 SELECT *, lag(sales) OVER (ORDER BY month) AS previous_sales
 FROM monthly
)
SELECT month, round(sales,2) AS sales_gbp,
 round(100*(sales-previous_sales)/nullif(previous_sales,0),2)
 AS change_pct
FROM changes ORDER BY month;

-- Q3 Sales by country. No claim about profit or customer nationality.
SELECT country, count(*) AS invoices,
 round(sum(invoice_value),2) AS sales_gbp
FROM invoice_totals GROUP BY country ORDER BY sales_gbp DESC;

-- Q4 Repeat purchasing in the observed data, not a retention cohort.
WITH frequency AS (
 SELECT customer_id, count(*) AS invoices
 FROM invoice_totals WHERE customer_id IS NOT NULL
 GROUP BY customer_id
)
SELECT count(*) AS identified_customers,
 count(*) FILTER (WHERE invoices >= 2) AS repeat_customers,
 round(100.0*count(*) FILTER (WHERE invoices >= 2)/
       nullif(count(*),0),2) AS repeat_customer_pct
FROM frequency;

-- Q5 Top product codes by positive sales; description may vary.
SELECT stock_code, sum(quantity) AS units,
 round(sum(line_value),2) AS sales_gbp
FROM sales_lines GROUP BY stock_code
ORDER BY sales_gbp DESC LIMIT 10;

-- Q6 Rank identified customers by positive sales.
WITH customer_value AS (
 SELECT customer_id, count(*) AS invoices,
 sum(invoice_value) AS sales
 FROM invoice_totals WHERE customer_id IS NOT NULL
 GROUP BY customer_id
)
SELECT customer_id, invoices, round(sales,2) AS sales_gbp,
 dense_rank() OVER (ORDER BY sales DESC) AS sales_rank
FROM customer_value ORDER BY sales_rank,customer_id LIMIT 10;
