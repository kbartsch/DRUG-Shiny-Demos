Let's take our basic reactive shiny app and capture user input using interaction with plots. Although there are several different ways to accomplish this, I prefer to use [plotly's](https://plot.ly/r/) R library. Here, I'll demonstrate 2 different types of plotly interaction:

1. Click events - when a user selects a single point on a plot
2. Selected events - when a user selects multiple points using the select or lasso tool. 

## Plotly Click Events
### Plotly key attribute 
``` r
 p <- plot_ly(
    data = dataframe, 
    type ='scatter',
    x = ~ <xvar>, 
    y = ~ <yvar>, 
    key = ~ <key>
)
```

### Plotly source attribute
``` r 
p$x$source <- "<unique_plot_source_name>"
```
### Plotly `event_data` 
```r
e <- event_data("plotly_click", source = "<unique_plot_source_name>")
```
### Incorporating Plotly `event_data` into Reactive Output 
```r
if(!is.null(e)){        
    cuts <- apply(
        summaryData %>%
            filter(key==as.character(e$key)) %>%
            select(cut)
        ,1,paste,collapse="|"
    )        
    data %>%
    filter(cut %in% cuts)        
}
else {   
    NULL
}
```

## Plotly Selected Events
### Plotly `event_data`
```r 
e <- event_data("plotly_selected", source = "<unique_plot_source_name>")
```