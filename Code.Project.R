library(tidyverse)
library(ggplot2)

#Loading the data
df<- read.csv("D:/Winter 2021-22/Environmental Data Science/1_Project/Data_fuel consumption/CO2 Emissions_Canada.csv")
emission<- df[,-1] # deleting the first column

#filter fuel type as premium gasoline  
emiss_pg<- filter(emission, Fuel.Type=='Z')

#Linear regression
#Linear modelling of Co2 emission by fuel consumption in the city
plot_lm_emission_ct<- ggplot(data = emiss_pg, mapping = aes(x = Fuel.Consumption.City..L.100.km., 
                      y = CO2.Emissions.g.km.)) +
                      geom_point()+ geom_smooth(method = "lm")

#plot_lm_emission_ct<-plot_lm_emission_ct+ xlab("Fuel Consumption in City (L/100 km)")+ ylab("CO2 Emission (g/km)") 
plot_lm_emission_ct<-plot_lm_emission_ct+ 
                    xlab("Fuel Consumption in City\n (l/100km)")+ ylab("CO2 Emission (g/km)")+
                      theme(axis.text=element_text(size=9),
                            axis.title=element_text(size=9))

lm_emission_ct<- lm(CO2.Emissions.g.km.~Fuel.Consumption.City..L.100.km., emiss_pg) 
summary(lm_emission_ct)
# check: Estimate as parameters
#        Pr(>|t|) as p-value (if <0.05)
#        Residual standard error
#        Multiple R-squared
#write the values in the image and interpret in the presentation 

#Linear modelling of Co2 emission by fuel consumption in the highway
plot_lm_emission_hw<- ggplot(data = emiss_pg, mapping = aes(x = Fuel.Consumption.Hwy..L.100.km., 
                                                            y = CO2.Emissions.g.km.)) +
                      geom_point()+ geom_smooth(method = "lm")

#plot_lm_emission_hw<-plot_lm_emission_hw+ xlab("Fuel Consumption in Highway (L/100 km)")+ ylab("CO2 Emission (g/km)") 
plot_lm_emission_hw<-plot_lm_emission_hw+ xlab("")+ 
                      ylab("CO2 Emission (g/km)")+
                      theme(axis.text=element_text(size=6),
                      axis.title=element_text(size=8))

lm_emission_hw<- lm(CO2.Emissions.g.km.~Fuel.Consumption.Hwy..L.100.km., emiss_pg) 
summary(lm_emission_hw)
# check: Estimate as parameters
#        Pr(>|t|) as p-value (if <0.05)
#        Residual standard error
#        Multiple R-squared
#write the values in the image and interpret in the presentation 

#Linear modelling of Co2 emission by fuel consumption in the city+highway combined 

plot_lm_emission_comb<-ggplot(data = emiss_pg, mapping = aes(x = Fuel.Consumption.Comb..L.100.km., 
                                      y = CO2.Emissions.g.km.)) +
  geom_point()+ geom_smooth(method = "lm")

#plot_lm_emission_comb<-plot_lm_emission_comb+xlab("Fuel Consumption in City+Highway (L/100 km)")+ ylab("CO2 Emission (g/km)")  
plot_lm_emission_comb<- plot_lm_emission_comb+xlab("Fuel Consumption in City+Highway\n (l/100km)")+ ylab("CO2 Emission (g/km)")+
                      theme(axis.text=element_text(size=9),
                      axis.title=element_text(size=9))

lm_emission_comb<- lm(CO2.Emissions.g.km.~Fuel.Consumption.Comb..L.100.km., emiss_pg)
summary(lm_emission_comb)
# check: Estimate as parameters
#        Pr(>|t|) as p-value (if <0.05)
#        Residual standard error
#        Multiple R-squared
#write the values in the image and interpret in the presentation 
#-----------------------------------

#install.packages("patchwork")
library(patchwork)
lm_emission<- plot_lm_emission_ct + plot_lm_emission_comb
lm_emission+ plot_annotation(title= "Simple Linear Regression of CO2 Emission",
                             theme = theme(plot.title = element_text(size = 12, face="bold")))
                             
#---------------------------------------  

#95% confidence interval                  
#In the city 
confint(lm_emission_ct)

plot_CI_lm_emission_ct<- ggplot(data = emiss_pg, mapping = aes(x = Fuel.Consumption.City..L.100.km., 
                                      y = CO2.Emissions.g.km.)) +
  geom_point()+ geom_smooth(method = "lm", se=TRUE, level=0.95)
  #labs(caption= "95%CI: Intercept [20.70367, 23.02324],\n Fuel consumption [18.41630, 18.58758]")

plot_CI_lm_emission_ct<- plot_CI_lm_emission_ct + xlab("Fuel Consumption in City\n (l/100km)")+ 
                        ylab("CO2 Emission (g/km)")+ theme(axis.text=element_text(size=7),
                        axis.title=element_text(size=7))
plot_CI_lm_emission_ct

#In the city and highway 
confint(lm_emission_comb)

plot_CI_lm_emission_comb<- ggplot(data = emiss_pg, mapping = aes(x = Fuel.Consumption.Comb..L.100.km., 
                                                                 y = CO2.Emissions.g.km.)) +
                            geom_point()+ geom_smooth(method = "lm", se=TRUE, level=0.95)
              #labs(caption= "95%CI: Intercept [0.1274897, 1.098725],\n Fuel consumption [23.1953752, 23.278531]")


plot_CI_lm_emission_comb<-plot_CI_lm_emission_comb+ xlab("Fuel Consumption in City+Highway\n (l/100km)")+ 
                          ylab("CO2 Emission (g/km)")+theme(axis.text=element_text(size=7),
                                                            axis.title=element_text(size=7))

plot_CI_lm_emission_comb


