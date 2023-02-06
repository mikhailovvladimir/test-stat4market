SELECT invaited_users.id, 
	   invaited_users.group_id,
       invaited_users.invited_by_user_id,
       invaited_users.name,
       invaited_users.posts_qty
FROM   users
       INNER JOIN (SELECT *
                   FROM   users) AS invaited_users
               ON users.id = invaited_users.invited_by_user_id
WHERE  users.posts_qty < invaited_users.posts_qty;

SELECT users.id, 
	   users.group_id,
       users.invited_by_user_id,
       users.name,
       users.posts_qty
FROM   users
       INNER JOIN (SELECT group_id,
                          Max(posts_qty) AS posts_qty
                   FROM   users
                   GROUP  BY group_id) AS max_posts
               ON users.group_id = max_posts.group_id
                  AND users.posts_qty = max_posts.posts_qty;

SELECT g.name,
       Count(u.id)
FROM `users` AS u
       INNER JOIN `groups` AS g
               ON u.group_id = g.id
GROUP  BY u.group_id,
          g.name
HAVING Count(u.id) > 10000;

SELECT invaited_users.id,
       invaited_users.group_id,
       invaited_users.invited_by_user_id,
       invaited_users.name,
       invaited_users.posts_qty
FROM   users
       INNER JOIN (SELECT *
                   FROM   users) AS invaited_users
               ON users.id = invaited_users.invited_by_user_id
WHERE  users.group_id != invaited_users.group_id
       AND users.id = invaited_users.invited_by_user_id;

SELECT groups.id,
       groups.name,
       Sum(users.posts_qty) AS count_posts
FROM `groups`
       INNER JOIN users
           ON users.group_id = groups.id
GROUP  BY groups.id
HAVING Sum(users.posts_qty) = (
    SELECT Max(sum_posts) AS sum_posts
    FROM  (
        SELECT groups.id,
               Sum(users.posts_qty) AS sum_posts
        FROM `groups`
            INNER JOIN users
            	ON users.group_id = groups.id
        GROUP  BY groups.id) as nested_select
	);