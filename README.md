# E-Commerce CRM Analytics Pipeline

> End-to-end CRM analytics pipeline covering customer segmentation, churn prediction, CLV modelling, and campaign evaluation — built with Python, SQL, and Power BI.

![Dashboard Preview](dashboard/dashboard_preview.png)

<img width="1440" height="900" alt="Screenshot 2026-05-10 at 13 23 53" src="https://github.com/user-attachments/assets/a532de0c-f9bd-4cde-b51a-b8d686e5b2f2" />

---

## Business Context

Online retailers generate vast amounts of customer transaction data, yet many struggle to translate it into actionable CRM strategies. This project simulates the work of a commercial data analyst tasked with:

- Understanding who the most valuable customers are
- Identifying customers at risk of churning
- Predicting future customer lifetime value
- Evaluating the effectiveness of promotional and re-engagement campaigns

The analysis is built on 100,000+ real e-commerce orders from the **Olist Brazilian E-Commerce dataset** (Kaggle), covering orders, customers, products, payments, and reviews.

---

## Tech Stack

| Layer | Tools |
|---|---|
| Data Processing | Python (pandas, NumPy) |
| Machine Learning | scikit-learn, XGBoost |
| CLV Modelling | lifetimes (BG/NBD model) |
| Statistical Testing | scipy |
| SQL Analysis | PostgreSQL / SQLite |
| Visualisation | matplotlib, seaborn, Power BI |
| Environment | Jupyter Notebooks |

---

## Project Structure

```
ecommerce-crm-analytics/
│
├── data/
│   ├── raw/                    # Original Olist CSV files (not tracked in git)
│   └── cleaned/                # Processed master dataset
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   ├── 02_rfm_segmentation.ipynb
│   ├── 03_churn_prediction.ipynb
│   ├── 04_clv_modelling.ipynb
│   └── 05_campaign_evaluation.ipynb
│
├── sql/
│   ├── customer_metrics.sql
│   ├── cohort_analysis.sql
│   └── campaign_performance.sql
│
├── dashboard/                  # Power BI .pbix file and screenshots
├── reports/                    # Summary findings
└── README.md
```

---

## Key Findings## Key Findings

- **RFM Segmentation:** 9 customer segments identified across 93,349 customers — Champions represent the highest avg CLV at 310 BRL, while Loyal Customers contribute the largest revenue share at 22%
- **Churn Prediction:** XGBoost model achieved AUC of 0.997, identifying 55,852 high-risk customers with recency as the dominant churn driver
- **CLV Modelling:** Total historical CLV of 15.4M BRL across all customers — top 20% of customers contribute 55% of total revenue
- **Campaign Evaluation:** Re-engagement campaign delivered 105.6% conversion uplift vs control group (11.9% vs 5.8%), generating 200,507 BRL additional revenue (p < 0.0001)

---

## How to Run

**1. Clone the repository**
```bash
git clone https://github.com/Toyor12/ecommerce-crm-analytics.git
cd ecommerce-crm-analytics
```

**2. Install dependencies**
```bash
pip install -r requirements.txt
```

**3. Download the dataset**

Download from Kaggle: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Place all CSV files into `data/raw/`

**4. Run notebooks in order**
```bash
jupyter notebook
```
Run notebooks 01 through 05 in sequence.

---

## Notebooks Overview

| Notebook | Description |
|---|---|
| 01_data_cleaning | Load, merge, and clean all Olist tables into a master dataset |
| 02_rfm_segmentation | Build RFM scores and segment customers into CRM personas |
| 03_churn_prediction | Train and evaluate churn classification model |
| 04_clv_modelling | Calculate historical CLV and predict future customer value |
| 05_campaign_evaluation | Simulate campaign cohorts and run A/B test analysis |

---
## Dashboard

The dashboard is built in Google Looker Studio and contains 4 pages:

1. **Customer Overview** — total customers, orders, revenue, monthly trend, category breakdown
2. **RFM Segments** — segment distribution, revenue share, avg CLV by segment
3. **Churn Risk** — risk distribution, churn rate by segment, high-risk customer count
4. **Campaign Performance** — A/B test results, conversion rate and revenue uplift by group

**[View Live Dashboard →](https://datastudio.google.com/reporting/6689c78c-483f-4700-9f73-e4186cd20d9a<img width="1440" height="900" alt="Screenshot 2026-05-10 at 13 23 53" src="https://github.com/user-attachments/assets/a853c60c-7f57-4269-893a-eee51e57140b" />
d20d9a)**

---

## Dataset

**Olist Brazilian E-Commerce Public Dataset**
Source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
License: CC BY-NC-SA 4.0

---

## Author

**Oyewole Oluwatoyosi** — Data Analyst | Commercial & CRM Analytics

- GitHub: github.com/Toyor12
- LinkedIn: linkedin.com/in/oluwatoyosi-oyewole-3a75b2109
- Portfolio: toyor12.github.io
