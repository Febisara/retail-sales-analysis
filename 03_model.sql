-- Rerun safely inside this dedicated learning database.
-- Source rows are never deleted by this script.
BEGIN;
CREATE OR REPLACE VIEW valid_sales AS
SELECT * FROM retail_raw
WHERE invoice_no IS NOT NULL
  AND invoice_date IS NOT NULL
  AND stock_code IS NOT NULL
  AND quantity > 0 AND unit_price > 0
  AND invoice_no NOT ILIKE 'C%';

CREATE TABLE IF NOT EXISTS customers (
 customer_id TEXT PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS invoices (
 invoice_no TEXT PRIMARY KEY,
 invoice_date TIMESTAMP NOT NULL,
 customer_id TEXT REFERENCES customers(customer_id),
 country TEXT
);
CREATE TABLE IF NOT EXISTS sales_lines (
 source_row INTEGER PRIMARY KEY,
 invoice_no TEXT NOT NULL REFERENCES invoices(invoice_no),
 stock_code TEXT NOT NULL,
 description TEXT,
 quantity INTEGER NOT NULL CHECK(quantity > 0),
 unit_price NUMERIC(14,4) NOT NULL CHECK(unit_price > 0),
 line_value NUMERIC(20,4) NOT NULL
);
TRUNCATE sales_lines, invoices, customers;
INSERT INTO customers
SELECT DISTINCT customer_id FROM valid_sales
WHERE customer_id IS NOT NULL;

-- Some source invoice timestamps vary within one invoice.
-- Use its earliest line timestamp as the invoice timestamp.
INSERT INTO invoices
SELECT invoice_no, min(invoice_date), min(customer_id), min(country)
FROM valid_sales GROUP BY invoice_no;

INSERT INTO sales_lines
SELECT source_row, invoice_no, stock_code, description,
 quantity, unit_price, quantity * unit_price
FROM valid_sales;
CREATE INDEX IF NOT EXISTS sales_lines_invoice_idx
 ON sales_lines(invoice_no);
CREATE INDEX IF NOT EXISTS invoices_customer_idx
 ON invoices(customer_id);

CREATE OR REPLACE VIEW invoice_totals AS
SELECT i.invoice_no, i.invoice_date, i.customer_id, i.country,
 sum(l.line_value) AS invoice_value
FROM invoices i JOIN sales_lines l USING(invoice_no)
GROUP BY i.invoice_no, i.invoice_date, i.customer_id, i.country;
COMMIT;
