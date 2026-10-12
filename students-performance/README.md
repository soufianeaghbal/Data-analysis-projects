# Factors associated with Students academic performance

In this project i analyzed 1,000 students' exam scores, trying to examine which factors really matters to students performance are they the direct factors which is basically preparing for exams or is there some indirect variables that affects students performance such as their parents education levels, gender and more variables 

### Tools :
MySQL, Excel 

### Project design :
Load data → validate → decode codes into labels (view) → explore → analyze by objective 

## 1. Research question and objectives 

### Research Question 
To what extent is students' academic performance (math, reading, writing and their overall performance) associated with their exam preparation and the other indirect factors (parent education, lunch type, ethnicity, and gender) ? 

### Objectives 
1. Examine the relationship between exam preparation and students academic performance.
2. Examine indirect factors effect on students academic performance.
3. Indentify which indirect factors whos the strongest association wiht academic performance.
4. Compare the association of the direct factor and the indirect factors .

### Hypotheses 


| Hypothesis | Tested in  |
|---|----|
| Students who completed the test preparation course score higher in all subjects than those who did not. | Task 3  |
| Students whose parents have higher education levels score higher than students whose parents have lower education levels. | Task 4  |
| Students with standard lunch score higher than students with free/reduced lunch. | Task 4  |
| Average scores differ across ethnic groups and between genders. | Task 4  |
| Among the indirect factors, lunch type and parental education show the largest score gaps. | Task 5  |
| The score gap associated with exam preparation is smaller than the gaps associated with the strongest indirect factors. | Task 5 & 6  |


## 2. Data Dictionary 

