-- Each result describes the raw source; flags can overlap.
SELECT count(*) AS raw_rows,
 count(*) FILTER (WHERE customer_id IS NULL) AS missing_customer,
 count(*) FILTER (WHERE quantity <= 0) AS nonpositive_quantity,
 count(*) FILTER (WHERE unit_price <= 0) AS nonpositive_price,
 count(*) FILTER (WHERE invoice_no ILIKE 'C%') AS cancellation_rows,
 min(invoice_date) AS earliest, max(invoice_date) AS latest
FROM retail_raw;

-- Must return no rows before building the invoice model.
SELECT invoice_no
FROM retail_raw
WHERE invoice_no IS NOT NULL
GROUP BY invoice_no
HAVING count(DISTINCT customer_id) > 1
    OR count(DISTINCT country) > 1;

-- Duplicate-looking source lines are flagged, not silently removed.
SELECT sum(copies - 1) AS additional_identical_rows
FROM (
 SELECT count(*) AS copies
 FROM retail_raw
 GROUP BY invoice_no, stock_code, description, quantity,
          invoice_date, unit_price, customer_id, country
 HAVING count(*) > 1
) d;

-- Diagnostic only: timestamps can vary within an invoice.
SELECT count(*) AS invoices_with_multiple_timestamps FROM (
 SELECT invoice_no FROM retail_raw GROUP BY invoice_no
 HAVING count(DISTINCT invoice_date) > 1
) d;
