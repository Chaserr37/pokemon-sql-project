-- Extract hp and attack from stats string, calculate attack/hp ratio
SELECT
  name,
  CAST(
    substr(
      stats,
      instr(stats, 'hp=') + 3,
      instr(stats, ',') - (instr(stats, 'hp=') + 3)
    ) AS INTEGER
  ) AS hp,

  CAST(
    substr(
      stats,
      instr(stats, 'attack=') + 7,
      instr(substr(stats, instr(stats, 'attack=')), ',') - 1
    ) AS INTEGER
  ) AS attack,

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
WHERE hp > 0
ORDER BY attack_to_hp_ratio DESC
LIMIT 10;
