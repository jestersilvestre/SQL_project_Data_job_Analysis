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