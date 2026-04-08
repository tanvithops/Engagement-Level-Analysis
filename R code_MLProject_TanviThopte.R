library(tidyverse)

data <- read.csv("emotional_monitoring_dataset.csv")
View(data)
str(data)

# Categorical variables are being converted to factors
data$CognitiveState <- as.factor(data$CognitiveState)
data$EmotionalState <- as.factor(data$EmotionalState)

#2. Exploratory Data Analysis (EDA)
#Distribution of EngagementLevel visualisation is being done
# Histogram of EngagementLevel
ggplot(data, aes(x = EngagementLevel)) +
  geom_histogram(binwidth = 1, fill = "blue", alpha = 0.7) +
  labs(title = "Distribution of EngagementLevel", x = "Engagement Level", y = "Count")

#EngagementLevel by CognitiveState and EmotionalState comparision using boxplots
# EngagementLevel by CognitiveState
ggplot(data, aes(x = CognitiveState, y = EngagementLevel, fill = CognitiveState)) +
  geom_boxplot() +
  labs(title = "Engagement Level by Cognitive State", x = "Cognitive State", y = "Engagement Level")

# EngagementLevel by EmotionalState
ggplot(data, aes(x = EmotionalState, y = EngagementLevel, fill = EmotionalState)) +
  geom_boxplot() +
  labs(title = "Engagement Level by Emotional State", x = "Emotional State", y = "Engagement Level")

#HYPOTHESIS 
#Test for Differences in EngagementLevel by CognitiveState (ANOVA)
#Hypotheses:
#H0: Mean engagement levels across CognitiveState groups are equal.
#𝐻1: Mean engagement levels  across CognitiveState group are not equal
# Performing ANOVA
anova_result <- aov(EngagementLevel ~ CognitiveState, data = data)
summary(anova_result)
# finding p-value for the CognitiveState variable
anova_summary <- summary(anova_result)
p_value <- anova_summary[[1]][["Pr(>F)"]][1]

# p-value is significant or not
if (p_value < 0.05) {
  print("Significant result !, performing Tukey HSD post-hoc test:")
  print(TukeyHSD(anova_result))
} else {
  print("No significant differences found.")
}


#H0: Mean engagement levels across EmotionalState groups are equal.
#𝐻1: Mean engagement levels  across EmotionalState group are not equal
# ANOVA for Engagement Level by Emotional State
anova_emotional <- aov(EngagementLevel ~ EmotionalState, data = data)
summary(anova_emotional)

# significance
p_value_emotional <- summary(anova_emotional)[[1]][["Pr(>F)"]][1]

if (p_value_emotional < 0.05) {
  print("Significant result for Emotional State! Performing Tukey HSD post-hoc test:")
  print(TukeyHSD(anova_emotional))
} else {
  print("No significant differences found for Emotional State.")
}

# Simple Linear Regression
# simple linear regression function
simple_linear_regression <- function(predictor, data) {
  formula <- as.formula(paste("EngagementLevel ~", predictor))
  model <- lm(formula, data = data)
  cat("\nSimple Linear Regression for Predictor:", predictor, "\n")
  print(summary(model))
}

#function is being applied to each predictor
predictors <- c("HeartRate", "SkinConductance", "AmbientNoiseLevel", "LightingLevel")
for (pred in predictors) {
  simple_linear_regression(pred, data)
}


#4. Multiple Linear Regression
#Model : EngagementLevel as a function of Physiological and Environmental Variables
#Hypotheses:
#H0: None of the predictors have a significant relationship with EngagementLevel.
#H1: At least one predictor significantly explains variation in EngagementLevel.

# regression model
model <- lm(EngagementLevel ~ HeartRate + SkinConductance + AmbientNoiseLevel + LightingLevel, data = data)

# Summary of the model
summary(model)

#  model diagnostics
par(mfrow = c(2, 2)) # Arrange plots in a 2x2 grid
plot(model)

#Scatter Plots(Linear Trendlines)

# HeartRate vs EngagementLevel
ggplot(data, aes(x = HeartRate, y = EngagementLevel)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  labs(title = "Heart Rate vs Engagement Level", x = "Heart Rate", y = "Engagement Level")

# LightingLevel vs EngagementLevel
ggplot(data, aes(x = LightingLevel, y = EngagementLevel)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Lighting Level vs Engagement Level", x = "Lighting Level", y = "Engagement Level")



# Correlation Between Predictors

# Snumerical columns
num_vars <- data %>% select(HeartRate, SkinConductance, AmbientNoiseLevel, LightingLevel, EngagementLevel)

#  correlation matrix
cor_matrix <- cor(num_vars)

#  correlation matrix
library(reshape2)
library(ggcorrplot)

# Melt correlation matrix
cor_melt <- melt(cor_matrix)

# heatmap
ggcorrplot(cor_matrix, lab = TRUE)  

if (!require(reshape2)) install.packages("reshape2", repos = "http://cran.us.r-project.org")
if (!require(ggcorrplot)) install.packages("ggcorrplot", repos = "http://cran.us.r-project.org")

library(reshape2)
library(ggcorrplot)
library(ggplot2)

num_vars <- data %>% select(HeartRate, SkinConductance, AmbientNoiseLevel, LightingLevel, EngagementLevel)

# correlation matrix
cor_matrix <- cor(num_vars)

print("Correlation Matrix:")
print(cor_matrix)

#correlation matrix using ggcorrplot
ggcorrplot(cor_matrix, lab = TRUE, title = "Correlation Matrix for Numerical Variables")

#heatmap using reshape2 and ggplot2
# Melt the correlation matrix
cor_melt <- melt(cor_matrix)

# heatmap
ggplot(cor_melt, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "black", size = 4) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  labs(title = "Correlation Heatmap", x = "", y = "") +
  theme_minimal()

