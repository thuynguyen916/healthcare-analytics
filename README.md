# Healthcare Analytics in R

## 📌 Overview

This project uses real-world data to analyze healthcare costs and financial risks using R. I worked with two datasets to:

- Predict medical charges based on age, smoking, BMI, and more
- Understand the risk of loan default among people from different backgrounds.

## 📁 Project Structure

```
healthcare-analytics/
├── data/
│   ├── raw/
│   │   ├── insurance.csv
│   │   └── loan_default_dataset.csv
│   └── description/
│       └── loan_default_dataset_description.docx
├── docs/
│   └── healthcare-loan-analysis.pdf
├── scripts/
│   └── healthcare_analysis.R
├── healthcare_analysis.Rproj
└── README.md
```

## 🚀 How to Run the Code

1. **Clone this repo**

```bash
git clone https://github.com/thuynguyen916/healthcare-analytics.git
```

2. **Open the project in RStudio**

Open the file: `healthcare_analysis.Rproj`

3. **Install the required R packages**

```r
install.packages(c("tidyverse", "caTools", "rpart", "rpart.plot", "randomForest", "stargazer", "corrplot", "car"))
```

4. **Run the code**

Open the file `scripts/healthcare_analysis.R` and run the sections step by step.

## ✅ What I Did

- Built multiple linear regression models to estimate healthcare costs using age, smoking status, BMI, and parental status

- Applied log transformation and alternative predictors (e.g., log(age)) to improve model interpretability and predictive accuracy

- Estimated and compared healthcare cost predictions under different scenarios (e.g., BMI of 19 vs. 27, age progression)

- Modeled loan default risk using multiple approaches: linear regression, logistic regression, and classification models (decision trees, random forest)

- Evaluated model performance with metrics like accuracy and used variable selection to reduce multicollinearity

- Exported model results and interpretations to a PDF report

## 📄 Outputs

- Final write-up: `docs/healthcare-loan-analysis.pdf`
- All analysis code: `scripts/healthcare_analysis.R`

---

**Author:** Thuy Nguyen  
**Term:** Fall 2024  
**Project Type:** Individual school project (DePaul University)  
**Tools:** R  
  
