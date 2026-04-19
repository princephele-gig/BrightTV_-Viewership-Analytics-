-- DATA: USER_PROFILES
select * 
FROM `bright_tv_case_study`.`default`.`bright_tv_user_profiles`
Limit 1000;

-- Basic user count
SELECT COUNT(*) AS total_users
FROM `bright_tv_case_study`.`default`.`bright_tv_user_profiles`;

-- Distribution of subscription types
SELECT Count (*) Province,
      Race,
      Gender
FROM `bright_tv_case_study`.`default`.`bright_tv_user_profiles`;

-- Age group analysis
SELECT 
  CASE 
    WHEN Age < 18 THEN 'Kids_Teens'
    WHEN Age BETWEEN 18 AND 34 THEN 'Youth'
    WHEN Age BETWEEN 35 AND 55 THEN 'Adults'
    ELSE 'Matured Seniors' 
  END AS age_group,
  COUNT(*) AS user_count
FROM `bright_tv_case_study`.`default`.`bright_tv_user_profiles`
GROUP BY age_group
ORDER BY user_count DESC;

-- Location-based subscription insights
SELECT Province, Gender, COUNT(*) AS user_count
FROM `bright_tv_case_study`.`default`.`bright_tv_user_profiles`
GROUP BY Province, Gender
ORDER BY Province, user_count DESC;

-- If Null and Case When Statements insights
SELECT 
    UserID,
    CASE 
        WHEN Gender IS NULL THEN 'Unknown' 
        ELSE Gender 
    END AS Gender,
    CASE 
        WHEN Race IS NULL THEN 'Unknown' 
        ELSE Race 
    END AS Race,
    CASE 
        WHEN Age IS NULL THEN '0' 
        ELSE CAST(Age AS STRING) 
    END AS Age,
    Province,
    CASE 
        WHEN Province IS NULL THEN 'Unknown' 
        ELSE Province 
    END AS Province
FROM bright_tv_case_study.default.bright_tv_user_profiles;

-- Last try of NUll
SELECT 
    IFNULL(ROUND(UserID, 0), 0) AS User_ID,
    IFNULL(Gender, 'Unknown') AS Gender,
    IFNULL(Race, 'Unknown') AS Race,
    IFNULL(CAST(Age AS STRING), '0') AS Age,
    IFNULL(Province, 'No_Province') AS Province
FROM bright_tv_case_study.default.bright_tv_user_profiles;

--- DATA:VIEWERSHIPS
select * from `bright_tv_case_study`.`default`.`bright_tv_viewership` limit 100;

-- Changing Time Zones
select 
    UserID0,
    RecordDate2,
    DATEADD(HOUR, 2, RecordDate2) AS WatchTime_SA
    from `bright_tv_case_study`.`default`.`bright_tv_viewership`;

-- Separating Columns of date and time with Changed UTC to SA Time
SELECT 
    UserID0,
    Channel2,
    RecordDate2,
    DATEADD(HOUR, 2, RecordDate2) AS WatchTime_SA,
    CAST(WatchTime_SA AS DATE) AS WatchDate,
    DATE_FORMAT(WatchTime_SA, 'HH:mm:ss') AS WatchTime
from `bright_tv_case_study`.`default`.`bright_tv_viewership`;

-- Average watch time per Channel
SELECT
    Channel2, 
    Round (AVG(`Duration 2`)/60,2) AS avg_watch_time
FROM bright_tv_case_study.default.bright_tv_viewership
GROUP BY Channel2
ORDER BY avg_watch_time ASC;

-- Top 5 most popular genres
SELECT Channel2, COUNT(*) AS genre_count
from `bright_tv_case_study`.`default`.`bright_tv_viewership`
GROUP BY Channel2
ORDER BY genre_count DESC;

-- Using the Full Join to combine the tables 
SELECT
coalesce (viewerships.UserID0, user_profiles.UserID) AS UserID,
viewerships.Channel2,
viewerships.RecordDate2,
viewerships.`Duration 2` AS Duration,
user_profiles.Gender,
user_profiles.Age,
user_profiles.Race,
user_profiles.Province
from `bright_tv_case_study`.`default`.`bright_tv_viewership` AS viewerships
FULL OUTER JOIN `bright_tv_case_study`.`default`.`bright_tv_user_profiles` AS user_profiles
    ON viewerships.UserID0 = user_profiles.UserID;


-- Full Join and Null Statements 
SELECT 
    IFNULL(ROUND(UserID, 0), 0) AS User_ID,
    IFNULL(Gender, 'Unknown') AS Gender,
    IFNULL(Race, 'Unknown') AS Race,
    IFNULL(CAST(Age AS STRING), '0') AS Age,
    IFNULL(Province, 'No_Province') AS Province
FROM bright_tv_case_study.default.bright_tv_user_profiles;
SELECT
coalesce (viewerships.UserID0, user_profiles.UserID) AS UserID,
viewerships.Channel2,
viewerships.RecordDate2,
viewerships.`Duration 2` AS Duration,
user_profiles.Gender,
user_profiles.Age,
user_profiles.Race,
user_profiles.Province
from `bright_tv_case_study`.`default`.`bright_tv_viewership` AS viewerships
FULL OUTER JOIN `bright_tv_case_study`.`default`.`bright_tv_user_profiles` AS user_profiles
    ON viewerships.UserID0 = user_profiles.UserID;
