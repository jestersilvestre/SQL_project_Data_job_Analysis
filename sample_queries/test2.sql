SELECT 
    job_postings.job_title_short,
    companies.name AS company_name,
    job_postings.salary_year_avg,
    CASE
        WHEN job_postings.salary_year_avg < 40000 THEN 'Low Salary'
        WHEN job_postings.salary_year_avg >= 60000 AND job_postings.salary_year_avg < 80000 THEN 'Standard Salary'
        WHEN job_postings.salary_year_avg > 81000 THEN 'High Salary'
    END AS job_salaries
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
    ON job_postings.company_id = companies.company_id
WHERE
    job_postings.job_title_short = 'Data Analyst'
ORDER BY 
    job_salaries ASC;