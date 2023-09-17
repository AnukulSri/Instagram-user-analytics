-- Instagram user Analytics
use instagram_user
-- Print the data of user table
Select * from users

-- Print the data of comments table
Select * from comments

-- Print the data from follows table
Select * from follows

-- Print the data from likes table
Select * from likes

-- Print the data from photos table
Select * from photos

-- Print the data from photos-tags table
Select * from photo_tags

-- Print the data from tags table
Select * from tags

-- Find the 5 oldest users of the Instagram from the database provided
Select Top 5 * from users
order by created_at

-- Find the users who have never posted a single photo on Instagram
Select * from users
Select * from photos

Select u.username from users u
where u.username not in(Select u.username from users u
join photos p
on u.id = p.user_id
where u.id = p.user_id)

select u.id , u.username as Name 
from users  u left  join photos p on u.id=p.user_id
where p.user_id is null 
group by user_id ,username , u.id  
order by id, user_id

--Declaring Contest Winner: 
--The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
-- Identify the winner of the contest and provide their details to the team
Select * from users
Select * from likes
Select * from photos


select a.* , b.username as UserName  from 
(select l.*, p.user_id from 
(SELECT top 1 photo_id, COUNT(*) AS Likes FROM likes 
GROUP BY photo_id
order by 2 desc ) l
join (select id, user_id from photos) p 
on l.photo_id=p.id) a  
join (select * from users) b 
on a.user_id=b.id

--A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
--Identify and suggest the top 5 most commonly used hashtags on the platform

Select * from tags
Select * from photo_tags

Select a.*,t.tag_name from
(Select Top 5 tag_id, count(photo_id) as td from photo_tags
group by tag_id
order by td desc) a
join (Select * from tags) t
on a.tag_id = t.id

-- The team wants to know, which day would be the best day to launch ADs.
-- What day of the week do most users register on? Provide insights on when to schedule an ad campaign
Select * from users

select count(*) as Registers, Day  from 
(select DATEName(WEEKDAY,created_at) AS Day  from users 
)a
group by Day 
order by 1 desc

-- Are users still as active and post on Instagram or they are making fewer posts
-- Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users

Select * from photos

Select user_id,count(*) as counts from photos
group by user_id

Select count(image_url) as total_images_posted from photos

Select count(id) as total_user from users

-- The investors want to know if the platform is crowded with fake and dummy accounts
-- Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).

Select * from likes

Select user_id,count(photo_id) as total_likes from likes
group by user_id
order by total_likes desc

