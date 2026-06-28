-- Snappy song database - English & Korean songs
-- Run this AFTER schema.sql to populate the songs table
-- Brazilian songs to be added separately by teammate

-- =============================================================
-- ENGLISH SONGS
-- =============================================================

-- HAPPY (English)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Happy', 'Pharrell Williams', 'HAPPY', 'English', 'https://open.spotify.com/search/Happy%20Pharrell%20Williams'),
('Can''t Stop the Feeling!', 'Justin Timberlake', 'HAPPY', 'English', 'https://open.spotify.com/search/Cant%20Stop%20the%20Feeling%20Justin%20Timberlake'),
('Walking on Sunshine', 'Katrina and the Waves', 'HAPPY', 'English', 'https://open.spotify.com/search/Walking%20on%20Sunshine'),
('Good as Hell', 'Lizzo', 'HAPPY', 'English', 'https://open.spotify.com/search/Good%20as%20Hell%20Lizzo'),
('Uptown Funk', 'Mark Ronson ft. Bruno Mars', 'HAPPY', 'English', 'https://open.spotify.com/search/Uptown%20Funk'),
('Best Day of My Life', 'American Authors', 'HAPPY', 'English', 'https://open.spotify.com/search/Best%20Day%20of%20My%20Life'),
('Sunflower', 'Post Malone, Swae Lee', 'HAPPY', 'English', 'https://open.spotify.com/search/Sunflower%20Post%20Malone'),
('Dancing Queen', 'ABBA', 'HAPPY', 'English', 'https://open.spotify.com/search/Dancing%20Queen%20ABBA');

-- SAD (English)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Someone Like You', 'Adele', 'SAD', 'English', 'https://open.spotify.com/search/Someone%20Like%20You%20Adele'),
('Fix You', 'Coldplay', 'SAD', 'English', 'https://open.spotify.com/search/Fix%20You%20Coldplay'),
('Skinny Love', 'Bon Iver', 'SAD', 'English', 'https://open.spotify.com/search/Skinny%20Love%20Bon%20Iver'),
('All I Want', 'Kodaline', 'SAD', 'English', 'https://open.spotify.com/search/All%20I%20Want%20Kodaline'),
('Liability', 'Lorde', 'SAD', 'English', 'https://open.spotify.com/search/Liability%20Lorde'),
('The Night We Met', 'Lord Huron', 'SAD', 'English', 'https://open.spotify.com/search/The%20Night%20We%20Met'),
('Hurt', 'Johnny Cash', 'SAD', 'English', 'https://open.spotify.com/search/Hurt%20Johnny%20Cash'),
('Cardigan', 'Taylor Swift', 'SAD', 'English', 'https://open.spotify.com/search/Cardigan%20Taylor%20Swift');

-- CALM (English)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Weightless', 'Marconi Union', 'CALM', 'English', 'https://open.spotify.com/search/Weightless%20Marconi%20Union'),
('Holocene', 'Bon Iver', 'CALM', 'English', 'https://open.spotify.com/search/Holocene%20Bon%20Iver'),
('River Flows in You', 'Yiruma', 'CALM', 'English', 'https://open.spotify.com/search/River%20Flows%20in%20You%20Yiruma'),
('Breathe Me', 'Sia', 'CALM', 'English', 'https://open.spotify.com/search/Breathe%20Me%20Sia'),
('Sunset Lover', 'Petit Biscuit', 'CALM', 'English', 'https://open.spotify.com/search/Sunset%20Lover%20Petit%20Biscuit'),
('Saturn', 'Sleeping at Last', 'CALM', 'English', 'https://open.spotify.com/search/Saturn%20Sleeping%20at%20Last'),
('To Build a Home', 'The Cinematic Orchestra', 'CALM', 'English', 'https://open.spotify.com/search/To%20Build%20a%20Home'),
('Clair de Lune', 'Claude Debussy', 'CALM', 'English', 'https://open.spotify.com/search/Clair%20de%20Lune%20Debussy');

-- ANGRY (English)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Break Stuff', 'Limp Bizkit', 'ANGRY', 'English', 'https://open.spotify.com/search/Break%20Stuff%20Limp%20Bizkit'),
('Bodies', 'Drowning Pool', 'ANGRY', 'English', 'https://open.spotify.com/search/Bodies%20Drowning%20Pool'),
('Killing in the Name', 'Rage Against the Machine', 'ANGRY', 'English', 'https://open.spotify.com/search/Killing%20in%20the%20Name'),
('Bulls on Parade', 'Rage Against the Machine', 'ANGRY', 'English', 'https://open.spotify.com/search/Bulls%20on%20Parade'),
('Du Hast', 'Rammstein', 'ANGRY', 'English', 'https://open.spotify.com/search/Du%20Hast%20Rammstein'),
('Smells Like Teen Spirit', 'Nirvana', 'ANGRY', 'English', 'https://open.spotify.com/search/Smells%20Like%20Teen%20Spirit'),
('Given Up', 'Linkin Park', 'ANGRY', 'English', 'https://open.spotify.com/search/Given%20Up%20Linkin%20Park'),
('Chop Suey!', 'System of a Down', 'ANGRY', 'English', 'https://open.spotify.com/search/Chop%20Suey%20System%20of%20a%20Down');

