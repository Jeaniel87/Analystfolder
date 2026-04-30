
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
         	- Total billed vs. total paid amounts.
          -	Overall and category-level ratio (paid/billed amount).
          -	Overall spending by member and provider.
   
   - Apply Window Functions (RANK) to:
         -	Rank the top cost-driving CPT codes and ICD diagnosis codes. 
         -	Rank the top cost-driving providers, members.

<img width="1558" height="878" alt="image" src="https://github.com/user-attachments/assets/7f7e1f8a-e5d9-4112-bcaf-f2b1d0d69415" />


# Results 


# Comments

The KPI reflects that across the reporting period, providers billed a combined $2.06M, of which $1.55M (75%) was reimbursed by the healthcare insurer. 
 The 25% denial rate (~$515K) highlights an opportunity to investigate claim rejections and optimize reimbursement performance.

Inpatient (1,09M) , Emergency (294k) , Outpatient (129k), pharmacy (11.3k), lab (23.4k) Inpatient dominates at $1.09M it represent 70% of all insurance payouts.
This is expected as hospital admissions involve  room costs, nursing care, extending days making them the most resource intensive claim type.
Emergency comes second - 249k(19%) reflects unplanned visits. While individule ER visits are expensive, their share suggests 
a meaningful portion of members seeking care reactively rather than through preventive or schedule channels.
Finally, Outpatient lab and Pharmacy are minimal around (11%) these likely reflect either low utilization or strong cost controls.


Lab (0.91) and Pharmacy (0.89) have the highest paid-to-billed ratios, suggesting they are well-reimbursed with relatively low adjustment or denial rates—likely due to standardized pricing and stronger cost control. In contrast, Outpatient (0.80), Emergency (0.77), and especially Inpatient (0.74) show progressively lower ratios, indicating higher write-offs denials which is common due to their severity and variability in care delivery.


Among the top 10 billed procedures CPT codes 67890 ($242K) and 23456 ($203K) are the top two cost drivers, collectively accounting for 46% of total insurance payouts across the top 10 CPT codes. 
Together, they represent $445K in reimbursements signaling that nearly half of high-volume procedure costs are concentrated in just two billing codes.

Diagnosis codes I10 ($259K) and A12.3 ($152K) emerge as the leading cost drivers among the top 10 ICD codes, contributing a combined $411K — representing 43% of total insurance payouts. 
Their disproportionate share of reimbursements signals that these two conditions alone are placing significant financial weight on the insurer's payout.

Leading the group, Member 6 ($43K) and Member 32 ($40K) alone contribute $83K, or roughly 46% of the top 5 total payout.
This level of spend concentration is a strong indicator that a small subset of members is driving a disproportionate share of healthcare costs.

The average paid ratio accross the top 5 sits at 0.75. PRV00002 and PRV00001 dominate the healthcare expenses accounting for 56% of total paid amount. Any improvement in their denial rates particularly PRV00001 would have a positive impact on overall revenue recovery.

# Conclusion

The disproportionate spend profile observed in CPT codes (67890;23456) ICD codes (I10;A12.3) and patient account (6;32) suggests a need for deeper utilization review, payer specific reimbursement analyis and proactive audit for these key cost drivers for better cost containment.

# Tools
- SQL Server
- Tableau

# Autor 
Junior Jean Daniel Bosso
https://www.linkedin.com/in/juniorbosso



