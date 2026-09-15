# AML Transaction Risk Intelligence Dashboard
 
**Tools:** Python (Pandas, Matplotlib) · SQL (Window Functions, CTEs) · Power BI (DAX)  
**Domain:** FinTech Compliance · Financial Fraud · Financial Intelligence · Transaction Monitoring  
**Dataset:** PaySim Synthetic Financial Fraud · 6.36M records · 743-Hour Window
 
---
 
## Business Problem
 
Legacy rules-based transaction monitoring systems are failing to catch sophisticated financial fraud schemes, leaving financial institutions exposed to massive regulatory liabilities. Analysis of 6,362,620 multi-channel transactions revealed that the existing binary detection flag caught just 0.2% of fraudulent activity. This project implements data-driven pattern detection, advanced SQL risk modeling, and an interactive executive dashboard to bridge a $11.98 billion undetected exposure gap.
 
---
 
## What I Built
 
### 1. Exploratory Data Analysis (`aml_fraud_analysis.ipynb`)
- Evaluated transaction distributions to uncover a 100% fraud concentration inside specific channels.
- Mapped transaction timestamps across 743 hours to analyze temporal velocity patterns.
- Generated 7 analytical visualizations assessing amount behaviors, systemic exposure, and destination frequency.
 
### 2. Advanced Risk Aggregation (`queries.sql`)
- Developed 7 production-grade SQL scripts deploying window functions, CTEs, and conditional routing logic.
- Computed cumulative transactional trends and rolling multi-hour averages to monitor real-time fraud persistence.
- Engineered a multi-level data aggregation pipeline to feed the underlying metrics for the Power BI dashboard scorecard.
 
### 3. Interactive Compliance Dashboard (`dashboard.pbix`)
- **4 Operational KPIs:** Real-time visibility into Total Transactions, Fraud Cases, Fraud Rate, and Total Financial Exposure.
- **Sustained Risk Visuals:** Dynamic line charting using rolling averages paired with a conditional formatting scorecard heatmap.
- **Compliance Gap Panel:** A clear, comparative layout contrasting legacy system hits (16 cases) against undetected exposure.
- *Note: Open `dashboard.pbix` in Power BI Desktop to interact with filters, or review the quick-access `dashboard.pdf`.*
 
### 4. Executive Compliance Memo (`business_memo.md`)
- Authoritative C-suite advisory detailing core regulatory findings, systemic gaps, and structural data limitations.
- Operational execution plan for an engineered 3-tier risk-scoring matrix mapping precise investigative actions.
- 5 strategic compliance recommendations spanning immediate velocity checks to continuous monitoring thresholds.
 
---
 
## Key Results
 
| Metric | Value |
|--------|-------|
| Total Monitored Volume | 6,362,620 transactions |
| Total Confirmed Fraud Cases | 8,213 cases |
| Overall Baseline Fraud Rate | 0.1291% |
| Legacy System Flagged Cases (`isFlaggedFraud`) | 16 cases |
| **Legacy System Detection Rate** | **0.20%** |
| Total Financial Fraud Exposure | ~$12.60 Billion |
| **Undetected Compliance Exposure Gap** | **$11.98 Billion** |
| System Failure / Miss Rate | 99.8% |
 
---
 
## Key Findings
 
**1. Vulnerability is heavily concentrated in specific channels**  
100% of fraudulent activity occurred exclusively within **TRANSFER** (0.77% fraud rate, 4,097 cases) and **CASH_OUT** (0.18% fraud rate, 4,116 cases) channels. Other channels (CASH_IN, PAYMENT, DEBIT) maintained zero fraud instances across the entire 31-day monitoring window. 
 
**2. Fraud operates as a highly systematic, 24/7 process**  
Rather than occurring in erratic bursts, fraud maintained a rigid velocity averaging **11.1 cases per hour** across all 743 hours. 12-hour rolling averages stayed stable throughout, confirming that no "low-risk" operational monitoring windows exist.
 
**3. Transaction limits are actively exploited by bad actors**  
Approximately **33% of all fraud transactions** clustered at exactly $1,000,000—the system's maximum allowed limit. This ceiling-targeting behavior is entirely inconsistent with organic customer activity and represents a deliberate optimization tactic.
 
