# 📊 HR Analytics & Employee Attrition Dashboard

> Identifying key drivers of employee attrition using Python, SQL, and Power BI — enabling data-driven workforce retention strategies.

---

## 🔍 Project Overview

This project analyzes a **1,470-record HR dataset** to uncover patterns behind employee attrition. By combining data wrangling in Python, structured querying in SQL, and interactive visualization in Power BI, the project delivers actionable insights for HR teams.

### Key Finding
> Employees in the **Sales department with less than 2 years of tenure** had the highest attrition rate (~40%), providing a clear signal for targeted retention efforts.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **Python (Pandas)** | Data cleaning, wrangling, EDA |
| **SQL** | Querying and aggregating attrition metrics |
| **Power BI** | Multi-page interactive dashboard |

---

## 📁 Project Structure

```
hr-attrition-dashboard/
│
├── data/
│   └── hr_dataset_sample.csv        # Sample dataset (first 100 rows)
│
├── python/
│   └── attrition_analysis.py        # Data wrangling & EDA script
│
├── sql/
│   └── attrition_queries.sql        # SQL queries for attrition metrics
│
├── powerbi/
│   └── dashboard_preview.md         # Dashboard description & screenshots guide
│
├── assets/
│   └── dashboard_screenshot.png     # (Add your Power BI screenshot here)
│
└── README.md
```

---

## 📈 Dashboard Features

- **Multi-page Power BI dashboard** with slicers for:
  - Department
  - Age Group
  - Gender
- Drill-through attrition patterns per business unit
- Benchmark performance across departments
- KPI cards: Attrition Rate, Avg Tenure, Satisfaction Score

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/hr-attrition-dashboard.git
cd hr-attrition-dashboard
```

### 2. Install Python dependencies
```bash
pip install pandas matplotlib seaborn
```

### 3. Run the analysis script
```bash
python python/attrition_analysis.py
```

### 4. Explore SQL queries
Run `sql/attrition_queries.sql` in your preferred SQL client (MySQL, PostgreSQL, or SQLite).

### 5. View the Power BI Dashboard
Open the `.pbix` file in Power BI Desktop (add your file to the `powerbi/` folder).

---

## 📊 Key Insights

| Segment | Attrition Rate |
|--------|---------------|
| Sales dept, < 2 years tenure | ~40% |
| Overall company average | ~16% |
| High job satisfaction employees | ~7% |

---

## 📌 Future Improvements

- Integrate live HR data via API
- Add predictive attrition model using Scikit-learn
- Automate Power BI refresh with Python + Power BI REST API

---

## 🙋 Author

**Your Name**  
[LinkedIn](https://linkedin.com/in/yourprofile) • [GitHub](https://github.com/yourusername)

---

## 📄 License

This project is licensed under the MIT License.
