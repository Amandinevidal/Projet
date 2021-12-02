#### --------------------------------------------- ####
# Date : 02/12/2021
# Author : Emmanuelle, Bastien, Amandine
# email : amandine.vidal-hosteng@univ-tlse3.fr
# Encoding : UTF-8
# file : shiny.R

# Shiny interface building
#### --------------------------------------------- ####


#### VISUALS ####

ui<-fluidPage(titlePanel("Trace Plot visualisation depending on parameter selection"),

              sidebarPanel( # ce que t'as sur les côtés
                fileInput(inputId = "outputs",
                          label = "Upload model outputs",
                          accept = c(".RData")), # extension attendue

                selectInput(inputId = "nb1", # spécifier ce qu'il y a sur le cote # prduit un menu deroulant # arg graphes
                            h3("Which parameter ?"), # titre
                            choices = list("parameter alpha"=1, "parameter beta 1"=2,"parameter beta 2"=3,"parameter beta 3"=4,"parameter mu"=5,"paramter sigma"=6), # parameter name
                            selected = 1)), # valeur par default

              mainPanel( # page princp
                h2("Trace plot"),
                plotOutput(outputId = "plot"),
                br(),
                br()
              )
)


#### SERVER ####

server <-function(input,output){
  parameter_names <- c("parameter alpha", "parameter beta 1","parameter beta 2","parameter beta 3","parameter mu","paramter sigma")
  i <- reactive({as.character(input$nb1)}) # i implementation attribu i à choices ici nb1
  output$plot= renderPlot({
  plot(1:10,1:10,main=paste("Parameter",parameter_names[i()]))
  })
}

shinyApp(ui,server)
