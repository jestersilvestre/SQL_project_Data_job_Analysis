
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
