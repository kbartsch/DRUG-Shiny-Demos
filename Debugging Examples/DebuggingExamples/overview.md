At some point while developing a shiny app, you will encounter a bug, or will need to peek into what a data frame looks like as you change it in a reactive block, or just want to be sure that you understand what the user input looks like. 

This is where debugging comes in. There are several ways to add debugging to a shiny app that can help you have visibility into things behind the scenes...


### `observe` blocks with output or print()
Similar `observeEvent`, we can listen to changes in the UI with a `observe` block. We can either print some value to the console, or even output it to an output in the `ui.r`. 
```r
observe({
    print(input$<someinputId>)
})
```
### `browser()`
Using `browser()` inline in any `r` code acts as a standard debug breakpoint, and allows you to step through the subsequent code step-by-step, observing objects as they are created and manipulated.
```r
output$reactiveoutput <- reactive({
    <code>
    <code>
    browser()
    <code>
})
```

### showcase mode 
You can run shiny apps in "Showcase" mode (which you typically see with online examples) where you can observe the UI side-by-side with the actual code. As the user interacts with various portions of the app, any code that fires is temorarily highlighed in the showcased code. A simple way to toggle showcase mode is to include a `DESCRIPTION` file in your app's directory. Changing the `DisplayMode` property can toggle how the app is shown (toggle to anything but "showcase" to turn off showcase mode...):

#### DESCRIPTION
``` DESCRIPTION
Title: Debuging App
Author: Kyle Bartsch
DisplayMode: Showcase 
Type: Shiny
```

### React Log 
The React Log is a useful tool to visualize dependencies, code execution sequence, and code execution timing. You can use it to identify bottle necks, observe reactivity sequence, and find problematic dependency. 

To use React Log, you will need to install the r pacakge: [reactlog](https://rstudio.github.io/reactlog/)

Once you have loaded the library, you can enable and use the tool by following 2 simple steps:

First, open n up a new `r` script. Run the following command:
```r 
options(shiny.reactlog=TRUE) 
```

Now fire up your shiny app. Once it is active, run this command to launch the reactive log:
``` 
Windows:
Ctrl + F3

Mac:
Cmd + F3
```