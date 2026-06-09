# NHS ENGLAND A&E PERFORMANCE ANALYSIS


### End-to-End Data Analytics Portfolio Project

**Tools:** Excel | MySQL | Power BI
**Data:** NHS England Official Statistics 2022-2025

---

## The Business Problem

The NHS has a constitutional standard that 95% of A&E patients must be seen within 4 hours. This target has not been met nationally since 2015. In March 2024 NHS England acknowledged the crisis by introducing a 
reduced interim target of 78% to be met by March 2025. Even this easier target was missed.

This project analyses 3 years of official NHS England data across 124 Trusts and 47 million patient visits to answer three questions:

- Where and when is the NHS failing its A&E target?
- Which Trusts are performing worst and best?
- Is performance getting better or worse?

---

## The Numbers

| Metric | Value |
|--------|-------|
| Trusts Analysed | 124 |
| Total Attendances | 47 Million |
| Total Patients Failed | 19.7 Million |
| % Patients Failed | 41.6% |
| Avg 4HR Performance | 58.2% |
| Trusts Hitting 95% Target | 0 out of 124 |
| Trusts Hitting 78% Target | 15 out of 124 |
| NHS Regions Covered | 7 |

---

## The Dataset

**Source:** NHS England Official Statistics
**URL:** digital.nhs.uk/data-and-information/
publications/statistical/
hospital-accident--emergency-activity

**Files used:**
- AE2223_ECDS_MSitAE_Tables.xlsx (2022-23)
- AE2324_ECDS_MSitAE_Tables.xlsx (2023-24)
- AE2425_ECDS_MSitAE_Tables.xlsx (2024-25)

**Sheet:** Table 6 — Provider level performance data

**Licence:** Open Government Licence v3.0
[Free to use for any purpose including portfolio work].

---

## My Approach
RAW XLSX > EXCEL> SQL > POWER BI
Each tool built on the work of the one before it. The original NHS files were never modified.

---

## Step 1 — Excel: Extract and Merge

The raw data was spread across 3 separate annual NHS England report files. Before writing a single SQL query I cleaned and merged everything in Excel.

**Actions taken:**
- Extracted Table 6 from all 3 annual XLSX files
- Added YEAR column to identify each record
- Merged all 3 years into one master dataset
- Mapped 124 Trusts to their NHS regions
  via provider code lookup
- Removed % symbols and comma separators
  to prepare for MySQL import
- Renamed columns to remove special characters
- Added calculated columns:
  PERFORMANCE_GAP (95 minus actual performance)
  TARGET_MET (YES or NO)
- Saved as NHS_AE_MASTER_CLEAN.csv

**Key challenge:** 22 Trusts had minor name 
variations across years due to inconsistent 
formatting in the source data. Resolved by using 
provider_code as the unique Trust identifier.

---

## Step 2 — MySQL: Clean and Analyse

With the clean CSV imported into MySQL Workbench I ran 10 business queries to turn raw rows into actual answers.

**Cleaning:**
- Trimmed whitespace from all text columns
- Validated row counts matched Excel
- Confirmed data types on all columns
- Used SQL_SAFE_UPDATES to prevent
  accidental bulk updates

**Business Queries:**

| Query | Question |
|-------|----------|
| 1 | Overall national performance by year |
| 2 | Top 10 worst performing Trusts 2024-25 |
| 3 | Top 10 best performing Trusts 2024-25 |
| 4 | Year on year improvement vs decline |
| 5 | Scale of the crisis — total patients failed |
| 6 | 78% vs 95% target — how many Trusts hit each |
| 7 | Performance by NHS region |
| 8 | Local Trust — Sunderland analysis |
| 9 | Sunderland vs national average |
| 10 | Chronic underperformers below 70% all 3 years |

---

## Step 3 — Power BI: Interactive Dashboard

The final step was turning everything into a dashboard any non-technical manager could use.
![NHS Dashboard Page 1](DASHBOARD%201.png)

**Page 1 — National Overview**
- KPI cards: avg performance, total Trusts, total attendances, total patients failed
- Line chart: national performance vs both 95% and 78% targets across 3 years
- Bar charts: attendances and patients failed by year
- Slicers: year, target status, region

![NHS Dashboard Page 2](NHS%20DASHBOARD%202.png)
https://github.com/Techy-Sam1/HEALTHCARE-PROJECT-NHS-A-E-ANALYSIS-/blob/c94b50ff20fc5fd4fc9f2f0f494eef8f3e10dc5a/
**Page 2 — Trust and Regional Analysis**
- KPI cards: Trusts hitting 95%, Trusts hitting 78%, Sunderland performance, % patients failed
- Trust performance ranking bar chart with conditional colour coding Red = below 78% | Amber = 78-95% | Green = above 95%
- Regional average performance bar chart
- Slicers: year, region, target status

**DAX measures created:**
- National Avg Performance
- Total Trusts
- Total Attendances
- Total Patients Failed
- Trusts Hitting 78%
- Trusts Hitting 95%
- Sunderland Performance
- Sunderland vs National Average
- % Patients Failed
- Target Status (calculated column)

---

## Key Findings

**1. Zero Trusts hit the 95% target**
Not one NHS Trust out of 124 achieved the constitutional standard in any of the 3 years. The target has not been met nationally since 2015.

**2. 109 Trusts failed even the 78% interim target**
88% of all NHS Trusts in England failed the easier recovery milestone introduced in March 2024.

**3. 19.7 million patients were failed**
41.6% of all A&E attendances across England between 2022 and 2025 waited longer than the constitutional standard.

**4. Demand outpaced improvement**
A&E attendances grew 18.3% while performance improved just 1.9 percentage points over 3 years.

**5. Geographic inequality affects every region**
A 6 point gap exists between best and worst regions. No region hits either target. Where you live determines the quality of emergency care you receive.

**6. Sunderland is below the national average**
South Tyneside and Sunderland NHS Foundation Trust performed at 55.07% — 3.13 points below the national average of 58.2%.

---

## Recommendations

1. **Learn from the 15 Trusts that hit 78%**
   Commission peer review visits from top performers to the bottom 20 Trusts.

2. **Place chronic underperformers on improvement plans**
   109 Trusts failed the 78% target and need formal quarterly accountability reporting.

3. **Reduce demand through alternative care pathways**
   Redirect appropriate attendances to same day emergency care and urgent treatment centres.

4. **Targeted investment in underperforming regions**
   North West, South West and East of England all perform at just 56% and need prioritised support.

5. **Publish real time Trust level dashboards publicly**
   Transparent monthly reporting drives accountability and enables informed patient choice at zero additional cost.

---

---

## Tools and Skills

| Tool | How Used | Key Techniques |
|------|----------|----------------|
| Excel | Extract, merge, clean | VLOOKUP, Find and Replace, calculated columns |
| MySQL | Deep clean, analyse | GROUP BY, CASE WHEN, JOIN, HAVING, Subquery |
| Power BI | Dashboard | DAX, conditional formatting, KPI cards |
| GitHub | Version control | README, folder structure |

---

## About This Project

This is the third project in my data analytics portfolio covering Finance, Telecoms and Healthcare.

Built entirely using free tools and publicly available government data under Open Government Licence v3.0.

---

**Author:** IFEOLUWA SAMUEL SUNDAY
**LinkedIn:** www.linkedin.com/in/ifeoluwa-samuel-sunday-a164bb32b


*Data Source: NHS England Official Statistics Hospital Accident and Emergency Activity 2022-2025*
