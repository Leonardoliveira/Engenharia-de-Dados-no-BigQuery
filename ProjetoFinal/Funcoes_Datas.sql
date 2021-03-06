SELECT CURRENT_DATETIME,
CURRENT_TIMESTAMP,
CURRENT_DATE,
CURRENT_TIME;

SELECT CURRENT_DATETIME('America/Sao_Paulo'),
CURRENT_DATETIME('Europe/London'),
CURRENT_TIMESTAMP,
CURRENT_DATE,
CURRENT_TIME;

SELECT TIMESTAMP('2020-07-01 10:00:00'),
DATETIME (2020, 7, 1, 10, 0 , 0),
DATE(2020, 7, 1),
TIME(10,0,0);

SELECT DATE(TIMESTAMP('2020-07-01 10:00:00')),
DATETIME(TIMESTAMP('2020-07-01 10:00:00')),
TIME(TIMESTAMP('2020-07-01 10:00:00'));

SELECT 
  DATE_ADD (DATE(2008, 12, 25), INTERVAL 5 DAY) AS CINCO_DIAS_DEPOIS,
  DATE_ADD (DATE(2008, 12, 25), INTERVAL 4 YEAR) AS QUATRO_ANOS_DEPOIS,
  TIMESTAMP_ADD (CURRENT_TIMESTAMP, INTERVAL 45 MINUTE) AS QUARENTA_CINCO_MINUTOS_DEPOIS;

SELECT 
  DATE_SUB (DATE(2008, 12, 25), INTERVAL 5 DAY) AS CINCO_DIAS_ANTES,
  DATE_SUB (DATE(2008, 12, 25), INTERVAL 4 YEAR) AS QUATRO_ANOS_ANTES,
  TIMESTAMP_SUB (CURRENT_TIMESTAMP, INTERVAL 45 MINUTE) AS QUARENTA_CINCO_MINUTOS_ANTES;

SELECT 
  DATE_DIFF (DATE(2010,12,25), DATE(2008, 9, 15), DAY),
  DATETIME_DIFF (CURRENT_DATETIME, DATETIME(TIMESTAMP('2020-07-01 10:00:00')), MINUTE);

SELECT DATA,
  EXTRACT(MONTH FROM DATA) AS MES,
  EXTRACT(DAY FROM DATA) AS DIA,
  EXTRACT(YEAR FROM DATA) AS ANO,
  EXTRACT(DAYOFWEEK FROM DATA) AS SEMANA
FROM UNNEST (GENERATE_DATE_ARRAY('2015-12-23', '2016-01-09')) AS DATA
ORDER BY DATA;

SELECT 
  DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), DAY), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), MINUTE), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), MONTH), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), YEAR);

SELECT 
  DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), 
  LAST_DAY(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), MONTH),
  LAST_DAY(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), YEAR);

<FUNCAO> (<FORMATO>, VALOR)
SELECT CURRENT_DATETIME, FORMAT_DATETIME('%A, Dia %d de %B de %Y', CURRENT_DATETIME);

SELECT
  visitStartTime FROM
 `bigquery-public-data.google_analytics_sample.ga_sessions_20170731`
LIMIT 10;

SELECT
  visitStartTime, TIMESTAMP_SECONDS(visitStartTime) FROM
 `bigquery-public-data.google_analytics_sample.ga_sessions_20170731`
LIMIT 10;

SELECT CURRENT_TIMESTAMP, UNIX_SECONDS(CURRENT_TIMESTAMP);
