WITH top_skills_count AS (
    SELECT
            skill_id,
            COUNT(*) AS total
    FROM 
            skills_job_dim
    GROUP BY
            skill_id
)
SELECT 
    skills_dim.skills AS top_skills,
    top_skills_count.total_skills
FROM skills_dim
LEFT JOIN
    top_skills_count ON top_skills_count.skill_id = skills_dim.skill_id
ORDER BY
   total_skills DESC
LIMIT 5



SELECT
    skills.skills AS top_skills,
    skills_job.total_skills
FROM skills_dim AS skills
INNER JOIN (
    SELECT
        skill_id,
        COUNT(*) AS total_skills
    FROM skills_job_dim
    GROUP BY skill_id
) skills_job
    ON skills.skill_id = skills_job.skill_id
ORDER BY skills_job.total_skills DESC
LIMIT 5;

CREATE TABLE march_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
 

 WITH q1_jobs AS (
    SELECT *
    FROM january_jobs

    UNION ALL

    SELECT *
    FROM february_jobs

    UNION ALL

    SELECT *
    FROM march_jobs
)

SELECT
    q1_jobs.job_id,
    q1_jobs.job_title_short,
    q1_jobs.salary_year_avg,
    skills_dim.skills,
    skills_dim.type,
    CASE
        WHEN q1_jobs.job_location = 'Anywhere' THEN 'Remote'
        WHEN q1_jobs.job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM q1_jobs
LEFT JOIN skills_job_dim
    ON q1_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE q1_jobs.salary_year_avg > 70000 AND q1_jobs.job_title_short = 'Data Analyst'
ORDER BY q1_jobs.job_id;
