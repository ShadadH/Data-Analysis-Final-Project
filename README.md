# 📉 Investigating Okun’s Law in the United States  
*By Adreeta Tasneem Raya, Shadad Hossain, Anoosh Jamshed, Abdur Rahman*

This project investigates the stability and validity of **Okun’s Law** in the U.S. economy between 1980 and 2020, with a specific focus on whether **unemployment benefits** distort the classic inverse relationship between unemployment and real GDP.

---

## 🔍 Research Question

> **Do unemployment benefits affect the relationship between unemployment and real GDP in the United States?**

Okun’s Law traditionally posits that increases in unemployment correspond to decreases in a country’s GDP. However, this relationship appears to weaken in recent decades. We explore whether unemployment insurance, along with structural labor factors like **minimum wage** and **labor compensation share**, could explain these deviations.

---

## 📚 Summary

- **Years covered:** 1980–2020  
- **Dependent Variable:** Real GDP  
- **Key Explanatory Variables:**
  - Unemployment Rate
  - Unemployment Benefits
  - Consumption
  - Minimum Wage
  - Labor Compensation Share in GDP
  - Recession (dummy)

---

## 📊 Methodology Overview

We estimate multiple regression models using macroeconomic data, iteratively improving model specification to address:

- **Endogeneity**
- **Multicollinearity**
- **Heteroskedasticity**
- **Omitted variable bias**
- **Non-linearities**

We test both **levels and first-differences** of variables and examine the **time-lag** between changes in unemployment and their effects on GDP. The final model explains over 74% of the variation in ΔRGDP and supports the existence of a modified Okun’s relationship.

---

## 📈 Final Model (Change-Based)

```math
ΔRGDP = β₀ + β₁(ΔUnemployment Rate) + β₂(ΔUnemployment Benefits) + 
        β₃(ΔConsumption) + β₄(Min Wage) + β₅(Labor Share) + 
        β₆(Recession Dummy) + ε
```

### Key Findings

- **Change in Unemployment Rate:** Negative and significant  
- **Change in Unemployment Benefits:** Positive and significant  
- **Change in Consumption:** Positive and significant  
- **Labor Share:** Positive and significant  
- **Minimum Wage:** Insignificant  
- **Recession Years:** Negative impact on GDP

---

## 📂 Dataset

Collected from the [St. Louis Fed FRED](https://fred.stlouisfed.org/) database, including:

| Variable                             | Source | Units |
|-------------------------------------|--------|-------|
| Real GDP                            | FRED   | Billion USD |
| Unemployment Rate                   | FRED   | % |
| Unemployment Benefits               | FRED   | Billion USD |
| Personal Consumption Expenditures  | FRED   | Billion USD |
| Labor Compensation Share in GDP     | FRED   | Proportion |
| Federal Minimum Wage                | FRED   | USD/hour |
| Recession Dummy                     | NBER   | 0/1 |

---

## 📄 File Contents

```
📁 data/
  └── okun_dataset.csv                # Main dataset (processed or raw)
📁 figures/
  ├── regression_results.png         # Summary table
  ├── residuals_plots.png            # Residual-vs-fitted plots
  └── VIF_output.png                 # Multicollinearity diagnostics
📁 scripts/
  └── final_model_analysis.R         # Clean regression code
📄 final_report.pdf                   # Full writeup with results and theory
📄 README.md                          # Project summary (this file)
```

---

## 📌 Conclusion

- Okun’s Law holds in our data **only when using changes** in unemployment and GDP.
- **Unemployment benefits positively influence GDP** by sustaining consumption, even when unemployment rises.
- **Labor compensation share** is a more accurate proxy for worker bargaining power than minimum wage alone.
- Future work could explore quarterly data or state-level disaggregation to test these patterns more robustly.

---

## 👩‍🏫 Authors

- Adreeta Tasneem Raya  
- Shadad Hossain  
- Anoosh Jamshed  
- Abdur Rahman  

**Date:** December 2022

---

## 📬 Contact

For questions or collaboration, please contact:  
📧 shadad.hossain@nyu.edu
