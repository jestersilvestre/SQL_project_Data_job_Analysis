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