-- All values in the first two result sets must be zero.
SELECT count(*) AS orphan_lines
FROM sales_lines l LEFT JOIN invoices i USING(invoice_no)
WHERE i.invoice_no IS NULL;

SELECT
 (SELECT sum(line_value) FROM sales_lines) -
 (SELECT sum(invoice_value) FROM invoice_totals)
 AS reconciliation_difference;

-- Classifications sum to the source total; do not add overlapping flags.
SELECT count(*) AS raw_rows,
 count(*) FILTER (WHERE invoice_no IS NOT NULL
  AND invoice_date IS NOT NULL AND stock_code IS NOT NULL
  AND quantity > 0 AND unit_price > 0
  AND invoice_no NOT ILIKE 'C%') AS included_rows,
 count(*) - (SELECT count(*) FROM valid_sales) AS excluded_rows
FROM retail_raw;

-- Show how many included invoices have no identified customer.
SELECT count(*) AS anonymous_invoices,
 round(sum(invoice_value),2) AS anonymous_sales_gbp
FROM invoice_totals WHERE customer_id IS NULL;
