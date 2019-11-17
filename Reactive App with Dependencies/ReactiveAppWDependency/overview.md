Let's take our basic reactive shiny app and add some layers of complexity. In some data, we utliamtely have to deal with cascading dependencies. That is, what if the user input values depend on some other choice? We wouldn't want to show options to the user in the UI that are not valid based on their choice of some other value. 

To illustrate this, let's create 2 arbitary variables in our data within the `global.r` file:
``` r 
data <- diamonds

data <- sample_n(data,1000)

data <- data %>%
  mutate(CutGroup = ifelse(cut %in% c('Fair','Good'),'Group A','Group B')) %>%
  mutate(ColorGroup = ifelse(CutGroup=='Group A' & color %in% c('D','E','F'),'Group X','Group Y'))
```

In this example:
1) `CutGroup` **Group A** applies only to *Fair* and *Good* cuts, **Group B** applies to all others. If I choose **Group A** from the `CutGroup` picker in the UI, I should only see *Fair* and *Good* as options in the `Cut` picker. 
2) Similarly, if I choose **Group A** from the `CutGroup` picker, I should see**Group X** and **Group Y** as options for `ColorGroup`; if I choose **Group B** from the `CutGroup` picker, I should only see **Group Y** as an option for `ColorGroup`
3) If I choose **Group A** for `CutGroup` , and I choose **Group X** for `ColorGroup`, I should only see *D*,*E*, or *F* as options for `Color`. 

So how can we listen for the user's choices for the `CutGroup` and `ColorGroup` inputs and limit other choices appropriately? 

## `observeEvent`
In the `server.r`, we can "observe" values from the `ui.r` side and run arbitrary updates to objects, such as other inputs.  
 
`observeEvent` takes this basic form:
```r 
observeEvent(input$<inputId>,{

    <Do Something with the > input$<inputId> value. 

})
```
This code will execute any time the `input$<inputId>` value changes within the UI. 

## `updateSelectInput`
Within an `observeEvent` block, we can also make updates to input objects like `pickerInputs`. We have access to the `choices` and `selected` properties. 

`updateSelectInput` takes this basic form:
``` r
updateSelectInput(
    session,
    '<inputId>',
    choices = <Set of Choices>, 
    selected = <Default Selected Item(s)>
)
```

## Putting it all together: 
In order to handle cascading dependencies with this function, we will have to do 3 things:
1) Listen to changes to `input$<inputId>` 
2) Filter out data using `input$<inputId>` to find valid input choices for other `ui.r` inputs. 
3) Update the input object in the `ui.r` with the subset of data from #2. 

Here is how we would listen for changes to the **CutGroup** input and update the choices for **Cut** based on what was chosen:

```r
observeEvent(c(input$selectedCutGroup),{
      
    cuts <- apply(
        data %>%
            filter(CutGroup==input$selectedCutGroup) %>%
            distinct(cut)
        ,1,paste,collapse="|"
    )

    updateSelectInput(
        session,
        'selectedCut',
        choices = cuts, 
        selected = cuts
    )
})  
```