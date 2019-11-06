library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(DT)

data <- diamonds

data <- sample_n(data,1000)
