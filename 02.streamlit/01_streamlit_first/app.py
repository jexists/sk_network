import streamlit as st

st.title('Hello world')

st.write(1234)

st.write(':read[streamlit] is :blue-background[best] :sunglasses:')

# st.button('노크하기')

if st.button('노크하기'):
    # ㅔㅑ굿
    st.write('여기 사람 있어요.')

st.write('동의하시면 아래 내용에 체크해주세요')
agree = st.checkbox('동의합니다.')

if agree:
    st.write('아얏호')

option = st.selectbox(
    '연락을 어떻게 받고 싶으신가요?',
    ('이메일', '유선통화', '문자')
)
st.write('선택한 방식:', option)

age = st.slider('당신은 몇 살인가요?', 0 ,120, 25)
st.write('저는', age, '살입니다.')

text1 = st.text_input('이름을 입력해주세요.')
text2 = st.text_area('자기소개 해주세요.')
st.write('이름 입력값' + text1)
st.write('자기소개 입력값' + text2)