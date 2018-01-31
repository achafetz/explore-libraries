00\_filesystem-practice\_jenny.R
================
Aaron
Wed Jan 31 14:05:59 2018

``` r
## First attempt: Just get it to work ----

list.files("~/Desktop/day1_s1_explore-libraries")
```

    ## [1] "01_explore-libraries_comfy.R"   "01_explore-libraries_jenny.R"  
    ## [3] "01_explore-libraries_spartan.R"

``` r
list.files("~/Desktop/day1_s1_explore-libraries", pattern = "\\.R$")
```

    ## [1] "01_explore-libraries_comfy.R"   "01_explore-libraries_jenny.R"  
    ## [3] "01_explore-libraries_spartan.R"

``` r
list.files(
  "~/Desktop/day1_s1_explore-libraries",
  pattern = "\\.R$",
  full.names = TRUE
)
```

    ## [1] "/Users/Aaron/Desktop/day1_s1_explore-libraries/01_explore-libraries_comfy.R"  
    ## [2] "/Users/Aaron/Desktop/day1_s1_explore-libraries/01_explore-libraries_jenny.R"  
    ## [3] "/Users/Aaron/Desktop/day1_s1_explore-libraries/01_explore-libraries_spartan.R"

``` r
from_files <- list.files(
  "~/Desktop/day1_s1_explore-libraries",
  pattern = "\\.R$",
  full.names = TRUE
)

(to_files <- basename(from_files))
```

    ## [1] "01_explore-libraries_comfy.R"   "01_explore-libraries_jenny.R"  
    ## [3] "01_explore-libraries_spartan.R"

``` r
file.copy(from_files, to_files)
```

    ## [1] TRUE TRUE TRUE

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny.R"       
    ## [2] "00_filesystem-practice_jenny.spin.R"  
    ## [3] "00_filesystem-practice_jenny.spin.Rmd"
    ## [4] "01_explore-libraries_comfy.html"      
    ## [5] "01_explore-libraries_comfy.R"         
    ## [6] "01_explore-libraries_jenny.R"         
    ## [7] "01_explore-libraries_spartan.R"       
    ## [8] "explore-libraries.Rproj"              
    ## [9] "README.md"

``` r
## Clean it out, so we can refine ----
file.remove(to_files)
```

    ## [1] TRUE TRUE TRUE

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny.R"       
    ## [2] "00_filesystem-practice_jenny.spin.R"  
    ## [3] "00_filesystem-practice_jenny.spin.Rmd"
    ## [4] "01_explore-libraries_comfy.html"      
    ## [5] "explore-libraries.Rproj"              
    ## [6] "README.md"

``` r
## Copy again, tighter code ----
from_dir <- file.path("~", "Desktop", "day1_s1_explore-libraries")
from_files <- list.files(from_dir, pattern = "\\.R$", full.names = TRUE)
to_files <- basename(from_files)
file.copy(from_files, to_files)
```

    ## [1] TRUE TRUE TRUE

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny.R"       
    ## [2] "00_filesystem-practice_jenny.spin.R"  
    ## [3] "00_filesystem-practice_jenny.spin.Rmd"
    ## [4] "01_explore-libraries_comfy.html"      
    ## [5] "01_explore-libraries_comfy.R"         
    ## [6] "01_explore-libraries_jenny.R"         
    ## [7] "01_explore-libraries_spartan.R"       
    ## [8] "explore-libraries.Rproj"              
    ## [9] "README.md"

``` r
## Clean it out, so we can use fs ----
file.remove(to_files)
```

    ## [1] TRUE TRUE TRUE

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny.R"       
    ## [2] "00_filesystem-practice_jenny.spin.R"  
    ## [3] "00_filesystem-practice_jenny.spin.Rmd"
    ## [4] "01_explore-libraries_comfy.html"      
    ## [5] "explore-libraries.Rproj"              
    ## [6] "README.md"

