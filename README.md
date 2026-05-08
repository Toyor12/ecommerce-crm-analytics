# E-Commerce CRM Analytics Pipeline

> End-to-end CRM analytics pipeline covering customer segmentation, churn prediction, CLV modelling, and campaign evaluation — built with Python, SQL, and Power BI.

![Dashboard Preview](dashboard/dashboard_preview.png)

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

The Power BI dashboard contains 4 pages:

1. **Customer Overview** — total customers, orders, revenue, geographic distribution
2. **RFM Segments** — segment breakdown, revenue contribution, customer counts
3. **Churn Risk** — churn probability distribution, high-risk segment profiles
4. **Campaign Performance** — conversion rates, A/B test results, revenue uplift

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
