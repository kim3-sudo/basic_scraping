"""
author: @kim3

This is a more complex scraping script that works on a Sidearm sports-based platform for roster information

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
import os
import os.path
import sys
import requests
import time
import csv
import logging
import platform
from datetime import datetime
from bs4 import BeautifulSoup
from os import path

logger = logging.getLogger('scraper')

# You could also set this to be a directory by string
print('Select save dir')
enddir = input('--> ')
print('')
print('Generate filename according to the current date and time.')
now = datetime.now()
dt_string = now.strftime("_%d%m%Y_%H%M%S")
if platform.system() == 'Windows':
    endfile = enddir + '\\Swim_Roster_Scrape' + dt_string + '.csv'
elif platform.system() == 'Darwin' or platform.system() == 'Linux':
    endfile = enddir + '/Swim_Roster_Scrape' + dt_string + '.csv'
print('')
print('Attempting to scrape roster information.')

url = "https://athletics.kenyon.edu/sports/mens-swimming-and-diving/roster/"
data = requests.get(url)
soup = BeautifulSoup(data.text, 'html.parser')

athletes = soup.find("div", attrs={"class": "sidearm-roster-default-template"})
athlete_names = athletes.find_all("a", attrs={"data-bind": "click: function() { return true; }, clickBubble: false"})
athlete_list = []
for a in athlete_names:
    result1 = a.text.strip()
    athlete_list.append(result1)

# clean non-names
cleaned = False
while cleaned == False:
    for elem in athlete_list:
        if elem == 'Full Bio' or elem == '':
            athlete_list.remove(elem)
            for elem in athlete_list:
                if elem == 'Full Bio' or elem == '':
                    cleaned = False
                else:
                    cleaned = True

athlete_years = athletes.find_all("span", attrs={"class": "sidearm-roster-player-academic-year"})
athlete_year = []
for b in athlete_years[1::2]:
    result2 = b.text.strip()
    athlete_year.append(result2)

athlete_school = []
for c in athlete_years[1::2]:
    result3 = soup.title.text.strip()
    athlete_school.append(result3)

athlete_positions = athletes.find_all("span", attrs={"class": "text-bold"})
athlete_position = []
for d in athlete_positions[1::2]:
    result4 = d.text.strip()
    athlete_position.append(result4)

athlete_hometowns = athletes.find_all("span", attrs={"class": "sidearm-roster-player-hometown"})
athlete_hometown = []
for e in athlete_hometowns[1::2]:
    result5 = e.text.strip()
    athlete_hometown.append(result5)

athlete_highschools = athletes.find_all("span", attrs={"class": "sidearm-roster-player-highschool"})
athlete_highschool = []
for f in athlete_highschools[1::2]:
    result6 = f.text.strip()
    athlete_highschool.append(result6)

df = pd.DataFrame()

df['athletes'] = athlete_list
df['year'] = athlete_year
df['school'] = athlete_school
df['position'] = athlete_positions
df['hometown'] = athlete_hometown
df['highschool'] = athlete_highschool

print('Attempting to generate CSV output')
try:
    print('Checking if CSV already exists.')
    if path.exists(endfile) == False:
        print('CSV does not already exist.')
        print('Generating new CSV.')
        with open(endfile, 'a') as f:
            df.to_csv(endfile, header = None, line_terminator = '\n')
    else:
        print('CSV already exists.')
        with open(endfile, 'a') as f:
            df.to_csv(f, header=None, line_terminator='\n')
except Exception as e:
    print('Unable to generate CSV output!')
    print('Scrape failure. Error code: LRL262')
    logger.error('Failed with code: ' + str(e))
    time.sleep(1)
else:
    print('Roster array generated successfully')

print('All done!')
