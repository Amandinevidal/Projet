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
                fileInput(inputId = "output1", # name of file to import (mcmc table) not load just named
                          label = "Upload model outputs", # name of the option
                          accept = c(".RData")), # output extension expected
                uiOutput("param")
              ),
              mainPanel( # page setup
                h2("Trace plot"), # title
                plotOutput(outputId = "plot"), # plot
                br(), # empty line
                br(),# empty line
              )


)


#### SERVER FUNCTION ####

server <-function(input,output){

  outvar <- reactive({
    if(is.null(input$output1)) { return(paste(" "))}
    else {
    file1<-load(input$output1$datapath,verbose = T)
    print(file1)
    return(rownames(output))
    }
  })
  output$param = renderUI({
    selectInput('param2',"Parameters",outvar())
  })

  i <- reactive({as.character(input$param2)}) # i take one parameter value corresponding to selectInput choices l24 #
  output$plot= renderPlot({ # type of element to add in shiny
    plot(1:10,1:10,main=paste(i())) # plot
  })

}

#### CALL SHINY APP ####

shinyApp(ui,server)
