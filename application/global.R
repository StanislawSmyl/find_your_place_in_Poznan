library(shiny)
library(leaflet)
library(shinysky)
library(httr)
library(randomForest)
#install.packages('shinyWidgets')
library(shinyWidgets)
#devtools::install_github("AnalytixWare/ShinySky")
library(shinysky)
#install.packages('shinythemes')
library(shinythemes)
load("deploy.RData")
load("modelRF.Rdata")
otodom <- read.csv("otodom.csv", stringsAsFactors = FALSE)
streets <- read.csv("PoznanStreets.csv", encoding = "UTF-8", stringsAsFactors = F)
colnames(streets) <- "streets"
adress_autocomplete <- streets$streets
