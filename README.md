# Denver R Users Group Shiny App Demos
Demo Shiny Apps for DRUG Talk on 11.19.19

# Outline 
## [Basic Shiny App](https://github.com/kbartsch/DRUG-Shiny-Demos/tree/master/Basic%20Shiny%20App)
- UI.r
- Server.r
- Global.r


## [Shiny App with Reactivity](https://github.com/kbartsch/DRUG-Shiny-Demos/tree/master/Shiny%20App%20with%20Reactivity)
Capturing UI Input 

`input$<inputid>`


Manipulating data in a reative way

`reactive({})`



Outputting changed data

`output$outputid <- render ({ reactive() })`

## [Reactivity with Dependency](https://github.com/kbartsch/DRUG-Shiny-Demos/tree/master/Reactive%20App%20with%20Dependencies)
When we need to limit / update UI choice based on other inputs 

`observeEvent({})`
- update choices 
- update selected 

## [Reactivity using Data Tables](https://github.com/kbartsch/DRUG-Shiny-Demos/tree/master/Reactivity%20from%20Data%20Tables)

Take rows chosen from a DataTable and drive reactive output in another element 
 
 `input$<tableID_rows_selected>`


## [Reactivity with Plot Interaction](https://github.com/kbartsch/DRUG-Shiny-Demos/tree/master/Reactivity%20from%20Plot%20Interaction)
`event_data("<plot event>", source = "<sourceplot>"))`

### Plot Source 
- naming plot sources 
- adding keys 
- Take clicked, brushed, selected points from a plot and drive reactive output in another element 
 


## [Debugging Examples](https://github.com/kbartsch/DRUG-Shiny-Demos/tree/master/Debugging%20Examples)

### Printing Output 
`print()` 
### Breaking into Browser session
`browser()`
### showcase mode

### reactive log


