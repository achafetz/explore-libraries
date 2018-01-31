01\_explore-libraries\_jenny.R
================
Aaron
Wed Jan 31 14:15:50 2018

``` r
## how jenny might do this in a first exploration
## purposely leaving a few things to change later!
```

Which libraries does R search for packages?

``` r
.libPaths()
```

    ## [1] "/Library/Frameworks/R.framework/Versions/3.4/Resources/library"

``` r
## let's confirm the second element is, in fact, the default library
.Library
```

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

``` r
library(fs)
path_real(.Library)
```

    ## /Library/Frameworks/R.framework/Versions/3.4/Resources/library

Installed packages

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.7.2     ✔ stringr 1.2.0
    ## ✔ readr   1.1.1     ✔ forcats 0.2.0

    ## ── Conflicts ────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

    ## [1] 117

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

    ## # A tibble: 3 x 3
    ##   LibPath                                                 Priority       n
    ##   <chr>                                                   <chr>      <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources… base          14
    ## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources… recommend…    15
    ## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources… <NA>          88

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                  51 0.436 
    ## 2 yes                 61 0.521 
    ## 3 <NA>                 5 0.0427

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 4 x 3
    ##   Built     n   prop
    ##   <chr> <int>  <dbl>
    ## 1 3.4.0    41 0.350 
    ## 2 3.4.1    11 0.0940
    ## 3 3.4.2    16 0.137 
    ## 4 3.4.3    49 0.419

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ##  [1] "assertthat"   "backports"    "base64enc"    "BH"          
    ##  [5] "bindr"        "bindrcpp"     "bitops"       "broom"       
    ##  [9] "callr"        "caTools"      "cellranger"   "cli"         
    ## [13] "clipr"        "clisymbols"   "colorspace"   "crayon"      
    ## [17] "curl"         "DBI"          "desc"         "devtools"    
    ## [21] "dichromat"    "digest"       "dplyr"        "enc"         
    ## [25] "evaluate"     "forcats"      "fs"           "ggplot2"     
    ## [29] "gh"           "git2r"        "glue"         "gtable"      
    ## [33] "haven"        "highr"        "hms"          "htmltools"   
    ## [37] "httr"         "ini"          "jsonlite"     "knitr"       
    ## [41] "labeling"     "lazyeval"     "lubridate"    "magrittr"    
    ## [45] "markdown"     "memoise"      "mime"         "mnormt"      
    ## [49] "modelr"       "munsell"      "openssl"      "pacman"      
    ## [53] "pillar"       "pkgconfig"    "plogr"        "plyr"        
    ## [57] "psych"        "purrr"        "R6"           "RColorBrewer"
    ## [61] "Rcpp"         "readr"        "readxl"       "rematch"     
    ## [65] "rematch2"     "reprex"       "reshape2"     "rlang"       
    ## [69] "rmarkdown"    "rprojroot"    "rstudioapi"   "rvest"       
    ## [73] "scales"       "selectr"      "stringi"      "stringr"     
    ## [77] "styler"       "tibble"       "tidyr"        "tidyselect"  
    ## [81] "tidyverse"    "translations" "usethis"      "utf8"        
    ## [85] "viridisLite"  "whisker"      "withr"        "xml2"        
    ## [89] "yaml"

``` r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n  prop
    ##   <lgl>  <int> <dbl>
    ## 1 F         51 0.436
    ## 2 T         66 0.564
