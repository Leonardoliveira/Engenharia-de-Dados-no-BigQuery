WITH items AS
 (SELECT 'FOO' AS ITEM
 UNION ALL SELECT 'BAR'
 UNION ALL SELECT 'BAZ')
 SELECT LOWER(ITEM) FROM items;

WITH items AS
 (SELECT 'foo' AS ITEM
 UNION ALL SELECT 'bar'
 UNION ALL SELECT 'baz')
 SELECT UPPER(ITEM) FROM items;

WITH items AS
 (SELECT 'rUA Antonio Carlos' AS ITEM
 UNION ALL SELECT 'AVENIDA sÃO pAULO'
 UNION ALL SELECT 'tv atroS DO aLTO')
 SELECT ITEM, UPPER(ITEM), LOWER(ITEM) FROM items;

WITH examples AS
 (SELECT "Alo Mundo-todo mundo!" AS FRASES
 UNION ALL SELECT "o cachorro TORNADO é alegre+manso"
 UNION ALL SELECT "maça&laranja&pera"
 UNION ALL SELECT "tata ta tavendo a tatia")
 SELECT FRASES, INITCAP(FRASES) FROM examples;

WITH examples AS
 (SELECT "Alo Mundo-todo mundo!" AS FRASES, " " AS DELIMITER
 UNION ALL SELECT "o cachorro TORNADO é alegre+manso", "+"
 UNION ALL SELECT "maça&laranja&pera", "&"
 UNION ALL SELECT "tata ta tavendo a tatia", "t")
 SELECT FRASES, INITCAP(FRASES), INITCAP(FRASES, DELIMITER) FROM examples;

WITH items AS
 (SELECT "     MAÇA     " AS ITEM
 UNION ALL SELECT "     BANANA     "
 UNION ALL SELECT "     LARANJA     ")
 SELECT ITEM, LTRIM(ITEM), RTRIM(ITEM), TRIM(ITEM) FROM items;

WITH items AS
 (SELECT "     MAÇA     " AS ITEM
 UNION ALL SELECT "     BANANA     "
 UNION ALL SELECT "     LARANJA     ")
 SELECT TRIM(ITEM), LEFT(TRIM(ITEM), 2), RIGHT(TRIM(ITEM),2) FROM items;

WITH examples AS
(SELECT "DR" AS Titulo, "Carlos" as NOME, "Junior" as SOBRENOME
UNION ALL SELECT "SR", "Marcos", "Almeida"
UNION ALL SELECT "DR" , "Mario", "Costa"
UNION ALL SELECT "MS" , "Maria", "Rosa")
SELECT CONCAT (Titulo, " ", Nome, " ", Sobrenome) FROM examples;

WITH examples AS
(SELECT "DR" AS Titulo, "Carlos" as NOME, "Junior" as SOBRENOME
UNION ALL SELECT "SR", "Marcos", "Almeida"
UNION ALL SELECT "DR" , "Mario", "Costa"
UNION ALL SELECT "MS" , "Maria", "Rosa")
SELECT CONCAT (Titulo, " ", Nome, " ", Sobrenome), 
CHAR_LENGTH(CONCAT (Titulo, " ", Nome, " ", Sobrenome)) FROM examples;

WITH examples AS
(SELECT "DR" AS Titulo, "Carlos" as NOME, "Junior" as SOBRENOME
UNION ALL SELECT "SR", "Marcos", "Almeida"
UNION ALL SELECT "DR" , "Mario", "Costa"
UNION ALL SELECT "MS" , "Maria", "Rosa")
SELECT CONCAT (Titulo, " ", Nome, " ", Sobrenome), 
CHAR_LENGTH(CONCAT (Titulo, " ", Nome, " ", Sobrenome)),
STARTS_WITH(CONCAT (Titulo, " ", Nome, " ", Sobrenome), "DR"), 
ENDS_WITH(CONCAT (Titulo, " ", Nome, " ", Sobrenome), "Dr") FROM examples;

WITH example AS
(SELECT 'banana' AS source_value, 'an' AS search_value, 1 as position, 1 as occcurrence
UNION ALL SELECT 'banana' AS source_value, 'an' AS search_value, 3 as position, 1 as occcurrence
UNION ALL SELECT 'banana' AS source_value, 'xx' AS search_value, 1 as position, 2 as occcurrence)
SELECT *, INSTR(source_value, search_value, position, occcurrence) FROM example;

WITH example AS
(SELECT 'banana' AS source_value,
UNION ALL SELECT 'melancia'
UNION ALL SELECT 'tangerina')
SELECT source_value, SUBSTR(source_value,3,3) FROM example;

WITH example AS
(SELECT 'banana' AS source_value,
UNION ALL SELECT 'melancia'
UNION ALL SELECT 'tangerina')
SELECT source_value, SUBSTR(source_value,3) FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, STRPOS(source_value, "@") FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, SUBSTR(source_value,1, STRPOS(source_value, "@") - 1) FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, REVERSE(source_value) FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, REPLACE(source_value, "@","XXXXXX") FROM example;

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, SPLIT(source_value, "@") FROM example;

SELECT FIELD,
REGEXP_CONTAINS(FIELD, r'[0-9]{5}-[0-9]{3}') AS TEM_CEP,
REGEXP_EXTRACT(FIELD, r'[0-9]{5}-[0-9]{3}', 1, 1) AS CEP,
REGEXP_EXTRACT(FIELD, r'[0-9]{5}-[0-9]{3}', 1, 2) AS CEP2,
REGEXP_EXTRACT_ALL(FIELD, r'[0-9]{5}-[0-9]{3}') AS CEP3,
REGEXP_REPLACE(FIELD, r'[0-9]{5}-[0-9]{3}', 'XXXXX-XXX') AS CEP2,
FROM
(SELECT * from UNNEST
(["22222-22","     22222-222  ","Meu CEP é 222222-22", "Do CEP 22222-222 ATÉ O 22333-222"]) AS FIELD);




