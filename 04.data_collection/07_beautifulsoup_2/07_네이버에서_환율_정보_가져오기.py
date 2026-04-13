
import requests
from bs4 import BeautifulSoup

url = 'https://finance.naver.com/marketindex/'

market_index = requests.get(url)
# print(market_index.status_code)

soup = BeautifulSoup(market_index.content, 'html.parser')
# print(soup)


usd = soup.select_one('#exchangeList .value')

# print(usd)
# 달러 프린트 해보기
print(f'usd/krw = {usd.text}')

# 미션2 엔화 프린트 해보기

jyp = soup.select_one('#exchangeList > li > a.head.jpy > div > span.value')

print(f'엔화 = {jyp.text}')


# 몽골 (iframe)
iframe = soup.find('iframe.frame_ex1')
iframe_src = iframe.get('src')
mnt = soup.select_one('.tbl_area tr:nth-child(17) .sale')

print(f'몽골 {mnt}')

print(soup.select_one('.section_exchange .tbl_area'))

# # 1. iframe 태그를 찾고 src 추출
# iframe = soup.find('iframe')
# iframe_src = iframe.get('src')

# # 2. 상대 경로일 경우 절대 경로로 변환
# full_url = urljoin(base_url, iframe_src)

# # 3. iframe의 주소로 다시 요청을 보내서 내부 데이터 파싱
# iframe_response = requests.get(full_url)
# iframe_soup = BeautifulSoup(iframe_response.text, 'html.parser')

# print(iframe_soup.select_one('h1').text) # 이제 내부 데이터에 접근 가능!
