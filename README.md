# Healthcare Analytics in R

## 📌 Overview

This project uses real-world data to analyze healthcare costs and financial risk using R. I worked with two datasets to:

- Predict medical charges based on age, smoking, BMI, and more
- Understand the risk of loan default among patients, which could impact healthcare access or affordability

Both parts are connected through the lens of healthcare analytics.

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
│   └── analysis output.docx
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

- Built multiple linear regression models to estimate healthcare costs
- Used log transformation to improve prediction accuracy
- Modeled loan default using logistic regression, decision trees, and random forest
- Exported the results and interpretations to a Word document

## 📄 Outputs

- Final write-up: `docs/analysis output.docx`
- All analysis code: `scripts/healthcare_analysis.R`


  
