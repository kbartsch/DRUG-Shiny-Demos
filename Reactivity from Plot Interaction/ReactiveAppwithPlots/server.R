
server <- function(input, output, session) {
  
  # suppress warnings  
  storeWarn<- getOption("warn")
  options(warn = -1) 
    
  output$SummaryPlot <- renderPlotly({
      
      f <- list(
          family = "Arial", 
          color = "rgb(58, 62, 65)", 
          size = 18
      )
      
      x <- list(
          title = "Median Carat",
          titlefont = f,
          showgrid = FALSE,
          zeroline = TRUE,
          showline = FALSE,
          showticklabels = TRUE
      )
      
      y <- list(
          title = "Median Price",
          titlefont = f,
          showgrid = FALSE,
          zeroline = TRUE,
          showline = FALSE,
          showticklabels = TRUE
      )
      
      margin <- list(autoexpand = TRUE,
                     l = 10,
                     r = 10,
                     t = 75
                     )

      
      p <- plot_ly(
          data = summaryData, 
          type ='scatter',
          x = ~median_carat, 
          y = ~median_price, 
          text = ~paste0('Cut: ',cut,'<br />color: ',color),
          hoverinfo = 'text',
          mode = "markers",
          color = ~cut,
          key = ~ key, 
          marker = list(size = 8,width = 2)
      ) %>% 
          layout(
             title = list(
               text = 'Median Carat vs. Median Price', 
               font = "'Noto Serif', serif",
               size=30,
               color="#004F80"
             ),
             showlegend=FALSE,
             legend = list(x = 100, y = 0.1),
             xaxis = x, 
             yaxis = y,
             margin = margin
          ) %>%
          
          config(
              displayModeBar = TRUE,
              displaylogo = FALSE,
              modeBarButtons = list(

                  list("toImage")
              )
          )
      
      p$x$source <- "summaryPlot"
      
      p
      
  })
    
  SelectedPointCutReactive <- reactive({
      
      e <- event_data("plotly_click", source = "summaryPlot")
    
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
  })
  
  
  output$CutColorDistribution <- renderPlotly({
      
      dataframe <- SelectedPointCutReactive()
      
      if(!is.null(dataframe)){
          
          f <- list(
              family = "Arial", 
              color = "rgb(58, 62, 65)", 
              size = 12
          )
          
          x <- list(
              title = "",
              titlefont = f,
              showgrid = FALSE,
              zeroline = FALSE,
              showline = TRUE,
              showticklabels = TRUE
          )
          
          y <- list(
              title = "",
              titlefont = f,
              showgrid = FALSE,
              zeroline = FALSE,
              showline = TRUE,
              showticklabels = TRUE
          )
          
          margin <- list(autoexpand = TRUE,
                         l = 25,
                         r = 25,
                         t = 50, 
                         b = 20)
          
          
          p <- plot_ly(
              data = dataframe, 
              y = ~price, 
              color= ~color, 
              key = ~key,
              text = ~paste0('Cut: ',cut,'<br />color: ',color, '<br />price: ',price),
              hoverinfo = 'text',
              type = "box", 
              boxpoints = "all", 
              jitter = 1,
              pointpos = 0
          ) %>% 
              layout(
                  title = list(
                    text = paste0(unique(dataframe$cut),' Colors vs Price'),
                    font = "'Noto Serif', serif",
                      size=30,
                      color="#004F80"
                  ),
                  xaxis = x,
                  yaxis = y,
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
          
          p$x$source <- "colorsboxPlot"
          
          p
          
      }
      else {
          
          NULL
          
      }
      
  })
    
  SelectedPointsColorReactive <- reactive({
      
      e <- event_data("plotly_selected", source = "colorsboxPlot")

      if(!is.null(e)){
        
        keys <- apply(
          e %>%
            select(key) 
          ,1,paste,collapse="|"
        )
      
       data %>%
         filter(key %in% keys) 

      }

      else {

      NULL
        
      }
  }) 
    
  output$selectedColorPoints <- DT::renderDataTable(
    DT::datatable(
      data=SelectedPointsColorReactive(),
      options = list(
        autowidth=TRUE,
        scrollX =TRUE,
        scrollY = '700px',
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
  
  
  output$rawdata <- DT::renderDataTable(DT::datatable(
    data=reactiveData(),
    options = list(
      autowidth=TRUE,
      scrollX =TRUE,
      scrollY = '700px',
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