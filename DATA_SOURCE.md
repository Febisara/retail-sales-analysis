# Data source

- Dataset: Online Retail.
- Citation: Chen, D. (2015). Online Retail [Dataset]. UCI Machine Learning Repository.
- Publisher page: https://archive.ics.uci.edu/dataset/352/online+retail
- DOI: https://doi.org/10.24432/C5BW33
- Dataset licence: [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).
- Licence checked against the publisher page on 15 November 2026.
- Original download date: not recorded in the submitted project; add the actual date if known.
- Original filename: Online Retail.xlsx.
- Original columns: InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country.
- Period: 1 December 2010 to 9 December 2011.
- Currency: pounds sterling (GBP).
- Scope: historical transactions from a UK online retailer, including wholesale customers.

The original workbook is retained locally without editing. prepare_csv.py adds source_row, preserves identifiers as text and writes timestamps in a consistent format for database import. The conversion retains every original row.

The raw workbook and converted transaction CSV are not included in the publication copy. Download the source separately and run the preparation script. The conversion audit is retained in outputs/conversion_audit.json.

Workbook SHA-256:

```text
43465a06f2ccf7c8b5bd2892bc7defb52f97487934fe93b16ae4c3936424676d
```

This is an independent learning project, not commissioned work for the retailer. The dataset licence describes the source material; it does not automatically license the project's Python or SQL code.
