# Modelling_of_CO2_Emission_by_Fuel_Consumption_of_Vehicles-_A_Case_Study_from_Canada-
Simulation of CO2 emission from fuel consumption of vehicles in Canada. Data are collected from  https://www.kaggle.com/debajyotipodder/co2-emission-by-vehicles.
Statistical software R is used for the analysis. Several regression models for the analysis are done and the models are validated with cross validation. 

Introduction

Problem Statement 
 -Carbon dioxide: one of the prominent green house gases contributing to climate change. 
 -One of the primary sources of CO2 emission: car (vehicle).
 -CO2 emission ∝ Fuel consumption 

Dataset
Accessed from https://www.kaggle.com/debajyotipodder/co2-emission-by-vehicles.
This data are also available at Canada Government official open data website: https://open.canada.ca/data/en/dataset/98f1a129-f628-4ce4-b24d-6f16bf24dd64#wb-auto-6.
Details of how CO2 emissions by a vehicle can vary with the different features.
Data contains data over a period of 7 years. 

Objectives
 (1) Model to predict CO2 emission of vehicles by fuel consumption. 
 (2) Inference between CO2 emission and the corresponding predictors. 
 (3) Checking the validity of the model by cross validation.
 (4) Post hoc interpretation. 

Data Analysis Methods  
Methods: Linear model, Classification and regression tree (CART), Random forest, Gradient boosting model.

Response: CO2 emission

2 predictors
    (1) Fuel (premium gasoline) consumption in the city.
    (2) Fuel (premium gasoline) consumption in the city and on the highway combined.
    
R libraries: tidyverse, ggplot2, rpart, rpart.plot, randomForest, gbm, vip, patchwork and pdp 

Conclusion

(1) CO2 emission ∝ Fuel consumption (proved).

 (2)Multiple linear regression model is recommended, as it has the highest value of Square of the correlation coefficient and it is most interpretable.
 
 (3)As a post-hoc interpretation fuel consumption in the city and on the highway together always has higher effect and importance than considering only the city.




