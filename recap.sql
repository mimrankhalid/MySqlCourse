/*
Foundation Recap Exercise
 
Use the table PatientStay.  
This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024
*/
 
SELECT
	*
FROM
	PatientStay ps ;
 
--Query 1: 

SELECT 
    * 
FROM 
    PatientStay 
WHERE 
    Hospital IN('Oxleas','PRUH') 
AND AdmittedDate LIKE '2024-02%' AND Ward='Day Surgery'


--Query 2

SELECT 
    PatientId
    ,AdmittedDate
    ,DischargeDate
    ,Hospital
    ,Ward
    ,DATEDIFF(DAY, AdmittedDate, DischargeDate) AS LengthOfStay
 FROM 
    PatientStay PS
ORDER BY 
    AdmittedDate DESC, 
    PatientId DESC

/*
1. List the patients -
a) in the Oxleas or PRUH hospitals and
b) admitted in February 2024
c) only the Surgery wards


 
2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.
3. Order results by AdmittedDate (latest first) then PatientID column (high to low)
4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.
*/
 
-- Write the SQL statement here
 
 
/*
5. How many patients has each hospital admitted? 
6. How much is the total tarriff for each hospital?
7. List only those hospitals that have admitted over 10 patients
8. Order by the hospital with most admissions first
*/
 
SELECT 
    PS.Hospital
    ,COUNT(*) AS TotalPatients
 FROM 
    PatientStay PS
GROUP BY PS.Hospital


SELECT 
    PS.Hospital
    ,COUNT(*) AS NumberofPatients
    ,SUM(PS.Tariff) AS TotalTarrif
FROM 
    PatientStay PS
GROUP BY PS.Hospital


SELECT 
    PS.Hospital
    ,COUNT(*) AS NumberofPatients
    ,SUM(PS.Tariff) AS TotalTarrif
FROM 
    PatientStay PS
GROUP BY PS.Hospital


SELECT 
    PS.Hospital
    ,COUNT(*) AS NumberofPatients
    ,SUM(PS.Tariff) AS TotalTarrif
FROM 
    PatientStay PS
GROUP BY PS.Hospital
HAVING COUNT(*) >=10



SELECT 
    Hospital
    ,PatientId
 FROM 
    PatientStay PS
where SUM(PatientId) > 10



-- Write the SQL statement here