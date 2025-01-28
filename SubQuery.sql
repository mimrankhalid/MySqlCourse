/*
SQL Course
Subqueries Lesson 1 - Self-Contained Subqueries
 
A self-contained subquery is independent of the outer query
It can be executed stand-alone.
It is executed once and the result is used by the outer query.  (As a result, it is generally more efficient than a correlated subquery
*/
 
/*
This is a scalar subquery returning a single value to use in the WHERE <column> =
List the patient stays with the highest tariff
*/
SELECT
	ps.PatientId
	, ps.Hospital
	, ps.Tariff
FROM
	PatientStay ps
WHERE
	ps.Tariff > (
    SELECT AVG(ps2.Tariff) FROM PatientStay ps2
   );
 
/*
This  subquery returns a one column list to use in the WHERE <column> IN (...)
List the patient stays in Surgery wards
*/
SELECT
	ps.PatientId
	, ps.Hospital
	, ps.Ward
	, ps.Tariff
FROM
	PatientStay ps
WHERE
	ps.Ward IN (
	SELECT DISTINCT Ward FROM dbo.PatientStay WHERE Ward LIKE '%Surgery' 
	);
 
/*
* This subqueries are based on a different table to the outer query
*/
SELECT
	h.Hospital
	, h.[Type]
	, h.Reach
FROM
	DimHospital h 
WHERE h.Hospital IN (
	SELECT DISTINCT ps.Hospital FROM PatientStay ps WHERE ps.Ward = 'Ophthalmology' AND ps.AdmittedDate = '2024-02-26'
	);
 
SELECT
	*
FROM
	PatientStay ps
WHERE
	ps.Hospital IN (
	SELECT h.Hospital FROM DimHospital h WHERE h.[Type] = 'Teaching'
	);
/*
This  subquery returns a table so use in the FROM ...
Calculate budget hospital tariffs as 10% more than actuals
*/
 
SELECT
	hosp.Hospital
	, hosp.HospitalTariff
	, hosp.HospitalTariff * 1.1 AS BudgetTariff
FROM
	(
	SELECT
		ps.Hospital
		, SUM(ps.Tariff) AS HospitalTariff
	FROM
		PatientStay ps
	GROUP BY
		ps.Hospital) hosp;
 



/*
This subquery returns a table so use in the FROM ...
Calculate the total tariff of the 10 most expensive patients 
i.e. those with the highest tariff 
(Ignore the possible complication that there may be some ties.)
*/
SELECT
	SUM(Top10Patients.Tariff) AS Top10Tariff
FROM
	(
	SELECT
		TOP 10
         ps.PatientId
		, ps.Tariff
	FROM
		PatientStay ps
	ORDER BY
		ps.Tariff DESC) Top10Patients;
 

-- CTE
WITH cte
AS(
SELECT TOP 10
	ps.PatientId
	,ps.Tariff
FROM 
	PatientStay ps
ORDER BY 
	ps.Tariff DESC
)

SELECT * FROM cte order by PatientId



/*
Aside: Another way to do first example (scalar subquery) uses SQL variables
*/
DECLARE @MaxTariff AS INT = (
	SELECT MAX(ps2.Tariff) FROM PatientStay ps2
	);
 
SELECT 	@MaxTariff;
 
SELECT
	*
FROM
	PatientStay ps
WHERE
	ps.Tariff = @MaxTariff;