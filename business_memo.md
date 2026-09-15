# AML Transaction Risk Analysis
## Executive Findings & Compliance Recommendations

**Prepared by:** Anukrati Rajawat, Business Analyst  
**Institution:** University of North Carolina Wilmington (UNCW)  
**Program:** MS Business Analytics, 2026  
**Date:** June 2026  
**Dataset:** PaySim Synthetic Mobile Money Transactions  
**Scope:** 6,362,620 transactions across 743 hours (31 days of monitoring)  
**Tools Used:** Python (Pandas, Matplotlib) · SQL (Window Functions, CTEs) · Power BI (DAX, KPI Dashboards)  

---

## Executive Summary

Analysis of 6,362,620 synthetic mobile money transactions revealed critical fraud patterns concentrated exclusively in two transaction types. Of the total transaction volume, 8,213 cases were confirmed fraudulent, representing 0.1291% of all transactions and approximately $12.6B in total fraud exposure.

Most significantly, the existing detection mechanism (`isFlaggedFraud`) identified only 16 cases — a detection rate of just 0.2%. Advanced pattern analysis through transaction type classification, amount distribution modeling, and temporal analysis successfully identified the remaining 8,197 undetected fraud cases, representing $11.98B in previously unidentified financial exposure.

---

## Key Findings

### Finding 1 — Transaction Type Concentration
100% of fraudulent activity occurred exclusively in **TRANSFER** (0.77% fraud rate, 4,097 cases) and **CASH_OUT** (0.18% fraud rate, 4,116 cases) transaction types. `PAYMENT`, `DEBIT`, and `CASH_IN` showed zero fraud instances across the entire 743-hour monitoring period.

The `TRANSFER` type carries a fraud rate 4.3 times higher than `CASH_OUT`, despite `CASH_OUT` processing nearly 4 times more total transaction volume. This indicates `TRANSFER` transactions represent the highest-priority monitoring target.

### Finding 2 — Fraud Persistence (24/7 Pattern)
Fraud activity maintained a consistent average of approximately 11.1 cases per hour across all 743 monitored hours with no identifiable safe monitoring window. The 12-hour rolling average remained stable throughout the monitoring period, confirming that fraud activity is systematic and sustained rather than opportunistic or time-bound.

This finding has direct operational implications: monitoring intensity cannot be reduced during any time period, including off-hours, weekends, or low-traffic windows.

### Finding 3 — Transaction Limit Exploitation
Approximately 33% of all fraud transactions were recorded at exactly **$1,000,000** — the maximum allowed transaction limit. This deliberate clustering at the system ceiling is inconsistent with natural transaction behavior and indicates a coordinated limit-exploitation tactic designed to maximize single-transaction fraud exposure before triggering alerts.

### Finding 4 — Differential Dollar Exposure by Type
Despite near-identical fraud case counts between `TRANSFER` (4,097 cases) and `CASH_OUT` (4,116 cases), `TRANSFER` transactions carry significantly higher dollar exposure: $6.07B versus $5.99B for `CASH_OUT`. This differential is driven by higher average `TRANSFER` amounts ($1,481K versus $1,455K per fraudulent case).

### Finding 5 — Critical Detection Gap ⚠️
The existing `isFlaggedFraud` detection field identified only 16 of 8,213 confirmed fraud cases — a catastrophic detection rate of 0.2%. The remaining 8,197 cases (99.8%), representing **$11.98B in exposure**, went entirely undetected by the current system.

This represents a fundamental compliance gap. An institution relying solely on the existing flagging mechanism would be exposed to the vast majority of fraudulent activity with no automated detection or response capability.

### Finding 6 — Destination Account Patterns
Analysis of destination account targeting frequency reveals a smurfing pattern consistent with organized money mule network activity. The majority of destination accounts were targeted only once, consistent with a strategy of using each account a single time to avoid detection through repetition-pattern matching systems.

A subset of 44 accounts were targeted between 2 and 5 times, representing a higher-priority investigation tier requiring immediate escalation.

