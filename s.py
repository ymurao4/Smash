import requests
import shutil
from bs4 import BeautifulSoup


url = requests.get('https://ultimateframedata.com/wario.php')

soup = BeautifulSoup(url.content, "html.parser")




