import streamlit as st
import pandas as pd
import numpy as np

st.title('Data Display elements')

st.caption('data 참고 사이트: https://docs.streamlit.io/develop/api-reference/data')

# 1. Metric (단일 지표 카드)
st.header('1. Metric')

# label : 지표 이름 / value : 값 / delta : 변화량
st.metric(label='Temperature', value='70 °F', delta='1.2 °F')

# 2. 여러 개의 metric 카드 (한 줄)
col1, col2, col3 = st.columns(3)
col1.metric("Temperature", "70 °F", "1.2 °F")
col2.metric("Wind", "9 mph", "-8%")
col3.metric("Humidity", "86%", "4%")

# 3. delta 색상 옵션
# delta_color='inverse' : 기본 색 반대로
st.metric(label='Gas price', value=4, delta=0.5, delta_color='inverse')
# st.metric(label='Gas price', value=4, delta=0.5)

# delta_color='off': 색상 표시 끄기
st.metric(label='active developers', value=123, delta=123, delta_color='off')

# 4. Grid 형태의 metric 카드 스타일 추가
a,b = st.columns(2)
c,d = st.columns(2)

# border=True -> 카드 스타일 추가
a.metric("Temperature", "30°F", "-9°F", border=True)
b.metric("Wind", "4 mph", "2 mph", border=True)

c.metric("Humidity", "77%", "5%", border=True)
d.metric("Pressure", "30.34 inHg", "-2 inHg", border=True)

# Dataframe 조회
st.header('Dataframe 조회하기')
titanic = pd.read_csv('./data/t2.csv')
# print(titanic)

# 인터렉티브 테이블 (스크롤, 정렬 가능)
st.dataframe(titanic.head(10))

# pandas styler 활용
# 난수 데이터프레임 생성 (10행*20열)
df = pd.DataFrame(np.random.randn(10,20), columns=('col %d' % i for i in range(20)))

# 각 열의 최대값을 강조 표시 (highlight_max)
st.dataframe(df.style.highlight_max(axis=0))

from numpy.random import default_rng as rng
df = pd.DataFrame(
    {
        "name": ["Roadmap", "Extras", "Issues"],
        "url": [
            "https://roadmap.streamlit.app/",
            "https://extras.streamlit.app/",
            "https://issues.streamlit.app/",
        ],
        "stars": rng(0).integers(0, 1000, size=3),
        "views_history": rng(0).integers(0, 5000, size=(3, 30)).tolist(),
    }
)

st.dataframe(
    df,
    column_config={
        "name": "App name",
        "stars": st.column_config.NumberColumn(
            "Github Stars",
            help="Number of stars on GitHub",
            format="%d ⭐",
        ),
        "url": st.column_config.LinkColumn("App URL"),
        "views_history": st.column_config.LineChartColumn(
            "Views (past 30 days)", y_min=0, y_max=5000
        ),
    },
    hide_index=True,
)