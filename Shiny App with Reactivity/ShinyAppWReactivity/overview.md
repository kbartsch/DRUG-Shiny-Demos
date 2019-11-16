Let's see how we can take the basic Shiny skeleton and make it "Reactive" -- that is, making it a dynamic application that reponds to user input and interactions...
## `UI.r`
### Capture User Input to "React"
The first step to making a shiny app reactive is to capture user input from the UI. There are all kinds of ways to capture user inputs that we will explore in the coming examples. 

The most basic way to capture input is to utilize common input controls (or widgets). 
You can check out the all the widgets available to capute user input here: [Shiny Widget Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html)

Some very common examples are:
- pickerInput
- sliderInput
- radioButtons
- checkboxGroup

I frequently use the pickerInput widget as it has lots of additional options. A basic construct would look something like this:
```r 
pickerInput(
    inputId = "someInputField",  # very important!
    label = "InputLabel",           # What the end user sees
    choices = levels(data$somevariable), # all the options availble to choose from
    selected = 'A Specifc Value From "data$somevariable"', # What is already chosen
    options = list( 
        `actions-box` = TRUE,   # Select all or Unselect All button?
        `live-search` = TRUE, # search bar enabled? 
        size = 10 # text size >
    ),
    multiple = TRUE # Can the user choose multiple items? 
)
```
The big item to take note of here is `inputId`. This will be the input name you will use to access selected items from this input within your `Server.r` code. 

You will access the value or values chosen in a given input by referencing `input$<inputId>` in the `server.r` code. 

## `Server.r`
The second step to making a shiny app reactive is to change the perspective of your app's data with user input. 

You can access user input values from the `ui.r` side by referencing `input$<inputId>`. 

### Creating Reactive Data:
Using the `input$<inputId>` value from the UI, you can filter or alter data as you wish:

```r
reactiveData <- reactive ({
    startingDataFrame %>%
        filter(Field == input$someInputField) %>%
        filter(AnotherField %in% input$otherSelectedValues) %>%
        mutate(GroupingField = ifelse(grepl(input$selectedStringPattern,anotherField),"Yes","No"))
})
```
### Outputting Reactive Data:
The final step in reactivity is to return reactive data back to the UI. This could be in many different forms:
- text 
- chart 
- table 

To return data back to the UI, we just need an output object that utilizes the reactive data we configured above. Note the use of `()` when referencing the reactive object:
``` r 
output$ReactiveOutput <- renderPlot ({
    ggplot(reactiveData(),aes(x = Field, y=AnotherField, fill = GroupingField)) + 
        geom_boxplot()
})
```

## The Full Flow
Now that we have set up reactivity, let's connect the items, review the sequence, and understand the cycle of reactivity:

- In the `UI`, an input widget is populated with options for a user to choose...
- The `Server` listens for any updates to this widget using the widget's `inputId`...
- When a new value is chosen within the widget, the `Server` takes the new value and can use it to filter, alter, or change data in any way (as defined within the `reactive` code)... 
- Any output in the `Server` can then reference the reactive (changing) data...  
- These outputs then return back to the `UI` various representations of this data as it changes... 
- Rinse and repeat! 


# Now let's see it in action....

