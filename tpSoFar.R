# Instalar y cargar los paquetes necesarios

library(brms)
library(dplyr)
library(ggplot2)
# Generar datos de ejemplo

set.seed(123)
x <- rnorm(100)
y <- 2 * x + rnorm(100)

# Especificar el modelo
model <- brm(y ~ x, data = data.frame(x, y), family = gaussian())

# Resumen del modelo
summary(model)
setwd("C:/Users/Usuario/Desktop/Exactas/Bayesiana/dataset/Modelling-Football-Players-Values-on-Transfer-Market-and-Their-Determinants-using-Robust-Regression/data")

datos<- read.csv("danelic2019.csv",sep=";", header = TRUE)
datos %>% filter(position == "FW") %>% 
  ggplot(aes(x=goals, y= value)) +
  geom_point(aes(color= league)) +
  geom_smooth(method= lm)

outliers<-datos %>% filter(value > 100000000)

modelo1<- brm(
  bf(value ~ goals + assists),
  data = datos,
  family = gaussian(),
  chains = 4, iter = 5000*2, seed = 1999,
  refresh = 0
)

summary(modelo1)
plot(modelo1)

samples <- posterior_samples(modelo1)

samples %>% ggplot(aes(x= b_goals, intercept=b_Intercept)) + geom_abline()


