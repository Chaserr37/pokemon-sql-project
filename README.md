# Pokémon SQL Project

![Pokémon Project Cover](./all-pokemon-pictures-bh730s8zr74xsc2p.webp)


## Project Motivation

I chose the Pokémon dataset because I wanted a project that’s both fun and different from typical business data. Working with Pokémon makes the learning process enjoyable and engaging while still challenging me to apply important SQL skills like data cleaning, string parsing, and advanced querying.

That said, I’m also planning to work on a future project using real business data to showcase my abilities in a more traditional, professional context with Python and SQL.

## Project Overview

This project demonstrates my ability to work with SQL by creating, importing, and querying a Pokémon dataset.  
The dataset contains information on Pokémon attributes such as base experience, height, weight, types, abilities, moves, and stats. Note on Units: Height is measured in decimetres (1 decimetre = 0.1 meters). Weight is measured in hectograms(1 hectogram = 0.1kilograms).

## Project Goals

This project showcases my ability to manipulate and analyze real-world data using SQL. By working with a comprehensive Pokémon dataset, I demonstrate skills in data cleaning, querying complex string fields, creating views, and deriving meaningful insights. The project highlights problem-solving with string parsing inside SQL and presents data clearly through well-structured queries and markdown tables.

## Database Setup

Dataset Source: The Pokémon dataset was downloaded from Kaggle, providing detailed information on Pokémon attributes including stats, types, and abilities.

Database: SQLite was used for creating the database, running queries, and performing data analysis.

Tools: I utilized DB Browser for SQLite for initial database exploration and VSCode for writing SQL queries and the README file. The original dataset was also examined in Microsoft Excel to better understand the data structure.

Dataset Source: The Pokémon dataset was downloaded from Kaggle, providing detailed information on Pokémon attributes including stats, types, and abilities.
Source Link: Pokémon Dataset on Kaggle

## How to Run the SQL Files

Run the SQL files in order from top to bottom to set up and analyze the Pokémon dataset:

1. `create_table.sql`  
2. `data_cleaning.sql`  
3. `views.sql`  
4. `analysis_queries.sql`  
5. `self_join.sql`  
6. `glass_cannon_analysis.sql`

You can run them using the SQLite command line like this:

```bash
sqlite3 pokemon.db < filename.sql
```

### Table Creation
The `pokemon` table was created with the following schema:

```sql
CREATE TABLE pokemon (
  id INTEGER,
  name TEXT,
  base_experience INTEGER,
  height INTEGER,
  weight INTEGER,
  types TEXT,
  abilities TEXT,
  moves TEXT,
  stats TEXT
);
```
## Checking Rows for NULL values in the dataset
```sql
SELECT *
FROM pokemon
WHERE name is NULL
	OR base_experience IS NULL
	OR height IS NULL
	OR weight IS NULL
	OR types IS NULL
	OR abilities IS NULL
	OR moves IS NULL
	OR stats IS NULL;
```
Result:
 Found 34 rows where the moves column is NULL. All other rows are complete and free of NULL values.
This could indicate that some of the moves were unknown or not assigned, will replace with unknown.

## Replacing NULL values with Unknown

```sql
UPDATE pokemon
SET moves = 'Unknown'
WHERE moves IS NULL;
``` 

## Verifying that we are not dealing with any duplicates

```sql
SELECT name, COUNT(*) AS count
FROM pokemon
GROUP BY name
HAVING count(*) > 1;
```

Result:
There are no duplicates in the dataset - each Pokémon appears only once by name.

## Calculate the Average Weight and Height of Pokémon with conversions from decimeters to feet and hectograms to pounds

```sql
SELECT
	AVG(height) * 0.1 AS avg_height_meters,
	AVG(height) * 0.1 * 3.28084 AS avg_height_feet,
	AVG(weight) * 0.1 AS avg_weight_kg,
	AVG(weight) * 0.1 * 2.20462 AS avg_weight_pounds
FROM pokemon;
```

Results:
avg_height_meters = 2.05 meters
avg_height_feet = 6.72 feet
avg_weight_kg = 98.08 kg
avg_weight_pounds = 216.24 lbs

The average Pokémon weighs 216 pounds and is roughly 6.7 feet tall!

## How many Pokémon are over 10 feet tall and weigh more than 1000lbs
```sql

SELECT
	name,
	height,
	height * 0.1 * 3.28084 AS height_in_feet,
	weight,
	weight * 0.1 * 2.20462 AS weight_in_pounds,
	types
	
FROM pokemon

WHERE height > 30 AND weight > 4536;
```

Results: There are 52 Pokémon that are over 10 feet and weigh more than 1000 pounds.
| Name            | Height (m) | Height (ft) | Weight (kg) | Weight (lbs) | Types          |
|-----------------|------------|-------------|-------------|--------------|----------------|
| groudon         | 35         | 11.48       | 9500        | 2094.39      | ground         |
| dialga          | 54         | 17.72       | 6830        | 1505.76      | steel, dragon  |
| giratina-altered| 45         | 14.76       | 7500        | 1653.47      | ghost, dragon  |
| celesteela      | 92         | 30.18       | 9999        | 2204.40      | steel, flying  |
| guzzlord        | 55         | 18.04       | 8880        | 1957.70      | dark, dragon   |

## Who is the biggest Pokémon?

