Use HealthCareInsurance;

select* from claims
select* from members



--check for duplicate

-- Claims dataset

select 
claim_id, member_id, provider_id, claim_date, claim_type, cpt_code, icd_code, billed_amount, paid_amount,
count(*)
from claims
group by claim_id, member_id, provider_id, claim_date, claim_type, cpt_code, icd_code, billed_amount, paid_amount
having count(*) > 1

--- Demographics dataset

select member_id, member_age, member_gender, plan_type , enrollment_start_date, enrollment_end_date,
count(*) from members
group by member_id, member_age, member_gender, plan_type , enrollment_start_date, enrollment_end_date
having count(*) > 1

--No duplicate record found.

--- Create a master table by merging the two datasets.

select 
t.claim_id, 
t.member_id, 
t.provider_id, 
t.claim_date, 
t.claim_type, 
t.cpt_code, 
t.icd_code, 
t.billed_amount, 
t.paid_amount,
t.member_age, 
t.member_gender, 
t.plan_type , 
t.enrollment_start_date, 
t.enrollment_end_date
into claim_members
from (
select
c.claim_id, 
c.member_id, 
c.provider_id,
c.claim_date, 
c.claim_type, 
c.cpt_code, 
c.icd_code, 
c.billed_amount,
c.paid_amount,
m.member_age, 
m.member_gender, 
m.plan_type , 
m.enrollment_start_date, 
m.enrollment_end_date
from claims c
join members m
on c.member_id = m.member_id) t

--- Cost Breakdown by Billed and amount paid
select 
	count(distinct member_id) as total_distinct_member,
	count(*) as total_claims,
	round(sum(billed_amount),2) as total_billed,
	round(sum(paid_amount) ,2) as total_paid,
	round(sum(paid_amount)/sum(billed_amount),2) as ratio_paid_billed
from claim_members
where billed_amount > 0
 

-- Rank claim type from the most expensive to the least expensive 

select 
claim_type,
count(*) as total_claims,
round(sum(billed_amount),2) as total_billed,
round(sum(paid_amount) ,2) as total_paid,
rank() over (order by sum(paid_amount) desc) as rk
from claim_members
group by claim_type


--- CPT & ICD Cost Drivers


-- Top 10 CPT codes by total paid amount.

WITH Top10_cpt AS (
    SELECT
        cpt_code,
        ROUND(SUM(billed_amount), 2) AS total_billed,
        ROUND(SUM(paid_amount), 2) AS total_paid,
        RANK() OVER (ORDER BY SUM(paid_amount) DESC) AS rk
    FROM claim_members
    GROUP BY cpt_code
)
SELECT *
FROM Top10_cpt
WHERE rk <= 10;

-- Top ICD by paid amount

WITH Top10_icd AS (
    SELECT
        icd_code,
        ROUND(SUM(billed_amount), 2) AS total_billed,
        ROUND(SUM(paid_amount), 2) AS total_paid,
        RANK() OVER (ORDER BY SUM(paid_amount) DESC) AS rk
    FROM claim_members
    GROUP BY icd_code
)
SELECT *
FROM Top10_icd
WHERE rk <= 10;

-- CPT codes with average amound paid per claim.

select top 10
	cpt_code,
	count(*) as total_claims,
	round(sum(paid_amount),2) as total_paid,
	round(sum(billed_amount), 2) as total_billed,
	round(avg(paid_amount),2) as avg_paid_amount
from claim_members
group by cpt_code
order by avg_paid_amount desc


--- Member Level Analysis

--- Top 5 highest - cost members

select top 5
member_id,
count(*) as total_claim,
round(sum(billed_amount),2) as total_billed,
round(sum(paid_amount),2) as total_paid
into cost_member
from claim_members
group by member_id
order by total_paid desc

select* from cost_member

--Top 5 members by claim types (inpatient, outpatient, ER, Pharmacy)

with top_5 as 
(select member_id
from cost_member)
,
 claims_tab as 
( select 
  member_id,
 claim_type,
 billed_amount,
 paid_amount
 from claim_members)

  select 
  c.member_id,
  c.claim_type,
  c.paid_amount,
  sum(c.paid_amount) over (partition by c.member_id order by c.paid_amount desc) as cum_paid,
  rank () over (partition by c.member_id order by  c.paid_amount desc) as rank_claim_type
  from claims_tab c
  join cost_member t
  on c.member_id = t.member_id
  
 --- Paid ratio by claim_type

select 
claim_type,
round ((sum (paid_amount)/ sum(billed_amount)),2) as paid_ratio
from claim_members
where billed_amount > 0
group by claim_type
order by sum (paid_amount)/ sum(billed_amount) desc


-- Top 10 providers

Select top 10
Provider_id,
count(*) as total_claim,
round(sum(billed_amount),2) as total_billed,
round(sum(paid_amount),2 ) as total_paid,
round ((sum (paid_amount)/ sum(billed_amount)),2) as paid_ratio
from claim_members
where billed_amount > 0
group by Provider_id
order by total_paid desc

--- Amount paid by month/ MoM_Change
select
*,
(total_paid - previous_total_paid) as MoM_change
from (

select
	month (claim_date) as months,
	count(*) as total_claim,
	round(sum(paid_amount),2) as total_paid,
    round(lag(sum(paid_amount)) over (order by month (claim_date)),2) as previous_total_paid
	from claim_members
group by month(claim_date) 

) t

