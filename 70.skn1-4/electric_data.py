# 라이브러리 불러오기
import numpy as np
import pandas as pd
import urllib.request   # URL 요청을 통해 데이터를 가져오는데 사용
import json             # json 데이터를 처리하는데 사용

# 인증키와  URL 주소

from dotenv import load_dotenv
import os

load_dotenv()

key = os.getenv('kor_key')
res_type = 'json'
numOfRows = 10
pageNo = 1

url = f'http://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey={key}&numOfRows={numOfRows}&pageNo={pageNo}&dataType=JSON'

# 데이터 가져오기
response = urllib.request.urlopen(url)
json_str = response.read().decode('utf-8')
print(json_str)

print(type(json_str))

# 딕셔너리로 변환
json_object = json.loads(json_str)
print(json_object)

# print(type(json_object))

# 데이터 플레임으로 변환
electric = pd.json_normalize(json_object['CardSubwayStatsNew']['row'])

print(electric)
