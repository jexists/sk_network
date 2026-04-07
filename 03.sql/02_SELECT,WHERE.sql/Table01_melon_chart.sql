DROP TABLE IF EXISTS melon_chart;

CREATE TABLE melon_chart (
    ranking INT,
    song VARCHAR(50),
    singer VARCHAR(20),
    album VARCHAR(50),
    like_no INT
);

INSERT INTO melon_chart (ranking, song, singer, album, like_no) VALUES
(1, 'Super Shy', 'NewJeans', 'NewJeans 2nd EP Get Up', 115766),
(2, 'Seven (feat. Latto) Clean Ver.', '정국', 'Seven (feat. Latto) Clean Ver.', 124699),
(3, 'ETA', 'NewJeans', 'NewJeans 2nd EP Get Up', 60239),
(4, '퀸카 (Queencard)', '(여자)아이들', 'I feel', 125309),
(5, 'I AM', 'IVE (아이브)', 'Ive IVE', 188847),
(6, '헤어지자 말해요', '박재정', '1집 Alone', 96577),
(7, '이브, 프시케 그리고 푸른 수염의 아내', 'Le SSERAFIM (르세라핌)', 'UNFORGIVEN', 96863),
(8, 'Spicy', 'aespa', 'MY WORLD - The 3rd Mini Album', 115388),
(9, 'Steal The Show (From 엘리멘탈)', 'Lauv', 'Steal The Show (From 엘리멘탈)', 108665),
(10, 'New Jeans', 'NewJeans', 'NewJeans 2nd EP Get Up', 57308),
(11, 'Love Dive', 'IVE (아이브)', 'LOVE DIVE', 234567),
(12, 'Hype Boy', 'NewJeans', 'New Jeans', 187654),
(13, 'After LIKE', 'IVE (아이브)', 'After LIKE', 212345),
(14, 'Pink Venom', 'BLACKPINK', 'BORN PINK', 278901),
(15, 'Antifragile', 'Le SSERAFIM (르세라핌)', 'ANTIFRAGILE', 198765),
(16, 'Dreamers', '정국', 'Dreamers (FIFA World Cup 2022)', 245678),
(17, 'Ditto', 'NewJeans', 'OMG', 312345),
(18, 'OMG', 'NewJeans', 'OMG', 289765),
(19, 'Tomboy', '(여자)아이들', 'I NEVER DIE', 267890),
(20, 'That That', 'PSY', 'PSY 9th', 345678),
(21, 'POP!', '나연 (TWICE)', 'IM NAYEON', 234567),
(22, 'ELEVEN', 'IVE (아이브)', 'ELEVEN', 298765),
(23, 'Feel My Rhythm', 'Red Velvet', 'The ReVe Festival 2022', 254321),
(24, 'Set Me Free', 'TWICE', 'READY TO BE', 189765),
(25, 'Like Crazy', '지민', 'FACE', 312098),
(26, 'Yet To Come', 'BTS', 'Proof', 401234),
(27, 'Shut Down', 'BLACKPINK', 'BORN PINK', 398765),
(28, 'Blue Flame', 'Le SSERAFIM (르세라핌)', 'FEARLESS', 198432),
(29, 'Illusion', 'aespa', 'Girls', 276543),
(30, 'Forever 1', '소녀시대', 'Forever 1', 305678),
(31, 'HOT', 'SEVENTEEN', 'Face the Sun', 278901),
(32, 'Candy', 'NCT DREAM', 'Candy', 334567),
(33, 'BIBI Vengeance', '비비 (BIBI)', 'Lowlife Princess: Noir', 198765),
(34, 'Love 119', 'RIIZE', 'Love 119', 234987),
(35, 'UNFORGIVEN', 'Le SSERAFIM (르세라핌)', 'UNFORGIVEN', 312345),
(36, 'LALISA', '리사 (BLACKPINK)', 'LALISA', 278432),
(37, 'Slow Dancing', 'V', 'Layover', 301234),
(38, 'Run BTS', 'BTS', 'Proof', 367890),
(39, 'Drama', 'aespa', 'Drama - The 4th Mini Album', 255678),
(40, 'Butter', 'BTS', 'Butter', 501234);

COMMIT;
