-- Self Join on base_experience
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
