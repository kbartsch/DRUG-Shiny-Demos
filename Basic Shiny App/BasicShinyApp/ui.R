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
        ,menuItem('Plots',tabName = "plot",icon = icon("bar-chart-o"))
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
            tabName = "plot", 
            fluidRow(
                column(
                    12,
                    box(
                        title = "", 
                        id = "",
                        height= "auto",
                        width = "auto",
                        ""
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
                        title = "", 
                        id = "",
                        height= "auto",
                        width = "auto",
                        ""
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