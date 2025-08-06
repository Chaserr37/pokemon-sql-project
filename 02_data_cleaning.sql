-- Check for NULL values
SELECT *
FROM pokemon
WHERE name IS NULL
  OR base_experience IS NULL
  OR height IS NULL
  OR weight IS NULL
  OR types IS NULL
  OR abilities IS NULL
  OR moves IS NULL
  OR stats IS NULL;

-- Replace NULL moves with 'Unknown'
UPDATE pokemon
SET moves = 'Unknown'
WHERE moves IS NULL;

-- Check for duplicates by name
SELECT name, COUNT(*) AS count
FROM pokemon
GROUP BY name
HAVING count(*) > 1;