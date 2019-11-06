# Denver R Users Group Shiny App Demos
Demo Shiny Apps for DRUG Talk on 11.19.19

# Outline 
## Basic Shiny App Structure - no reactivity 
- UI.r
- Server.r
- Global.r

## Basic Shiny App with reactivity 
UI input 

`reactive({})`


## Reactivity with dependency 
need to limit / update UI choice based on other inputs 

### observeEvent({})
- update choices 
- update selected 

### conditionalPanel () 
- only show UI inputs based on conditions 
 
## reactive HTML output - titles, text, instructions, etc (may cut due to time) 
 
## reactivity from Data Table Selections - input$<>_rows_selected
Take rows chosen from a DataTable and drive reactive output in another element 
 
## reactivity from Plot interaction observeEvent({})

`event_data("<plot event>", source = "<sourceplot>"))`
### Plot Source 
- naming plot sources 
- adding keys 
- Take clicked, brushed, selected points from a plot and drive reactive output in another element 
 
## resetting selections in a reactive way (may cut due to time) 
`runjs() `
 
## Debugging 
### Printing Output 
`print()` 
### Breaking into Browser session
`browser()`
### showcase mode

### reactive log
