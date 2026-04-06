import streamlit as st
import random

st.subheader("점심 메뉴 추천기")

food_list_2 = [
     {'category': '한식', 'name': '김치찌개', 'spicy': True, 'price': '10000'},
     {'category': '한식', 'name': '비빔밥', 'spicy': True, 'price': '10000'},
     {'category': '한식', 'name': '제육볶음', 'spicy': True, 'price': '10000'},
     {'category': '한식', 'name': '불고기', 'spicy': False, 'price': '10000'},
     {'category': '중식', 'name': '불고기', 'spicy': False, 'price': '10000'},
]

food_list = {
    '한식':{
        'spicy': ['김치찌개', '비빔밥', '제육볶음'],
        'non-spicy': ['불고기']
    },
    '중식':{
        'spicy': ['짬뽕'],
        'non-spicy': ['짜장면', '볶음밥'],
        },
    '양식':{
        'spicy': ['매운 돈까스'],
        'non-spicy':['파스타', '리조또', '햄버거'],
        },
    '분식':{
        'spicy': ['떡볶이', '라면'],
        'non-spicy':['김밥',],
        },
}
category = st.selectbox('음식 종류를 선택해주세요.',
             (food_list.keys()))

price = st.selectbox('예산을 선택해주세요.',
             (['5000원 이하', '10000원 이하','상관없음']))

if category != "":
    spicy = st.checkbox('매운음식 가능')
    
    if spicy:
        # print(', '.join(food_list[category]['spicy']))
        final_list = food_list[category]['spicy']
    else:
        final_list = food_list[category]['non-spicy']
        

if st.button('추천받기', type='primary', width='stretch'):
        # print(final_list)
        # print(len(final_list))
        random_n = random.randint(0, len(final_list)-1)
        # print(random_n)
        # final = ', '.join(food_list[category]['non-spicy'])
        final = final_list[random_n]
        st.subheader(f'오늘의 추천 메뉴는 :red["{final}"]입니다.', text_alignment="center")
        # text = f'오늘의 추천 메뉴는 "{final}"입니다.'
        # st.html('')
        # st.write(f'오늘의 추천 메뉴는 {final}입니다.')


# - 앱 제목 만들기
# - 음식 종류 선택하기
# - 예산 선택하기
# - 매운 음식 가능 여부 선택하기
# - 버튼을 누르면 조건에 맞는 메뉴 추천하기
# - 추천 결과를 보기 좋게 출력하기