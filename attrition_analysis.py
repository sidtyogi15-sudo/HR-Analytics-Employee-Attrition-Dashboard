"""
HR Analytics - Employee Attrition Analysis
==========================================
Analyzes a 1,470-record HR dataset to identify key drivers of employee attrition.
"""

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# ─────────────────────────────────────────
# 1. LOAD DATA
# ─────────────────────────────────────────
df = pd.read_csv("data/hr_dataset_sample.csv")

print("=== Dataset Overview ===")
print(f"Shape: {df.shape}")
print(df.head())
print(df.dtypes)

# ─────────────────────────────────────────
# 2. DATA CLEANING
# ─────────────────────────────────────────
# Drop irrelevant/constant columns
cols_to_drop = ["EmployeeCount", "Over18", "StandardHours"]
df.drop(columns=[c for c in cols_to_drop if c in df.columns], inplace=True)

# Convert Attrition to binary
df["AttritionBinary"] = df["Attrition"].apply(lambda x: 1 if x == "Yes" else 0)

# Handle missing values
df.fillna(df.median(numeric_only=True), inplace=True)

print("\n=== Null Values After Cleaning ===")
print(df.isnull().sum().sum(), "nulls remaining")

# ─────────────────────────────────────────
# 3. OVERALL ATTRITION RATE
# ─────────────────────────────────────────
overall_rate = df["AttritionBinary"].mean() * 100
print(f"\n=== Overall Attrition Rate: {overall_rate:.1f}% ===")

# ─────────────────────────────────────────
# 4. ATTRITION BY DEPARTMENT
# ─────────────────────────────────────────
dept_attrition = (
    df.groupby("Department")["AttritionBinary"]
    .agg(["mean", "count"])
    .rename(columns={"mean": "AttritionRate", "count": "Employees"})
    .sort_values("AttritionRate", ascending=False)
)
dept_attrition["AttritionRate"] = (dept_attrition["AttritionRate"] * 100).round(1)

print("\n=== Attrition by Department ===")
print(dept_attrition)

# ─────────────────────────────────────────
# 5. ATTRITION BY TENURE (YearsAtCompany)
# ─────────────────────────────────────────
df["TenureGroup"] = pd.cut(
    df["YearsAtCompany"],
    bins=[0, 2, 5, 10, 40],
    labels=["<2 yrs", "2-5 yrs", "5-10 yrs", "10+ yrs"]
)

tenure_attrition = (
    df.groupby("TenureGroup", observed=True)["AttritionBinary"]
    .mean()
    .mul(100)
    .round(1)
    .reset_index()
    .rename(columns={"AttritionBinary": "AttritionRate (%)"})
)

print("\n=== Attrition by Tenure Group ===")
print(tenure_attrition)

# ─────────────────────────────────────────
# 6. HIGH-RISK SEGMENT: Sales + <2 yrs tenure
# ─────────────────────────────────────────
high_risk = df[
    (df["Department"] == "Sales") &
    (df["YearsAtCompany"] < 2)
]
high_risk_rate = high_risk["AttritionBinary"].mean() * 100
print(f"\n=== High-Risk Segment (Sales, <2 yrs tenure) ===")
print(f"Attrition Rate: {high_risk_rate:.1f}%  |  Employees: {len(high_risk)}")

# ─────────────────────────────────────────
# 7. ATTRITION BY JOB SATISFACTION
# ─────────────────────────────────────────
if "JobSatisfaction" in df.columns:
    satisfaction_attrition = (
        df.groupby("JobSatisfaction")["AttritionBinary"]
        .mean()
        .mul(100)
        .round(1)
        .reset_index()
        .rename(columns={"AttritionBinary": "AttritionRate (%)"})
    )
    print("\n=== Attrition by Job Satisfaction (1=Low, 4=High) ===")
    print(satisfaction_attrition)

# ─────────────────────────────────────────
# 8. SALARY BAND ANALYSIS
# ─────────────────────────────────────────
if "MonthlyIncome" in df.columns:
    df["SalaryBand"] = pd.cut(
        df["MonthlyIncome"],
        bins=[0, 3000, 6000, 10000, 50000],
        labels=["Low", "Mid", "High", "Very High"]
    )
    salary_attrition = (
        df.groupby("SalaryBand", observed=True)["AttritionBinary"]
        .mean()
        .mul(100)
        .round(1)
        .reset_index()
        .rename(columns={"AttritionBinary": "AttritionRate (%)"})
    )
    print("\n=== Attrition by Salary Band ===")
    print(salary_attrition)

# ─────────────────────────────────────────
# 9. VISUALIZATIONS
# ─────────────────────────────────────────
sns.set_style("whitegrid")
fig, axes = plt.subplots(2, 2, figsize=(14, 10))
fig.suptitle("HR Attrition Analysis", fontsize=16, fontweight="bold")

# Plot 1: Attrition by Department
axes[0, 0].bar(dept_attrition.index, dept_attrition["AttritionRate"], color=["#e74c3c", "#3498db", "#2ecc71"])
axes[0, 0].set_title("Attrition Rate by Department (%)")
axes[0, 0].set_ylabel("Attrition Rate (%)")

# Plot 2: Attrition by Tenure
axes[0, 1].bar(tenure_attrition["TenureGroup"], tenure_attrition["AttritionRate (%)"], color="#e67e22")
axes[0, 1].set_title("Attrition Rate by Tenure Group (%)")
axes[0, 1].set_ylabel("Attrition Rate (%)")

# Plot 3: Job Satisfaction
if "JobSatisfaction" in df.columns:
    axes[1, 0].bar(satisfaction_attrition["JobSatisfaction"].astype(str),
                   satisfaction_attrition["AttritionRate (%)"], color="#9b59b6")
    axes[1, 0].set_title("Attrition Rate by Job Satisfaction")
    axes[1, 0].set_ylabel("Attrition Rate (%)")
    axes[1, 0].set_xlabel("Satisfaction Score (1=Low, 4=High)")

# Plot 4: Salary Band
if "MonthlyIncome" in df.columns:
    axes[1, 1].bar(salary_attrition["SalaryBand"], salary_attrition["AttritionRate (%)"], color="#1abc9c")
    axes[1, 1].set_title("Attrition Rate by Salary Band")
    axes[1, 1].set_ylabel("Attrition Rate (%)")

plt.tight_layout()
plt.savefig("assets/attrition_analysis.png", dpi=150)
print("\n✅ Charts saved to assets/attrition_analysis.png")
plt.show()
