#### --------------------------------------------- ####
# Date : 03/12/2021
# Author : Emmanuelle, Bastien, Amandine
# email : amandine.vidal-hosteng@univ-tlse3.fr
# Encoding : UTF-8
# file : make.R


# Main script
#### --------------------------------------------- ####

#### Load packages ####
devtools::load_all()

#### Load functions ####
#source(here::here("R/functions.R"))

#### Data simulations ####
source(here::here("analyses/01-simu_data.R"))

#### Model ####
source(here::here("analyses/02-model.R"))

#### Shiny ####
library(shiny)
source(here::here("analyses/shiny.R"))

shinyApp(ui,server)
