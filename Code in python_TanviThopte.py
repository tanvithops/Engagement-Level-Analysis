pip install pandas numpy seaborn matplotlib statsmodels scikit-learn


# Load libraries
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from scipy.stats import f_oneway
from statsmodels.stats.multicomp import pairwise_tukeyhsd
import statsmodels.api as sm
import statsmodels.formula.api as smf
from sklearn.preprocessing import LabelEncoder

# Load dataset
data = pd.read_csv("emotional_monitoring_dataset.csv")

# Inspect data structure
print(data.info())

# Convert categorical variables to factors
data['CognitiveState'] = data['CognitiveState'].astype('category')
data['EmotionalState'] = data['EmotionalState'].astype('category')

# 2. Exploratory Data Analysis (EDA)
# Visualize the Distribution of EngagementLevel
plt.figure(figsize=(8, 6))
sns.histplot(data['EngagementLevel'], bins=int(data['EngagementLevel'].max()), kde=False, color='blue', alpha=0.7)
plt.title('Distribution of Engagement Level')
plt.xlabel('Engagement Level')
plt.ylabel('Count')
plt.show()

# Boxplots to Compare EngagementLevel by CognitiveState and EmotionalState
plt.figure(figsize=(8, 6))
sns.boxplot(data=data, x='CognitiveState', y='EngagementLevel', palette='Set2')
plt.title('Engagement Level by Cognitive State')
plt.xlabel('Cognitive State')
plt.ylabel('Engagement Level')
plt.show()

plt.figure(figsize=(8, 6))
sns.boxplot(data=data, x='EmotionalState', y='EngagementLevel', palette='Set3')
plt.title('Engagement Level by Emotional State')
plt.xlabel('Emotional State')
plt.ylabel('Engagement Level')
plt.show()

# HYPOTHESIS 
# Test for Differences in EngagementLevel by CognitiveState (ANOVA)
anova_result = f_oneway(
    *[data.loc[data['CognitiveState'] == state, 'EngagementLevel'] 
      for state in data['CognitiveState'].cat.categories]
)
print(f"ANOVA Result: F={anova_result.statistic:.2f}, p={anova_result.pvalue:.4f}")

# Tukey HSD post-hoc test if p-value is significant
if anova_result.pvalue < 0.05:
    print("Significant result, performing Tukey HSD post-hoc test:")
    tukey = pairwise_tukeyhsd(endog=data['EngagementLevel'], groups=data['CognitiveState'], alpha=0.05)
    print(tukey)
else:
    print("No significant differences found.")

# Simple Linear Regression for Each Predictor
predictors = ['HeartRate', 'SkinConductance', 'AmbientNoiseLevel', 'LightingLevel']
for predictor in predictors:
    formula = f'EngagementLevel ~ {predictor}'
    model = smf.ols(formula=formula, data=data).fit()
    print(f"\nSimple Linear Regression for Predictor: {predictor}")
    print(model.summary())

# 4. Multiple Linear Regression
# Fit the regression model
formula = 'EngagementLevel ~ HeartRate + SkinConductance + AmbientNoiseLevel + LightingLevel'
model = smf.ols(formula=formula, data=data).fit()

# Summary of the model
print("\nMultiple Linear Regression Model Summary:")
print(model.summary())

# Check model diagnostics
sm.graphics.plot_regress_exog(model, 'HeartRate', fig=plt.figure(figsize=(12, 8)))
plt.show()

# Scatter Plots with Linear Trendlines
sns.lmplot(data=data, x='HeartRate', y='EngagementLevel', height=6, aspect=1.5, line_kws={'color': 'red'})
plt.title('Heart Rate vs Engagement Level')
plt.xlabel('Heart Rate')
plt.ylabel('Engagement Level')
plt.show()

sns.lmplot(data=data, x='LightingLevel', y='EngagementLevel', height=6, aspect=1.5, line_kws={'color': 'blue'})
plt.title('Lighting Level vs Engagement Level')
plt.xlabel('Lighting Level')
plt.ylabel('Engagement Level')
plt.show()

# Check Correlation Between Predictors
num_vars = data[['HeartRate', 'SkinConductance', 'AmbientNoiseLevel', 'LightingLevel', 'EngagementLevel']]
cor_matrix = num_vars.corr()

# Visualize correlation matrix
plt.figure(figsize=(10, 8))
sns.heatmap(cor_matrix, annot=True, cmap='coolwarm', fmt='.2f')
plt.title('Correlation Matrix for Numerical Variables')
plt.show()

# Alternative visualization: Custom heatmap
cor_melt = cor_matrix.reset_index().melt(id_vars='index')
cor_melt.columns = ['Var1', 'Var2', 'value']

plt.figure(figsize=(10, 8))
sns.heatmap(cor_matrix, annot=True, cmap='coolwarm', fmt='.2f', cbar_kws={'shrink': 0.8})
plt.title('Correlation Heatmap')
plt.show()
