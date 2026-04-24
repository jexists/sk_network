# 1. 라이브러리 불러오기
import requests
from bs4 import BeautifulSoup

# 2. html 요소 얻기
# 봇 차단 방지 헤더 추가 (https://www.whatismybrowser.com/detect/what-is-my-user-agent/)
header = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"}
url = "https://www.melon.com/chart/index.htm" # 멜론 top100주소
page = requests.get(url, headers=header)

# 3. BeatifulSoup 으로 파싱


# 결과물을 저장할 리스트 생성


# 리스트로 저장
