"""
author: @kim3

This is a simple scraping script that works on a simple table. You can run this script right out of the box.
"""

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

import pandas as pd
import requests
from bs4 import BeautifulSoup

url = 'https://beyondmercury.com/cslab/sampletable/'
page = requests.get(url, headers = {'User-agent': 'Mozilla/5.0'}).text
soup = BeautifulSoup(page, 'html.parser')

table = soup.find("table")

# ignore the header, start at 1 instead of 0
data_rows = table.findAll('tr')[1:]

# iterate over each row and append to a list
data = []
for tr in data_rows:
    td = tr.find_all('td')
    row = [tr.text for tr in td]
    data.append(row)

# typecast the list into a proper pandas dataframe
df = pd.DataFrame(data, columns = ['', 'id', 'name', 'vision', 'composure', 'acceleration', 'speed', 'stamina', 'strength', 'balance', 'agility', 'jumping', 'heading'])

df.to_csv('./sampletable.csv')
