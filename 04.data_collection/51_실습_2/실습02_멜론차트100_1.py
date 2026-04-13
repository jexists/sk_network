# 1. 라이브러리 불러오기
import requests
from bs4 import BeautifulSoup

# 2. html 요소 얻기
# 봇 차단 방지 헤더 추가 (https://www.whatismybrowser.com/detect/what-is-my-user-agent/)
header = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"}
url = "https://www.melon.com/chart/index.htm" # 멜론 top100주소
page = requests.get(url, headers=header)

class Melon:
  def __init__(self, rank, title, singer):
    self.rank = rank
    self.title = title
    self.singer = singer

  def __str__(self):
      return f'{self.rank}, {self.title}, {self.singer}'

# 3. BeatifulSoup 으로 파싱
soup = BeautifulSoup(page.content, 'html.parser')
# print(soup)

# 결과물을 저장할 리스트 생성

melon_list = []

best_list = soup.select('.service_list_song tbody tr')

# print(len(best_list))

for i, item in enumerate(best_list):
  if item.select_one('.wrap_song_info .rank01'):
    title = item.select_one('.wrap_song_info .rank01').text.strip()
  if item.select_one('.wrap_song_info .rank02 a'):
    singer = item.select_one('.wrap_song_info .rank02 a').text.strip()
  # print(f'{i+1}, {title}, {singer}')
  # print(singer)
  melon_list.append(Melon(i+1, title, singer))

for melon in melon_list:
  print(melon)

# 리스트로 저장
