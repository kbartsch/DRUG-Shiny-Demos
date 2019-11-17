Let's take our basic reactive shiny app and look at user input in a new way. Rather than using standard input widgets, let's get the user input from a table of data instead. 

## Using Data Tables as Filters
Let's start by creating 2 new dataframes (in the `global.r` file) that can serve as filters for our data:

1) A table that summarizes the different `cut` options:
``` r 
CutsTable <- data %>%
  group_by(cut) %>%
  tally() %>%
  select(cut,`Total Rows` = n)
```
2) A table that summarizes the different `color` options:
```r
ColorsTable <- data %>%
  group_by(color) %>%
  tally() %>%
  select(color, `Total Rows` = n)
```
In the `server.r` file, we will createt table output objects:
```r 
output$scatterCutsTable <- DT::renderDataTable(DT::datatable(
    data=CutsTable,
    options = list(
      dom = 't',
      autowidth=TRUE,
      scrollX =TRUE,
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
In the `ui.r` file, we can display these tables next to a plot:
```r
DT::dataTableOutput("scatterCutsTable")
```

## Capturing Rows Selected within a Table:
Now we just need to listen for which rows are selected within a given table. Shiny creates a standard object for the rows selected in a datatable. It can be referred to as `input$<dataTableObjectId>_rows_selected`. 

The object includes the row indicies of items selected within a given data table. If no rows are selected, the object returns as `NULL` so we need to be wary of that scenario within our code. 

We can take these indicies and filter data in an reactive object, in the same basic way we do using standard widget input (`input$inputID`). Here, in a reactive object, we can check for rows selected and then filter a dataframe based on those selections:

```r 
reactiveData <- reactive({
      
    cutRows <- input$scatterCutsTable_rows_selected 
    # check to see if rows have been selected 
    if(!is.null(cutRows)){
      cuts <- apply(CutsTable[cutRows,'cut'],1,paste,collapse="|")
    } else {
      cuts <- unique(data$cut)
    }
    
    data %>%
        filter(cut %in% cuts)     
  })
```
