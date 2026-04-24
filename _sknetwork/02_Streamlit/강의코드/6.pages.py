import streamlit as st

st.caption('text 참고사이트: https://docs.streamlit.io/get-started/tutorials/create-a-multipage-app')

# 페이지 선언(🎠 🎃)
def main_page():
    st.title('Main page 🎠')
    st.sidebar.title('Side main 🎠')
def page2():
    st.title('Page 2 🎃')
    st.sidebar.title('Side 2 🎃')
def page3():
    st.title('Page 3 🍋‍🟩')
    st.sidebar.title('Side 3 🍋‍🟩')

# 딕셔너리 선언
page_names_to_funcs = {'Main Page': main_page, 'Page2': page2, 'Page3':page3}

# 사이드 바에서 selectbox 선언 & 선택 결과 저장
selected_page = st.sidebar.selectbox("Select a page", page_names_to_funcs.keys())

# 해당 페이지 부르기
page_names_to_funcs[selected_page]()