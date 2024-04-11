Hi [Business Stakeholder],

I'm part of the data team at Fetch and have been tasked with improving the quality of some of our core data assets that 
underpin our business operations. I've discovered a few foundational issues that I believe are impacting the reliability
and accuracy of our data. Here's a brief overview of the data quality issues I've identified:

1. **Duplicates**: I found a significant number of duplicate records in the `users` raw json source. This could be causing
   discrepancies in our user data and may be inflating our user counts. 

2. **Test Data**: I noticed test data was interspersed with the production brand data. This could be skewing our brand 
   performance metrics and may be leading to incorrect insights.

3. **Data Sparsity**: The receipt items table is relatively sparse, particularly in areas where the `brand_code` is null.
    This could be limiting our ability to roll up data to the brand level and is likely impacting our ability to analyze
    brand performance.

(For more detail on the above items, please reference the reports [here](https://github.com/connorpheraty/fetch_rewards_takehome_ch/tree/main/3_data_quality_issues))

In the interest of trying to resolve some of the issues, I was hoping you could help me answer a few questions:

#### Do we have de-duplication logic in place for our base tables?

#### How are we currently moving data from our production application database to our data warehouse?

Given the severity of the data quality issues, I would recommend implementing a data pipeline that includes data validation
checks to ensure that only clean, production data is being loaded into our data warehouse. I would also recommend running 
a cost/benefit analysis on third-party ETL tools like FiveTran that could solve our interim needs.

Related to this, it appears we are mixing staging and production data in our data warehouse. Given a more robust data pipeline solution, 
we should separate these environments to ensure that only production data is accessible to our analysts.

#### Performance and Scaling Concerns:
(I'm kind of shoe-horning this in here, but it was in the rubric)

Given that Snowflake is a cloud-based data warehouse, we don't need to worry about provisioning servers and scaling up/down 
infrastructure. However, in order to optimize costs, we should be mindful of data warehouse usage and query efficiency 
throughout the company. I would recommend setting up usage alert monitoring to ensure we are not exceeding our budget.
Occasionally long-running queries do get run by folks and we want to make sure we catch those before they become a problem.
Related to this, it may be beneficial to teach our snowflake power-users at the company how to use the query profiler to 
optimize their queries.

Let me know if you have any follow-up questions or concerns.

Thanks!