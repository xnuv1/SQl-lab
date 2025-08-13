--Basketball (Questions 1-15)

--1. All Team Information - "Display all information for the first 10 teams in the database."

select 
*
from bigquery-public-data.ncaa_basketball.mbb_teams
limit 10;


--2. Unique Conferences - "Find all unique conference names that exist in the database."

select 
distinct(conf_name)
from bigquery-public-data.ncaa_basketball.mbb_teams;


--3. Teams in Alphabetical Order - "List all team markets in alphabetical order."

select 
market
from bigquery-public-data.ncaa_basketball.mbb_teams
order by 1 asc;


--4. First Five Teams - "Show the first 5 teams when ordered by team name."

select 
name
from bigquery-public-data.ncaa_basketball.mbb_teams
order by 1
limit 5;


--5. Basic Team Details - "Display only the market, name, and conference name for all teams.

select 
market,
name, 
conf_name
from bigquery-public-data.ncaa_basketball.mbb_teams;


--6. Venue States - "Find all unique venue states and display them in alphabetical order."

select
distinct(venue_state)
from bigquery-public-data.ncaa_basketball.mbb_teams
order by 1 asc;


--7. Team Colors Sample - "Show the market and color information for 15 teams."

select
market,
color
from bigquery-public-data.ncaa_basketball.team_colors
limit 15;


--8. Mascot Information - "Display the market, mascot, and mascot name for the first 10 teams."

select 
market,
mascot,
mascot_name
from bigquery-public-data.ncaa_basketball.mascots
limit 10;



--Conference & Team Organization (9-15)

--9. Big Ten Teams - "Find all teams that belong to the Big Ten conference."

select 
name,
conf_name
from bigquery-public-data.ncaa_basketball.mbb_teams
where conf_name = "Big Ten"
ORDER BY 2 desc;


--10. Tournament Games - "Find all games between 2014-2016 that were part of any tournament."

select 
game_id,
season,
tournament
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season between 2014 and 2016 and tournament is not null;


--11. State Schools - "Find all teams where the market name contains the word 'State'."

select
name,
market
from bigquery-public-data.ncaa_basketball.mbb_teams
where market like '%State%';


--12. Power Conferences - "Find all teams that belong to the ACC, SEC, or Big 12 conferences."

select
name,
conf_name
from bigquery-public-data.ncaa_basketball.mbb_teams
where conf_alias = "ACC" or conf_alias = "SEC" or conf_name = "Big 12";


--13. Teams Per Conference - "Count how many teams belong to each conference."

select
conf_name,
count(name) as Team_count
from bigquery-public-data.ncaa_basketball.mbb_teams
group by  1
order by Team_count desc;


--14. Large Conferences - "Find conferences that have more than 10 teams."

select
conf_name,
case when count(name) > 10 then "Larger Conference" else "Small Conference" end as conf_size
from bigquery-public-data.ncaa_basketball.mbb_teams
group by 1
having conf_size = "Larger Conference";


/*15. Conference Regional Groups - "Group conferences into regions and count teams in
each region."
Categories for regions:
● East: "Eastern Region" (ACC, Big East, Colonial Athletic Association)
● Midwest: "Midwest Region" (Big Ten, Big 12)
● West: "Western Region" (Pac-12, Mountain West)
● Other: "Other Regions" (all other conferences)*/

select
count(*) as Team_count,
case when conf_alias = 'ACC' or conf_name = "Big East" or conf_name= 'Colonial Athletic Associatio' then  'Eastern Region' 
when conf_name = 'Big Ten' or conf_name = 'Big 12' then "Midwest Region"
when conf_alias = 'Pac-12' or conf_name = 'Mountain West' then 'Western Region'
else 'Other Regions' end as Region
from bigquery-public-data.ncaa_basketball.mbb_teams
group by region
order by Team_count desc;



--Category 2: Deep Diving into Performance (Questions 16-30)

--16. High Attendance Games - "Find all games in 2016 that had attendance greater than 15,000."

select
game_id,
attendance
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2016 and attendance > 15000;


--17. Total Teams - "Count the total number of teams in the database."

select
count(*)
from bigquery-public-data.ncaa_basketball.mbb_teams;


--18. Highest Attendance 2015 - "Find the highest attendance recorded for any game in 2015."

select
game_id,
attendance
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2015 
order by attendance desc;


--19. Lowest Attendance 2014 - "Find the lowest attendance recorded for any game in 2014 (excluding null values)."

select
game_id,
attendance
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2014 and attendance is not null
order by attendance asc;


