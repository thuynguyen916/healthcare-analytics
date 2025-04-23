# ECO 520
# Business Analytics II
# Assignment 3
# Prof. Peter Bondarenko
# Thuy Chinh Van Nguyen

# Load the necessary libraries into the R environment
# Each library provides specific functions for data analysis and visualization.
library(ggplot2)     # For creating various types of plots
library(stargazer)   # For displaying regression results in a nice format
library(corrplot)    # For visualizing correlation matrices
library(car)         # For calculating Variance Inflation Factor (VIF) to check multicollinearity
library(dplyr)       # For data manipulation and transformation
library(tidyr)       # For tidying data (cleaning and organizing it)
library(readr)
library(caTools)

### Question 1
## 1.1

# Import the insurance dataset
insurance <- read_csv("insurance.csv")

# Construct a new variable called isSmoker 
insurance$isSmoker <- ifelse(insurance$smoker == "yes", 1,0)

# Construct a new variable called healthyBMI
insurance$healthyBMI <- ifelse(insurance$bmi >= 18.5 & insurance$bmi< 25, 1,0)

# Construct a new variable called hasChildren
insurance$hasChildren <- ifelse(insurance$children != 0, 1,0)

# Create a new dataset with new variablse
insurance <- insurance

## 1.2
# Create a multiple regression model
mlr1_model <- lm(charges ~ age+ isSmoker + healthyBMI + hasChildren, data = insurance)

## 1.3
# Export this multiple regression into a word doc using stargazer
library(stargazer)

stargazer(mlr1_model,
          type= "html",
          out = "1st Multiple Regression model.doc")

## 1.4
# Create an example dataset to calculate the estimated average medical cost for a 40yr old, non-smoker individual with 1 child and a healthy BMI (BMI =19)
example1_data <- data.frame(
  age = 40,
  isSmoker = 0, # smoker = 1 and non-smoker = 0
  healthyBMI = 1, # healthy BMI = 1 and non healthy BMO = 0
  hasChildren = 1 # with any children = 1 and no children = 0
)

# Predict the charges for the example
pred1_charges <- predict(mlr1_model, example1_data)

# Print the prediction for question 1.4
print("Estimated average medical costs for a 40 year-old, non-smoker individual with one child and a BMI of 19:")
print(pred1_charges)

## 1.5
# Create another example dataset to calculate the estimated average medical cost for a 40yr old, non-smoker individual with 1 child and a healthy BMI (BMI =19)
example2_data <- data.frame(
  age = 40,
  isSmoker = 0, # smoker = 1 and non-smoker = 0
  healthyBMI = 0, # healthy BMI = 1 and non healthy BMO = 0
  hasChildren = 1 # with any children = 1 and no children = 0
)

# Predict the charges for the example
pred2_charges <- predict(mlr1_model, example2_data)

# Print the prediction for question 1.5
print("Estimated average medical costs for a 40 year-old, non-smoker individual with one child and a BMI of 27:")
print(pred2_charges)

## 1.6 
# Create a second multiple linear regression with log transformation of charges being the dependent variable:
mlr2_model <- lm(log(charges)~ age + isSmoker + healthyBMI + hasChildren, data = insurance)

## 1.7
# Export to a word doc using stargazer
stargazer(
mlr2_model,
text= "Multi linear regression with log(charges) being a dependent variable",
type= "html",
out = "2nd Multiple Regression model.doc")

## 1.8 
# Predict the charges for the example
pred3_charges <- predict(mlr2_model, example1_data)

# Print the prediction for question 1.8
print("Estimated average medical costs for a 40 year-old, non-smoker individual with one child and a BMI of 19:")
print(exp(pred3_charges))

## 1.9
# Predict the charges for the example
pred4_charges <- predict(mlr2_model, example2_data)

# Print the prediction for question 1.9
print("Estimated average medical costs for a 40 year-old, non-smoker individual with one child and a BMI of 27:")
print(exp(pred4_charges))

## 1.10
# Create a sample of individual to calculate average medical costs for a 50 year-old, non-smoker individual with one child and a BMI of 19
example3_data <- data.frame(
  age = 50,
  isSmoker = 0, # smoker = 1 and non-smoker = 0
  healthyBMI = 1, # healthy BMI = 1 and non healthy BMO = 0
  hasChildren = 1 # with any children = 1 and no children = 0
)

