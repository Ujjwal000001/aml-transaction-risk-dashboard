{\rtf1\ansi\ansicpg1252\cocoartf2870
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 .AppleSystemUIFontMonospaced-Regular;}
{\colortbl;\red255\green255\blue255;\red104\green102\blue97;\red11\green11\blue11;\red255\green255\blue255;
}
{\*\expandedcolortbl;;\cssrgb\c48235\c47451\c45490;\cssrgb\c4314\c4314\c4314;\cssrgb\c100000\c100000\c100000;
}
\margl1440\margr1440\vieww18780\viewh11500\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 \
\cf3 \cb4 \strokec3 -- QUERY 1\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- Finding: Fraud rate and dollar exposure by transaction type\cb1 \
\cf2 \strokec2 \
\
\cf3 \cb4 \strokec3 SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     type,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(total_transactio) AS total_transactions,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(fraud_count) AS total_fraud_cases,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         100.0 * SUM(fraud_count)\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3               / SUM(total_transactio), 3\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS fraud_rate_pct,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(SUM(total_amount) / 1000000.0, 2)\cb1  \
	 \cb4 AS total_volume_millions,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         SUM(CASE WHEN fraud_count > 0\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                  THEN fraud_count * avg_amount\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                  ELSE 0 END) / 1000000.0, 2\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS fraud_exposure_millions\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 FROM fraud_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 GROUP BY type\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ORDER BY fraud_rate_pct DESC;\cb1 \
\cf2 \strokec2 \
\cf3 \strokec3 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- QUERY 2\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- Finding: Cumulative fraud growth over time\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 \'a0\cf2 \cb1 \strokec2 \
\cf3 \cb4 \strokec3 SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     step AS hour,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(fraud_count) AS hourly_fraud_cases,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(total_transactio) AS hourly_total_txns,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         100.0 * SUM(fraud_count)\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3               / SUM(total_transactio), 4\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS hourly_fraud_rate_pct,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(SUM(fraud_count))\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         OVER (ORDER BY step) AS cumulative_fraud_total,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(SUM(total_transactio))\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         OVER (ORDER BY step) AS cumulative_txn_total\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 FROM fraud_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 GROUP BY step\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ORDER BY step\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 LIMIT 30;\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 \'a0\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- QUERY 3\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- Finding: 12-hour rolling average of fraud (advanced window)\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     step AS hour,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(fraud_count) AS hourly_fraud,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         AVG(SUM(fraud_count))\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             OVER (\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                 ORDER BY step\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                 ROWS BETWEEN 11 PRECEDING\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                          AND CURRENT ROW\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             ), 2\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS rolling_12hr_avg,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         AVG(SUM(fraud_count))\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             OVER (\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                 ORDER BY step\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                 ROWS BETWEEN 23 PRECEDING\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                          AND CURRENT ROW\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             ), 2\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS rolling_24hr_avg\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 FROM fraud_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 GROUP BY step\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ORDER BY step\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 LIMIT 10;\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- QUERY 4\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- Finding: High-value fraud analysis using CTE\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 \'a0\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 WITH high_value_hours AS (\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         type,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         step,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         fraud_count,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         avg_amount,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         fraud_rate_pct\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     FROM fraud_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     WHERE fraud_rate_pct > 0\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3       AND avg_amount > 200000\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ),\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 type_summary AS (\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         type,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         COUNT(*) AS hours_with_hv_fraud,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         SUM(fraud_count) AS total_hv_fraud_cases,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         ROUND(AVG(avg_amount), 0) AS avg_hv_fraud_amount,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         ROUND(MAX(avg_amount), 0) AS max_single_hour_avg,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         ROUND(AVG(fraud_rate_pct), 4) AS avg_fraud_rate_pct\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     FROM high_value_hours\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     GROUP BY type\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 )\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 SELECT *\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 FROM type_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ORDER BY avg_hv_fraud_amount DESC;\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- QUERY 5\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- Finding: Fraud exposure by amount bracket\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     CASE\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         WHEN avg_amount < 10000\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             THEN '1. Under $10K'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         WHEN avg_amount >= 10000\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3          AND avg_amount < 100000\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             THEN '2. $10K to $100K'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         WHEN avg_amount >= 100000\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3          AND avg_amount < 500000\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             THEN '3. $100K to $500K'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         WHEN avg_amount >= 500000\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3          AND avg_amount < 999999\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             THEN '4. $500K to $999K'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         ELSE\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             '5. $1M \'97 Limit exploitation'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     END                                         AS amount_bracket,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     COUNT(*)                                    AS transaction_groups,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(fraud_count)                            AS total_fraud_cases,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(AVG(fraud_rate_pct), 3)               AS avg_fraud_rate_pct,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(SUM(total_amount) / 1000000.0, 2)     AS total_exposure_millions\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 FROM fraud_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 WHERE fraud_count > 0\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 GROUP BY amount_bracket\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ORDER BY amount_bracket;\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- QUERY 6\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- Finding: Peak fraud hours \'97 which hours have highest fraud rate\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     step AS hour,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     type,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(fraud_count) AS fraud_cases,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(total_transactio) AS total_transactions,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         100.0 * SUM(fraud_count)\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3               / SUM(total_transactio), 4\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS fraud_rate_pct,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         SUM(fraud_count) * AVG(avg_amount) / 1000000.0, 3\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS estimated_exposure_M\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 FROM fraud_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 WHERE fraud_count > 0\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 GROUP BY step, type\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 HAVING SUM(fraud_count) >= 5\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ORDER BY fraud_cases DESC\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 LIMIT 10;\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- QUERY 7\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 -- Finding: Summary risk scorecard \'97 executive view\cb1 \
\
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 SELECT\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     type,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(total_transactio) AS total_transactions,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     SUM(fraud_count) AS fraud_cases,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         100.0 * SUM(fraud_count)\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3               / SUM(total_transactio), 3\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS fraud_rate_pct,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         SUM(fraud_count) * AVG(avg_amount) / 1000000.0, 2\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ) AS estimated_fraud_exposure_M,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(AVG(avg_amount) / 1000.0, 1) AS avg_txn_amount_K,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     ROUND(MAX(max_amount) / 1000.0, 1) AS max_single_txn_K,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     COUNT(DISTINCT step) AS hours_with_fraud,\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     CASE\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         WHEN ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                  100.0 * SUM(fraud_count)\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                        / SUM(total_transactio), 3\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3              ) >= 0.5\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             THEN 'CRITICAL \'97 Immediate action'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         WHEN ROUND(\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                  100.0 * SUM(fraud_count)\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3                        / SUM(total_transactio), 3\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3              ) > 0\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             THEN 'HIGH \'97 Enhanced monitoring'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3         ELSE\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3             'SAFE \'97 Standard monitoring'\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3     END  AS risk_classification\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 FROM fraud_summary\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 GROUP BY type\cb1 \
\cf2 \strokec2 \
\cf3 \cb4 \strokec3 ORDER BY fraud_rate_pct DESC;\cb1 \
}