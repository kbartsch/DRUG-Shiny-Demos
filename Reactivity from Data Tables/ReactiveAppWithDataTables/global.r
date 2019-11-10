library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(DT)
library(shinyWidgets)

data <- diamonds

data <- sample_n(data,1000)

CutsTable <- data %>%
  group_by(cut) %>%
  tally() %>%
  select(cut,`Total Rows` = n)

ColorsTable <- data %>%
  group_by(color) %>%
  tally() %>%
  select(color, `Total Rows` = n)
