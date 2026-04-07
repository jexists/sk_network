import streamlit as st

# header, subheader, text, caption 연습하기
st.title('Text elements')
st.caption('text 참고 사이트: https://docs.streamlit.io/develop/api-reference/text')
st.header('header 연습')
st.subheader('subheader 연습')
st.text('text 연습')
st.caption('catipon 연습')

# markdonw 연습하기
st.markdown('# this is a markdown title')
st.markdown('## this is a markdown title')
st.markdown('this is a **markdown bold 진하게**')
st.markdown('this is a *markdown 기울임*')
st.markdown('this is a _markdown 기울임_')
st.markdown('this is a **_markdown 진하고 기울임_**')

st.markdown('- item')
st.markdown('1. item')

# code, Latex 수학식 표현
st.code('x=1234')
st.latex(r'''
    a + ar + a r^2 + a r^3 + \cdots + a r^{n-1} =
    \sum_{k=0}^{n-1} ar^k =
    a \left(\frac{1-r^{n}}{1-r}\right)
    ''')

# write 연습하기
st.write('this is a string write \n')
st.write('\n')
st.write('\n')
st.write('Hello, "world" :sunglasses:')