### Finding 7 — Risk Scoring Framework
A 3-tier risk scoring model was developed to replace the legacy binary logic. 

> **Risk Scoring Engine Weights:**
> * **Transaction Channel:** TRANSFER (40 points) · CASH_OUT (30 points)
> * **Ceiling Proximity:** Up to 40 points for hitting the $1M transaction limit
> * **Mule Network Velocity:** Up to 20 points based on destination account repeat frequency

| Tier | Score Range | Cases | % of Total | Action Required |
|------|------------|-------|-----------|-----------------|
| 🔴 **Tier 1 — Critical** | 75–100 | 1,056 | 35.2% | Immediate SAR filing |
| 🟠 **Tier 2 — Investigate** | 50–74 | 1,434 | 47.8% | Compliance analyst review required < 24 hrs |
| 🟢 **Tier 3 — Monitor** | 0–49 | 510 | 17.0% | Flag for automated behavioral tracking |

---

## Strategic Recommendations

### 1. Implement Real-Time Velocity Friction (Immediate Priority)
Implement real-time velocity checks on all `TRANSFER` transactions exceeding $200,000. Route flagged transactions to an analyst review queue before settlement clearance. 
* *Expected Impact:* Intercept the majority of Tier 1 Critical cases before final financial exposure occurs.

### 2. Deploy Proximity Triggers (Short Term - Month 1)
Deploy automated ceiling-proximity alerts for any transaction approaching $999,000 or above. The clustering of 33% of fraud at exactly the $1M limit is a highly detectable signal. A simple threshold trigger at $999,000 flags these transactions instantly with zero model overhead.

### 3. Establish Destination-Account Watchlists (Short Term - Month 1)
Create an automated destination-account watchlist populated from confirmed fraud destination accounts. Cross-reference all incoming `TRANSFER` and `CASH_OUT` movements against this watchlist in real time before processing transactional approval.

### 4. Transition to Multi-Tier Risk Scoring (Medium Term - Quarter 1)
Completely replace the binary `isFlaggedFraud` detection field with the engineered 3-tier risk scoring model. The existing system's 99.8% miss rate creates false assurance of compliance safety. The proposed model provides a graduated response capability aligned perfectly to actual risk severity.

### 5. Enforce Uniform 24/7 Monitoring (Medium Term - Quarter 1)
Implement 24/7 continuous monitoring with uniform alert thresholds regardless of time of day or transaction volume. Pattern analysis confirms fraud does not reduce during off-peak hours; any reduction in monitoring intensity represents a directly exploitable compliance gap.

---

## Methodology

<details>
<summary><b>🔍 Click to view technical methodology details</b></summary>

| Step | Tool | Technique | Output |
|------|------|-----------|--------|
| Data exploration | Python (Pandas) | EDA, descriptive statistics | Dataset overview, fraud rates |
| Pattern analysis | Python (Matplotlib) | Data visualization, distribution analysis | 7 analytical charts |
| Risk aggregation | SQL (SQLiteOnline) | Window functions, CTEs, CASE statements | 7 analytical queries |
| Executive reporting | Power BI (DAX) | KPI cards, interactive dashboard | AML Risk Intelligence Dashboard |
| Risk scoring | Python | Custom scoring algorithm | 3-tier risk framework |
| Recommendations | Business Analysis | Domain expertise, findings synthesis | This compliance memo |

</details>

---

## Dataset Reference

* **Dataset:** PaySim Synthetic Financial Fraud Dataset  
* **Source:** [Kaggle - PaySim1](https://www.kaggle.com/datasets/ealaxi/paysim1)  
* **Records:** 6,362,620 transactions · 11 columns · 743 hours (~31 days of monitoring)  
* **Features:** `step`, `type`, `amount`, `nameOrig`, `oldbalanceOrg`, `newbalanceOrig`, `nameDest`, `oldbalanceDest`, `newbalanceDest`, `isFraud`, `isFlaggedFraud`  

> **Note:** Synthetic dataset generated for academic research. All account identifiers are randomly generated. No real customer data is used.