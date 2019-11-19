source('global.R')

appPageTitle <- "Reactive App with Plot Interaction"

header <- dashboardHeader(
    title = appPageTitle,
    titleWidth = 400
)

sidebar <- dashboardSidebar(
    width = 150,
    sidebarMenu(
        id="sidebar"
        ,menuItem("Overview",tabName="Overview",icon=icon("fas fa-home"))
        ,menuItem('Select Events',tabName = "plots",icon = icon("bar-chart-o"))
        ,menuItem('Data Table',tabName = "table",icon = icon("fas fa-table"))
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
                        title = h1("Reactivity from Plot Interaction"),
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
                        plotlyOutput("SummaryPlot",height="750px")
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
                            plotlyOutput("CutColorDistribution", height="350px")
                        )
                    ), 
                    fluidRow(
                        box(
                            title = "",
                            id = "",
                            height= "auto",
                            width = "auto", 
                            DT::dataTableOutput("selectedColorPoints")
                            
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