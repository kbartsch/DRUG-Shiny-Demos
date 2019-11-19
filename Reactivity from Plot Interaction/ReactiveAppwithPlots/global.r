library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(DT)
library(shinyWidgets)
library(shinyjs)

data <- diamonds

set.seed(12345678)

data <- sample_n(data,1000)

data <- data  %>%
  mutate(key = rownames(data))


summaryData <- data %>%
  group_by(cut,color) %>%
  summarise(median_carat = median(carat), median_price = median(price)) %>%
  mutate(key = paste0(cut,'-',color))
