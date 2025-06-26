
--  Payment Trend: Provider vs Patient (Dual Running Totals)
WITH patient_trend AS (
SELECT
		pp.claim_id,
		pp.patient_id AS patient_id,
		pp.payment_date AS patient_payment_date,
		pp.payment_amount AS patient_payment_amount,
		SUM(pp.payment_amount) OVER(PARTITION BY pp.patient_id ORDER BY pp.payment_date) AS patient_running_total
FROM patient_payments pp
),
provider_trend AS (
SELECT
		c.claim_id,
		c.provider_id AS provider_id,
		pay.payment_date AS provider_payment_date,
		pay.payment_amount AS provider_payment_amount,
		SUM(pay.payment_amount) OVER(PARTITION BY c.provider_id ORDER BY pay.payment_date) AS provider_running_total
FROM claims c 
JOIN payments pay ON c.claim_id = pay.claim_id
)
SELECT 
    patient_id,
    patient_payment_date,
    patient_payment_amount,
    patient_running_total,
    provider_id,
    provider_payment_date,
    provider_payment_amount,
    provider_running_total,
    CASE 
        WHEN patient_id IS NOT NULL AND provider_id IS NOT NULL THEN 'Both'
        WHEN patient_id IS NOT NULL THEN 'Patient Only'
        WHEN provider_id IS NOT NULL THEN 'Provider Only'
        ELSE 'Unclassified'
    END AS payment_status
FROM patient_trend pt
FULL OUTER JOIN provider_trend pv ON pt.claim_id = pv.claim_id;





















































