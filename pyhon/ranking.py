import requests
import csv
import shutil
from bs4 import BeautifulSoup

urlNames = ['AirSpeed', 'FallSpeed', 'DashSpeed', 'RunSpeed', 'WalkSpeed', 'Weight']

for urlName in urlNames:
  url = requests.get('https://kuroganehammer.com/Ultimate/' + urlName)

  soup = BeautifulSoup(url.content, 'html.parser')

  tbody = soup.find("tbody")
  trs = tbody.select('tr')

  table = []
  tableRow = []

  for tr in trs:
    tds = tr.find_all('td')
    num = tds[0].get_text()
    name = tds[1].get_text()
    value = tds[2].get_text()
    column = [num, name, value]
    table.append(column)





  import pandas as pd

  # Column = ['num', 'name', 'speed']

  df = pd.DataFrame(table)

  df.to_csv("%s.csv" % urlName, encoding='utf-8')