--20. Average Attendance 2015 - "Calculate the average attendance for all games in 2015."

select
avg(attendance) as avg_attendance
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2015;


--21. Total Attendance 2016 - "Calculate the total attendance across all games in 2016."

select
sum(attendance) as Total_attendance
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2016 ;


--22. Tournament Game Count - "Count how many tournament games were played in 2015."

select
count(game_id) as num_of_games
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2015 and tournament is not null;


--23. Unique Venues 2014 - "Count how many different venues were used during the 2014 season."

select
count(distinct(venue_name)) as used_venues
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2014;


--24. Attendance Statistics 2016 - "Show the minimum, maximum, and average attendance for games in 2016."

select 
min(attendance) as min_att,
max(attendance) as max_att,
avg(attendance) as avg_att
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2016;



--Seasonal & Temporal Analysis (25-30)

--25. Home Games in 2015 - "Find all home games played during the 2015 season."

select 
game_id
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season = 2015  and h_name is not null;


--26. January 2015 Games - "Find all games that were scheduled in January 2015."

select 
game_id,
extract(month from scheduled_date) as game_month
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season = 2015 
group by 1, 2
having game_month = 1;


--27. Conference Games in 2014 - "Find all conference games played during the 2014 season."

select 
game_id
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2014 and conference_game is not null and conference_game = true;


--28. Games Per Season - "Count the number of games played in each season from 2014-2016."

select
season,
count(*) as total_games
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season is not null and season between 2014 and 2016
group by 1
order by season;


--29. Games by Month - "Count how many games were played in each month during 2015."

select
extract(month from scheduled_date)as Month,
count(*) as Game_count
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season = 2015
group by Month;


--30. Weekend Games - "Find all games played on weekends (Saturday or Sunday) in 2016."

select
game_id,
extract(DAYOFWEEK from scheduled_date)as Game_day
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season = 2016
group by 1, 2
having Game_day = 7 or  Game_day = 1;



--Category 3: Advanced Analytics (Questions 31-45)

--31. Teams with Colors - "Show each team's market, name, and team color."

select
t.name,
t.market,
c.color
from bigquery-public-data.ncaa_basketball.mbb_teams t
left join bigquery-public-data.ncaa_basketball.team_colors c
on t.id = c.id;


--32. Teams with Mascots - "Show all teams and their mascots, including teams without mascot information."

select
t.name,
t.conf_name,
m.mascot
from bigquery-public-data.ncaa_basketball.mbb_teams t 
left join  bigquery-public-data.ncaa_basketball.mascots m
on t.id = m.id;


--33. Formatted Game Dates - "Display game dates in 'Month YYYY' format for games in 2014."

select
FORMAT_DATE('%b %Y', scheduled_date) AS formatted
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season = 2014;


--34. Average Attendance as Float - "Calculate the average attendance for 2015 games, casting attendance as a decimal number."

select
avg(cast(attendance as float64)) as avg_att
from bigquery-public-data.ncaa_basketball.mbb_games_sr
where season = 2015;


--35. CTE - High Performing Conference Teams - "Find teams that had above-average attendance compared to other teams in their same conference during 2015."

with avg_att_table as (
select 
conf_name,
avg(attendance) AS avg_att
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2015
group by 1
),

team_avg as (
select
t.name,
t.conf_name,
avg(t.attendance) as team_avg_att,
a.avg_att
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr t
join avg_att_table a 
on t.conf_name = a.conf_name
where t.season = 2015
group by t.name, t.conf_name, a.avg_att
)

select
*
from team_avg
where team_avg_att > avg_att
order by team_avg_att desc;


--36. CTE - High Activity Teams - "Find teams that played more than 30 games in 2015 and show their full team information."

with game_count_table as(
  select
  name,
  market,
  alias,
  count(*) as game_count
  from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
  where season = 2015
  group by 1,2,3
  
)

select
*
from game_count_table
where game_count > 30
order by game_count desc;


--37. CTE - Most Active Conferences - "Find the top 5 conferences with the most games played from 2014-2016."

with conf_count_table as(
select
conf_name,
count(*) as game_count
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season between 2014 and 2016
group by 1
  
)

select
*
from conf_count_table
order by game_count desc
limit 5;



--Performance Categorization & Classification (38-42)

/* 38. Attendance Size Categories - "Categorize games in 2015 by their attendance size and
count each category."
Categories for attendance size:
● Small: "Small Crowd" (attendance < 5,000)
● Medium: "Medium Crowd" (attendance 5,000-15,000)
● Large: "Large Crowd" (attendance > 15,000)
● Unknown: "Unknown Size" (null attendance)*/