- `student_id`: unique ID for each student
- `gender`: student gender (0 = female, 1 = male)
- `race_ethnicity`: ethnic group, anonymized (group A to group E)
- `parental_level_of_education`: highest level of education of the parent(s) (some high school, high school, some college, associate's degree, bachelor's degree, master's degree)
- `lunch`: type of lunch received (0 = free/reduced, 1 = standard)
- `test_preparation_course`: whether the student completed a test preparation course (0 = none, 1 = completed)
- `math_score`
- `reading_score`
- `writing_score`
- `total_score`
- `average_score`


## 3. Data Analysis

### Overview
The 1,000 students averaged 67.77 overall (SD = 14.25). Math was the weakest subject (66.09) and reading the strongest (69.17), with writing at 68.05. Individual averages ranged from 9 to 100.




### Finding 1: Exam preparation (Objective 1)
| Group | Students | Avg math | Avg reading | Avg writing | Avg overall |
|-------|----------|----------|-------------|-------------|-------------|
| Completed | 358 | 69.70 | 73.89 | 74.42 | 72.67 |
| None | 642 | 64.08 | 66.53 | 64.50 | 65.04 |
| **Gap** | | **+5.62** | **+7.36** | **+9.92** | **+7.63** |

The results shows that students who completed the course preparation score higher with a signification gap in the results. where writing have the highest scores gap by 9.92 and an average of 7.63 for the overall which makes **H1: Supported.**



### Finding 2: Indirect factors (Objective 2)
| Factor | Group | Students | Math | Reading | Writing | Overall |
|--------|-------|----------|------|---------|---------|---------|
| Gender | female | 518 | 63.63 | 72.61 | 72.47 | 69.57 |
| Gender | male | 482 | 68.73 | 65.47 | 63.31 | 65.84 |
| Lunch | standard | 645 | 70.03 | 71.65 | 70.82 | 70.84 |
| Lunch | free/reduced | 355 | 58.92 | 64.65 | 63.02 | 62.20 |
| Parental education | master's degree | 59 | 69.75 | 75.37 | 75.68 | 73.60 |
| Parental education | bachelor's degree | 118 | 69.39 | 73.00 | 73.38 | 71.92 |
| Parental education | associate's degree | 222 | 67.88 | 70.93 | 69.90 | 69.57 |
| Parental education | some college | 226 | 67.13 | 69.46 | 68.84 | 68.48 |
| Parental education | some high school | 179 | 63.50 | 66.94 | 64.89 | 65.11 |
| Parental education | high school | 196 | 62.14 | 64.70 | 62.45 | 63.10 |
| Ethnicity | group E | 140 | 73.82 | 73.03 | 71.41 | 72.75 |
| Ethnicity | group D | 262 | 67.36 | 70.03 | 70.15 | 69.18 |
| Ethnicity | group C | 319 | 64.46 | 69.10 | 67.83 | 67.13 |
| Ethnicity | group B | 190 | 63.45 | 67.35 | 65.60 | 65.47 |
| Ethnicity | group A | 89 | 61.63 | 64.67 | 62.67 | 62.99 |

- **Parental education:** scores rise with education level, from 63.10 (high school) to 73.60 (master's degree). **H2: Supported.**
- **Lunch type:** standard lunch students scored 8.64 points higher, with the largest gap in math (11.11). **H3: Supported.**
- **Ethnicity:** averages rise from group A (62.99) to group E (72.75), a spread of 9.76 points.
- **Gender:** the overall gap was small (female 69.57 vs. male 65.84, 3.73 points) and the direction depends on the subject: males led in math (+5.10), females in reading (+7.14) and writing (+9.16). **H4: Partly supported.** because ethnicity differs clearly (9.76-point spread), but the gender difference is small.



### Finding 3: Ranking the factors (Objective 3)
| Rank | Factor | Type | Score gap | Effect size (gap / 14.25) |
|------|--------|------|-----------|---------------------------|
| 1 | Parental education | Indirect | 10.50 | 0.74 |
| 2 | Ethnicity | Indirect | 9.76 | 0.68 |
| 3 | Lunch type | Indirect | 8.64 | 0.61 |
| 4 | Exam preparation | Direct | 7.63 | 0.54 |
| 5 | Gender | Indirect | 3.73 | 0.26 |

Parental education showed the largest gap, followed by ethnicity and lunch type. Gender showed the smallest. **H5: Not supported**.



### Finding 4: Direct vs indirect factors (Objective 4)
Exam preparation ranked fourth, with a smaller gap (7.63) than parental education, ethnicity, and lunch type. **H6: Supported.**

Test prep gap within each subgroup (completed minus none):

| Factor | Group | Completed | None | Gap | Students (completed / none) |
|--------|-------|-----------|------|-----|------------------------------|
| Parental education | some high school | 69.34 | 61.91 | 7.43 | 77 / 102 |
| | high school | 66.96 | 61.55 | 5.41 | 56 / 140 |
| | some college | 74.65 | 65.28 | 9.37 | 77 / 149 |
| | associate's degree | 74.94 | 66.42 | 8.52 | 82 / 140 |
| | bachelor's degree | 76.24 | 69.17 | 7.07 | 46 / 72 |
| | master's degree | 76.32 | 72.20 | 4.12 | 20 / 39 |
| Ethnicity | group A | 70.06 | 59.21 | 10.85 | 31 / 58 |
| | group B | 70.64 | 62.58 | 8.06 | 68 / 122 |
| | group C | 71.87 | 64.39 | 7.48 | 117 / 202 |
| | group D | 73.53 | 67.20 | 6.33 | 82 / 180 |
| | group E | 76.69 | 69.80 | 6.89 | 60 / 80 |
| Lunch type | free/reduced | 67.76 | 58.95 | 8.81 | 131 / 224 |
| | standard | 75.51 | 68.30 | 7.21 | 227 / 418 |

Prepared students scored higher in all 13 subgroups (gaps from 4.12 to 10.85 points), so the association holds regardless of background. Background gaps also remained: among students without preparation, standard lunch students scored 9.35 points higher than free/reduced students (68.30 vs. 58.95), and among prepared students 7.75 points higher (75.51 vs. 67.76).



## 4. Conclusion 
Academic performance is associated with both exam preparation and background factors but these indirect factors effects students performance more than preparing or not does as we saw parental education showed the largest score gap (10.50) points, followed by ethnicity (9.76) and lunch type (8.64). This does not mean preparing for the exam does not effect the students. it actually does as the results shows the prep gap was positive in all 13 subgroups. 

### Recommendations : 
1. Motivate students to prepare more for their tests especially students on free lunch where the gap was 8.81 points.
2. Hold support programs for students whose parents have a high school education or less.




