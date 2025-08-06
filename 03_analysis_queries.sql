-- Average Weight and Height with unit conversions
SELECT
  AVG(height) * 0.1 AS avg_height_meters,
  AVG(height) * 0.1 * 3.28084 AS avg_height_feet,
  AVG(weight) * 0.1 AS avg_weight_kg,
  AVG(weight) * 0.1 * 2.20462 AS avg_weight_pounds
FROM pokemon;

-- Pokémon over 10 feet tall and weigh more than 1000 lbs
SELECT
  name,
  height,
  height * 0.1 * 3.28084 AS height_in_feet,
  weight,
  weight * 0.1 * 2.20462 AS weight_in_pounds,
  types
FROM pokemon
WHERE height > 30 AND weight > 4536;

-- Biggest Pokémon by size score
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

-- Pokémon names starting with 'Z'
SELECT
  name,
  types
FROM pokemon
WHERE name LIKE 'z%'
ORDER BY name;

-- Dragon-type Pokémon
SELECT
  name,
  types
FROM pokemon
WHERE types LIKE '%dragon%'
ORDER BY name;

-- Count Rock-type Pokémon
SELECT COUNT(*) AS rock_type_count
FROM pokemon
WHERE types LIKE '%rock%';