CI_lm_emission_comb<- plot_CI_lm_emission_ct + plot_CI_lm_emission_comb 
CI_lm_emission_comb+plot_annotation(title= "Simple Linear Regression of CO2 Emission (With CI)",
                                    theme = theme(plot.title = element_text(size = 10, face="bold")))
#-----------------------------------------------------

#Multiple linear regression
mlm<-lm(CO2.Emissions.g.km.~Fuel.Consumption.City..L.100.km.+
          Fuel.Consumption.Comb..L.100.km., emiss_pg) 

summary(mlm)

library(GGally)

emiss_new<- emiss_pg [, c(-1,-2,-3,-4,-5,-6,-8,-10) ]
emiss_new<- emiss_new %>% rename(Emission=CO2.Emissions.g.km.)
emiss_new<- emiss_new %>% rename(City=Fuel.Consumption.City..L.100.km.)
emiss_new<- emiss_new %>% rename(City_Highway=Fuel.Consumption.Comb..L.100.km.)

ggpairs(emiss_new)
#----------------------------------------------------------------
#Cross validation 
set.seed(123)
train_id <- sample(c(1:nrow(emiss_new)), size=nrow(emiss_new)*0.8)
head(train_id)  
test_id  <- setdiff(c(1:nrow(emiss_new)), train_id) 
head(test_id)

train <- emiss_new %>% slice(train_id)
test  <- emiss_new %>% slice(test_id)

# modeling

# linear model 
model_lm <- lm(Emission~City+City_Highway, train)
summary(model_lm)

# cart
library(rpart)
library(rpart.plot)
model_cart <- rpart(Emission~., train)
rpart.plot(model_cart)

## random forest
#install.packages("randomForest")
library(randomForest)
set.seed(123)
model_rf <- randomForest(Emission~., train)
model_rf

# boosting: Generalized Boosted Regression Modeling
#install.packages("gbm")
library(gbm)
set.seed(123)
model_gbm <- gbm(Emission~., distribution="gaussian", train)
model_gbm
summary(model_gbm)


#performance evaluation 

# we predict sales values for the test dataset
pred_lm   <- predict(model_lm, test)
plot(pred_lm, test$Emission)
pred_cart <- predict(model_cart, test)
pred_rf   <- predict(model_rf, test)
pred_gbm  <- predict(model_gbm, test)

# r2: obs vs pred
r2_lm   <- cor(pred_lm, test$Emission)^2
r2_cart <- cor(pred_cart, test$Emission)^2
r2_rf   <- cor(pred_rf, test$Emission)^2
r2_gbm  <- cor(pred_gbm, test$Emission)^2
#--------------------------------------------------------------------
# model specific post-hoc interpretability
library(vip)

# model agnostic post-hoc interpretability
# permutation-based feature importance

pvip_lm <- vip(model_lm, method="permute", target="Emission", metric="rsquared",pred_wrapper=predict) + 
            labs(title="lm")+ theme(axis.text=element_text(size=5))
pvip_cart <- vip(model_cart, method="permute", target="Emission", metric="rsquared", 
                 pred_wrapper=predict) + labs(title="cart")+theme(axis.text=element_text(size=5))
pvip_rf <- vip(model_rf, method="permute", target="Emission", metric="rsquared", 
               pred_wrapper=predict) + labs(title="rf")+theme(axis.text=element_text(size=5))
pvip_gbm <- vip(model_gbm, method="permute", target="Emission", metric="rsquared", 
                pred_wrapper=predict) + labs(title="gbm")+theme(axis.text=element_text(size=5))

plot_pvip_all <-
  pvip_lm + pvip_cart + pvip_rf + pvip_gbm

plot_pvip_all


# partial dependence plot

##install.packages("pdp")
library(pdp)

#model.lm %>%  partial(pred.var="TV") %>% autoplot

pdp_lm <- model_lm %>%  partial(pred.var=c("City","City_Highway")) %>% autoplot +
          labs(title="lm")+theme(axis.text=element_text(size=5), axis.title=element_text(size=5))

pdp_cart <- model_cart %>%  partial(pred.var=c("City","City_Highway")) %>% autoplot+ 
          labs(title="cart")+theme(axis.text=element_text(size=5), axis.title=element_text(size=5))


pdp_rf <- model_rf %>%  partial(pred.var=c("City","City_Highway")) %>% autoplot + 
          labs(title="rf")+theme(axis.text=element_text(size=5), axis.title=element_text(size=5))

pdp_gbm <- model_gbm %>%  partial(pred.var=c("City","City_Highway"), n.trees=10) %>% autoplot + 
          labs(title="gbm")+theme(axis.text=element_text(size=5), axis.title=element_text(size=5))


plot_pdp_all <-
  pdp_lm + pdp_cart + pdp_rf + pdp_gbm

plot_pdp_all

# Final plot

plot_hist <- emiss_new %>%  ggplot(aes(Emission)) + geom_histogram()
plot_emission_city   <- emiss_new %>%  ggplot(aes(City, Emission)) + geom_point()
plot_emission_comb   <- emiss_new %>%  ggplot(aes(City_Highway, Emission)) + geom_point()

Final_plot <-
  (plot_hist/plot_emission_city/plot_emission_comb) |  #pipe symbol 
  plot_pvip_all |  # pipe
  plot_pdp_all

Final_plot + 
  plot_annotation(
    title = "CO2 Emission by Fuel Consumption",
    subtitle = "Variable importance and PD plots for 4 models",
    caption = "lm: linear regression, cart: decision tree, 
    rf: random forest, gbm: gradient boosting",
    theme = theme(plot.title = element_text(size = 7, face="bold"),
                  plot.subtitle =element_text(size = 5), 
                  plot.caption = element_text(size = 5)))
                  
  











