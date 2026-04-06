import streamlit as st

st.title('Layouts')
st.caption('layout 참고사이트: https://docs.streamlit.io/library/api-reference/layout')

# 1. sidebar
with st.sidebar:
    st.header('1.sidebar')

# 사이드바에 select box 추가
add_selectbox = st.sidebar.selectbox('어떻게 연락드릴까요?', ('email', 'mobile', 'offce phone'))

# 선택값에 따라 아이콘 표시
if add_selectbox == 'email':
    st.sidebar.title('이메일')
elif add_selectbox == 'mobile':
    st.sidebar.title('모바일')
else:
    st.sidebar.title('전화')

# 2. Columns
st.header('2. Columns')
col1, col2, col3 = st.columns(3)

# 각 column에 개별 요소 배치
with col1:
    st.text('A cat')
    st.image('https://static.streamlit.io/examples/cat.jpg')
with col2:
    st.text('A dog')
    st.image('https://static.streamlit.io/examples/dog.jpg')
with col3:
    st.text('A owl')
    st.image('https://static.streamlit.io/examples/owl.jpg')

# 3. Tabs
st.header('3.Tabs')
tab1, tab2, tab3 = st.tabs(['고양이', '개', '부엉이'])

with tab1:
    st.caption('A cat')
    st.image('https://static.streamlit.io/examples/cat.jpg')
with tab2:
    st.caption('A dog')
    st.image('https://static.streamlit.io/examples/dog.jpg')
with tab3:
    st.caption('A owl')
    st.image('https://static.streamlit.io/examples/owl.jpg')