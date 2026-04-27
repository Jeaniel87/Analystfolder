
# Business problem — Healthcare Insurance Cost Analysis


A healthcare insurance company is experiencing escalating claims costs with limited visibility into the underlying cost drivers. 
Without a clear understanding of where reimbursement dollars are flowing, the organization is unable to make informed decisions around cost containment, care management, or provider contract optimization.

The goal of this analysis is to break down claims expenditure to identify which services, procedures, diagnosis codes, and members are driving the highest costs, enabling the insurer to take targeted, 
data-driven action to improve financial performance and operational efficiency.

Two datasets have been provided for this analysis:
Claims Dataset — contains claim types (Inpatient, Outpatient, Emergency, Pharmacy, Lab), diagnosis codes (ICD), procedure codes (CPT), billed amounts, and paid amounts.
Member Demographics Dataset — Contains member-level information to support segmentation and identify high-cost members.

Questions to Answer

- Which claim types are the most expensive?

- Which CPT and ICD codes drive the highest spending?

- Which members account for the largest share of total costs?

- How do billed amounts compare to paid amounts?

# Analytical Objectives

1.  Data Preparation
 	- Audit both datasets for quality issues (Duplicate records). Merge the claims and demographics datasets into a unified master Dataset.
    
2. Business Metrics & KPI Development
   - Run SQL aggregations (SUM, AVG, COUNT) to compute core financial KPIs, including:
         	- Total billed vs. total paid amounts
          -	Overall and category-level ratio (paid/billed amount)
          -	Overall spending by month
   
   Apply Window Functions (RANK) to:
         -	Rank the top cost-driving CPT codes and ICD diagnosis codes. 
         -	Rank the top cost-driving providers, members.

