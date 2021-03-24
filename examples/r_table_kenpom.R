# author: @murray1
# This is an example scraping utility for R to get data from a Google Doc

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

p_load(googlesheets, dplyr, stringr, readr, tidyr, janitor, purrr)

# authenticate to the public sheet
# note the formula in the top left cell of each sheet
# access on the web at https://docs.google.com/spreadsheets/d/1VX1JUZA-D_n6FlN4AhOnrzISmpszNAuR8qC_LqNcHoo/edit#gid=1994663602
ken_pom_data_sheet <- gs_key("1VX1JUZA-D_n6FlN4AhOnrzISmpszNAuR8qC_LqNcHoo")

gs_url("https://docs.google.com/spreadsheets/d/1Cbpedw-zK5Xy0oLdddJ52pnrq1yg61V2SSjL41r8Lgo/edit?usp=sharing", lookup = FALSE)
