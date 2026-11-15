# Retail sales and customer findings

## Scope and metric

This independent portfolio exercise examines historical transactions from the UCI Online Retail dataset, covering 1 December 2010 to 9 December 2011. The baseline includes 19,960 eligible invoices with gross positive sales of £10,666,684.54 and an average invoice value of £534.40.

Gross positive sales includes positive-quantity, positive-price, non-cancellation lines with required invoice identifiers, stock codes and dates. It is not net revenue or profit. The baseline retains duplicate-looking source lines.

## 1. November had the highest complete-month sales

November 2011 recorded £1,509,496.33 in gross positive sales, the highest value among the 12 complete months analysed. This was 30.69% above October's £1,154,979.30. September had also increased by 39.45% compared with August.

The final three complete months therefore show increased positive sales. This supports investigating which products and customer accounts contributed to the increase. It does not establish that a campaign or seasonal effect caused it. One annual cycle is insufficient to establish a recurring seasonal pattern.

Next action: break down the September–November increase by stock code and customer, and compare with promotion, availability and fulfilment records if those become available.

Source: [Monthly sales](outputs/monthly_sales.csv).

## 2. Sales were concentrated in the United Kingdom

Invoices recorded against the United Kingdom accounted for £9,025,222.08 across 18,019 invoices, approximately 84.61% of gross positive sales over the full source period.

The Netherlands was the next-largest recorded country by value, with £285,446.34 across 94 invoices, followed by EIRE with £283,453.96 across 288 invoices. Country describes the recorded invoice country, not customer nationality.

The concentration means UK performance has a substantial influence on overall results. Differences in invoice counts also suggest that country totals should be examined alongside average invoice values and account concentration.

Next action: investigate the customers and product codes behind the largest country totals before proposing market expansion or account-management priorities. Sales value alone does not establish market profitability.

Source: [Country sales](outputs/country_sales.csv).

## 3. Most identified customers purchased more than once

Among 4,338 identified customers with eligible invoices, 2,845 had at least two invoices during the observed period: 65.58%.

This measures repeat purchasing within the available data. It is not a retention rate because customers entered the observation window at different times and the calculation does not follow matched acquisition cohorts.

Next action: examine purchase frequency and sales concentration among identified repeat buyers. A later cohort analysis could compare customers over equal periods following their first observed purchase.

Source: [Repeat customers](outputs/repeat_customers.csv).

## Coverage and limitations

The validated anonymous-sales query returned 1,428 eligible invoices without customer identifiers, worth £1,755,276.64, approximately 16.46% of gross positive sales. These invoices remain in sales totals but are excluded from identified-customer calculations.

December 2011 is excluded from month-on-month comparisons because the source ends on 9 December. Country and overall totals include that partial month, so their totals should not be compared directly with the sum of the 12-month chart.

Negative, zero-price and cancellation rows are outside the positive-sales definition. Costs are unavailable, and some stock codes may represent charges or adjustments. The data cannot establish profit or the operational causes of observed patterns.

## Baseline scope

Duplicate-looking rows remain included. A deduplicated sensitivity comparison was not performed. During the assisted review, the leading stock code DOT was found to have the source description DOTCOM POSTAGE; stock-code sales rankings therefore include charges and must not be labelled solely as physical-product rankings.
