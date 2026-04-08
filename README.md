Understanding Engagement Level using Machine Learning
Project Overview

This project explores how physiological signals and environmental conditions influence a person's engagement level.

The goal is to identify which factors (like heart rate, noise, lighting, etc.) actually matter when predicting engagement — useful for applications in workplaces, classrooms, and human behavior analysis.

🎯 Objectives
Analyze how emotional and cognitive states impact engagement
Identify key predictors of engagement level
Study relationships between physiological signals and engagement
Evaluate the impact of environmental conditions

📂 Dataset
Source: Kaggle – Emotional Monitoring Dataset
Includes:
Physiological data (Heart Rate, Skin Conductance, EEG, etc.)
Environmental data (Noise, Lighting)
Behavioral states (Emotional & Cognitive)
Target: Engagement Level

🔑 Key Features
HeartRate
SkinConductance
EEG
Temperature
PupilDiameter
SmileIntensity / FrownIntensity
CortisolLevel
ActivityLevel
AmbientNoiseLevel
LightingLevel
EmotionalState
CognitiveState
EngagementLevel (Target)

🧹 Data Preprocessing
Converted categorical variables into factors
Handled missing values
Ensured correct data formats
Cleaned and structured dataset for analysis

📊 Methods Used
This project applies multiple statistical and ML techniques:

Hypothesis Testing
Correlation Analysis
Simple Linear Regression
Multiple Linear Regression
ANOVA (Analysis of Variance)
Data Visualization (histograms, bar plots, heatmaps)

🔍 Key Insights
📈 Exploratory Data Analysis
Engagement Level 3 occurs most frequently
Emotional state strongly influences engagement
Cognitive state (focused vs distracted) shows no major difference

🧪 Statistical Findings
Cognitive state → ❌ Not significant
Emotional state → ✅ Influential

📉 Regression Results
Skin Conductance → Strong negative impact (most important predictor)
Heart Rate → Significant in multiple regression
Noise & Lighting → Not significant

📊 Model Performance
R² ≈ 12% → Model explains limited variance
Indicates more complex/non-linear relationships may exist

📌 Correlation Highlights
Weak correlation between most features and engagement
Strong negative correlation between:
Heart Rate & Skin Conductance

⚠️ Limitations
Limited contextual information in dataset
Possible multicollinearity issues
Linear assumptions may oversimplify reality
External noise in measurements
Limited generalizability

🚀 Future Improvements
Use advanced ML models (Random Forest, XGBoost, Neural Networks)
Apply feature engineering
Explore non-linear relationships
Collect richer contextual data

🛠️ Tech Stack
Python / R
Statistical Analysis
Data Visualization
Machine Learning Models

📎 How to Run
Load dataset from Kaggle
Perform preprocessing
Run statistical analysis
Train regression models
Visualize results

👤 Author

Tanvi Thopte
Foundations of Machine Learning