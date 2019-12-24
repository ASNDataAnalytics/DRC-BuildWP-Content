
# * Code Template for Shiny App with iFrame -------------------------------

library(shiny)
library(ggplot2)
library(dplyr)
library(extrafont)
loadfonts(quiet = TRUE)

# * Grants Data -----------------------------------------------------------

grants <- tibble::tribble(
  ~year,                  ~grant, ~grant_category, ~applicants, ~new_recipients, ~cont_recipients, ~total_recipients, ~new_percent_funded, ~new_award, ~cont_award, ~total_award,
   1996,            "Gottschalk",           "CDG",          NA,               1,                0,                 1,                  NA,      75000,           0,        75000,
   1996,           "Scherbenske",         "Other",          NA,               2,                0,                 2,                  NA,         NA,          NA,           NA,
   1996,                 "Total",         "Total",          NA,               3,                0,                 3,                  NA,      75000,           0,        75000,
   1997,            "Gottschalk",           "CDG",           5,               1,                1,                 2,                 0.2,      75000,       75000,       150000,
   1997,           "Scherbenske",         "Other",          NA,               2,                0,                 2,                  NA,         NA,          NA,           NA,
   1997,                 "Total",         "Total",           5,               3,                1,                 4,                  NA,      75000,       75000,       150000,
   1998,            "Gottschalk",           "CDG",           7,               2,                1,                 3,         0.285714286,     150000,       75000,       225000,
   1998,           "Scherbenske",         "Other",           6,               4,                0,                 4,         0.666666667,      50000,           0,        50000,
   1998,                  "R-29",         "Other",          18,               6,                0,                 6,         0.333333333,     150000,          NA,       150000,
   1998,                 "Total",         "Total",          31,              12,                1,                13,         0.387096774,     350000,      150000,       425000,
   1999,            "Gottschalk",           "CDG",           8,               2,                2,                 4,                0.25,     150000,      150000,        3e+05,
   1999,           "Scherbenske",         "Other",           8,               3,                4,                 7,               0.375,      12500,      150000,       162500,
   1999,                  "R-29",         "Other",           0,               0,                6,                 6,                   0,          0,      150000,       150000,
   1999,                 "Total",         "Total",          16,               5,                6,                11,              0.3125,     162500,      450000,       612500,
   2000,            "Gottschalk",           "CDG",           6,               2,                2,                 4,         0.333333333,     150000,      150000,        3e+05,
   2000,           "Scherbenske",         "Other",           7,               2,                3,                 5,         0.285714286,      50000,       1e+05,       150000,
   2000,                  "R-29",         "Other",           0,               0,                6,                 6,                   0,          0,       62492,        62492,
   2000,                   "SSG",           "SSG",           2,               2,                0,                 2,                   1,      62400,           0,        62400,
   2000,                 "Total",         "Total",          15,               6,               11,                17,                 0.4,     262400,      312492,       574892,
   2001,            "Gottschalk",           "CDG",          12,               3,                2,                 5,                0.25,      3e+05,      150000,       450000,
   2001,               "Merrill",           "CDG",           2,               1,                0,                 1,                 0.5,      1e+05,           0,        1e+05,
   2001,           "Scherbenske",         "Other",           5,               3,                2,                 5,                 0.6,      75000,       50000,       125000,
   2001,                   "SSG",           "SSG",           5,               3,                0,                 3,                 0.6,      93600,           0,        93600,
   2001,                 "Total",         "Total",          24,              10,                4,                14,         0.416666667,     568600,       2e+05,       768600,
   2002,            "Gottschalk",           "CDG",          10,               4,                3,                 7,                 0.4,      4e+05,       3e+05,        7e+05,
   2002,               "Merrill",           "CDG",           2,               1,                1,                 2,                 0.5,      1e+05,       1e+05,        2e+05,
   2002, "Health Services (RPA)",           "CDG",           6,               1,                0,                 1,         0.166666667,      1e+05,           0,        1e+05,
   2002,           "Scherbenske",         "Other",           4,               2,                3,                 5,                 0.5,      50000,       37500,        87500,
   2002,                 "Total",         "Total",          22,               8,                7,                15,         0.363636364,     650000,      437500,      2087500,
   2003,            "Gottschalk",           "CDG",           7,               3,                4,                 7,         0.428571429,      3e+05,   399742.84,    699742.84,
   2003,               "Merrill",           "CDG",           2,               1,                1,                 2,                 0.5,      1e+05,       1e+05,        2e+05,
   2003,        "ASP Geriatrics",           "CDG",           4,               2,                0,                 2,                 0.5,     150000,           0,       150000,
   2003, "Health Services (RPA)",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       1e+05,        1e+05,
   2003,           "Scherbenske",         "Other",           9,               7,                2,                 9,         0.777777778,      75000,       50000,        75000,
   2003,                   "SSG",           "SSG",           1,               1,                0,                 1,                   1,      31200,           0,        31200,
   2003,                 "Total",         "Total",          23,              14,                8,                22,         0.608695652,     656200,   649742.84,   1255942.84,
   2004,            "Gottschalk",           "CDG",          21,               3,                3,                 6,         0.142857143,      3e+05,       3e+05,        6e+05,
   2004,               "Merrill",           "CDG",           7,               1,                1,                 2,         0.142857143,      1e+05,       1e+05,        2e+05,
   2004,        "ASP Geriatrics",           "CDG",           4,               2,                2,                 4,                 0.5,     150000,       15000,       165000,
   2004, "Health Services (RPA)",           "CDG",           7,               1,                0,                 1,         0.142857143,      1e+05,           0,        1e+05,
   2004,                  "KUFA",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2004,           "Scherbenske",         "Other",           7,               2,                5,                 7,         0.285714286,      1e+05,      175000,       275000,
   2004,                   "SSG",           "SSG",           4,               1,                0,                 1,                0.25,       7500,           0,         7500,
   2004,                 "Total",         "Total",          50,              11,               11,                22,                0.22,     857500,      590000,      1447500,
   2005,            "Gottschalk",           "CDG",          30,               3,                3,                 6,                 0.1,      3e+05,       3e+05,        6e+05,
   2005,               "Merrill",           "CDG",           4,               1,                1,                 2,                0.25,      1e+05,       1e+05,        2e+05,
   2005,        "ASP Geriatrics",           "CDG",           1,               1,                2,                 3,                   1,      75000,      150000,       225000,
   2005,                  "KUFA",           "CDG",           1,               1,                1,                 2,                   1,      1e+05,       1e+05,        2e+05,
   2005,           "Scherbenske",         "Other",          12,               2,                2,                 4,         0.166666667,      75000,      225000,        3e+05,
   2005,        "New Directions",         "Other",          11,               2,                0,                 2,         0.181818182,      1e+05,           0,        1e+05,
   2005,                   "SSG",           "SSG",           4,               1,                0,                 1,                0.25,       7500,           0,         7500,
   2005,                 "Total",         "Total",          63,              11,                9,                20,         0.174603175,     757500,      875000,      1632500,
   2006,            "Gottschalk",           "CDG",          43,               6,                3,                 9,         0.139534884,     558333,       2e+05,       758333,
   2006,               "Merrill",           "CDG",          10,               1,                1,                 2,                 0.1,      1e+05,       1e+05,        2e+05,
   2006,        "ASP Geriatrics",           "CDG",           5,               2,                1,                 3,                 0.4,     150000,       75000,       225000,
   2006,                   "AKF",           "CDG",           1,               1,                0,                 1,                   1,      1e+05,           0,        1e+05,
   2006,                  "KUFA",           "CDG",           1,               1,                1,                 2,                   1,      1e+05,       1e+05,        2e+05,
   2006,                "Halpin",           "CDG",           3,               1,                0,                 1,         0.333333333,      1e+05,           0,        1e+05,
   2006,           "Scherbenske",         "Other",           1,               0,                2,                 2,                   0,          0,      125000,       125000,
   2006,        "New Directions",         "Other",           9,               1,                2,                 3,         0.111111111,      50000,       1e+05,       150000,
   2006,                   "SSG",           "SSG",           5,               3,                0,                 3,                 0.6,      22000,           0,        22000,
   2006,                 "Total",         "Total",          78,              16,               10,                26,         0.205128205,    1180333,       7e+05,      1880333,
   2007,            "Gottschalk",           "CDG",          39,               7,                5,                12,         0.230769231,  607600.71,       5e+05,   1107600.71,
   2007,                "Siegel",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2007,               "Merrill",           "CDG",           9,               2,                1,                 3,         0.222222222,      2e+05,       1e+05,        3e+05,
   2007,        "ASP Geriatrics",           "CDG",          NA,               0,                2,                 2,                  NA,          0,      150000,       150000,
   2007,                   "AKF",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2007,                "Halpin",           "CDG",           2,               1,                0,                 1,                 0.5,      1e+05,           0,        1e+05,
   2007,           "Scherbenske",         "Other",           3,               2,                0,                 2,         0.666666667,      50000,           0,        50000,
   2007,        "New Directions",         "Other",           8,               2,                1,                 3,                0.25,      2e+05,       1e+05,        3e+05,
   2007,                   "SSG",           "SSG",           1,               0,                0,                 0,                   0,          0,           0,            0,
   2007,                 "Total",         "Total",          62,              16,                9,                25,         0.258064516, 1357600.71,      850000,   2207600.71,
   2008,            "Gottschalk",           "CDG",          NA,              10,                6,                16,                  NA,     950000,       6e+05,      1550000,
   2008,                "Siegel",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2008,               "Merrill",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2008,        "ASP Geriatrics",           "CDG",          NA,               2,                0,                 2,                  NA,     134950,           0,       134950,
   2008,                   "AKF",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2008,                "Halpin",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2008,           "Scherbenske",         "Other",           8,               4,                3,                 7,                 0.5,      3e+05,      225000,       525000,
   2008,        "New Directions",         "Other",           6,               1,                0,                 1,         0.166666667,      50000,           0,        50000,
   2008,                   "SSG",           "SSG",           6,               6,                0,                 6,                   1,      88000,           0,        88000,
   2008,                 "Total",         "Total",          71,              27,               13,                40,          0.38028169,    1922950,     1225000,      3147950,
   2009,            "Gottschalk",           "CDG",          NA,              13,                9,                22,                  NA,    1100000,      850000,      1950000,
   2009,                "Siegel",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2009,                   "AKF",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2009,        "ASP Geriatrics",           "CDG",          NA,               1,                2,                 3,                  NA,      75000,      134950,       209950,
   2009,               "Merrill",           "CDG",          NA,               1,                1,                 2,                  NA,      50000,       1e+05,       150000,
   2009,                "Halpin",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2009,           "Scherbenske",         "Other",           5,               3,                3,                 6,                  NA,     250000,      175000,       425000,
   2009,        "New Directions",         "Other",          NA,               0,                1,                 1,                   0,          0,       50000,        50000,
   2009,                   "SSG",           "SSG",          15,              10,               NA,                10,                  NA,      90500,           0,        90500,
   2009,                 "Total",         "Total",          83,              31,               19,                50,         0.373493976,    1865500,     1609950,      3475450,
   2010,            "Gottschalk",           "CDG",          NA,               7,                8,                15,                  NA,      7e+05,   708195.71,   1408195.71,
   2010,                   "AKF",           "CDG",          NA,               0,                1,                 1,                  NA,          0,    95240.69,     95240.69,
   2010,                "Siegel",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2010,        "ASP Geriatrics",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       75000,        75000,
   2010,               "Merrill",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2010,                "Halpin",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       1e+05,        1e+05,
   2010,           "Scherbenske",         "Other",           4,               3,                0,                 3,                0.75,   217334.5,           0,     217334.5,
   2010,                   "SSG",           "SSG",           8,               7,                0,                 7,               0.875,     126550,           0,       126550,
   2010,                 "Total",         "Total",          57,              19,               12,                31,         0.333333333,  1243884.5,   1078436.4,    2322320.9,
   2011,            "Gottschalk",           "CDG",          NA,               7,                7,                14,                  NA,      7e+05,      650000,      1350000,
   2011,        "ASP Geriatrics",           "CDG",          NA,               2,                0,                 2,                  NA,      50000,           0,        50000,
   2011,                "Siegel",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2011,               "Merrill",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2011,           "Scherbenske",         "Other",           6,               2,                0,                 2,         0.333333333,      2e+05,           0,        2e+05,
   2011,                   "SSG",           "SSG",          22,              18,                0,                18,         0.818181818,      2e+05,           0,        2e+05,
   2011,                 "Total",         "Total",          80,              31,                9,                40,              0.3875,    1350000,      850000,      2200000,
   2012,            "Gottschalk",           "CDG",          NA,               6,                7,                13,                  NA,      6e+05,      574409,      1174409,
   2012,        "ASP Geriatrics",           "CDG",          NA,               1,                2,                 3,                  NA,      12500,       50000,        62500,
   2012,                "Siegel",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2012,               "Merrill",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       1e+05,        1e+05,
   2012,              "NephCure",           "CDG",          NA,               1,                0,                 1,                  NA,      99560,           0,        99560,
   2012,           "Scherbenske",         "Other",           4,               1,                0,                 1,                0.25,   23696.76,           0,     23696.76,
   2012,                   "SSG",           "SSG",          20,              18,                0,                18,                 0.9,     178000,       33000,       211000,
   2012,                 "Lipps",         "Other",          68,              11,                0,                11,         0.161764706,      5e+05,           0,        5e+05,
   2012,                 "Total",         "Total",         161,              39,               11,                50,         0.242236025, 1513756.76,      857409,   2371165.76,
   2013,            "Gottschalk",           "CDG",          NA,               7,                6,                13,                  NA,      7e+05,       6e+05,      1300000,
   2013,        "ASP Geriatrics",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       12500,        12500,
   2013,                "Siegel",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2013,               "Merrill",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2013,              "NephCure",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2013,                   "OHF",           "CDG",          NA,               0,                0,                 0,                  NA,          0,           0,            0,
   2013,                "Halpin",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2013,                 "Lipps",         "Other",          48,              10,               10,                20,         0.208333333,      5e+05,       5e+05,        1e+06,
   2013,                   "SSG",           "SSG",          16,              16,                1,                17,                   1,     241500,       13000,       254500,
   2013,                 "Total",         "Total",         127,              37,               20,                57,         0.291338583,    1841500,     1325500,      3167000,
   2014,            "Gottschalk",           "CDG",          NA,               7,                7,                14,                  NA,      7e+05,       7e+05,      1400000,
   2014,        "ASP Geriatrics",           "CDG",          NA,               0,                1,                 1,                  NA,      12500,           0,        12500,
   2014,                "Siegel",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       1e+05,        1e+05,
   2014,              "NephCure",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2014,               "Merrill",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2014,                   "OHF",           "CDG",          NA,               0,                0,                 0,                  NA,          0,           0,            0,
   2014,                "Halpin",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       1e+05,        1e+05,
   2014,                 "Lipps",         "Other",          54,              10,                9,                19,         0.185185185,      5e+05,      450000,       950000,
   2014,               "Bennett",         "Other",           7,               1,                0,                 1,         0.142857143,      25000,           0,        25000,
   2014,                   "SSG",           "SSG",          22,              19,                1,                20,         0.863636364,     217000,       10500,       227500,
   2014,                 "Total",         "Total",         138,              20,               20,                20,         0.144927536,    1654500,     1460500,      3115000,
   2015,            "Gottschalk",           "CDG",          NA,               7,                7,                14,                  NA,      7e+05,      548112,      1248112,
   2015,       "AAIM Geriatrics",           "CDG",          NA,               1,                0,                 1,                  NA,      25000,           0,        25000,
   2015,                "Siegel",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2015,               "Merrill",           "CDG",          NA,               0,                1,                 1,                  NA,      1e+05,           0,        1e+05,
   2015,              "NephCure",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       50000,       150000,
   2015,                   "OHF",           "CDG",          NA,               0,                0,                 0,                  NA,          0,           0,            0,
   2015,                 "Lipps",         "Other",          55,              10,                8,                18,         0.181818182,     425000,    313006.4,     738006.4,
   2015,               "Bennett",         "Other",           2,               1,                1,                 2,                 0.5,      50000,       50000,        1e+05,
   2015,                 "Total",         "Total",         127,              21,               18,                39,         0.165354331,    1500000,    961118.4,    2461118.4,
   2016,            "Gottschalk",           "CDG",          NA,               6,                6,                12,                  NA,     561888,       6e+05,      1161888,
   2016,       "AAIM Geriatrics",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       25000,        25000,
   2016,                "Siegel",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2016,               "Merrill",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2016,              "NephCure",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2016,                   "OHF",           "CDG",          NA,               0,                0,                 0,                  NA,          0,           0,            0,
   2016,                 "Lipps",         "Other",          45,              10,                4,                14,         0.222222222,      5e+05,       2e+05,        7e+05,
   2016,               "Bennett",         "Other",           2,               1,                1,                 2,                 0.5,      50000,       25000,        75000,
   2016,             "ASN-AMFDP",         "Other",          17,               1,                0,                 1,         0.058823529,     105000,           0,       105000,
   2016,                 "Total",         "Total",         118,              21,               13,                34,         0.177966102,    1516888,      950000,      2466888,
   2017,            "Gottschalk",           "CDG",          NA,               6,                6,                12,                  NA,     554463,      545013,      1099476,
   2017,                "Siegel",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2017,               "Merrill",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2017,              "NephCure",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       50000,        50000,
   2017,                   "OHF",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2017,                 "Lipps",         "Other",          51,              10,                9,                19,         0.196078431,     475000,      450000,       925000,
   2017,               "Bennett",         "Other",           2,               1,                1,                 2,                 0.5,      50000,       50000,        1e+05,
   2017,             "ASN-AMFDP",         "Other",          10,               0,                1,                 1,                   0,          0,      105000,       105000,
   2017,                 "Total",         "Total",         121,              20,               20,                40,         0.165289256,    1379463,     1400013,      2779476,
   2018,            "Gottschalk",           "CDG",          NA,               6,                6,                12,                  NA,     577000,      596729,      1173729,
   2018,                "Siegel",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2018,               "Merrill",           "CDG",          NA,               1,                1,                 2,                  NA,      1e+05,       1e+05,        2e+05,
   2018,             "Bonventre",           "CDG",          NA,               1,                0,                 1,                  NA,      1e+05,           0,        1e+05,
   2018,                   "OHF",           "CDG",          NA,               0,                1,                 1,                  NA,          0,       1e+05,        1e+05,
   2018,                 "Lipps",         "Other",          52,              10,                9,                19,         0.192307692,      5e+05,      450000,       950000,
   2018,               "Bennett",         "Other",           6,               1,                1,                 2,         0.166666667,      50000,       50000,        1e+05,
   2018,             "ASN-AMFDP",         "Other",           7,              NA,                1,                 1,                   0,         NA,      105000,       105000,
   2018,   "Pre-Doc Fellowships",         "Other",          28,               4,                0,                 4,         0.142857143,      40000,           0,        40000,
   2018,                 "Total",         "Total",         150,              24,               19,                43,                0.16,    1467000,     1401729,      2868729
  )




