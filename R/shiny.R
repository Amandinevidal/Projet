#### --------------------------------------------- ####
# Date : 02/12/2021
# Author : Emmanuelle, Bastien, Amandine
# email : amandine.vidal-hosteng@univ-tlse3.fr
# Encoding : UTF-8
# file : shiny.R

# Shiny interface building
#### --------------------------------------------- ####

library(shiny)

#### VISUALS ####

ui<-fluidPage(titlePanel("Trace Plot visualisation depending on parameter selection"),

              sidebarPanel( # add web site options on side
                fileInput(inputId = "output", # name of file to import (used next in server function)
                          label = "Upload model outputs", # name of the option
                          accept = c(".RData")), # output extension expected

                selectInput(inputId = "nb1", # name of input for parameter choice (used next in server function)
                            h3("Which parameter ?"), # title for selection
                            choices = list("parameter alpha"=1, "parameter beta 1"=2,"parameter beta 2"=3,"parameter beta 3"=4,"parameter mu"=5,"paramter sigma"=6), # parameter names
                            selected = 1)), # default value

              mainPanel( # page setup
                h2("Trace plot"), # title
                plotOutput(outputId = "plot"), # plot
                br(), # empty line
                br() # empty line
              )
)


#### SERVER FUNCTION ####

server <-function(input,output){
  i <- reactive({as.character(input$nb1)}) # i take one parameter value corresponding to selectInput choices l24
  output$plot= renderPlot({ # type of element to add in shiny
    plot(1:10,1:10) # plot
  })
}

#### CALL SHINY APP ####

shinyApp(ui,server)
