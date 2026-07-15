# Introduction
📊 This project explores the Data Analyst job market using SQL, analyzing 💰 salary trends, 🏆 identifying the highest-paying roles, and 🔥 discovering the most in-demand technical skills. It also uncovers where 📈 high-demand skills align with 💼 high-paying opportunities, providing valuable insights for aspiring and experienced data analysts.

📁 Check out the SQL scripts used in this project: [project_sql](/project_sql/)

# Background
As the demand for Data Analysts continues to rise, understanding the current job market has become essential for anyone pursuing a career in data analytics. This project uses SQL to analyze real-world job posting data, uncovering insights into salaries, employer requirements, and the skills that are most valued in the industry.

Through this analysis, the project answers key questions such as:

1. Which Data Analyst roles offer the highest salaries?   
2. Which technical skills are most frequently requested by employers?  
3. Which skills combine strong market demand with high earning potential?

# Tools I Used
This project was completed using the following tools and technologies.

- **SQL** – Used to query and analyze job posting data, uncovering insights into salaries, skill demand, and career opportunities for Data Analysts.  
- **PostgreSQL** – Used to store and manage the job market dataset while executing SQL queries for analysis.  
- **Visual Studio Code** – Used as the development environment for writing, testing, and organizing SQL queries throughout the project.  
- **Git & GitHub** – Used to track project progress, manage version control, and share the analysis through a public repository.

# The Analysis
The SQL queries in this project focus on different areas of the Data Analyst job market, with each analysis addressing a specific question to uncover meaningful insights.
### 1. Top-Paying jobs
This query identifies the top 10 highest-paying remote Data Analyst positions by filtering job postings to include only remote roles with available average annual salary data. The results are sorted in descending order by salary and include key job details such as the company name, job location, schedule type, salary, and posting date, providing an overview of the highest-paying opportunities in the data analytics job market.
```sql
SELECT
    job_postings.job_id,
    job_postings.job_title,
    companies.name,
    job_postings.job_location,
    job_postings.job_schedule_type,
    job_postings.salary_year_avg,
    job_postings.job_posted_date
FROM
    job_postings_fact AS job_postings
LEFT JOIN 
    company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE
    job_postings.job_title_short = 'Data Analyst' AND
    job_postings.job_location = 'Anywhere' AND
    job_postings.salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Based on the analysis of the dataset, the following key insights were identified:

- **The highest-paying remote Data Analyst positions** offer annual salaries ranging from approximately $184K to $650K, demonstrating the significant earning potential for specialized Data Analyst roles.
- **The top-paying opportunities** are offered by companies across a variety of industries, indicating that high-paying Data Analyst roles are not limited to a single sector but are in demand across the broader job market.
- **All of the top 10 positions are remote ("Anywhere")** and include available salary information, highlighting the strong availability of well-compensated remote opportunities for Data Analysts.

![top-jobs](project_sql\assets\topjobs.png)
*Bar graph visualizing the top 10 most in-demand skills among top-paying Data Analyst roles; ChatGPT generated this graph from SQL query results.*


### 2. Top-Paying Job skills
To identify the highest-paying Data Analyst roles, I filtered job postings to include only remote positions with a specified average yearly salary. I then ranked the results by salary and selected the top 10 highest-paying jobs. Finally, I joined the results with the skills tables to identify the technical skills required for each of these high-paying positions.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact AS job_postings
    LEFT JOIN 
        company_dim AS companies ON job_postings.company_id = companies.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills.skills
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim AS skills_job ON top_paying_jobs.job_id = skills_job.job_id
INNER JOIN
    skills_dim AS skills ON skills_job.skill_id = skills.skill_id
ORDER BY
    salary_year_avg DESC
```
Based on the analysis of the dataset, the following key insights were identified:

- **SQL** is the most in-demand skill, appearing 8 times, followed by Python (7) and Tableau (6), highlighting the core skills required for top-paying Data Analyst roles.  
- **Top-paying Data Analyst jobs** in the dataset offer salaries ranging from $184K to $256K per year, with an average salary of about $209K.  
- **SmartAsset, Inclusively, and AT&T** appear most frequently among the top-paying job postings, indicating they actively seek Data Analysts with strong technical skills.

![In-demand-skills](project_sql\assets\in-demand-skills.png)
*Bar graph visualizing the top 10 most in-demand skills among top-paying Data Analyst roles; ChatGPT generated this graph from SQL query results.*

### 3. In-Demand Skills for Data Analysts
This query analyzes job postings to determine the five most frequently requested skills for Data Analyst positions.

