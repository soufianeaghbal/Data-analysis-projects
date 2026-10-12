create database students_performance;
use students_performance;

create table students_performance (
								   student_id int primary key,
                                   gender int check (gender in (0, 1)),
                                   race_ethnicity varchar(20),
                                   parental_level_of_education varchar(40),
                                   lunch int check (lunch in (0, 1)),
                                   test_preparation_course int check (test_preparation_course in (0 , 1)),
                                   math_score int,
                                   reading_score int, 
                                   writing_score int,
                                   total_score int,
                                   average_score decimal (10,6)
								  );

 /* task 1: decoding so results and charts show words like "female" not 0 and 1, which makes more sense */
 
 create view students_decoded as 
 
 select 
		student_id,
        case gender 
			when 0 then  "female"
            else "male"
		end as gender,
        race_ethnicity, 
        parental_level_of_education as parent_education,
        case lunch 
			when 1 then "standard" 
            else "free/reduced" 
		end as lunch_type, 
        case test_preparation_course
			when 1 then "completed" 
            else "none"
		end as test_prep,
		math_score,
        reading_score, 
        writing_score, 
        total_score,
        round(average_score, 2) as average_score
from students_performance;
		
select * from students_decoded limit 5;

 /* task 2: data exploration */ 
select 
	count(*) as students,
    round(avg(math_score), 2) as avg_math,
    round(avg(reading_score),2) as avg_reading,
    round(avg(writing_score),2) as avg_writing,
    round(avg(average_score), 2) as avg_overall, 
    round(stddev(average_score), 2) as sd_overall,
    min(average_score) as min_overall,
    max(average_score) as max_overall
from students_decoded;


 /* task 3: examining the different between students who pepared for the exams and ones who did not */
 
 with avg_scores_diff as (
						  select 
							test_prep,
                            round(avg(math_score),2) as math, 
                            round(avg(reading_score),2) as reading, 
                            round(avg(writing_score), 2) as writing, 
                            round(avg(average_score),2) as overall
						 from students_decoded
                         group by test_prep
                         )
select 
	c.math - n.math as math_gap, 
    c.reading - n.reading as reading_gap,
    c.writing - n.writing as writing_gap,
    c.overall - n.overall as overall_gap
from avg_scores_diff as c
join avg_scores_diff as n on c.test_prep = "completed" and n.test_prep = "none";


/* task 4: indirect factors vs performance */

with factors as (
				select "parent_education" as factor, 
                       parent_education as grp,
                       math_score, 
                       reading_score, 
                       writing_score, average_score 
				from students_decoded
	union all
                select "lunch_type", 
                       lunch_type,     
                       math_score, 
                       reading_score, 
                       writing_score, 
                       average_score 
				from students_decoded
	union all 
                select "race_ethnicity", 
                        race_ethnicity, 
                        math_score, 
                        reading_score, 
                        writing_score, 
                        average_score 
				from students_decoded
    union all 
                select 'gender',         
					   gender,         
                       math_score, 
                       reading_score, 
					   writing_score, 
                       average_score 
				from students_decoded
)

select 
	factor, 
    grp, 
    count(*) as students,
    round(avg(math_score), 2) as avg_math,
    round(avg(reading_score), 2) as avg_reading, 
    round(avg(writing_score), 2) as avg_writing,
    round(avg(average_score), 2) as avg_overall
from factors 
group by factor, grp
order by factor, avg_overall DESC;

/* task 5: rank the factors by the largest effect */
select
    factor,
    round(max(avg_overall) - min(avg_overall), 2) as score_gap,
    rank() over (order by max(avg_overall) - min(avg_overall) desc) as gap_rank
from (
     select factor, 
            grp, 
            avg(average_score) as avg_overall
     from (
           select "parent_education" as factor, 
                parent_education as grp, 
                average_score 
		   from students_decoded
           union all
           select 'lunch_type',     
		           lunch_type,     
                   average_score 
           from students_decoded
           union all
           select 'race_ethnicity', 
				  race_ethnicity, 
                  average_score 
		   from students_decoded
           union all
           select 'gender',         
                   gender,         
                   average_score from students_decoded
           union all
           select 'test_prep',      
                   test_prep,      
                   average_score 
		   from students_decoded
         ) as factors
    group by factor, grp
    ) as grp_avgs
group by factor
order by gap_rank;

/* task 6 : comparing the association of the direct factor (exam prep) with the the strongest inderect factors 
which are parental education, lunch type and thenicity */ 

/* test prep aeffect within each parental education group */
select parent_education, 
	   test_prep, 
       count(*) as students, 
       round(avg(average_score), 2) as avg_overall
from students_decoded
group by parent_education, test_prep
order by parent_education, test_prep;

/* test prep effect within each ethnic group */
select race_ethnicity, 
	   test_prep, 
       count(*) as students, 
       round(avg(average_score), 2) as avg_overall
from students_decoded
group by race_ethnicity, test_prep
order by race_ethnicity, test_prep;

/* test prep effect within each lunch group */ 
select lunch_type, 
       test_prep, 
       count(*) as students, 
       round(avg(average_score), 2) as avg_overall
from students_decoded
group by lunch_type, test_prep
order by lunch_type, test_prep;
