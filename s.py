import requests
import csv
import shutil
from bs4 import BeautifulSoup

fighter_names = [
        "mario", "donkey_kong", "link", "samus", "dark_samus", "yoshi", "kirby", "fox", "pikachu", "luigi", "ness", "captain_falcon", "jigglypuff", "peach", "daisy", "bowser", "ice_climber", "sheik", "zelda", "dr_mario", "pichu", "falco", "marth", "lucina", "young_link", "ganondorf", "mewtwo", "roy", "chrom", "mr_game_and_watch", "meta_knight", "pit", "dark_pit", "zero_suit_samus", "wario", "snake", "ike", "pt_squirtle", "pt_ivysaur", "pt_charizard", "diddy_kong", "lucas", "sonic", "king_dedede", "olimar", "lucario", "rob", "toon_link", "wolf", "villager", "mega_man", "wii_fit_trainer", "rosalina_and_luma", "little_mac", "greninja", "mii_fighter", "palutena", "pac_man", "robin", "shulk", "bowser_jr", "duck_hunt", "ryu", "ken", "cloud", "corrin", "bayonetta", "inkling", "ridley", "simon", "richter", "king_k_rool", "isabelle", "incineroar", "piranha_plant", "joker", "hero", "banjo_and_kazooie", "terry", "byleth", "minmin", "mii_brawler", "mii_gunner", "mii_swordfighter"
    ]

for name in fighter_names:

  url = requests.get('https://ultimateframedata.com/'+ name +'.php')

  soup = BeautifulSoup(url.content, "html.parser")

  moveContainers = soup.find_all("div", class_="movecontainer")
  headLine = soup.find("h1", class_="charactername")

  table = []

  for moveContainer in moveContainers:
    try:
      movename = moveContainer.find("div", class_="movename").text
    except:
      print("")
    try:
      startup = moveContainer.find("div", class_="startup").text
    except:
      print("")
    try:
      totalframes = moveContainer.find("div", class_="totalframes").text
    except:
      print("")
    try:
      landinglag = moveContainer.find("div", class_="landinglag").text
    except:
      print("")
    try:
      notes = moveContainer.find("div", class_="notes").text
    except:
      print("")
    try:
      basedamage = moveContainer.find("div", class_="basedamage").text
    except:
      print("")
    try:
      shieldlag = moveContainer.find("div", class_="shieldlag").text
    except:
      print("")
    try:
      shieldstun = moveContainer.find("div", class_="shieldstun").text
    except:
      print("")
    try:
      whichhitbox = moveContainer.find("div", class_="whichhitbox").text
    except:
      print("")
    try:
      advantage = moveContainer.find("div", class_="advantage").text
    except:
      print("")
    try:
      activeframes = moveContainer.find("div", class_="activeframes").text
    except:
      print("")
    table.append([headLine, movename, startup, totalframes, landinglag, notes, basedamage, shieldlag, shieldstun, whichhitbox, advantage, activeframes])

  import pandas as pd

  Column = ['Character Name', 'Move name', 'Start up', 'Total frames', 'Landingag', 'Notes', 'Base damage', 'Shield lag', 'Shield stun', 'Which hit box', 'Advantage', 'Active frames']

  df = pd.DataFrame(table, columns=Column)

  df.to_csv("%s.csv" % name, encoding='utf-8')