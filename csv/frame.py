import requests
import csv
import shutil
from bs4 import BeautifulSoup

fighter_names = [
        "mario", "donkey_kong", "link", "samus", "dark_samus", "yoshi", "kirby", "fox", "pikachu", "luigi", "ness", "captain_falcon", "jigglypuff", "peach", "daisy", "bowser", "ice_climber", "sheik", "zelda", "dr_mario", "pichu", "falco", "marth", "lucina", "young_link", "ganondorf", "mewtwo", "roy", "chrom", "mr_game_and_watch", "meta_knight", "pit", "dark_pit", "zero_suit_samus", "wario", "snake", "ike", "pt_squirtle", "pt_ivysaur", "pt_charizard", "diddy_kong", "lucas", "sonic", "king_dedede", "olimar", "lucario", "rob", "toon_link", "wolf", "villager", "mega_man", "wii_fit_trainer", "rosalina_and_luma", "little_mac", "greninja", "palutena", "pac_man", "robin", "shulk", "bowser_jr", "duck_hunt", "ryu", "ken", "cloud", "corrin", "bayonetta", "inkling", "ridley", "simon", "richter", "king_k_rool", "isabelle", "incineroar", "piranha_plant", "joker", "hero", "banjo_and_kazooie", "terry", "byleth", "minmin", "mii_brawler", "mii_gunner", "mii_swordfighter"
    ]

for name in fighter_names:

  url = requests.get('https://ultimateframedata.com/'+ name +'.php')

  soup = BeautifulSoup(url.content, "html.parser")

  moveContainers = soup.find_all("div", class_="movecontainer")
  headLine = soup.find("h1", class_="charactername")

  table = []

  for moveContainer in moveContainers:
    try:
      movename = moveContainer.find("div", class_="movename").get_text()
      lines = [line.strip() for line in movename.splitlines()]
      move = "\n".join(line for line in lines if line)
    except:
      print("")
    try:
      startup = moveContainer.find("div", class_="startup").get_text()
      lines = [line.strip() for line in startup.splitlines()]
      start = "\n".join(line for line in lines if line)
    except:
      print("")
    try:
      totalframes = moveContainer.find("div", class_="totalframes").get_text()
      lines = [line.strip() for line in totalframes.splitlines()]
      total = "\n".join(line for line in lines if line)
    except:
      print("")
    try:
      advantage = moveContainer.find("div", class_="advantage").get_text()
      lines = [line.strip() for line in advantage.splitlines()]
      ad = "\n".join(line for line in lines if line)
    except:
      print("")
    try:
      activeframes = moveContainer.find("div", class_="activeframes").get_text()
      lines = [line.strip() for line in activeframes.splitlines()]
      ac = "\n".join(line for line in lines if line)
    except:
      print("")
    table.append([move, start, total, ad, ac])

  import pandas as pd

  Column = ['Move name', 'Start up', 'Total frame', 'Advantage', 'Active frames']

  df = pd.DataFrame(table, columns=Column)

  df.to_csv("%s.csv" % name, encoding='utf-8')
