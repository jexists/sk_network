import streamlit as st


# 버튼으로 할 경우

if "page" not in st.session_state:
    st.session_state.page = "MBTI"

if st.sidebar.button("오늘의 운세"):
    st.session_state.page = "오늘의 운세"

if st.sidebar.button("점심 메뉴 추천앱"):
    st.session_state.page = "점심 메뉴 추천앱"

if st.sidebar.button("MBTI"):
    st.session_state.page = "MBTI"

#  화면 출력
if st.session_state.page == "오늘의 운세":
    st.title("오늘의 운세")
    pg = st.navigation(["fortune.py"])
    pg.run()
elif st.session_state.page == "점심 메뉴 추천앱":
    st.title("점심 메뉴 추천앱") 
    pg = st.navigation(["lunch.py"])
    pg.run()
elif st.session_state.page == "MBTI":
    st.title("MBTI") 
    pg = st.navigation(["mbti.py"])
    pg.run()
else:
    st.title("찾을 수 없는 페이지입니다.")