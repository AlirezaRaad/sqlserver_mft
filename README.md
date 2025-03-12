# MFT | SQLServer

Hello to Everybody.
This is my answer to the question which had been provided by our <a href="https://www.linkedin.com/in/hani-hani-1793097a/">teacher</a> in <a href="https://www.linkedin.com/company/khanehomran/">MFT institution</a>, which is located in Tehran, IRAN.

The <b>First question</b> is, based on the picture below, create a database; Then pollute the database with data, and then answer the following questions:
1. The number of prescriptions that France has made drugs in it.
2. Name of the insurance company which had over 100 prescriptions in the last year.
3. Create a subprogram to get a company id and return the most expensive drug of that company.
4. Name of the Most Expensive Drug in each category.
5. Without tampering with the actual data in the database, make a report with two columns: the name of the drug and the price, which has a 3% increase.


![Alt text](Q1.png)



The <b>Second question</b> which is optional is, Using given Ratatouille database file, for each restaurant, provide a report that includes:
1. Which food is cooked by which chef
2. Which food is cooked but doesn't have a chef
3. Which chefs don't cook any food

The Boss insists you provide the report in one table with restaurant_title, chef_title, food_title as its columns, like the picture below:

![Alt text](Ratatouille.png)








<hr>


# Solutions : 1st Question

### **First Step : [Database Creating](Answers/AlirezaRaad-Pharmaceutical-Database_Creation.sql)**

In this step, instead of making tables with a foreign key constraint at first glance, I decided to break down the problem and first CREATE raw tables, and then ALTER the tables to add the given foreign key constraint in the picture.

### **Second Step**: [Database Polluting](Answers/AlirezaRaad-Pharmaceutical-Database_Poluting.sql)

In this step, I manually inserted data into `type_tbl`, `drug_tbl`, `country_tbl`, `company_tbl`, `commercial_tbl`, and `insurance_tbl` because I believe you HAVE to hardcode some essential data first. Then, by using the randomness of `NEWID()`, I randomly added data into `prescription_tbl` and `order_tbl`.

### **Last Step**: [Report](Answers/AlirezaRaad-Pharmaceutical-Database_Reports.sql)

Now, I just used my SQL knowledge and answered the given questions.


<hr>

# Solutions : 2nd Question

[Answer to this Question](https://github.com/AlirezaRaad/sqlserver_mft/blob/main/Answers/AlirezaRaad-Ratatouille-Report.sql) was a bit tricky, because I did not put `AND Food_table.restaurant_id = Restaurant_table.restaurant_id` at the end of my `LEFT JOIN Food_table ON Food_table.food_id = Food_chef_table.food_id` in the 3rd question, I consistently got 8 rows instread of 10.

You have to add an `AND` because you have to check the cooks that don't cook any food IN A RESTAURANT. If you don't add this and use regular `LEFT JOIN`, you fetch the chefs, but because they cook in other restaurants, you won't get the desired result.