``` r
## Copy again, using fs ----
library(fs)
(from_dir <- path_home("Desktop", "day1_s1_explore-libraries"))
```

    ## /Users/Aaron/Desktop/day1_s1_explore-libraries

``` r
(from_files <- dir_ls(from_dir, glob = "*.R"))
```

    ## /Users/Aaron/Desktop/day1_s1_explore-libraries/01_explore-libraries_comfy.R
    ## /Users/Aaron/Desktop/day1_s1_explore-libraries/01_explore-libraries_jenny.R
    ## /Users/Aaron/Desktop/day1_s1_explore-libraries/01_explore-libraries_spartan.R

``` r
(to_files <- path_file(from_files))
```

    ## 01_explore-libraries_comfy.R   01_explore-libraries_jenny.R   
    ## 01_explore-libraries_spartan.R

``` r
(out <- file_copy(from_files, to_files))
```

    ## 01_explore-libraries_comfy.R   01_explore-libraries_jenny.R   
    ## 01_explore-libraries_spartan.R

``` r
dir_ls()
```

    ## 00_filesystem-practice_jenny.R
    ## 00_filesystem-practice_jenny.spin.R
    ## 00_filesystem-practice_jenny.spin.Rmd
    ## 01_explore-libraries_comfy.R
    ## 01_explore-libraries_comfy.html
    ## 01_explore-libraries_jenny.R
    ## 01_explore-libraries_spartan.R
    ## README.md
    ## explore-libraries.Rproj

``` r
dir_info()
```

    ##                                    path type    size permissions
    ## 1        00_filesystem-practice_jenny.R file   1.72K   rw-r--r--
    ## 2   00_filesystem-practice_jenny.spin.R file   1.72K   rw-r--r--
    ## 3 00_filesystem-practice_jenny.spin.Rmd file   1.82K   rw-r--r--
    ## 4          01_explore-libraries_comfy.R file   1.67K   rw-r--r--
    ## 5       01_explore-libraries_comfy.html file 729.51K   rw-r--r--
    ## 6          01_explore-libraries_jenny.R file   1.54K   rw-r--r--
    ## 7        01_explore-libraries_spartan.R file     850   rw-r--r--
    ## 8                             README.md file     146   rw-r--r--
    ## 9               explore-libraries.Rproj file     205   rw-r--r--
    ##     modification_time  user group device_id hard_links special_device_id
    ## 1 2018-01-31 14:05:58 Aaron staff  16777220          1                 0
    ## 2 2018-01-31 14:05:59 Aaron staff  16777220          1                 0
    ## 3 2018-01-31 14:05:59 Aaron staff  16777220          1                 0
    ## 4 2018-01-31 11:47:31 Aaron staff  16777220          1                 0
    ## 5 2018-01-31 13:59:52 Aaron staff  16777220          1                 0
    ## 6 2018-01-31 11:47:31 Aaron staff  16777220          1                 0
    ## 7 2018-01-31 11:47:31 Aaron staff  16777220          1                 0
    ## 8 2018-01-31 13:46:17 Aaron staff  16777220          1                 0
    ## 9 2018-01-31 13:31:11 Aaron staff  16777220          1                 0
    ##        inode block_size blocks flags generation         access_time
    ## 1 8591757643    4194304      8     0          0 2018-01-31 14:06:00
    ## 2 8591757771    4194304      8     0          0 2018-01-31 14:06:00
    ## 3 8591757772    4194304      8     0          0 2018-01-31 14:06:00
    ## 4 8591757779    4194304      8     0          0 2018-01-31 14:06:00
    ## 5 8591757154    4194304   1464     0          0 2018-01-31 14:04:35
    ## 6 8591757780    4194304      8     0          0 2018-01-31 14:06:00
    ## 7 8591757781    4194304      8     0          0 2018-01-31 14:06:00
    ## 8 8591755800    4194304      8     0          0 2018-01-31 13:46:19
    ## 9 8591754278    4194304      8     0          0 2018-01-31 13:40:35
    ##           change_time          birth_time
    ## 1 2018-01-31 14:05:58 2018-01-31 11:21:08
    ## 2 2018-01-31 14:05:59 2018-01-31 14:05:59
    ## 3 2018-01-31 14:05:59 2018-01-31 14:05:59
    ## 4 2018-01-31 14:06:00 2018-01-31 11:47:31
    ## 5 2018-01-31 13:59:52 2018-01-31 13:59:52
    ## 6 2018-01-31 14:06:00 2018-01-31 11:47:31
    ## 7 2018-01-31 14:06:00 2018-01-31 11:47:31
    ## 8 2018-01-31 13:46:17 2018-01-31 13:46:17
    ## 9 2018-01-31 13:31:11 2018-01-31 13:31:10

