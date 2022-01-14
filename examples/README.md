Some more examples:

- [PLL results](https://github.com/kim3-sudo/pll_analysis/blob/main/src/scrape/pllscrape.py): for a completely custom example that also uses Selenium to interact with the webpage
  - Selenium interacts with the webpage and clicks things
  - Beautiful Soup 4 scrapes and parses the webpage
- [Manchester United](https://github.com/kim3-sudo/soccer_goal_analysis/blob/main/src/scrape/manutd_scrape.py): a more realistic scraper
  - Beautiful Soup 4 scrapes and parses the webpage
  - This is similar to the majority of table data that you'll find on the Internet
- [Columbus Crew](https://github.com/kim3-sudo/soccer_goal_analysis/blob/main/src/scrape/colcrew_scrape.py): similar to the Man Utd scraper
- [Kenyon Men's Soccer](https://github.com/kim3-sudo/soccer_goal_analysis/blob/main/src/scrape/kenyonmsoc_scrape.py)
  - Requests used to get the webpage
  - A naive method used to parse the webpage using regular expressions (ew yucky)
