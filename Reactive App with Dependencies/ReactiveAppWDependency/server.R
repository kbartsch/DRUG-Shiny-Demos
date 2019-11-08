
server <- function(input, output, session) {
  
  observeEvent(c(input$selectedCutGroup),{
      
      cuts <- apply(
        data %>%
          filter(CutGroup==input$selectedCutGroup) %>%
          distinct(cut)
        ,1,paste,collapse="|"
      )
      
      colorGroups <- apply(
        data %>%
          filter(CutGroup==input$selectedCutGroup) %>%
          distinct(ColorGroup)
        ,1,paste,collapse="|"
      )
      
      updateSelectInput(
        session,
        'selectedCut',
        choices = cuts, 
        selected = cuts
      )
      
      updateSelectInput(
        session,
        'selectedColorGroup',
        choices = colorGroups, 
        selected = colorGroups
      )
      
    })
  
  observeEvent(c(input$selectedCutGroup2),{
    
    
    cuts <- apply(
      data %>%
        filter(CutGroup==input$selectedCutGroup2) %>%
        distinct(cut)
      ,1,paste,collapse="|"
    )
    
    colorGroups <- apply(
      data %>%
        filter(CutGroup==input$selectedCutGroup2) %>%
        distinct(ColorGroup)
      ,1,paste,collapse="|"
    )
    
    updateSelectInput(
      session,
      'selectedCut2',
      choices = cuts, 
      selected = NULL
    )
    
    updateSelectInput(
      session,
      'selectedColorGroup2',
      choices = colorGroups, 
      selected = NULL
    )
    
  })
  
    
    reactiveData <- reactive({
        
        data %>%
            filter(cut %in% input$selectedCut, 
                   color %in% input$selectedColor, 
                   clarity %in% input$selectedClarity, 
                   depth >= min(input$selectedDepth) & depth <= max(input$selectedDepth),
                   price >= min(input$selectedPrice) & price <= max(input$selectedPrice)
                   )
        
    })    
    
  
    output$ScatterPlot <- renderPlotly({
    
      dataset <- reactiveData()
      
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
          data = dataset, 
          type ='scatter',
          x = ~carat, 
          y = ~price, 
          text = ~paste0("Carat: ",carat, "<br /> Price: ",price),
          hoverinfo = 'text',
          mode = "markers",
          color = ~cut, 
          marker = list(size = 8,width = 2)
        ) %>% 
          layout(
              title = 'Carat vs. Price', 
              legend = list(x = 100, y = 0.1),
              xaxis = x, 
              yaxis = y,
              title = list(
                  font = "'Noto Serif', serif",
                  size=30,
                  color="#004F80"
              ), 
              margin = margin,
              showlegend=TRUE
          ) %>%
          config(
            displayModeBar = TRUE,
            displaylogo = FALSE
          )
    
        p
    
    })
  
  
  output$BoxPlot <- renderPlotly({
      
      dataset <- reactiveData()
    
        f <- list(
          family = "Arial", 
          color = "rgb(58, 62, 65)", 
          size = 12
        )
        
        x <- list(
          title = "Clarity",
          titlefont = f,
          showgrid = FALSE,
          zeroline = FALSE,
          showline = TRUE,
          showticklabels = TRUE
        )
        
        y <- list(
          title = "Price",
          titlefont = f,
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
          data = dataset, 
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
            title = list(
                font = "'Noto Serif', serif",
                size=30,
                color="#004F80"
            ), 
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
    data=reactiveData(),
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