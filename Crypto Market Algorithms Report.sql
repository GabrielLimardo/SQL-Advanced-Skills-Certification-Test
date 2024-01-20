SELECT DISTINCT
  c.algorithm,
  q1.jumlah AS q1_jumlah,
  q2.jumlah AS q2_jumlah,
  q3.jumlah AS q3_jumlah,
  q4.jumlah AS q4_jumlah
FROM coins c
JOIN (
  SELECT SUM(volume) AS jumlah, coins.algorithm
  FROM transactions
  LEFT JOIN coins ON transactions.coin_code = coins.code
  WHERE MONTH(dt) BETWEEN '01' AND '03' AND YEAR(dt) = 2020
  GROUP BY coins.algorithm
) q1 ON c.algorithm = q1.algorithm

JOIN (
  SELECT SUM(volume) AS jumlah, coins.algorithm
  FROM transactions
  LEFT JOIN coins ON transactions.coin_code = coins.code
  WHERE MONTH(dt) BETWEEN '04' AND '06' AND YEAR(dt) = 2020
  GROUP BY coins.algorithm
) q2 ON c.algorithm = q2.algorithm

JOIN (
  SELECT SUM(volume) AS jumlah, coins.algorithm
  FROM transactions
  LEFT JOIN coins ON transactions.coin_code = coins.code
  WHERE MONTH(dt) BETWEEN '07' AND '09' AND YEAR(dt) = 2020
  GROUP BY coins.algorithm
) q3 ON c.algorithm = q3.algorithm

JOIN (
  SELECT SUM(volume) AS jumlah, coins.algorithm
  FROM transactions
  LEFT JOIN coins ON transactions.coin_code = coins.code
  WHERE MONTH(dt) BETWEEN '10' AND '12' AND YEAR(dt) = 2020
  GROUP BY coins.algorithm
) q4 ON c.algorithm = q4.algorithm

ORDER BY c.algorithm ASC;