```sql
SELECT 
    skills,
    COUNT(skills_job.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_job ON job_postings_fact.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE  
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Based on the analysis of the dataset, the following key insights were identified

- **SQL** is the most in-demand skill, making it the core technical competency for Data Analyst roles.  
- **Excel and Python** remain highly sought-after, highlighting the importance of both spreadsheet analysis and programming skills.  
- **Tableau and Power BI** rank among the top skills, reflecting the growing demand for data visualization and business intelligence expertise.

| Skills | Demand Count |
| ------- | -----------: |
| SQL | 7291 |
| Excel | 4611 |
| Python | 4330 |
| Tableau | 3745 |
| Power BI | 2609 |

*Table of the demand for the top 5 skills for data analyst job posting*

### 4. Skills Based on Salary
This query identifies the highest-paying skills for Data Analyst positions by calculating the average annual salary associated with each skill. The results are ranked in descending order to highlight the skills linked to the highest-paying job opportunities.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_job ON job_postings_fact.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE  
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Based on the analysis of the dataset, the following key insights were identified:

- **Specialized technologies** are associated with higher average salaries, indicating that niche technical expertise is highly valued by employers.
- **Cloud, data engineering, and infrastructure skills** command competitive salaries, reflecting the growing demand for scalable data solutions.
- **Advanced programming and analytics tools** continue to offer strong earning potential, highlighting the value of expanding technical skill sets in the data analytics field.

| Skills | Average Salary (USD) |
| ------- | -------------------: |
| PySpark | $208,172 |
| Bitbucket | $189,155 |
| Couchbase | $160,515 |
| Watson | $160,515 |
| DataRobot | $155,486 |
| GitLab | $154,500 |
| Swift | $153,750 |
| Jupyter | $152,777 |
| Pandas | $151,821 |
| Elasticsearch | $145,000 |

*Table of the average salary fot the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn
This query identifies the most optimal skills for Data Analyst roles by combining both salary and demand. It calculates the average annual salary and the number of job postings for each skill, filters out low-demand skills, and ranks the results by highest average salary to highlight skills that are both well-paying and frequently requested.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Based on the analysis of the dataset, the following key insights were identified:

- **Cloud and big data technologies** such as **Azure**, **AWS**, **S**nowflake**, **Hadoop**, and **BigQuery** offer a strong combination of competitive salaries and consistent market demand, making them valuable skills for Data Analysts.
- **Collaboration and project management tools**, including **Confluence** and **Jira**, appear among the highest-value skills, highlighting the importance of effective teamwork and workflow management in data analytics roles.
- **Programming and database-related skills**, such as **Go**, **Java**, and **SSIS**, continue to provide strong earning potential, demonstrating that technical expertise beyond traditional analytics tools is increasingly valued by employers.

| Skill ID | Skills | Demand Count | Average Salary (USD) |
| --------: | ------ | -----------: | -------------------: |
| 8 | Go | 27 | $115,320 |
| 234 | Confluence | 11 | $114,210 |
| 97 | Hadoop | 22 | $113,193 |
| 80 | Snowflake | 37 | $112,948 |
| 74 | Azure | 34 | $111,225 |
| 77 | BigQuery | 13 | $109,654 |
| 76 | AWS | 32 | $108,317 |
| 4 | Java | 17 | $106,906 |
| 194 | SSIS | 12 | $106,683 |
| 233 | Jira | 20 | $104,918 |

*Table of the most optimal skills for data analyst sorted by salary*

# What I Learned
Throughout this project, I gained hands-on experience in analyzing data, exploring trends, and transforming raw information into meaningful insights.

- **🗂️Writing advanced SQL queries** using JOINs, CTEs, subqueries, aggregate functions, GROUP BY, and HAVING to extract and analyze data from relational databases.
- **📊Applying SQL for data analysis** to uncover trends in salaries, identify in-demand skills, and evaluate the relationship between job demand and compensation.
- **🧩Improving data querying and problem-solving skills** by filtering, sorting, aggregating, and combining datasets to answer real-world business questions.

# Conclusions
This project has been a valuable learning experience that strengthened my ability to work with SQL and analyze real-world datasets. Throughout the journey, I learned how to write efficient queries, extract meaningful insights from relational databases, and answer business-driven questions using data. By exploring salary trends, identifying in-demand skills, and comparing demand with compensation, I gained a deeper understanding of how data can support informed decision-making. Overall, this project not only improved my technical SQL skills but also enhanced my analytical thinking, problem-solving abilities, and confidence in transforming raw data into actionable insights.