-- =============================================================
-- KOREAN SONGS
-- =============================================================

-- HAPPY (Korean)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Dynamite', 'BTS', 'HAPPY', 'Korean', 'https://open.spotify.com/search/Dynamite%20BTS'),
('LOVE DIVE', 'IVE', 'HAPPY', 'Korean', 'https://open.spotify.com/search/LOVE%20DIVE%20IVE'),
('Cupid', 'FIFTY FIFTY', 'HAPPY', 'Korean', 'https://open.spotify.com/search/Cupid%20FIFTY%20FIFTY'),
('Super Shy', 'NewJeans', 'HAPPY', 'Korean', 'https://open.spotify.com/search/Super%20Shy%20NewJeans'),
('How You Like That', 'BLACKPINK', 'HAPPY', 'Korean', 'https://open.spotify.com/search/How%20You%20Like%20That%20BLACKPINK'),
('Gee', 'Girls'' Generation', 'HAPPY', 'Korean', 'https://open.spotify.com/search/Gee%20Girls%20Generation'),
('Celebrity', 'IU', 'HAPPY', 'Korean', 'https://open.spotify.com/search/Celebrity%20IU'),
('Attention', 'NewJeans', 'HAPPY', 'Korean', 'https://open.spotify.com/search/Attention%20NewJeans');

-- SAD (Korean)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Spring Day', 'BTS', 'SAD', 'Korean', 'https://open.spotify.com/search/Spring%20Day%20BTS'),
('Through the Night', 'IU', 'SAD', 'Korean', 'https://open.spotify.com/search/Through%20the%20Night%20IU'),
('Lilac', 'IU', 'SAD', 'Korean', 'https://open.spotify.com/search/Lilac%20IU'),
('All of My Life', 'Lee Mujin', 'SAD', 'Korean', 'https://open.spotify.com/search/All%20of%20My%20Life%20Lee%20Mujin'),
('Sweet Night', 'V (BTS)', 'SAD', 'Korean', 'https://open.spotify.com/search/Sweet%20Night%20V%20BTS'),
('Tell Me It Was a Dream', 'Sondia', 'SAD', 'Korean', 'https://open.spotify.com/search/Tell%20Me%20It%20Was%20a%20Dream'),
('Snowflower', 'Park Hyo Shin', 'SAD', 'Korean', 'https://open.spotify.com/search/Snowflower%20Park%20Hyo%20Shin'),
('Goodbye', 'IU, Younha', 'SAD', 'Korean', 'https://open.spotify.com/search/Goodbye%20IU%20Younha');

-- CALM (Korean)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Blueming', 'IU', 'CALM', 'Korean', 'https://open.spotify.com/search/Blueming%20IU'),
('Autumn Morning', 'Jannabi', 'CALM', 'Korean', 'https://open.spotify.com/search/Autumn%20Morning%20Jannabi'),
('Aloha', 'Cosmic Girls', 'CALM', 'Korean', 'https://open.spotify.com/search/Aloha%20Cosmic%20Girls'),
('Serenade', 'Akdong Musician', 'CALM', 'Korean', 'https://open.spotify.com/search/Serenade%20Akdong%20Musician'),
('Paris in the Rain', 'Lauv (Korean ver.)', 'CALM', 'Korean', 'https://open.spotify.com/search/Paris%20in%20the%20Rain%20Korean'),
('Officially Missing You', 'Heize', 'CALM', 'Korean', 'https://open.spotify.com/search/Officially%20Missing%20You%20Heize'),
('My Sea', 'Jang Beom June', 'CALM', 'Korean', 'https://open.spotify.com/search/My%20Sea%20Jang%20Beom%20June'),
('You Are My Spring', 'Sung Si Kyung', 'CALM', 'Korean', 'https://open.spotify.com/search/You%20Are%20My%20Spring');

-- ANGRY (Korean)
INSERT INTO songs (title, artist, emotion, language, spotify_url) VALUES
('Fire', 'BTS', 'ANGRY', 'Korean', 'https://open.spotify.com/search/Fire%20BTS'),
('Kick It', 'NCT 127', 'ANGRY', 'Korean', 'https://open.spotify.com/search/Kick%20It%20NCT%20127'),
('Not Today', 'BTS', 'ANGRY', 'Korean', 'https://open.spotify.com/search/Not%20Today%20BTS'),
('PIRI', 'NCT DOJAEJUNG', 'ANGRY', 'Korean', 'https://open.spotify.com/search/PIRI%20NCT%20DOJAEJUNG'),
('Bad Boy', 'Red Velvet', 'ANGRY', 'Korean', 'https://open.spotify.com/search/Bad%20Boy%20Red%20Velvet'),
('Burn It Up', 'Stray Kids', 'ANGRY', 'Korean', 'https://open.spotify.com/search/Burn%20It%20Up%20Stray%20Kids'),
('Get Out', 'Stray Kids', 'ANGRY', 'Korean', 'https://open.spotify.com/search/Get%20Out%20Stray%20Kids'),
('Save Me, Wake Me', 'Stray Kids', 'ANGRY', 'Korean', 'https://open.spotify.com/search/Save%20Me%20Wake%20Me%20Stray%20Kids');
