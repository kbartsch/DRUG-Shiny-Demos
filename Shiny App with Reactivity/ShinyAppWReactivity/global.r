library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(DT)
library(shinyWidgets)

data <- diamonds

data <- sample_n(data,1000)
