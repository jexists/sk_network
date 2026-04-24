# uv add youtube-comment-downloader

from youtube_comment_downloader import YoutubeCommentDownloader
import pandas as pd
from youtube_comment_downloader import SORT_BY_POPULAR

# 유튜브 댓글 다운로더 초기화
dl = YoutubeCommentDownloader()

# 스크래핑할 유튜브 URL 지정
url = 'https://www.youtube.com/watch?v=uaBHe5P4JF8'

# 수집할 댓글 수 
max_comments = 300

# 댓글 수집 함수 정의
def get_comments(url, max_comments):
    comments = []       # 댓글 저장할 빈 리스트
    for i, com in enumerate(dl.get_comments_from_url(url, sort_by=SORT_BY_POPULAR), 1):
        comments.append(com['text'])    # 댓글 텍스트만 추출하여 리스트에 추가
        if i >= max_comments:
            break                       # 최대 댓글 수에 도달하면 반복 종료
    return comments

# 댓글 수집
comments = get_comments(url, max_comments)


# 데이터프레임 변환
df = pd.DataFrame(comments, columns=['comment'])

# CSV 파일 저장
df.to_csv("youtube_comments.csv", index=False, encoding='utf-8-sig')

# 완료 확인
print(f'{len(comments)}개의 댓글이 csv파일로 저장되었습니다.')