# * Tag for Embedding into Website ----------------------------------------

## Source: https://www.brettory.com/2018/02/embedding-a-shiny-app-in-blogdown/

## YAML

# ```{r setup, include=FALSE}
# knitr::opts_chunk$set(echo = TRUE)
# 
# library(dplyr)
# library(ggplot2)
# library(shiny)
# library(widgetframe)
# ```

# Here you can also control the size of the frame with commands width and height, 
# and additional commands like scrolling and frameborder to make it look a 
# little nicer. The exact command I use to embed the shiny app is:
# 	
# 	```
# <iframe width="700" height="400" scrolling="no" frameborder="no"  src="https://brettory.shinyapps.io/gender_tech_country/"> </iframe>
# 	```
# 
# 
# The final product: 
# 	
# 	
# 	<br>
# 	
# 	<iframe width="700" height="400" scrolling="no" frameborder="no"  src="https://brettory.shinyapps.io/gender_tech_country/"> </iframe> 
# <iframe width="450" height="400" scrolling="no" frameborder="no"  src="https://brettory.shinyapps.io/gender_tech_country/"> </iframe>

# * UI --------------------------------------------------------------------

ui <- shinyUI(
	fluidPage(
		## Add Calls to Webfonts and iFrame Resizer
		tags$head(
			tags$style(
			HTML("
        @import url('//fonts.googleapis.com/css?family=Roboto');
        h1 {
            font-family: 'Roboto Black';
            line-height: 1.1;
            color: #3366cc;
        }
        ")
			), 
		tags$script(
			src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/3.5.16/iframeResizer.contentWindow.min.js", 
			type="text/javascript")
		), 
	
	# Application title
	headerPanel("ASN Grants Portfolio"),
	
	# Sidebar with a dropdown input for number of bins 
	fluidPage(
		sidebarPanel(
			selectInput("Year",
									label = h3("ASN Grants \nDisbursed by Year"),
									choices = list(
										"1996", "1997", "1998", "1999", "2000", "2001", 
										"2002", "2003", "2004", "2005", "2006", "2007",
										"2008", "2009", "2010", "2011", "2012", "2013",
										"2014", "2015", "2016", "2017", "2018"
										)
									)
			),
		
		# Show a plot of the generated distribution
		mainPanel(
			plotOutput("plot"), 
			HTML('<div data-iframe-height></div>')
			)
		)
	)
)


# * Server ----------------------------------------------------------------

server <- shinyServer(function(input, output) {
	output$plot <- renderPlot({
		
		grants %>% 
			dplyr::filter(
				!grant == "Total"
				) %>% 
			dplyr::filter(
				year == as.numeric(input$Year)
				) %>% 
			group_by(
				year, 
				grant_category
				) %>% 
			mutate(Total = sum(total_award)) %>% 
			select(
				year, 
				grant_category, 
				Total
				) %>% 
			distinct(year, grant_category, Total) %>% 
			ggplot(
				aes(
					x = grant_category, 
					y = Total)
				) +
			geom_bar(
				stat = "identity", 
				width = .7, 
				fill = "#4267b1"
				) +
			scale_y_continuous(
				labels = scales::dollar
				) +
			labs(x = "", y = "") +
			theme_minimal(
				base_size = 14, 
				base_family = "Roboto"
				) +
			ggtitle(
				paste("ASN Grants Disbursed", input$Year)
				) +
			geom_text(
				aes(
					label = scales::dollar(Total)
					), 
				vjust = -0.6, 
				family = "Roboto",
				size = 4
				) +
			theme(
				plot.title = element_text(hjust = 0.5)
			)
	})
})


# * App -------------------------------------------------------------------

shinyApp(ui = ui, server = server)	


