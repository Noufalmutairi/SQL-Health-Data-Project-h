-- Desciptive Statistics --
SELECT 
    COUNT(DISTINCT region) AS Number_of_regions,
    SUM(patients_2019 + patients_2020 + patients_2021 + patients_2022) AS total_patients,
    ROUND(AVG(patients_2019 + patients_2020 + patients_2021 + patients_2022),
            0) AS average_patients,
    MIN(patients_2019 + patients_2020 + patients_2021 + patients_2022) AS min_patients,
    MAX(patients_2019 + patients_2020 + patients_2021 + patients_2022) AS max_patients,
    ROUND(STDDEV(patients_2019 + patients_2020 + patients_2021 + patients_2022),
            0) AS patients_stddev
FROM
    l_region;
    
    
    
-- Clculate the average and standard deviation for each year --
SELECT 
    ROUND(AVG(p_2019), 0) AS average_2019,
    ROUND(STDDEV(p_2019), 0) AS stddev_2019,
    ROUND(AVG(p_2020), 0) AS average_2020,
    ROUND(STDDEV(p_2020), 0) AS stddev_2020,
    ROUND(AVG(p_2021), 0) AS average_2021,
    ROUND(STDDEV(p_2021), 0) AS stddev_2021,
    ROUND(AVG(p_2022), 0) AS average_2022,
    ROUND(STDDEV(p_2022), 0) AS stddev_2022
FROM
    region;
    
    
    
    
-- Sort the regions based on the total number of patients in descending order --
SELECT 
    region, total
FROM
    region
ORDER BY total DESC;


-- Retrieve the number of regions --
SELECT 
    COUNT(DISTINCT region) AS number_regions
FROM
    region;




-- Find the five regions with the highest total of patients --
SELECT 
    region, total_patients
FROM
    region
ORDER BY total DESC
LIMIT 5;



-- Find the percentage change in patients numbers for each region between 2019 and 2022 -- 
SELECT 
    Region,
    patients_2019,
    patients_2022,
    CONCAT(ROUND((patients_2022 - patients_2019) / patients_2019 * 100,
                    0),
            '%') AS percentage_change,
    CASE
        WHEN (patients_2022 - patients_2019) > 0 THEN 'increase'
        ELSE 'decrease'
    END AS change_type
FROM
    region
ORDER BY percentage_change DESC;



-- the total number of patients for each age group --
SELECT 
    Age_group,
    SUM(patients_2019 + patients_2020 + patients_2021 + patients_2022) AS total_patients
FROM
    agegroup
GROUP BY Age_group;



-- Retrieve the age groups with the highest number of patients for each year --
SELECT 
    '2019' AS year, Age_group, patients_2019 AS total_patients
FROM
    agegroup
WHERE
    patients_2019 = (SELECT 
            MAX(patients_2019)
        FROM
            agegroup) 
UNION SELECT 
    '2020' AS year, Age_group, patients_2020 AS total_patients
FROM
    agegroup
WHERE
    patients_2020 = (SELECT 
            MAX(patients_2020)
        FROM
            agegroup) 
UNION SELECT 
    '2021' AS year, Age_group, patients_2021 AS total_patients
FROM
    agegroup
WHERE
    patients_2021 = (SELECT 
            MAX(patients_2021)
        FROM
            agegroup) 
UNION SELECT 
    '2022' AS year, Age_group, patients_2022 AS total_patients
FROM
    agegroup
WHERE
    patients_2022 = (SELECT 
            MAX(patients_2022)
        FROM
            agegroup);
 
 
 -- Retrieve the age groups with the lowest number of patients for each year --
SELECT 
    '2019' AS year, Age_group, patients_2019 AS total_patients
FROM
    agegroup
WHERE
    patients_2019 = (SELECT 
            MIN(patients_2019)
        FROM
            agegroup) 
UNION SELECT 
    '2020' AS year, Age_group, patients_2020 AS total_patients
FROM
    agegroup
WHERE
    patients_2020 = (SELECT 
            MIN(patients_2020)
        FROM
            agegroup) 
UNION SELECT 
    '2021' AS year, Age_group, patients_2021 AS total_patients
FROM
    agegroup
WHERE
    patients_2021 = (SELECT 
            MIN(patients_2021)
        FROM
            agegroup) 
UNION SELECT 
    '2022' AS year, Age_group, patients_2022 AS total_patients
FROM
    agegroup
WHERE
    patients_2022 = (SELECT 
            MIN(patients_2022)
        FROM
            agegroup);
 
 
 -- Calculate the total number of females and males across all years --
SELECT 
    SUM(female) AS total_female, SUM(male) AS total_males
FROM
    gender;



-- Calculate the average number of females and males across all years --
SELECT 
    AVG(female) AS average_females, AVG(male) AS average_males
FROM
    gender;



-- Calculate the percentage of females and males for each year -- 
SELECT 
    year,
    CONCAT(ROUND((female / (female + male)) * 100, 0),
            '%') AS percentage_females,
    CONCAT(CEIL((male / (female + male)) * 100),
            '%') AS percentage_males
FROM
    gender;
