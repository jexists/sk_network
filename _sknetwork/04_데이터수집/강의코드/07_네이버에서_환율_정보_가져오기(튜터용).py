import requests
from bs4 import BeautifulSoup

url = 'https://finance.naver.com/marketindex/'
market_index = requests.get(url)
print(market_index.status_code)

# soup 객체 만들기
soup = BeautifulSoup(market_index.content, 'html.parser')

# 미션1. 달러 (1488.50) 프린트 해보기
# 고유한 class 조합만으로 구분 가능
# usd = soup.select_one('#exchangeList > li.on > a.head.usd > div > span.value')
usd = soup.select_one('#exchangeList span.value')
print(f'usd/krw = {usd.text}')

# 미션2. 엔화 (931.98) 프린트 해보기
jpy = soup.select_one('a.head.jpy > div.head_info > span.value')
print(f'jpy/krw = {jpy.text}')

# 미션3. 몽골



