# Power BI Dashboard — Overview

## Dashboard Pages

### Page 1: Executive Summary
- **KPI Cards**: Overall Attrition Rate | Total Employees | Avg Tenure | Avg Job Satisfaction
- **Donut Chart**: Attrition vs Active Employees
- **Bar Chart**: Attrition by Department
- **Slicers**: Department | Gender | Age Group

### Page 2: Attrition Deep Dive
- **Heatmap Matrix**: Department × Tenure Group attrition rates
- **Line Chart**: Attrition Rate over Years at Company
- **Bar Chart**: Attrition by Job Satisfaction Level (1–4)
- **Clustered Bar**: Attrition by Salary Band

### Page 3: Risk Segmentation
- **Scatter Plot**: Monthly Income vs Attrition (colored by Department)
- **Treemap**: Headcount at Risk by Department
- **Table**: Top 10 High-Risk Employee Profiles
- **Card**: High-Risk Segment Rate — Sales, <2 yrs tenure (~40%)

---

## DAX Measures Used

```dax
Attrition Rate =
DIVIDE(
    COUNTROWS(FILTER(hr_employees, hr_employees[Attrition] = "Yes")),
    COUNTROWS(hr_employees),
    0
)

Attrition Count =
COUNTROWS(FILTER(hr_employees, hr_employees[Attrition] = "Yes"))

Avg Monthly Income =
AVERAGE(hr_employees[MonthlyIncome])

Avg Job Satisfaction =
AVERAGE(hr_employees[JobSatisfaction])

High Risk Count =
CALCULATE(
    COUNTROWS(hr_employees),
    hr_employees[Department] = "Sales",
    hr_employees[YearsAtCompany] < 2,
    hr_employees[Attrition] = "Yes"
)
```

---

## How to Reproduce
1. Import `data/hr_dataset_sample.csv` (or the full IBM HR dataset) into Power BI Desktop
2. Use **Power Query** to add calculated columns:
   - `TenureGroup` (bucketed `YearsAtCompany`)
   - `SalaryBand` (bucketed `MonthlyIncome`)
   - `AgeGroup` (bucketed `Age`)
3. Create the DAX measures above
4. Build visuals as described per page
5. Add slicers: Department, Gender, AgeGroup

---

## Dataset Source
IBM HR Analytics Employee Attrition & Performance  
Available on [Kaggle](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
