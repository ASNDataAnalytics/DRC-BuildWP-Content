
# * Source File for MH Revenue App ----------------------------------------


# * Load Packages ---------------------------------------------------------

require(shiny)
require(extrafont)
loadfonts(quiet = TRUE)
require(DT)
require(tidyverse)



# * Load Data -------------------------------------------------------------

mh <- tbl_df(
  read.table(
    header = TRUE, 
    text = "
Specialty Average_Revenue Average_Salary
Cardiology_(Invasive) $3,484,375 $590,000
Cardiology/Non-Inv. $2,310,000 $427,000
Cardiovascular_Surgery $3,697,916 $425,000
Family_Practice $2,111,931 $241,000
Gastroenterology $2,965,277 $487,000
General_Surgery $2,707,317 $350,000
Hematology/Oncology $2,855,000 $425,000
Internal_Medicine $2,675,387 $261,000
Nephrology $1,789,062 $272,000
Neurology $2,052,884 $301,000
Neurosurgery $3,437,500 $687,000
OB/GYN $2,024,193 $324,000
Ophthalmology $1,440,217 $300,000
Orthopedic_Surgery $3,286,764 $533,000
Otolaryngology $1,937,500 $405,000
Pediatrics $1,612,500 $230,000
Psychiatry $1,820,512 $261,000
Pulmonology $2,361,111 $418,000
Urology $2,161,458 $386,000
",
    stringsAsFactors = FALSE)
) 

df <- read_csv(
  file = "table.csv")


# * Clean and Mutate ------------------------------------------------------


mh <- mh %>% 
  mutate(
    `Mean Revenue` = parse_number(Average_Revenue),
    `Mean Salary` = parse_number(Average_Salary)
  ) %>% 
  mutate(
    ROI = (`Mean Revenue` - `Mean Salary`) / `Mean Salary` 
  ) %>% 
  arrange(
    desc(ROI), 
    `Mean Salary`
  ) %>%
  select(
    Specialty,
    `Mean Revenue`,
    `Mean Salary`,
    ROI
  )



# * Additional Data for Data Table ----------------------------------------

## POC 

# a <- tbl_df(
#   read.table(
#     text = "
# 2019 $2,310,000
# 2016 $1,260,971
# 2013 $1,232,142
# 2010 $1,319,658
# 2007 $2,240,786
# 2004 $2,646,039
# 2002 N/A")
# ) %>% 
#   mutate(
#     Specialty = rep("Cardiology Non-Invasive", nrow(.))
#   ) %>% 
#   mutate(Revenue = V2 %>% 
#            as.character() %>% 
#            parse_number()
#   ) %>% 
#   select(
#     Year = V1,
#     Specialty, 
#     Revenue)

# * Reading Function ------------------------------------------------------

