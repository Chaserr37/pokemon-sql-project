CREATE VIEW rock_pokemon AS
SELECT name, types
FROM pokemon
WHERE types LIKE '%rock%';

-- Query to use the view
SELECT * FROM rock_pokemon;