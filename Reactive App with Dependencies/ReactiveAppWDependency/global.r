library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(DT)
library(shinyWidgets)

data <- diamonds

data <- sample_n(data,1000)


data <- data %>%
  mutate(CutGroup = ifelse(cut %in% c('Fair','Good'),'Group A','Group B')) %>%
  mutate(ColorGroup = ifelse(CutGroup=='Group A' & color %in% c('D','E','F'),'Group X','Group Y'))