# test_fun <- function(copy, name) {
#   x <- tbl_df(
#     read.table(
#     text = copy
#     ) %>% 
#       mutate(
#         Specialty = rep(name, nrow(.))
#         ) %>% 
#         mutate(Revenue = V2 %>% 
#                  as.character() %>% 
#                  parse_number()
#                ) %>% 
#           select(
#             Year = V1,
#             Specialty, 
#             Revenue
#           )
#       )
#   x
# }
# 
# a <- test_fun("
# 2019 $2,310,000
# 2016 $1,260,971
# 2013 $1,232,142
# 2010 $1,319,658
# 2007 $2,240,786
# 2004 $2,646,039
# 2002 N/A", 
#               name = "Cardiology\u2013Non-Invasive")
# 
# b <- test_fun("
# 2019 $3,484,375
# 2016 $2,448,136
# 2013 $2,169,643
# 2010 $2,240,366
# 2007 $2,662,600
# 2004 $2,490,748
# 2002 N/A", name = "Cardiology\u2013Invasive"
# )
# 
# c <- test_fun(
#   copy = "2019 $2,111,931
# 2016 $1,493,518
# 2013 $2,067,567
# 2010 $1,662,832
# 2007 $1,615,828
# 2004 $2,000,329
# 2002 $1,559,482",
#   name = "Family Practice"
# )
# 
# d <- test_fun(
#   copy = "2019 $2,965,277
# 2016 $1,422,677
# 2013 $1,385,714
# 2010 $1,450,590
# 2007 $1,335,133
# 2004 $1,735,338
# 2002 $1,246,428",
#   name = "Gastroenterology"
# )
# 
# e <- test_fun(
#   copy = "2019 $2,707,317
# 2016 $2,169,673
# 2013 $1,860,566
# 2010 $2,112,492
# 2007 $1,947,934
# 2004 $2,446,987
# 2002 $1,835,470",
#   name = "General Surgery")
# 
# f <- test_fun(
#   copy = "2019 $2,855,000
# 2016 $1,688,056
# 2013 $1,761,029
# 2010 $1,485,627
# 2007 $1,624,246
# 2004 $1,802,749
# 2002 $1,810,546",
#   name = "Hematology/Oncology"
# )
#  
# g <- test_fun(
#   copy = "2019 $2,675,387
# 2016 $1,830,200
# 2013 $1,843,137
# 2010 $1,678,253
# 2007 $1,987,253
# 2004 $2,100,124
# 2002 $1,569,000", 
#   name = "Internal Medicine"
# )
# 
# h <- test_fun(
#   copy = "2019 $1,789,062
# 2016 $1,260,971
# 2013 $1,175,000
# 2010 $696,888
# 2007 $865,214
# 2004 $1,121,000
# 2002 $1,704,326",
#   name = "Nephrology"
# )
# 
# i <- test_fun(
#   copy = "2019 $2,052,884
# 2016 $1,025,536
# 2013 $691,406
# 2010 $907,317
# 2007 $557,916
# 2004 $924,798
# 2002 $1,030,303",
#   name = "Neurology"
# )
# 
# j <- test_fun(
#   copy = "2019 $3,437,500
# 2016 $2,445,810
# 2013 $1,684,523
# 2010 $2,815,650
# 2007 $2,100,000
# 2004 $2,406,275
# 2002 $2,364,864",
#   name = "Neurosurgery"
# )
# 
# k <- test_fun(
#   copy = "2019 $2,024,193
# 2016 $1,583,209
# 2013 $1,439,024
# 2010 $1,364,131
# 2007 $1,413,436
# 2004 $1,903,919
# 2002 $1,643,028",
#   name = "Obstetrics/Gynecology"
# )
# 
# l <- test_fun(
#   copy = "2019 $1,440,217
# 2016 $1,035,577
# 2013 $725,000
# 2010 $1,662,832
# 2007 $725,000
# 2004 $842,711
# 2002 $584,310",
#   name = "Ophthalmology"
# )
# 
# m <- test_fun(
#   copy = "2019 $3,286,764
# 2016 $2,746,605
# 2013 $2,683,510
# 2010 $2,117,764
# 2007 $2,312,168
# 2004 $2,992,022
# 2002 $1,855,944",
#   name = "Orthopedic Surgery"
# )
# 
# n <- test_fun(
#   copy = "2019 $1,612,500
# 2016 $665,972
# 2013 $787,790
# 2010 $856,154
# 2007 $697,516
# 2004 $860,600
# 2002 $690,104",
#   name = "Pediatrics"
# )
# 
# o <- test_fun(
#   copy = "2019 $1,820,512
# 2016 $1,210,586
# 2013 $1,302,631
# 2010 $1,290,104
# 2007 $888,911
# 2004 $1,332,948
# 2002 $1,138,059",
#   name = "Psychiatry"
# )
# 
# p <- test_fun(
#   copy = "2019 $2,361,111
# 2016 $1,190,870
# 2013 $1,009,868
# 2010 $1,204,919
# 2007 $1,332,534
# 2004 $1,781,578
# 2002 $1,278,688",
#   name = "Pulmonology"
# )
# 
# q <- test_fun(
#   copy = "2019 $2,161,458
# 2016 $1,405,659
# 2013 $1,428,030
# 2010 $1,382,704
# 2007 $1,272,563
# 2004 $1,317,415
# 2002 $1,123,697",
#   name = "Urology"
# )
# 
# df <- 
#   rbind(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q)
# 
# write_csv(
#   df, 
#   path = here::here("03_reports", "06_MH-Revenue-Shiny/MH-Revenue/table.csv")
# )
