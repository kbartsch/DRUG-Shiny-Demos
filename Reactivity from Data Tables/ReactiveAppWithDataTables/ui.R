source('global.R')

appPageTitle <- "Reactive with Dependency"

header <- dashboardHeader(
    title = appPageTitle,
    titleWidth = 350
)

sidebar <- dashboardSidebar(
    width = 350,
    sidebarMenu(
        id="sidebar"
        ,menuItem("Overview",tabName="Overview",icon=icon("fas fa-home"))
        ,menuItem('Scatter with Table',tabName = "plots",icon = icon("bar-chart-o"))
        ,menuItem('Data Table',tabName = "table",icon = icon("fas fa-table"))
        ,br()
        ,conditionalPanel(
            condition = "input.sidebar == 'plots' | input.sidebar == 'plots2'"
            ,"Dataset Filters: "
            ,sliderInput(
                inputId = "selectedDepth",
                label = "Depth",
                min = min(data$depth),max = max(data$depth),
                value = c(min(data$depth),max(data$depth))
            )
            ,sliderInput(
                inputId = "selectedPrice",
                label = "Price Range",
                min = min(data$price),max = max(data$price),
                value = c(min(data$price),max(data$price))
            )
        ) 
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "Overview",
            fluidRow(
                column(
                    12,
                    box(
                        title = h1("Reactivity using Data Tables"),
                        id = "",
                        height= "auto",
                        width = "auto", 
                        withMathJax(includeMarkdown("overview.md"))
                    )
                )
            )
        )
        ,tabItem(
            tabName = "plots", 
            fluidRow(
                column(
                    6,
                    box(
                        title = "", 
                        id = "",
                        height= "auto",
                        width = "auto",
                        plotlyOutput("ScatterPlot",height="750px")
                    )
                ),
                column(
                    6,
                    fluidRow(
                        box(
                            title = "",
                            id = "",
                            height= "auto",
                            width = "auto",
                            DT::dataTableOutput("scatterCutsTable")
                        )
                    ), 
                    fluidRow(
                        box(
                            title = "",
                            id = "",
                            height= "auto",
                            width = "auto",
                            DT::dataTableOutput("scatterColorsTable")
                        )
                    )
                )
            )
        )
        
        ,tabItem(
            tabName = "table", 
            fluidRow(
                column(
                    12,
                    box(
                        title = "Raw Data Table", 
                        id = "",
                        height= "auto",
                        width = "auto",
                        DT::dataTableOutput("rawdata")
                    )
                )
            )
        )
    )
)
        

ui <- dashboardPage(
    title = appPageTitle,
    header,
    sidebar,
    body
)