``` r
## Sidebar: Why does Jenny name files this way? ----
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
ft <- tibble(files = dir_ls(glob = "*.R"))
ft
```

    ## # A tibble: 5 x 1
    ##   files                              
    ##   <fs::path>                         
    ## 1 00_filesystem-practice_jenny.R     
    ## 2 00_filesystem-practice_jenny.spin.R
    ## 3 01_explore-libraries_comfy.R       
    ## 4 01_explore-libraries_jenny.R       
    ## 5 01_explore-libraries_spartan.R

``` r
ft %>%
  filter(str_detect(files, "explore"))
```

    ## # A tibble: 3 x 1
    ##   files                         
    ##   <fs::path>                    
    ## 1 01_explore-libraries_comfy.R  
    ## 2 01_explore-libraries_jenny.R  
    ## 3 01_explore-libraries_spartan.R

``` r
ft %>%
  mutate(files = path_ext_remove(files)) %>%
  separate(files, into = c("i", "topic", "flavor"), sep = "_")
```

    ## # A tibble: 5 x 3
    ##   i     topic               flavor    
    ## * <chr> <chr>               <chr>     
    ## 1 00    filesystem-practice jenny     
    ## 2 00    filesystem-practice jenny.spin
    ## 3 01    explore-libraries   comfy     
    ## 4 01    explore-libraries   jenny     
    ## 5 01    explore-libraries   spartan

``` r
dirs <- dir_ls(path_home("Desktop"), type = "directory")
(dt <- tibble(dirs = path_file(dirs)))
```

    ## # A tibble: 9 x 1
    ##   dirs                     
    ##   <fs::path>               
    ## 1 Empirics                 
    ## 2 ICPIStyleGuide           
    ## 3 IEDC - Metrics           
    ## 4 Jordan                   
    ## 5 day1_s1_explore-libraries
    ## 6 day1_s2_copy-files       
    ## 7 explore-libraries        
    ## 8 good viz examples        
    ## 9 jac_wed

``` r
dt %>%
  separate(dirs, into = c("day", "session", "topic"), sep = "_")
```

    ## Warning: Too few values at 7 locations: 1, 2, 3, 4, 7, 8, 9

    ## # A tibble: 9 x 3
    ##   day               session topic            
    ## * <chr>             <chr>   <chr>            
    ## 1 Empirics          <NA>    <NA>             
    ## 2 ICPIStyleGuide    <NA>    <NA>             
    ## 3 IEDC - Metrics    <NA>    <NA>             
    ## 4 Jordan            <NA>    <NA>             
    ## 5 day1              s1      explore-libraries
    ## 6 day1              s2      copy-files       
    ## 7 explore-libraries <NA>    <NA>             
    ## 8 good viz examples <NA>    <NA>             
    ## 9 jac               wed     <NA>

``` r
## Principled use of delimiters --> meta-data can be recovered from filename

## Clean it out, so we reset for workshop ----
file_delete(to_files)
dir_ls()
```

    ## 00_filesystem-practice_jenny.R
    ## 00_filesystem-practice_jenny.spin.R
    ## 00_filesystem-practice_jenny.spin.Rmd
    ## 01_explore-libraries_comfy.html
    ## README.md
    ## explore-libraries.Rproj
