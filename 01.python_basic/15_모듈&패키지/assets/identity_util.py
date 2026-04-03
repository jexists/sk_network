# identity_util.py

def user_age(year):
    return 2026 - year

def user_gender(minnum):
    if int(minnum) % 2 == 0:
        return '여성'
    else:
        return '남성'
