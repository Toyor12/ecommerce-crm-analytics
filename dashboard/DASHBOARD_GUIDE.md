# Power BI Dashboard Guide

## Overview

Build a single .pbix file with 4 report pages. Load the cleaned CSV files from `../data/cleaned/` as data sources.

---

## Data Sources to Load

| File | Used In |
|---|---|
| master_transactions.csv | Page 1 — Customer Overview |
| rfm_segments.csv | Page 2 — RFM Segments |
| churn_predictions.csv | Page 3 — Churn Risk |
| campaign_results.csv | Page 4 — Campaign Performance |

---

## Page 1 — Customer Overview

**KPI Cards (top row):**
- Total Customers
- Total Revenue (BRL)
- Avg Order Value (BRL)
- Repeat Purchase Rate (%)

**Visuals:**
- Line chart: Monthly Revenue Trend (order_date by month vs total_payment sum)
- Bar chart: Revenue by Product Category (top 10)
- Map: Customer Distribution by State
- Card: Date range of data

**Filters/Slicers:**
- Date range slicer
- State multiselect

---

## Page 2 — RFM Segments

**KPI Cards:**
- Number of Segments
- Champions % of customers
- Champions % of revenue

**Visuals:**
- Donut chart: Customer count by Segment
- Clustered bar: Revenue share by Segment
- Scatter plot: Recency vs Monetary, coloured by Segment
- Table: Segment summary (avg recency, avg frequency, avg CLV, recommended action)

**DAX Measures:**
```
Champions Revenue % =
DIVIDE(
    CALCULATE(SUM(rfm_segments[monetary]), rfm_segments[Segment] = "Champions"),
    SUM(rfm_segments[monetary])
) * 100

Repeat Purchase Rate =
DIVIDE(
    COUNTROWS(FILTER(rfm_segments, rfm_segments[frequency] > 1)),
    COUNTROWS(rfm_segments)
) * 100
```

---

## Page 3 — Churn Risk

**KPI Cards:**
- High Risk Customers (count)
- High Risk Revenue at Stake (BRL)
- Overall Churn Rate (%)

**Visuals:**
- Clustered bar: Churn risk distribution (Low / Medium / High)
- Bar chart: Churn rate by RFM Segment
- Gauge: Overall churn probability (avg)
- Table: Top 50 highest churn probability customers (customer_id, segment, churn_probability, monetary)

**DAX Measures:**
```
High Risk Revenue =
CALCULATE(
    SUM(churn_predictions[monetary]),
    churn_predictions[churn_risk] = "High"
)

Avg Churn Probability =
AVERAGE(churn_predictions[churn_probability]) * 100
```

---

## Page 4 — Campaign Performance

**KPI Cards:**
- Treatment Conversion Rate
- Control Conversion Rate
- Relative Uplift (%)
- Revenue Uplift (BRL)

**Visuals:**
- Clustered bar: Conversion rate — Treatment vs Control
- Clustered bar: Revenue — Treatment vs Control
- Bar chart: Conversion rate by Segment and Group
- Table: Campaign results summary with p-value annotation (add as text box)

**DAX Measures:**
```
Treatment Conversion Rate =
CALCULATE(
    AVERAGE(campaign_results[converted]),
    campaign_results[group] = "treatment"
) * 100

Control Conversion Rate =
CALCULATE(
    AVERAGE(campaign_results[converted]),
    campaign_results[group] = "control"
) * 100

Relative Uplift % =
DIVIDE(
    [Treatment Conversion Rate] - [Control Conversion Rate],
    [Control Conversion Rate]
) * 100
```

---

## Styling Notes

- Primary colour: #1F4E79 (dark navy blue)
- Accent colour: #2E75B6
- Light fill: #D6E4F0
- Font: Segoe UI throughout
- Canvas background: white (#FFFFFF)
- Add company logo placeholder top left on each page
- Use consistent card style: white background, thin border, bold metric, grey label

---

## Export for GitHub

1. Save as `ecommerce_crm_dashboard.pbix` in the `dashboard/` folder
2. Export each page as PNG: File > Export > Export to PDF, then convert pages to images
3. Save screenshots as `dashboard/page1_overview.png` etc.
4. Add the Page 1 screenshot to the top of README.md as the preview image
