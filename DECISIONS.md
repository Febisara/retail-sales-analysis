# Decision log

Recorded for the completed baseline project, November 2026.

## Preserve source lines

I retained all 541,909 raw lines and used the original Excel row number as source_row. Invoice number plus stock code is not a unique line key.

The source contains 5,268 additional identical-looking lines. I retained them because matching values alone do not prove an erroneous duplicate. A deduplicated sensitivity analysis was not performed; the published results are the baseline.

## Define positive sales explicitly

I included positive quantity and unit price, non-cancellation rows with invoice number, date and stock code. This retains 530,104 lines and excludes 11,805.

An alternative is net signed transaction value, but it requires different treatment of cancellations, returns and adjustments. The current metric is gross positive sales, not net revenue or profit.

## Retain anonymous sales

I kept eligible invoices without customer identifiers in overall sales. Excluding them would omit £1,755,276.64 from positive sales.

Customer analyses use only known identifiers because anonymous invoices cannot reliably be connected to individual customers.

## Resolve invoice-level attributes after checking conflicts

The quality query returned no invoices with conflicting known customer IDs or countries. Missing values alongside one known ID are treated as compatible, and the model selects the known value.

There are 43 invoices with multiple timestamps. I used the earliest eligible line timestamp as the invoice timestamp. I aggregate lines to invoices before calculating average invoice value.

## Use complete months for growth

The source ends on 9 December 2011. I excluded December 2011 from monthly growth comparisons, while retaining its eligible transactions in full-period totals.

## Interpret customer and product rankings cautiously

Repeat purchasing means two or more observed eligible invoices, not cohort retention. Costs are absent, so sales rankings do not measure profitability.

The top-code result is reported as a stock-code ranking. The project review identified DOT's source description as DOTCOM POSTAGE. No separate DOT investigation query was run by me, and the ranking is not described as the best-selling physical product.

## Validation

My exported checks show zero orphan lines and a zero difference between line and invoice totals. Invoice 536365 has seven lines summing to £139.12; the saved manual-check values match the SQL total. The manual check was saved as CSV, so spreadsheet formulas are not retained.

I reported rerunning the model and confirming unchanged totals during the guided workflow. The submitted files contain the final exports, rather than separate before-and-after snapshots.

The final AI-assisted review independently compared the workbook with the converted CSV and recomputed the saved results from the submitted data. This was not a second PostgreSQL execution.

## Presentation and assistance

I retained PNG charts without editable chart workbooks. The images were checked against the saved CSVs during review; their creation method was not independently established.

I used the supplied course SQL and preparation script, ran the baseline workflow, and used AI assistance for guidance, checks and documentation. No performance improvement, commercial intervention or duplicate sensitivity result is claimed.
