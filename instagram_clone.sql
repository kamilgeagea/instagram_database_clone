-- CHALLENGE 1: FIND THE 5 OLDEST USERS
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- CHALLENGE 2: FIND DAY OF THE WEEK WHERE USERS REGISTER THE MOST
SELECT
    DAYNAME(created_at) AS DAY,
    COUNT(*) AS REGISTRATIONS
FROM users
GROUP BY DAY
ORDER BY REGISTRATIONS DESC
LIMIT 2;

-- CHALLENGE 3: FIND THE USERS WHO HAVE NEVER POSTED A PHOTO
SELECT
    users.id,
    username,
    users.created_at
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL
ORDER BY username;

-- CHALLENGE 4: USER THAT HAS THE MOST LIKED PHOTO
SELECT
    username,
    image_url,
    COUNT(*) AS nb_of_likes
FROM users
INNER JOIN photos
    ON users.id = photos.user_id
INNER JOIN likes
    ON photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY COUNT(*) DESC LIMIT 1;

-- CHALLENGE 5: AVERAGDE POST PER USER
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS average;

-- CHALLENGE 5: ALTERNATIVE
SELECT AVG(total_photos) AS average_posts_per_user FROM (
    SELECT
        username,
        COUNT(photos.id) AS total_photos
    FROM users
    LEFT JOIN photos
        ON users.id = photos.user_id
    GROUP BY users.id
) AS photo_count;

-- CHALLENGE 6: WHAT ARE THE 5 MOST POPULAR HASHTAGS
SELECT
    tag_name,
    COUNT(*) AS total_use
FROM photo_tags
INNER JOIN tags
    ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total_use DESC
LIMIT 5;

-- CHALLENGE 7: FIND USERS WHO LIKED EVERY PHOTOS (BOTS)
SELECT
    username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
HAVING COUNT(*) = (SELECT COUNT(*) FROM photos);