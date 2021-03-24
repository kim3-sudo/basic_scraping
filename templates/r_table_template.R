# author: @kim3
# This is an scraping script template that uses rvest
# You need to finish this script before it will run!

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
data <- html %>%
  html_nodes("table") %>%
  .[1] %>%
  html_table(fill = TRUE)

# Make sure the table structure is as expected
str(data)
head(data[[1]], 4)

# Convert the list into a R dataframe
# Remove row 1 that contains the column header names
data[[1]] <- data[[1]][-1,]
# Rename columns
colnames(data[[1]]) <- c("col1", "col2", "col3")
# Check work
head(data[[1]], 4)

# Convert tibble to RDF
dataframe = as.data.frame(data)
# Typecast numerical dataframe variables to numerical type
dataframe$variable <- as.numeric(dataframe$variable)

saveRDS(dataframe, './choose where to save your r dataset and what to name it')