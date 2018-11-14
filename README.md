# Intro to the Tidyverse Workshops (Datafest Tbilisi 2018)

This repo includes the material for two workshops held in **Datafest Tbilisi**:

- Data manipulation using `dplyr`
- Data visualization using `ggplot2`

## Getting Started 

### Environment

#### Option 1 

- Go to [Intro to the Tidyverse](https://rstudio.cloud/spaces/6529/join?access_code=FoNbx0Y2AtyZNeKbGAJtyAELvU2HxPtIwmIcoIQo) project on **Rstudio Cloud**.
- Click on **Intro to the Tidyverse** project.

#### Option 2 *(Local)*

- Install R.
- Install Rstudio.
- Install the `tidyverse`  and `gapminder` packages using `install.packages(c("tidyverse", "gapminder"))`.

**NOTE:** For more details about R and Rstudio installation, check [Installing R and RStudio](https://moderndive.com/2-getting-started.html#installing-r-and-rstudio) section in [ModernDive](https://moderndive.com) book.

#### Options 3

- Go to [jupyter.org/try](http://jupyter.org/try).
- Click on **Try Jupyter with R**.
- Install the `gapminder` package using `install.packages("gapminder")`.

### Basic Checks

Make sure you are not getting any errors when you execute:

```r
library(tidyverse)
library(gapminder)
```

### Material

The material exists in one repo, which you can download or clone using:

`git Clone https://github.com/OmaymaS/datafest_tidyverse_workshop.git`

#### Exercises

The `./tutorial` directory includes seperate `.Rmd` files with exercises and solutions.

#### Slides

- [Data Manipulation using dplyr (First Steps)](https://speakerdeck.com/omaymas)
- [Data Visualization using ggplot2](https://github.com/OmaymaS/datafest_tidyverse_workshop/blob/master/slides/data_visualization_with_ggplot2.pdf)