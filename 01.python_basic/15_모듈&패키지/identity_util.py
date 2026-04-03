# identity_util.py

def user_age(year):
    return 2026 - year

def user_gender(minnum):
    print(minnum)
    if int(minnum[7]) % 2 == 0:
        return '여성'
    else:
        return '남성'

