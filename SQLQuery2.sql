-- Total Number of Patients

SELECT 
	COUNT(DISTINCT patient_id)
FROM Patient

SELECT 
	COUNT(DISTINCT claim_id)
FROM claims

-- Claims Count per Patient
SELECT 
	patient_id,
	COUNT(*) AS claims_count
FROM claims
GROUP BY patient_id
ORDER BY claims_count DESC

-- Total Payment Amount per Patient
SELECT
	c.patient_id,
	SUM(p.payment_amount) AS total_amount
FROM claims c JOIN payments p 
ON c.claim_id = p.claim_id
GROUP BY c.patient_id
ORDER BY total_amount DESC;

-- Total Claims per Provider
SELECT
	p.provider_id,
	provider_name,
	COUNT(claim_id) AS total_claims
FROM providers p 
JOIN claims c
ON p.provider_id = c.provider_id
GROUP BY p.provider_id,
	provider_name


-- Average Claim Amount per Provider

SELECT 
	provider_id,
	AVG(claim_amount) AS average_claim
FROM claims
GROUP BY provider_id
ORDER BY average_claim DESC

-- Payments Breakdown per Provider

SELECT c.provider_id, SUM(p.payment_amount) AS total_payments
FROM claims c
JOIN payments p ON c.claim_id = p.claim_id
GROUP BY c.provider_id
ORDER BY total_payments DESC;

-- Number of Payments per Claim
SELECT
	claim_id,
	COUNT(*) AS number_of_payments
FROM payments
GROUP BY claim_id
ORDER BY number_of_payments DESC;

--  Patients with No Claims (if possible)

SELECT 
	p.first_name,
	p.patient_id,
	p.last_name,
	c.claim_id
FROM patient p
LEFT JOIN claims c ON p.patient_id = c.patient_id
WHERE c.claim_id IS NULL;

-- Most Recent Payment per Claim
SELECT
claim_id,
payment_id,
payment_amount,
MAX(payment_date) AS most_recent_payment
FROM Payments
GROUP BY claim_id,
payment_id,
payment_amount
ORDER BY most_recent_payment DESC

--  CTE + Row Number: Rank Patients by Total Payment Amount
WITH payment_rank AS(
SELECT
	c.patient_id,
	SUM(payment_amount) AS total_payment_amount
FROM claims c 
JOIN payments p ON c.claim_id = p.claim_id
GROUP BY c.patient_id
)
SELECT 
pr.patient_id,
pr.total_payment_amount,
ROW_NUMBER() OVER(ORDER BY total_payment_amount DESC) AS rank_payment
FROM payment_rank pr
ORDER BY rank_payment


-- CTE + Running Total of Payments Over Time

WITH payments_by_date AS (
    SELECT payment_date, SUM(payment_amount) AS daily_payments
    FROM payments
    GROUP BY payment_date
)
SELECT payment_date, daily_payments,
       SUM(daily_payments) OVER (ORDER BY payment_date) AS running_total
FROM payments_by_date
ORDER BY payment_date;


-- Lag Function: Compare Each Payment to the Previous One
SELECT
	payment_id,
	payment_amount,
	LAG(payment_amount) OVER(ORDER BY payment_id) AS previous_payment,
	payment_amount - LAG(payment_amount) OVER(ORDER BY payment_id) AS 'difference'
FROM payments;

-- Rank Providers by Average Claim Amount
SELECT 
	provider_id,
	AVG(claim_amount) AS avg_claim,
    RANK() OVER (ORDER BY AVG(claim_amount) DESC) AS claim_rank
FROM claims
GROUP BY provider_id
ORDER BY claim_rank;

-- CTE + Dense Rank: Top 5 Patients by Total Payments
WITH top_five AS (
SELECT
	c.patient_id,
	SUM(p.payment_amount) AS total_payment
FROM claims c 
JOIN payments p ON c.claim_id = p.claim_id
GROUP BY c.patient_id
)
SELECT TOP 5
	patient_id,
	total_payment,
	DENSE_RANK() OVER(ORDER BY total_payment DESC) AS r5
FROM top_five
ORDER BY r5

-- Claims per Patient with Percent of Total
-- See each patient’s claims as a percentage of the total claims in the system.
SELECT
	p.patient_id,
	c.claim_id
FROM patient p
JOIN claims c ON p.patient_id = c.patient_id

















































































