USE MiniEasyPeasyCook;

-- --------------------------------------------------------
-- Main page (Recipes user owns, liked or saved)
-- --------------------------------------------------------
SET @username = 'globb2i';

-- Own recipes of an user
SELECT U.Username, R.FoodName, R.Description, R.Recipe FROM User U INNER JOIN Recipe R 
ON U.ID = R.UserID
WHERE Username = @username;

-- Liked recipes of an user
SELECT U.Username, R.FoodName, R.Description, R.Recipe FROM User U INNER JOIN Liking L
ON U.ID = L.UserID Inner JOIN Recipe R 
ON L.RecipeID = R.ID
WHERE Username = @username;

-- Saved recipes of an user
SELECT U.Username, R.FoodName, R.Description, R.Recipe FROM User U INNER JOIN Saving S
ON U.ID = S.UserID Inner JOIN Recipe R 
ON S.RecipeID = R.ID
WHERE Username = @username;


-- --------------------------------------------------------
-- Information about one specific repcipe

-- --------------------------------------------------------
SET @recipeID = 405;

-- Main information 
SELECT * FROM Recipe R INNER JOIN User U
ON R.UserID = U.ID
WHERE R.ID = @recipeID
GROUP BY R.ID;

-- Images of a post
SELECT I.ImageFileUrl FROM Recipe R INNER JOIN Image I
ON R.ID = I.RecipeID 
WHERE R.ID = @recipeID;


-- ------------------------------------------------------------------------------------------------------------------------------
-- Analythical data queries
-- ------------------------------------------------------------------------------------------------------------------------------
-- TotalNumberOfUsers
SELECT COUNT(*) AS TotalNumberOfUsers FROM User; 

-- TotalNumberOfRecipes
SELECT COUNT(*) AS TotalNumberOfPosts FROM Recipe; 

-- MaxNumberOfRecipesPerUser
SELECT MAX(result.NumberOfRecipes) AS MaxNumberOfRecipesPerUser FROM (SELECT COUNT(R.ID) AS NumberOfRecipes FROM User U LEFT JOIN Recipe R ON U.ID = R.UserID
GROUP BY U.ID) result;

-- MaxNumberOfLikesPerRecipe
SELECT MAX(NumberOfLikesPerRecipe) AS MaxNumberOfLikesPerPost FROM (SELECT R.ID, COUNT(L.RecipeID) AS NumberOfLikesPerRecipe FROM Recipe R LEFT JOIN Liking L ON R.ID = L.RecipeID
GROUP BY R.ID) result;

-- Top 10 recipes with greatest amount of likes
SELECT R.ID, COUNT(L.RecipeID) AS Likes FROM Recipe R INNER JOIN Liking L 
ON R.ID = L.RecipeID
GROUP BY R.ID
ORDER BY Likes Desc
LIMIT 10;

-- Top 10 saved recipes
SELECT R.ID, COUNT(S.RecipeID) AS Savings FROM Recipe R INNER JOIN Saving S 
ON R.ID = S.RecipeID
GROUP BY R.ID
ORDER BY Savings Desc
LIMIT 10;

-- Number of user registrations by date (will return as many rows as there are unique dates)
SELECT DATE(CreationTime) AS CreationTimeH, COUNT(*) AS NumberOfRegistrations 
FROM User GROUP BY CreationTimeH;

SELECT G.Name AS GenderName, COUNT(U.ID) AS NumberOfUsers FROM Gender G 
INNER JOIN User U ON G.ID = U.GenderID
GROUP BY G.ID ORDER BY NumberOfUsers DESC;
