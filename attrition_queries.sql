-- ============================================================
-- HR Analytics: Employee Attrition Queries
-- Dataset: IBM HR Analytics (1,470 records)
-- ============================================================

-- ─────────────────────────────────────────
-- 1. OVERALL ATTRITION RATE
-- ─────────────────────────────────────────
SELECT
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees;


-- ─────────────────────────────────────────
-- 2. ATTRITION RATE BY DEPARTMENT
-- ─────────────────────────────────────────
SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees
GROUP BY Department
ORDER BY AttritionRate_Pct DESC;


-- ─────────────────────────────────────────
-- 3. HIGH-RISK SEGMENT: Sales + <2 Years Tenure
-- ─────────────────────────────────────────
SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees
WHERE Department = 'Sales'
  AND YearsAtCompany < 2
GROUP BY Department;


-- ─────────────────────────────────────────
-- 4. ATTRITION BY TENURE GROUP
-- ─────────────────────────────────────────
SELECT
    CASE
        WHEN YearsAtCompany < 2  THEN '< 2 Years'
        WHEN YearsAtCompany < 5  THEN '2–5 Years'
        WHEN YearsAtCompany < 10 THEN '5–10 Years'
        ELSE '10+ Years'
    END AS TenureGroup,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees
GROUP BY TenureGroup
ORDER BY AttritionRate_Pct DESC;


-- ─────────────────────────────────────────
-- 5. ATTRITION BY JOB SATISFACTION LEVEL
-- ─────────────────────────────────────────
SELECT
    JobSatisfaction,
    CASE JobSatisfaction
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Very High'
    END AS SatisfactionLabel,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;


-- ─────────────────────────────────────────
-- 6. ATTRITION BY SALARY BAND
-- ─────────────────────────────────────────
SELECT
    CASE
        WHEN MonthlyIncome < 3000  THEN 'Low (<3K)'
        WHEN MonthlyIncome < 6000  THEN 'Mid (3K–6K)'
        WHEN MonthlyIncome < 10000 THEN 'High (6K–10K)'
        ELSE 'Very High (10K+)'
    END AS SalaryBand,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees
GROUP BY SalaryBand
ORDER BY AttritionRate_Pct DESC;


-- ─────────────────────────────────────────
-- 7. ATTRITION BY AGE GROUP & GENDER
-- ─────────────────────────────────────────
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age < 35 THEN '25–34'
        WHEN Age < 45 THEN '35–44'
        ELSE '45+'
    END AS AgeGroup,
    Gender,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees
GROUP BY AgeGroup, Gender
ORDER BY AgeGroup, Gender;


-- ─────────────────────────────────────────
-- 8. DEPARTMENT + TENURE CROSS-TAB (for Power BI input)
-- ─────────────────────────────────────────
SELECT
    Department,
    CASE
        WHEN YearsAtCompany < 2  THEN '< 2 Years'
        WHEN YearsAtCompany < 5  THEN '2–5 Years'
        WHEN YearsAtCompany < 10 THEN '5–10 Years'
        ELSE '10+ Years'
    END AS TenureGroup,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1
    ) AS AttritionRate_Pct
FROM hr_employees
GROUP BY Department, TenureGroup
ORDER BY Department, AttritionRate_Pct DESC;
