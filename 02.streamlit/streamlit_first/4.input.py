import streamlit as st
from datetime import datetime
import pandas as pd

st.title('Input Widgets')
st.caption('input 참고사이트: https://docs.streamlit.io/library/api-reference/widgets')

# 1. Button
st.header('1. Button')

# 버튼 클릭 시 실행
if st.button('노크하기'):
    st.write('여기 사람 있어요.')

# 버튼에 따른 조건문 처리
if st.button('Say hello'):
    st.write('hello')
else:
    st.write('goodbye')

test = st.button('테스트')
st.write(test)

# 2. Radio Button
# 하나만 선택 가능
st.header('2.Radio Button')
genre = st.radio('좋아하는 영화 장르는?', 
                 ('SF', '액션', '로맨스'))

if genre == 'SF':
    st.write('인터스텔라')
elif genre == '액션':
    st.write('테이큰')
elif genre == '로맨스':
    st.write('말할 수 없는 비밀')

# 체크박스
st.header('3.Checkbox')
agree = st.checkbox('I agree')

if agree:
    st. write('🚀' *10)

# 4. select box (단일 선택)
st.header('4.Select box')
option = st.selectbox('어떻게 연락드릴까요?', ('Email','Mobile', 'Office phone'))
st.write('네', option, ' 로 연락 드리겠습니다.')

# 5. Multiselect (다중 선택)
st.header('5. Multi select')
options = st.multiselect(
    '좋아하는 색은?',
    ['green', 'yellow', 'red', 'blue'],
    ['yellow']
)

st.write('당신의 선호 색상은 : ')
for i in options:
    st.write(i)

# Input: text / number
st.header('6.Input: Text/Number')

# 텍스트입력
st.subheader('**_text_input_**')
title = st.text_input('가장 좋아하는 영화는?', 'sound of music')
st.write('당신의 최애 영화는: ', title)

# 숫자 입력
st.subheader('**number_input**')
number = st.number_input('insert a number(1-10)', min_value=1, max_value=10, value=5,step=1)
st.write('the current number is', number)

# 7. Date Input
st.header('7. Date input')
ymd = st.date_input('when is your birdthday', datetime(2000,9,6))
st.write('your birthday', ymd)


# 8. slider
st.header('8.slider')

# 숫자 구간 슬라이더 (최소 ~ 최대)
st.subheader('**최소-최대값 내에서 숫자 사이 구간**')
values = st.slider('값 구간을 선택하세요', 0.0, 100.0, (25.0, 75.0))
st.write('value ', values)

# 날짜 구간 슬라이더
st.subheader('** 년 월 일 사이 구간 ** ')
slider_date = st.slider(
    '날짜 구간을 선택하세요',
    min_value = datetime(2024, 1, 1),
    max_value = datetime(2024, 12, 31),
    value = (datetime(2024,6,1), datetime(2024,7,31)),
    format = 'YY/MM/DD'
)

st.write('slider date', slider_date)
st.write('slider_date[0]', slider_date[0], 'slider_date[1]', slider_date[1],)

# 날짜 구간으로 데이터 조회하기
st.header('날짜 구간으로 데이터 조회하기')

# CSV 데이터 불러오기
df = pd.read_csv('data_subway_in_seoul.csv', encoding='cp949')
st.write('날짜 필드 형식:', df['날짜'].dtypes)
st.write(df)