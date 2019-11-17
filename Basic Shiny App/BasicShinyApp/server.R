
server <- function(input, output, session) {
   
  
  output$ScatterPlot <- renderPlotly({
    
    x <- list(
      title = "Carat",
      showgrid = FALSE,
      zeroline = TRUE,
      showline = FALSE,
      showticklabels = TRUE
    )
    
    y <- list(
      title = "Price",
      showgrid = FALSE,
      zeroline = TRUE,
      showline = TRUE,
      showticklabels = TRUE
    )
    
    margin <- list(
      autoexpand = TRUE,
      l = 10,
      r = 10,
      t = 100
    )

    p <- plot_ly(
      data = data, 
      type ='scatter',
      x = ~carat, 
      y = ~price, 
      text = ~paste0("Carat: ",carat, "<br /> Price: ",price),
      hoverinfo = 'text',
      mode = "markers",
      color = ~cut, 
      marker = list(size = 8,width = 2)
    ) %>% 
      layout(title = 'Carat vs. Price', 
             showlegend=TRUE,
             legend = list(x = 100, y = 0.1),
             xaxis = x, 
             yaxis = y,
             margin = margin
             
      ) %>%
      config(
        displayModeBar = TRUE,
        displaylogo = FALSE
      )

    p
    
  })
  
  
  output$BoxPlot <- renderPlotly({
    
    f <- list(
      family = "Arial", 
      color = "rgb(58, 62, 65)", 
      size = 12
    )
    
    x <- list(
      title = "Clarity",
      font = f,
      showgrid = FALSE,
      zeroline = FALSE,
      showline = TRUE,
      showticklabels = TRUE
    )
    
    y <- list(
      title = "Price",
      font = f,
      showgrid = FALSE,
      zeroline = FALSE,
      showline = TRUE,
      showticklabels = TRUE
    )
    
    margin <- list(
      autoexpand = TRUE,
       l = 25,
       r = 25,
       t = 100
     )
    
    p <- plot_ly(
      data = data, 
      y = ~price, 
      color= ~clarity, 
      text = ~paste0("Clarity: ",clarity, "<br /> Price: ",price),
      hoverinfo = 'text',
      type = "box", 
      boxpoints = "all", 
      jitter = 1,
      pointpos = 0
    ) %>% 
      layout(
        title = 'Clarity vs. Price',
        xaxis = x,
        yaxis = y,
        font= f,
        margin = margin,
        showlegend = FALSE 
      ) %>%
      config(
        displayModeBar = TRUE,
        displaylogo = FALSE,
        modeBarButtons = list(
          list("select2d"), 
          list("lasso2d"),
          list("toImage") 
        )
      )

    p
    
  })
  
  
  
  output$rawdata <- DT::renderDataTable(DT::datatable(
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
  ))
  
   
}