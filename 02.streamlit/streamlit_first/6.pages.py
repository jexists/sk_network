import streamlit as st


st.caption('page 참고사이트: https://docs.streamlit.io/get-started/tutorials/create-a-multipage-app')

# 페이지 선언 ()
def page1():
    st.title('Main page')
    st.sidebar.title('side page1')

def page2():
    st.title('page2')
    st.sidebar.title('side page2')

def page3():
    st.title('page3')
    st.sidebar.title('side page3')

# 딕셔너리 선언
page_names_to_funcs = {'page1': page1, 'page2': page2, 'page3': page3}

# 사이드 바에서 selectbox 선언 & 선택 결과 저장
selected_page = st.sidebar.selectbox('select a page', page_names_to_funcs.keys())

# 해당 페이지 부르기
page_names_to_funcs[selected_page]()

# ======================
# 버튼으로 할 경우

if "page" not in st.session_state:
    st.session_state.page = "page1"

if st.sidebar.button("page1"):
    st.session_state.page = "page1"

if st.sidebar.button("page2"):
    st.session_state.page = "page2"

#  화면 출력
if st.session_state.page == "page1":
    st.title("page1")
elif st.session_state.page == "page2":
    st.title("page2") 
