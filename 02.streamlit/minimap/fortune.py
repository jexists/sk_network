import streamlit as st
import random

st.subheader('오늘의 운세를 받아보세요.')
# 이름 입력
# 버튼클릭
# 랜덤 운세문구
# 결과 
name = st.text_input('이름을 입력해주세요.')

random_text = [
    '오늘은 새로운 도전을 해보기에 좋은 날입니다.',
    '작은 실수가 있어도 너무 걱정하지 마세요.  ',
    '좋은 아이디어가 떠오를 수 있습니다.   ',
    '오늘은 휴식이 필요한 날입니다.',
    '주변 사람과의 대화에서 좋은 기회를 얻을 수 있습니다.'
]
if st.button('운세보기', type='primary', width='stretch'):
    if name == '':
        st.error('이름을 입력해주세요.', icon=None, width="stretch")
        pass
        # st.write('이름을 입력해주세요.')
    else:
        # with st.container(horizontal_alignment='right'):
            random = random.randint(0,4)
            # if st.button('운세보기', type='primary', width='stretch'):
            st.write(f'{name}님, 오늘의 운세는 "{random_text[random]}" 입니다.')
            
            with st.container(horizontal_alignment='right'):
                st.button('다시보기')
#... 님, 오늘의 운세는 ... 입니다.