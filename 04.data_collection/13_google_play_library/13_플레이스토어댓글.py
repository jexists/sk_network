# uv add google-play-scraper

from google_play_scraper import reviews, Sort
import pandas as pd

# 앱 ID 입력
app_id = 'com.kakao.talk'

# 수집하고자 하는 리뷰 개수
new_reviews_to_collect = 400

# 리뷰 수집
def collect_reviews(app_id, num_reviews):
  review_list = []
  count = 0

  while count < num_reviews:
    result, _ = reviews(
      app_id,
      lang='ko',
      country='kr',
      sort=Sort.NEWEST,
      count=100
    )
    # review_list.append(result)
    review_list.extend(result)
    count += len(result)

    if len(result) == 0:
      break

  return pd.DataFrame(review_list)


# 데이터 수집 실행
review_data = collect_reviews(app_id, new_reviews_to_collect)

# 데이터 저장
review_data.to_csv('./playstore_reviews_extend.csv', index=False, encoding='utf-8-sig')
