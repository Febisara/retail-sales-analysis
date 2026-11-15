"""Convert the source workbook to a stable CSV for PostgreSQL import."""
from pathlib import Path
import hashlib
import json
import pandas as pd

ROOT = Path(__file__).resolve().parent
source = ROOT / 'data' / 'raw' / 'Online Retail.xlsx'
out = ROOT / 'data' / 'processed'
out.mkdir(parents=True, exist_ok=True)
df = pd.read_excel(source, dtype={
    'InvoiceNo': 'string', 'StockCode': 'string',
    'CustomerID': 'string'
})
expected = ['InvoiceNo', 'StockCode', 'Description', 'Quantity',
            'InvoiceDate', 'UnitPrice', 'CustomerID', 'Country']
if list(df.columns) != expected:
    raise ValueError('Workbook columns differ from the expected contract')
df.insert(0, 'source_row', range(2, len(df) + 2))
df['InvoiceDate'] = pd.to_datetime(df['InvoiceDate'], errors='raise')
df.to_csv(out / 'retail.csv', index=False,
          date_format='%Y-%m-%d %H:%M:%S', encoding='utf-8')
audit = {
    'source_rows': len(df),
    'missing_customer_rows': int(df['CustomerID'].isna().sum()),
    'exact_duplicate_rows': int(df[expected].duplicated().sum()),
    'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest()
}
(out / 'conversion_audit.json').write_text(json.dumps(audit, indent=2))
print(json.dumps(audit, indent=2))
