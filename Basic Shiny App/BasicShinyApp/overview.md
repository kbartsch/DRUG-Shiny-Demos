Shiny Apps are interactive web applications built in `R`. They are highly customizable and quite easy to develop once you get the hang of the basic components. There are lots of out-of-the-box widgets that allow you to get going with Shiny with minimal effort. 

All Shiny apps require at least 2 components: 
- `UI` - where items are actually rendered in the application. 
- `Server` - where data is manipulated, plots are constructed, etc. 

** __TIP__ ** It is helpful to start with the `Server` objects you want to output first becuase you have to reference them by name in the `UI`. 

I also suggest you include a 3rd component: `global.r`. 

Let's review the role of each componet with some examples:

## `Global.r` (optional)
The `global.r` file is a good place to perform actions you want available to the entire application (hence the name "global"). Here is a good place to load required libraries, load data, and create any objects in memory that will be used across the app. 

A `global.r` file may look like this:
```r
library(shiny)
library(tidyverse)
library(plotly)
library(DT)

data <- diamonds

data <- sample_n(data,1000)
```

## `Server.r`
The `server.r` file is where data is manipulated and prepared for output / rendering within the UI. There are many many different ways to output data from the `server.r` file to the UI:
### Outputs 

#### Plots:
```r
output$plotToOutput <- renderPlot ({
    ggplot(data,aes(x=xvar,y=yvar,fill=groupvar)) +
        geom_boxplot()
})
```
#### Tables:
``` r
output$tableToOutput <- DT::renderDataTable(
    DT::datatable
    (
    data=data,
    options = list(
        autowidth=TRUE,
        scrollX =TRUE,
        scrollY = '500px',
        columnDefs = list(
            list(
            width = '200px', 
            targets = "_all"
            )
            ),
        pageLength = 25
        ),
    rownames = FALSE
    )    
)
```

## `UI.r`
The `ui.r` file is where the application's web components are configured and where outputs from the `server.r` file are rendered. 
### Rendering Items

#### Rendering a Plot: 
```r 
plotOutput("PlotToOutput")
```

#### Rendering a Table:
```r
DT::dataTableOutput("tableToOutput")
```