```sql

SELECT
  name,
  height,
  height * 0.1 * 3.28084 AS height_in_feet,
  weight,
  weight * 0.1 * 2.20462 AS weight_in_pounds,
  (height * 0.1 * 3.28084) * (weight * 0.1 * 2.20462) AS size_score,
  types
FROM pokemon
ORDER BY size_score DESC
LIMIT 1;
```

Result: The biggest Pokémon by height and weight is Centiskorch-gmax at 246 feet tall and 2204 pounds.


## What Pokémon have a name that starts with the letter Z?

```sql
SELECT name,
types
FROM pokemon
WHERE name LIKE 'z%'
ORDER BY name;
```

Result: There are 25 Pokémon whose name start with the letter "Z". Below is a snippet from the query result:

| Name             | Types         |
|------------------|---------------|
| Zacian           | fairy         |
| Zacian-Crowned   | fairy, steel  |
| Zamazenta        | fighting      |
| Zamazenta-Crowned| fighting, steel|
| Zangoose         | normal        |


## Which Pokémon are of the Dragon type?

```sql
SELECT name, types
FROM pokemon
WHERE types LIKE '%dragon%'
ORDER BY name;
```
Result: There are 107 Pokémon that are Dragon-type or part Dragon-type. Below is a snippet from the query result:

| Name          | Types          |
|---------------|----------------|
| Altaria       | dragon, flying |
| Altaria-Mega  | dragon, fairy  |
| Ampharos-Mega | electric, dragon|
| Appletun      | grass, dragon  |
| Appletun-Gmax | grass, dragon  |


## Count Pokémon by Rock type:

```sql
SELECT COUNT(*) AS rock_type_count
FROM pokemon
WHERE types LIKE '%rock%';
```

Result: There are 102 Pokémon that include the Rock type.


## Creating a View for Rock-Type Pokémon

```sql
CREATE VIEW rock_pokemon AS
SELECT name, types
FROM pokemon
WHERE types LIKE '%rock%';
```

Now I can quickly retrieve Rock-type Pokémon by running:
```sql
SELECT * FROM rock_pokemon;
```

This makes it much easier if I would like to quickly view rock type Pokémon multiple times.

## Demonstrating a Self Join: Matching Pokémon by Base Experience

```sql
SELECT
  p1.name AS pokemon1,
  p2.name AS pokemon2,
  p1.base_experience
FROM
  pokemon p1
JOIN
  pokemon p2 ON p1.base_experience = p2.base_experience
               AND p1.name <> p2.name
ORDER BY
  p1.base_experience DESC, p1.name, p2.name
LIMIT 20;
```

Results: This allows us to see the Pokémon that have the same base experience and use join within the same table.

| Pokémon 1         | Pokémon 2         | Base Experience |
|-------------------|-------------------|-----------------|
| zacian-crowned    | zamazenta-crowned | 360             |
| mewtwo-mega-x     | mewtwo-mega-y     | 351             |
| mewtwo-mega-x     | rayquaza-mega     | 351             |
| mewtwo-mega-y     | rayquaza-mega     | 351             |


## Identifying "Glass Cannon" Pokémon
One interesting insight I extracted was identifying “glass cannon” Pokémon — those with high attack power but low HP, meaning they can deal strong damage but are fragile.

Challenge: Parsing Stats Stored as Strings
The Pokémon stats are stored in a single string column in the format:
hp=45, attack=49, defense=49, special-attack=65, special-defense=65, speed=45

Since the stats are embedded as key-value pairs in a string rather than separate columns, I used SQLite string functions (instr and substr) to extract individual stats directly within SQL. This avoids the need for preprocessing the data outside the database.

```sql
SELECT
  name,
  -- Extract hp
  CAST(
    substr(
      stats,
      instr(stats, 'hp=') + 3,
      instr(stats, ',') - (instr(stats, 'hp=') + 3)
    ) AS INTEGER
  ) AS hp,

  -- Extract attack
  CAST(
    substr(
      stats,
      instr(stats, 'attack=') + 7,
      instr(substr(stats, instr(stats, 'attack=')), ',') - 1
    ) AS INTEGER
  ) AS attack,

  -- Calculate ratio (attack/hp)
  ROUND(
    CAST(
      substr(
        stats,
        instr(stats, 'attack=') + 7,
        instr(substr(stats, instr(stats, 'attack=')), ',') - 1
      ) AS FLOAT
    ) /
    CAST(
      substr(
        stats,
        instr(stats, 'hp=') + 3,
        instr(stats, ',') - (instr(stats, 'hp=') + 3)
      ) AS FLOAT
    ),
    2
  ) AS attack_to_hp_ratio

FROM pokemon
WHERE hp > 0 -- avoid division by zero
ORDER BY attack_to_hp_ratio DESC
LIMIT 10;
```

Result: shedinja was the #1 "glass-cannon" Pokémon with 1 hp to 90 attack.
| Name          | HP | Attack | Attack_to_HP_Ratio |
|---------------|----|--------|--------------------|
| shedinja      | 1  | 90     | 90.00              |
| diglett       | 10 | 55     | 5.50               |
| wiglett       | 10 | 55     | 5.50               |
| diglett-alola | 10 | 55     | 5.50               |

| deoxys-attack | 50 | 180    | 3.60               |
