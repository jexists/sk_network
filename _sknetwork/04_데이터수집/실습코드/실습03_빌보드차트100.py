# 1. 모듈 임포트
import requests
from bs4 import BeautifulSoup

# 2. html 요소 얻기
url = "https://www.billboard.com/charts/hot-100/"
page = requests.get(url)

# 3. BeatifulSoup 으로 파싱
bs_result = BeautifulSoup(   )
bs_result

hot100 = bs_result.find_all(   )
hot100

print(len(hot100))

# 확인해보기
info = hot100[0].find_all(   )
title = 
rank = 
artist = 
print(rank)
print(title)
print(artist)
