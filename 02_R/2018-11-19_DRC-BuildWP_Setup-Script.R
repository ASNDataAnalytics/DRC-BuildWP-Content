
# Set-Up Script -----------------------------------------------------------


# Load Packages -----------------------------------------------------------

require(tidyverse)
require(here)


# Create Directories ------------------------------------------------------

if(!dir.exists("content")) {
  dir.create("content")
}

if(!dir.exists(here::here("content", "briefs"))) {
  dir.create(here::here("content", "briefs"))
}

if(!dir.exists(here::here("content", "reports"))) {
  dir.create(here::here("content", "reports"))
}

if(!dir.exists(here::here("content", "resources"))) {
  dir.create(here::here("content", "resources"))  
}

if(!dir.exists("content_data")){
  dir.create("content_data")
}

if(!dir.exists("static")){
  dir.create("static")
}

if(!dir.exists(here::here("static", "images"))) {
  dir.create(here::here("static", "images"))
}

if(!dir.exists(here::here("static", "files"))) {
  dir.create(here::here("static", "files"))
}

if(!dir.exists("01_data")){
  dir.create("01_data")
}

if(!dir.exists("02_R")){
  dir.create("02_R")
}