# Predict the charges for the example
pred5_charges <- predict(mlr2_model, example3_data)

# Print the prediction for medical charges for question 1.10
print("Estimated average medical costs for a 50 year-old, non-smoker individual with one child and a BMI of 19:")
print(exp(pred5_charges))

# Calculate the percentage difference in charges for an individual 10 years older (example1_data vs. example3_data)
perc_diff <- ((exp(pred5_charges)/ exp(pred3_charges))-1)*100

# Print the result
print("The percentage difference in charges for an individual that ages by 10 years:")
print(perc_diff)

## 1.11
# Create a multiple linear regression with log(charges) as a dependent variable and log(age) as one of the predictors
mlr3_model <- lm(log(charges) ~ log(age) + isSmoker + healthyBMI + hasChildren, data = insurance)

## 1.12
# Export to a word doc using stargazer
stargazer(mlr3_model,
          type= "html",
          out = "3rd Multiple Regression model.doc")

## 1.13
# Using example1_data to predict estimated average medical cost for question 1.13
pred6_charges <- predict(mlr3_model, example1_data)

# Print the prediction for medical charges for question 1.13
print("Estimated average medical costs for a 40 year-old, non-smoker individual with one child and a BMI of 19:")
print(exp(pred6_charges))

## 1.14
# Using example2_data to predict estimated average medical cost for question 1.14
pred7_charges <-predict(mlr3_model, example2_data)

# Print the prediction for medical charges for question 1.14
print("Estimated average medical costs for a 40 year-old, non-smoker individual with one child and a BMI of 27:")
print(exp(pred7_charges))


### Question 2
## 2.1
# Read the bank loan default dataset
d <- read_csv("loan_default_dataset.csv")

# View dataset
View(d)

# Convert some specific columns to factor (categorical variable)
d$Default <- as.factor(d$Default)
d$Gender <- as.factor(d$Gender)
d$Marital_status <-as.factor(d$Marital_status)
d$Car_loan <- as.factor(d$Car_loan)
d$Personal_loan <-as.factor(d$Personal_loan)
d$Home_loan <-as.factor(d$Home_loan)
d$Education_loan <- as.factor(d$Education_loan)
d$Emp_status <- as.factor(d$Emp_status)

## 2.2
# Apply summary only to numeric columns
numeric_vars_summary <- sapply(d, function(x) if (is.numeric(x)) summary(x))

# Print
print(numeric_vars_summary)

## 2.3, 2.4
# Tabulate all the categorical variables in the dataset
cat_tables <- lapply(d[, sapply(d, is.factor)], table)

# Print the results
print(cat_tables)

## 2.5
# Read the bank loan default dataset
d <- read_csv("loan_default_dataset.csv")

# View dataset
View(d)

# Convert categorical variables to factors
d$Gender <- as.factor(d$Gender)
d$Marital_status <-as.factor(d$Marital_status)
d$Emp_status <- as.factor(d$Emp_status)

# View dataset
str(d)

# Create a multi linear regression model using all other variables in the dataset
multi1_model <- lm(Default ~ ., data = d)

# Summary of the model
summary(multi1_model)

## 2.6
# Use stargazer to export the regression results to MS Word
stargazer(multi1_model,
          type= "html",
          out = "Multiple Linear Regression model for Loan default.doc")

## 2.7
# Test multicollinearity by using VIF?
vif_values <- vif(multi1_model)

# Print the VIF values to assess multicollinearity
print("VIF values:")
print(vif_values)

# Create a horizontal bar plot of VIF values
barplot_vif <- barplot(vif_values,
                       main = "VIF Values for Independent Variables",
                       vertical = TRUE,  # Vertical bars
                       col = "skyblue",  # Color of the bars
                       ylim = c(0, max(vif_values) + 1),  # Extend y-axis limit
                       las = 1)  # Rotate axis labels for better readability

# Add a horizontal reference line at VIF = 5
abline(h = 5, col = "red", lwd = 2, lty = 2)  # Red dashed line for reference

# Add text to explain the reference line
text(5, max(barplot_vif) + 0.5, "VIF = 5", pos = 4, col = "red")

