#' Which libraries does R search for pkgsages?

# try .libPaths(), .Library

.libPaths()

#' Installed pkgsages

## use installed.pkgsages() to get all installed pkgsages
## if you like working with data frame or tibble, make it so right away!
## remember to use View() or similar to inspect

pkgs <- installed.pkgsages() %>% as.tibble()

## how many pkgsages?

nrow(pkgs)

#' Exploring the pkgsages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
##   * what proportion need compilation?
##   * how break down re: version of R they were built on

## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))


glimpse(pkgs)
pkgs %>% distinct(Priority)

pkgs %>% count(Priority)
pkgs %>% count(Priority, Built)
pkgs %>% count(Priority) %>% mutate(prop = n/sum(n))

pkgs %>% count(Priority, Suggests) %>% print(n = Inf)

pkgs %>% 
    select(Priority, pkgsage) %>% 
    arrange(Priority) %>% 
    print(n = Inf)

pkgs %>% 
    mutate(addtl_needs = ifelse(is.na(Suggests), 0, str_count(Suggests, ",") + 1)) %>% 
    count(Priority, addtl_needs)
           
           
           
           
           

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended pkgsages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


#' Going further

## if you have time to do more ...

## is every pkgsage in .Library either base or recommended?
## study pkgsage naming style (all lower case, contains '.', etc
## use `fields` argument to installed.pkgsages() to get more info and use it!