**4. Differential exposure exists between identical volume counts**  
Despite near-equal case distributions, TRANSFER networks carry higher dollar exposure ($6.07B) than CASH_OUT networks ($5.99B). This behavior is driven by higher average TRANSFER amounts ($1,481K vs. $1,455K per case).
 
**5. Target destination networks exhibit "Smurfing" traits**  
The vast majority of target destination accounts were utilized only once to evade traditional repetition detection logic. However, a critical sub-cluster of 44 accounts was flagged for repeated hits (2–5 times), pinpointing an active, organized money mule network.
 
---
 
## 3-Tier Risk Scoring Framework
 
To replace the ineffective legacy binary flagging logic, a multi-variable scoring model was engineered across transaction channel (40 pts), ceiling limits (40 pts), and account repetition (20 pts):
 
| Tier | Score Range | Active Cases | Volume % | Operational Action Required |
|------|-------------|--------------|----------|-----------------------------|
| 🔴 **Tier 1 — Critical** | 75–100 | 1,056 | 35.2% | Immediate Suspicious Activity Report (SAR) filing |
| 🟠 **Tier 2 — Investigate** | 50–74 | 1,434 | 47.8% | Compliance analyst review required within < 24 hours |
| 🟢 **Tier 3 — Monitor** | 0–49 | 510 | 17.0% | Dynamic baseline behavioral logging and watchlist tracking |
 
---
 
## Strategic Recommendations
 
1. **Deploy Real-Time Velocity Friction (Immediate):** Implement automated clearance holds and real-time verification checks on all outbound TRANSFER transactions exceeding $200,000 to halt critical exposure before settlement occurs.
2. **Launch Proximity Triggers (Month 1):** Deploy immediate threshold rules alerting compliance queues of any single transaction approaching $999,000+ to isolate ceiling-exploitation tactics with zero model overhead.
3. **Establish Destination Watchlists (Month 1):** Build an active database of identified fraud destination accounts to cross-reference all incoming TRANSFER and CASH_OUT movements in real time before processing approval.
4. **Transition to Multi-Tier Scoring (Quarter 1):** Sundown the legacy binary flagging system and fully migrate to the graduated 3-tier risk scorecard model to properly triage analysts' operational queues based on risk severity.
5. **Enforce Uniform 24/7 Monitoring (Quarter 1):** Keep alert thresholds and investigation workflows identical during off-hours, weekends, and holidays, as pattern analysis proves fraud velocity does not drop during low-traffic windows.
 
---
 
## Dashboard Preview
 
https://github.com/AnukratiR/aml-transaction-risk-dashboard/blob/main/dashboard_screenshot.png
 
---
 
## Top Analytics Drivers (Feature Framework)
 
1. Transaction Type Concentration (TRANSFER / CASH_OUT)
2. Transaction Limit Closeness ($1,000,000 Cap)
3. Destination Account Velocity (Mule Network Repetition)
4. Temporal Continuity (Continuous 11.1 cases/hour pattern)
 
---
 
## Project Structure
 
```
aml-transaction-risk-dashboard/
├── aml_fraud_analysis.ipynb      # Python notebook: EDA and 7 pattern-detection charts
├── queries.sql                   # 7 production SQL scripts (Window functions, CTEs)
├── fraud_summary.csv             # Cleaned, aggregated export dataset for Power BI ingestion
├── business_memo.md              # Executive C-suite compliance findings & strategy
├── dashboard.pbix                # Interactive Power BI dashboard file
├── dashboard.pdf                 # Static corporate PDF layout of the dashboard
├── dashboard_screenshot.png      # Portfolio thumbnail asset
├── visual_assets/                # Supporting analytical asset tracking
│   ├── chart1_to_7.png           # Python data visualization outputs
│   └── query_results1_to_7.png   # SQL execution confirmation captures
└── README.md
```
 
---

 
## Resume Bullet
 
> Developed an end-to-end AML Transaction Risk Intelligence platform processing 6.36M records using Python and SQL; discovered a 99.8% legacy detection gap exposing $11.98B in unflagged fraud. Engineered a 3-tier risk-scoring matrix using advanced SQL (CTEs, Window Functions), and deployed an interactive Power BI compliance dashboard to optimize transaction monitoring workflows.
 
---
 
## Dataset Credit
 
PaySim Synthetic Financial Fraud Dataset — Generated for academic research via [Kaggle](https://www.kaggle.com/datasets/ealaxi/paysim1.