# Identify variables with VIF greater than 5 (indicating high multicollinearity)
high_vif_vars <- names(vif_values[vif_values > 5])
if (length(high_vif_vars) > 0) {
  print("Variables with VIF > 5:")
  print(high_vif_vars)  # Print variables with high VIF values
} else {
  print("No variables have VIF > 5")  # No problematic variables found
}

## 2.8
# Remove all insignificant/ problematic variables and create a new multiple linear 
multi2_model <- lm(Default ~ Checking_amount+ Term + Credit_score +Emp_status + Amount + Saving_amount + Age, data= d)

# Summary of the model
summary(multi2_model)

## 2.9
# Use stargazer to export the regression results to MS Word
stargazer(multi2_model,
          type= "html",
          out = "Final Multiple Linear Regression model for Loan default.doc")

## 2.10
# Create an example dataset to run prediction for the final multiple linear regression
examples_data <- data.frame(
  Checking_amount = c(-100, 570, 1892, 98,-5),
  Term = c(11, 20, 9, 27, 15),
  Credit_score = c(675, 750,813, 779, 700),
  Emp_status = c("employed","unemployed","unemployed","employed","unemployed"),
  Amount = c(1896,375, 570, 1357, 2178),
  Saving_amount = c(1800, 3578, 4000, 1527, 995),
  Age = c(20, 37, 40, 31, 24)
)

# Run prediction and view
examples_pred <- predict(multi2_model, examples_data)
examples_pred

### Question 3
## 3.1
# Create a multiple logistic regression using the same variables that were used in the final multiple linear regression
logit1_model <- glm(Default ~ Checking_amount + Term + Credit_score + Emp_status + Amount + Saving_amount + Age, family = binomial (link=logit),
                          data = d)

# Summary of the model
summary(logit1_model)

## 3.2
# Use stargazer to export the regression results to MS Word
stargazer(logit1_model,
          type= "html",
          out = "Multiple Logistic Regression model for Loan default.doc")

## 3.3
# Remove insignificant varaibles to create a final logistic regression 
logit2_model <-glm(Default ~ Checking_amount + Term + Credit_score + Saving_amount + Age, family = binomial (link=logit),
                        data = d)

# Summary of the model
summary(logit2_model)

## 3.4, 3.5
# Use stargazer to export the regression results to MS Word
stargazer(logit2_model,
          type= "html",
          out = "Final Multiple Logistic Regression model for Loan default.doc")

## 3.6 
# Create a dataset to predict the probability of a loan default for an individual with a 600 vs 800 credit score
example4_data <- data.frame(
  Checking_amount = c(500,500),
  Term = c(22,22),
  Credit_score = c(600,800),
  Amount = c(2000,2000),
  Saving_amount = c(2200,2200),
  Age = c(35,35)
)

# Predict and view
comparing_pred <- predict(logit2_model, example4_data,  type = "response")
comparing_pred

# Calculate the difference
example4_diff <- (comparing_pred[1]-comparing_pred[2])*100
print("Probability difference:")
print(example4_diff)

### Question 4
## 4.1
# Split the data set into training data set and testing data set
set.seed(123)

# Determine the number of observations
num_rows <- nrow(d)

# Create a random sample of 70:30 
train_indices <- sample(1:num_rows, size = 0.7*num_rows)

#Create training and testing dataset
training_data <- d[train_indices, ]
testing_data <- d[-train_indices, ]

## 4.2
training_logit_model <-glm(Default ~ Checking_amount + Term + Credit_score + Saving_amount + Age, family = binomial (link=logit), 
                   data = training_data)

# Summary of the model
summary(training_logit_model)

## 4.3
# Use stargazer to export the regression results to MS Word
stargazer(training_logit_model,
          type= "html",
          out = "Training Multiple Logistic Regression model for Loan default.doc")

## 4.4
# Predict the probabilities of default for the individuals in the testing dataset
testing_data_pred <- predict(training_logit_model,testing_data, type = "response")
testing_data_pred

## 4.5
# Create a classification table for the model
pred_class <- ifelse(testing_data_pred >= 0.7,1,0)

# Create a confusion matrix (classification table)
confusion_matrix <- table(testing_data$Default, pred_class)
print("Confusion Matrix:")
print(confusion_matrix)

## 4.6
# Calculate the accuracy rate
accuracy <- sum(diag(confusion_matrix))/ (sum(confusion_matrix))*100
print("Accuracy percentage rate:")
print(accuracy)

