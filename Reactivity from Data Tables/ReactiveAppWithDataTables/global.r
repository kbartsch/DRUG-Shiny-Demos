library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(DT)
library(shinyWidgets)

data <- diamonds

data <- sample_n(data,1000)

scatterTable <- data %>%
  group_by(cut,color) %>%
  tally() 


BoxplotTable <- data %>%
  group_by(cut,clarity) %>%
  tally() 
