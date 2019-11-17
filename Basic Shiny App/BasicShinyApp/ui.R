source('global.R')

appPageTitle <- "Basic Shiny App - No Reactivity"

header <- dashboardHeader(
    title = appPageTitle,
    titleWidth = 350
)

sidebar <- dashboardSidebar(
    width = 350,
    sidebarMenu(
        id="sidebar"
        ,menuItem("Overview",tabName="Overview",icon=icon("fas fa-home"))
        ,menuItem('Plots',tabName = "plots",icon = icon("bar-chart-o"))
        ,menuItem('Tables',tabName = "table",icon = icon("fas fa-table"))
        ,br()
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
                        title = h1("Overview - Basic Shiny Apps"),
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
                    box(
                        title = "", 
                        id = "",
                        height= "auto",
                        width = "auto",
                        plotlyOutput("BoxPlot",height="750px")
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