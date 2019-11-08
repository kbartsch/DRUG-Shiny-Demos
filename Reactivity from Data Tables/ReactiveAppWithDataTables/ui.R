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
        ,menuItem('BoxPlot with Table',tabName = "plots2",icon = icon("bar-chart-o"))
        ,menuItem('Data Table',tabName = "table",icon = icon("fas fa-table"))
        ,br()
        ,conditionalPanel(
            condition = "input.sidebar == 'plots' | input.sidebar == 'plots2'"
            ,"Dataset Filters: "
            ,pickerInput(
                inputId = "selectedCut", 
                label = "Cut",
                choices = levels(data$cut), 
                selected =levels(data$cut),
                options = list(
                    `actions-box` = TRUE,
                    `live-search` = TRUE,
                     size = 10,
                    `selected-text-format` = "count > 3"
                ),
                choicesOpt = list(
                    style = rep_len("color: black; line-height: 1.6;",length(levels(data$cut))+1)
                ),
                multiple = TRUE
            )
            ,pickerInput(
                inputId = "selectedColor",
                label = "Color",
                choices = levels(data$color),
                selected =levels(data$color),
                options = list(
                    `actions-box` = TRUE,
                    `live-search` = TRUE,
                    size = 10,
                    `selected-text-format` = "count > 3"
                ),
                choicesOpt = list(
                    style = rep_len("color: black; line-height: 1.6;",length(unique(data$color))+1)
                ),
                multiple = TRUE
            )
            ,pickerInput(
                inputId = "selectedClarity",
                label = "Clarity",
                choices = levels(data$clarity),
                selected = levels(data$clarity),
                options = list(
                    `actions-box` = TRUE,
                    `live-search` = TRUE,
                    size = 10,
                    `selected-text-format` = "count > 3"
                ),
                choicesOpt = list(
                    style = rep_len("color: black; line-height: 1.6;",length(unique(data$clarity))+1)
                ),
                multiple = TRUE
            )
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
                        title = "",
                        id = "",
                        height= "auto",
                        width = "auto", 
                        includeHTML(normalizePath(file.path('./www/overview.html'))) 
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
                    box(
                        title = "",
                        id = "",
                        height= "auto",
                        width = "auto",
                        DT::dataTableOutput("scatterTable")
                    )
                )
            )
        )
        ,tabItem(
            tabName = "plots2", 
            fluidRow(
                column(
                    6,
                    box(
                        title = "", 
                        id = "",
                        height= "auto",
                        width = "auto",
                        plotlyOutput("BoxPlot",height="750px")
                    )
                ),
                column(
                    6,
                    box(
                        title = "",
                        id = "",
                        height= "auto",
                        width = "auto",
                        DT::dataTableOutput("BoxplotTable")
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