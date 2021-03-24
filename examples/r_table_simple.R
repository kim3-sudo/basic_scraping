# author: @kim3
# This is an example scraping script that uses rvest

# MIT License
#
# Copyright (c) 2021 Sejin Kim
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Import required libraries
library(rvest)
library(xml2)
library(dplyr)

# Read the HTML from the desired webpage into a R object
html <- read_html("https://beyondmercury.com/cslab/sampletable/")
# Get all of the tables from the webpage
tables <- html_nodes(html, "table")

head(tables)

# Parse the HTML
soccer <- html %>%
  html_nodes("table") %>%
  .[1] %>%
  html_table(fill = TRUE)

# Make sure the table structure is as expected
str(soccer)
head(soccer[[1]], 4)

# Convert the list into a R dataframe
# Remove row 1 that contains the column header names
soccer[[1]] <- soccer[[1]][-1,]
# Rename columns
colnames(soccer[[1]]) <- c("", "id", "name", "vision", "composure", "acceleration", "speed", "stamina", "strength", "balance", "agility", "jumping", "heading")
# Check work
head(soccer[[1]], 4)

# Convert tibble to RDF
soccer = as.data.frame(soccer)
# Typecast dataframe to numerical
soccer$vision <- as.numeric(soccer$vision)
soccer$composure <- as.numeric(soccer$composure)
soccer$acceleration <- as.numeric(soccer$acceleration)
soccer$speed <- as.numeric(soccer$speed)
soccer$stamina <- as.numeric(soccer$stamina)
soccer$strength <- as.numeric(soccer$strength)
soccer$balance <- as.numeric(soccer$balance)
soccer$agility <- as.numeric(soccer$agility)
soccer$jumping <- as.numeric(soccer$jumping)
soccer$heading <- as.numeric(soccer$heading)
# Spot test datatype
mode(soccer$stamina)

saveRDS(soccer, './soccer.rds')
