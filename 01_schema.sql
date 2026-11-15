CREATE TABLE IF NOT EXISTS retail_raw (
 source_row INTEGER PRIMARY KEY,
 invoice_no TEXT,
 stock_code TEXT,
 description TEXT,
 quantity INTEGER,
 invoice_date TIMESTAMP,
 unit_price NUMERIC(14,4),
 customer_id TEXT,
 country TEXT
);
