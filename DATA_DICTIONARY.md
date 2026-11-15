# Data dictionary

## Grain and relationships

One raw row is an invoice line, not an invoice. One identified customer can have many invoices, and one invoice can have many sales lines. Invoice numbers plus stock codes are not assumed to identify source lines uniquely.

## Raw fields

| Source / SQL field | SQL type | Meaning |
|---|---|---|
| Added / source_row | INTEGER, primary key | Excel row number, starting at 2 after the header; traces lines back to the source |
| InvoiceNo / invoice_no | TEXT | Invoice identifier; a leading C indicates cancellation |
| StockCode / stock_code | TEXT | Item or charge code; preserve as an identifier |
| Description / description | TEXT | Source description; may vary for a stock code |
| Quantity / quantity | INTEGER | Recorded quantity; may be zero or negative in raw data |
| InvoiceDate / invoice_date | TIMESTAMP | Source date/time; no timezone is inferred |
| UnitPrice / unit_price | NUMERIC(14,4) | Price per unit in GBP |
| CustomerID / customer_id | TEXT | Customer identifier; NULL means unknown |
| Country / country | TEXT | Recorded country; not a claim about nationality |

## Reporting objects

| Object | Grain and definition |
|---|---|
| retail_raw | Every imported source line |
| valid_sales | Source lines with invoice number, date and stock code, positive quantity and price, and no cancellation prefix |
| customers | One row per identified customer in valid_sales |
| invoices | One row per eligible invoice, using the earliest included timestamp and the known customer/country after conflict checks |
| sales_lines | One row per eligible source_row, linked to invoices |
| invoice_totals | One row per invoice with the sum of its eligible line values |

## Metrics

| Metric | Definition |
|---|---|
| line_value | Quantity × unit price, stored as NUMERIC(20,4) |
| invoice_value | Sum of eligible line values for an invoice |
| gross_positive_sales_gbp | Sum of invoice values; not net revenue or profit |
| average_invoice_gbp | Mean of invoice values, not mean of line values |
| identified_customers | Distinct non-NULL customer identifiers in eligible invoices |
| repeat_customers | Identified customers with at least two eligible invoices in the observation window |
| repeat_customer_pct | 100 × repeat_customers / identified_customers |
| change_pct | 100 × (current monthly sales − previous monthly sales) / previous monthly sales; NULL when no prior comparison or zero denominator |
| sales_rank | DENSE_RANK by unrounded customer sales, descending; ties share ranks |
| units | Sum of positive quantities by stock code; interpretation depends on the code |

## Scope rules

Retain anonymous eligible invoices in sales totals, but exclude them from identified-customer metrics. Retain duplicate-looking lines in the baseline. Monthly growth uses December 2010–November 2011 only. Other reports include the partial December 2011 period. Round totals for display, rather than rounding each line prematurely.