select
game_id,
attendance,
case 
when attendance > 15000 then "Large Crowd"
when attendance > 5000 then "Medium Crowd"
when attendance < 5000 then "Small Crowd"
else "Unknown Size" end as attendance_category
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2015;


/*39. Home Attendance Performance - "Categorize teams by their home game attendance
performance from 2014-2016."
Categories for performance:
● High: "High Attendance" (average home attendance > 10,000)
● Medium: "Medium Attendance" (average home attendance 5,000-10,000)
● Low: "Low Attendance" (average home attendance < 5,000)*/

select
name,
case 
when avg(attendance) > 10000 then "High Attendance"
when avg(attendance) > 5000 then "Medium Attendance"
else "Low Attendnace" end as attendance_category
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season between 2014 and 2016 and home_team = true and neutral_site = false
group by name
order by attendance_category;


/*40. Tournament Participation - "Categorize teams by their tournament participation from
2014-2016 and count by season."
Categories for participation:
● NCAA: "NCAA Tournament" (tournament = 'NCAA')
● Other: "Other Tournament" (tournament not null but not 'NCAA')
● None: "No Tournament" (tournament is null)*/

select
name,
season,
case
when tournament = 'NCAA' then "NCAA Tournament"
when tournament is not null and tournament != 'NCAA'then "Other Tournament"
else "No Tournament" end as Tournament_Participation
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season between 2014 and 2016
order by season;


-- 41. CTE - Top Scoring Teams - "Find teams that scored above their conference average in 2015 using a CTE to calculate conference averages first."

with conf_avg_table as (
select
conf_name,
avg(points) as conf_avg
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2015
group by 1
)

select 
t.name,
c.conf_avg,
avg(t.points) as team_avg
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr t
left join conf_avg_table c
on t.conf_name = c.conf_name
group by t.name, c.conf_avg 
having team_avg > c.conf_avg 
order by team_avg desc, c.conf_avg;


--42. CTE - Popular Venue Analysis - "Find venues that have higher attendance than the average attendance of venues in their same state using a CTE derived table."

with attendance_avg_table as (
select
venue_state,
avg(attendance) as avg_state_attendance
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr 
group by 1
)

select 
t.name,
t.venue_state,
a.avg_state_attendance,
avg(t.attendance) as team_avg_att
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr t
left join attendance_avg_table a
on t.venue_state = a.venue_state
group by t.name, t.venue_state,a.avg_state_attendance
having team_avg_att >  avg_state_attendance
order by team_avg_att desc;



--Advanced Multi-Dimensional Analysis (43-45)

--43. CTE - Conference Tournament Leaders - "Find the team in each conference that played the most tournament games from 2014-2016 using a CTE to first calculate tournament games per team."

with tournament_games as (
select
name,
conf_name,
count(*) as num_of_games
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season between 2014 and 2016 and tournament is not null
group by 2,1
)

select
conf_name,
name,
num_of_games
from tournament_games t
where num_of_games =
(
select
max(num_of_games)
from tournament_games t1
where t1.conf_name = t.conf_name
)
order by num_of_games desc;



--44. CTE - Top Player Minutes - "Find players who averaged more than 20 minutes per game in 2015 using a CTE derived table to calculate player averages first."

with avg_min_table as (
select 
full_name,
avg(minutes_int64) as avg_min
from bigquery-public-data.ncaa_basketball.mbb_players_games_sr
where season = 2015
group by full_name
)

select full_name, avg_min
from avg_min_table
where avg_min > 20
order by avg_min desc;


-- 45. CTE - Season Comparison Analysis - "Compare each team's 2015 performance to their 2014 performance by using a CTE to calculate season statistics first, then joining the results."

with the_2014_table as 
(
select 
name,
sum(points) as points_in_2014,
sum(rebounds) as rebounds_in_2014,
sum(assists) as assists_in_2014
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2014
group by 1
),

the_2015_table as (
select 
name,
sum(points) as points_in_2015,
sum(rebounds) as rebounds_in_2015,
sum(assists) as assists_in_2015
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr
where season = 2015 
group by 1
)

select 
t.name,
a.points_in_2014,
b.points_in_2015,
a.rebounds_in_2014,
b.rebounds_in_2015,
a.assists_in_2014,
b.assists_in_2015
from bigquery-public-data.ncaa_basketball.mbb_teams_games_sr t
join the_2014_table a using(name) 
join the_2015_table b using (name);
