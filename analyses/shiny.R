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
                          label = "Upload model mcmc output", # name of the option
                          accept = c(".RData")), # output extension expected
                uiOutput("param")
                # ajouter un menu deroulant parametre qui convergent
                # un menu deroulant parametre qui ont pas converger
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

  ## load output1 + save rownames as parma2
  outvar <- reactive({
    if(is.null(input$output1)) { return(paste(" "))} # at the moment there is no file
    else { # when browse
      file1<-load(input$output1$datapath,verbose = T) # take output and read it in file1
      results <- MCMCvis::MCMCsummary(jsample)
      # print(file1) # check if file1 is readed
      # take only rhat>1.1 rownames
      return(rownames(results)) # return rownames to add it in menu
    }
  })
  ## read outvar in order to names all parameters
  output$param = renderUI({
    selectInput('param2',"All parameters",outvar())
  })

  ## plot (output2) with reactive title to selected parameter (output1)
  i <- reactive({as.character(input$param2)}) # i take one parameter value corresponding to selectInput choices l24 #
  output$plot= renderPlot({ # type of element to add in shiny
    bayesplot::mcmc_trace(jsample,pars=i()) # plot
  })

}

#### CALL SHINY APP ####

shinyApp(ui,server)
