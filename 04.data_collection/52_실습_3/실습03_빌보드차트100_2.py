# 1. 모듈 임포트
import requests
from bs4 import BeautifulSoup
import pandas as pd

# 2. html 요소 얻기
url = "https://www.billboard.com/charts/hot-100/"
page = requests.get(url)

# 3. BeatifulSoup 으로 파싱
bs_result = BeautifulSoup(page.content,'html.parser')
# print(bs_result)

hot100 = bs_result.find_all('div', class_='o-chart-results-list-row-container')
# print(hot100)

# print(len(hot100))

# 확인해보기
info = hot100[0].find_all("span", class_='c-label')
# print(info)s
title = hot100[0].find("h3").get_text(strip=True)
rank = info[0].get_text(strip=True)
artist = info[1].get_text(strip=True)
print(rank)
print(title)
print(artist)

# 리스트로 만들기
result_list = []
for item in hot100:
  tmp_dict = {}
  info = item.find_all("span", class_='c-label')
  # print(info)s
  title = item.find("h3").get_text(strip=True)
  rank = info[0].get_text(strip=True)
  artist = info[1].get_text(strip=True)
  tmp_dict['rank'] = rank
  tmp_dict['title'] = title
  tmp_dict['artist'] = artist

  result_list.append(tmp_dict)
# print(result_list)


# 리스트 -> 데이터프레임 변환
df = pd.DataFrame(result_list)

# CSV 파일 저장
df.to_csv('billboard_hot100.csv', index=False, encoding='utf-8-sig')

