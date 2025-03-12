USE Ratatouille
/*
This the report is based on Ratatouille database.
Question: In Each Restaurant :
1.Which Food Is Coocked By which chef

2. Whcih food is coocked BUT dont have any chef

3.Whcih chefs ont cook any food

*/

WITH CTE AS (
---------1
SELECT Restaurant_table.restaurant_title, Chef_table.chef_title, Food_table.food_title FROM Restaurant_table JOIN Food_table ON 
Restaurant_table.restaurant_id = Food_table.restaurant_id  JOIN Food_chef_table ON Food_chef_table.food_id = Food_table.food_id
JOIN Chef_table ON Chef_table.chef_id = Food_chef_table.chef_id
UNION ALL 

---------2
SELECT Restaurant_table.restaurant_title, Chef_table.chef_title, Food_table.food_title FROM Restaurant_table LEFT JOIN Food_table ON 
Restaurant_table.restaurant_id = Food_table.restaurant_id LEFT JOIN Food_chef_table ON Food_chef_table.food_id = Food_table.food_id
LEFT JOIN Chef_table ON Chef_table.chef_id = Food_chef_table.chef_id
WHERE chef_title IS NULL
UNION ALL

---------3
SELECT Restaurant_table.restaurant_title, Chef_table.chef_title, Food_table.food_title FROM Restaurant_table JOIN Restaurant_chef_table ON 
Restaurant_table.restaurant_id = Restaurant_chef_table.restaurant_id LEFT JOIN Chef_table ON Chef_table.chef_id = Restaurant_chef_table.chef_id
LEFT JOIN Food_chef_table ON Restaurant_chef_table.chef_id = Food_chef_table.chef_id LEFT JOIN Food_table ON Food_table.food_id = Food_chef_table.food_id
AND Food_table.restaurant_id = Restaurant_table.restaurant_id
WHERE Food_table.food_title IS NULL

) SELECT * FROM CTE ORDER BY restaurant_title
