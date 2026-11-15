# Data quality and validation

## Raw source profile

| Check | Observed result |
|---|---:|
| Raw source lines | 541,909 |
| Missing customer identifiers | 135,080 |
| Nonpositive quantities | 10,624 |
| Nonpositive prices | 2,517 |
| Cancellation-prefix lines | 9,288 |
| Additional identical-looking lines | 5,268 |
| Invoices with multiple timestamps | 43 |
| Conflicting known customer or country per invoice | 0 |

The source covers 1 December 2010–9 December 2011. Quality flags overlap and must not be added to calculate excluded rows. The actual workbook contains missing customer IDs despite the publisher's general metadata stating otherwise.

The raw workbook SHA-256 matches outputs/conversion_audit.json. The submitted CSV matches the workbook after expected timestamp parsing, adding source_row and treating descriptions as text. One numeric-valued source description becomes text in CSV; this does not change sales calculations.

## Inclusion and reconciliation

| Check | Observed result | Evidence |
|---|---:|---|
| Included positive-sales lines | 530,104 | outputs/check_row_counts.csv |
| Excluded lines | 11,805 | outputs/check_row_counts.csv |
| Included + excluded | 541,909 | Reconciles to raw count |
| Orphan sales lines | 0 | outputs/check_orphan_lines.csv |
| Line minus invoice total | £0.00 | outputs/check_reconciliation.csv |
| Eligible invoices | 19,960 | outputs/sales_summary.csv |
| Gross positive sales | £10,666,684.54 | outputs/sales_summary.csv |
| Average invoice value | £534.40 | outputs/sales_summary.csv |
| Anonymous eligible invoices | 1,428 | outputs/check_anonymous_sales.csv |
| Anonymous positive sales | £1,755,276.64 | outputs/check_anonymous_sales.csv |

## Manual check and repeatability

Invoice 536365 has seven eligible lines. Each saved manual line calculation equals quantity × unit price and the saved SQL line_value. The total is £139.12, matching outputs/manual_invoice_total.csv.

Evidence is stored in manual_invoice_lines.csv, manual_invoice_check.csv and manual_invoice_total.csv under outputs. The manual check is a CSV of values; spreadsheet formulas are not preserved.

The project author reported rerunning the model with unchanged summary totals and zero reconciliation difference. Separate before-and-after exports were not included.

## Review performed on 15 November 2026

An AI-assisted review independently compared the source workbook and converted CSV, recomputed the conversion audit, and recalculated all six saved business reports from source data. Monetary checks used exact scaled integer arithmetic and decimal rounding.

All six reports and the four saved validation exports matched the independently recomputed values. The monthly and country PNGs were visually inspected against the CSV results. Their values and labels agree with the results; the monthly line chart has a nonzero vertical minimum. Editable chart workbooks were not supplied, and chart authorship or creation method was not verified.

The leading stock code DOT was inspected in the source and has description DOTCOM POSTAGE. This was a review check, not a separate SQL investigation performed by the project author.

## Boundaries of verification

- PostgreSQL was not available in the review environment. SQL was inspected, but the Windows PostgreSQL installation and scripts were not re-executed there.
- The Python lock file was reconstructed from installed-package metadata in the submitted environment. A fresh installation was not tested.
- The original download date was not present in the submitted files.
- Exact duplicate-looking lines remain in the baseline; no deduplicated sensitivity comparison was run.
- PNG charts are retained without a claim that they were created in Excel or another particular tool.
- Passing checks establish consistency for this dataset, not complete coverage of every possible input.
