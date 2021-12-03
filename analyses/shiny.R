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

ui <- fluidPage(titlePanel("VisuBayes: parameters convergence check"),

                sidebarPanel( # add web site options on side
                  fileInput(inputId = "output1", # name of file to import (mcmc table) not load just named
                            label = "Upload model mcmc output", # name of the option
                            accept = c(".RData")), # output extension expected
                  uiOutput("param"),
                  # add text advert to know which parameter does not converge
                  #uiOutput(outputId = "warning"),
                  #br(),
                  h2("Parameters summary"),
                  br(),
                  p("Red lines indicate parameters that did not converge.", style="color:red"),
                  br(),
                  DT::dataTableOutput("table"),
                ),
                mainPanel( # page setup
                  h2("Trace plot"), # title
                  plotOutput(outputId = "plot",width = "100%", height = "300px"), # trace plot
                  br(), # empty line
                  h2("Density posterior for each chain"),
                  plotOutput(outputId = "plot2",width = "100%", height = "300px"),
                  br(), # empty line
                  br()# empty line
                )
)


#### SERVER FUNCTION ####

server <- function(input,output){

  ## load data
  filedata <- reactive({
    file1 <- load(input$output1$datapath,verbose = T)
    get(file1)
  })

  ## load output1 + save rownames as parma2
  outvar <- reactive({
    if(is.null(input$output1)) { return(paste(" "))} # at the moment there is no file
    else { # when browse
      results <- MCMCvis::MCMCsummary(filedata()) # create mcmc summary
      return(rownames(results)) # return rownames to add it in menu
    }
  })

  ## read outvar in order to names all parameters
  output$param = renderUI({
    selectInput('param2',"All parameters",outvar())
  })

  ## print summary table
  summarytable <- reactive({
    MCMCvis::MCMCsummary(filedata())|>dplyr::mutate_all(function(x)round(x,1))|>dplyr::select(-7)
  })
  output$table <- DT::renderDataTable({
    if(is.null(input$output1)) {
      DT::datatable(matrix(0,ncol=3,nrow=3))
    } else {
      summarydata <- MCMCvis::MCMCsummary(filedata())|>dplyr::mutate_all(function(x)round(x,2))|>dplyr::select(-7)
      DT::datatable(as.data.frame(summarydata)) |> DT::formatStyle('Rhat',target = "row", backgroundColor = DT::styleInterval(c(0,1.09,Inf), c('white','white','red','red')))
    }
  })

  ## plot (output2) with reactive title to selected parameter (output1)
  i <- reactive({as.character(input$param2)}) # i take one parameter value corresponding to selectInput choices l24 #
  output$plot= renderPlot({ # type of element to add in shiny
    if(is.null(input$output1)) {
      return(paste(" ")) # at the moment there is no file
    } else {
      bayesplot::mcmc_trace(filedata(),pars=i()) # trace plot
    }
  })

  ## plot (output2) with reactive title to selected parameter (output1)
  output$plot2= renderPlot({ # type of element to add in shiny
    if(is.null(input$output1)) {
      return(paste(" ")) # at the moment there is no file
    } else {
      bayesplot::mcmc_dens_chains(filedata(),pars=i()) # density posterior for each chains
    }
  })

  output$warning <- renderUI({
    if(is.null(input$output1)) {
      return(paste(" ")) # at the moment there is no file
    } else {
      results2 <- MCMCvis::MCMCsummary(filedata())
      results2nc <- results2[results2$Rhat>1.1,]
      if (sum(results2[results2$Rhat>1.1,])==0) {
        HTML(
          paste("All parameters reached convergence")
        )
      } else {
        HTML(
          paste("Non convergent parameters :\n",rownames(results2nc),sep="")
        )
      }
    }
  })

}

#### CALL SHINY APP ####

shinyApp(ui,server)
