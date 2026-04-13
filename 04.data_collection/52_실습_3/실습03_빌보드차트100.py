# 1. 모듈 임포트
import requests
from bs4 import BeautifulSoup

# 2. html 요소 얻기
url = "https://www.billboard.com/charts/hot-100/"
page = requests.get(url)

# 3. BeatifulSoup 으로 파싱
bs_result = BeautifulSoup(page.content,'html.parser')
# print(bs_result)

hot100 = bs_result.find_all('div', class_='o-chart-results-list-row-container')
# print(hot100)

# print(len(hot100))
# title-of-a-story
# # 확인해보기
info = hot100[0].find_all('li', class_='o-chart-results-list__item')
# print(info)
title = hot100[0].select_one('#title-of-a-story').text.strip()
artist = hot100[0].select_one('#title-of-a-story+span').text.strip()
rank = hot100[0].select_one('.o-chart-results-list__item span.c-label').text.strip()
print(rank)
print(title)
print(artist)
