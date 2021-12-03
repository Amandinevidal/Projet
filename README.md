
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VisuBayes: Parameters posterior check

This repository contains the data and code for a great shinyapp to
visualise chain mixing after Bayesian GLMM analysis.

### How to cite

Please cite this compendium as:

> Authors, (2021). *Compendium of R code and data for VisuBayes:
> Parameters posterior check*. Accessed 03 déc. 2021. Online at
> <https://doi.org/xxx/xxx>

## Contents

The **analyses** directory contains:

  - [:file\_folder: simu data](/analyses/01-simu_data.R): Simulate data
    for 3 species.
  - [:file\_folder: simu data bis](/analyses/01-simu_databis.R):
    Simulate data for 4 species.
  - [:file\_folder: model](/analyses/02-model.R): Model simulated data
    with 3 species.
  - [:file\_folder: modelbis](/analyses/02-modelbis.R): Model simulated
    data with 4 species.
  - [:file\_folder: shiny](/analyses/shiny.R): Fabulous shiny
    application.

## How to run in your browser or download and run locally

This research compendium has been developed using the statistical
programming language R. To work with the compendium, you will need
installed on your computer the [R
software](https://cloud.r-project.org/) itself and optionally [RStudio
Desktop](https://rstudio.com/products/rstudio/download/).

You can download the compendium as a zip from from this URL:
[master.zip](/archive/master.zip). After unzipping: - open the `.Rproj`
file in RStudio - run `devtools::install()` to ensure you have the
packages this analysis depends on (also listed in the
[DESCRIPTION](/DESCRIPTION) file). - finally, open
`analysis/paper/paper.Rmd` and knit to produce the `paper.docx`, or run
`rmarkdown::render("analysis/paper/paper.Rmd")` in the R console

### Licenses

**Text and figures :**
[CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)

**Code :** See the [DESCRIPTION](DESCRIPTION) file

**Data :** [CC-0](http://creativecommons.org/publicdomain/zero/1.0/)
attribution requested in reuse

### Contributions

We welcome contributions from everyone. Before you get started, please
see our [contributor guidelines](CONTRIBUTING.md). Please note that this
project is released with a [Contributor Code of Conduct](CONDUCT.md). By
participating in this project you agree to abide by its terms.
