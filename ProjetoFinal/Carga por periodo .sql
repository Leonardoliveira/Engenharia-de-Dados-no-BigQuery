-- CONSULTA QUE DEVE SER EXECUTADA PARA ALIMENTAR O DW. ATUALIZA NO MYSQL E DEPOIS ATUALIZA ESSA CONSULTA
-- ESSA CONSULTA ESTÁ AUTOMATICA

-- CRIAR A TABELA DE PARAMETROS NO BIGQUERY E COPIAR SEU VALOR DO MYSQL

DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.parametro`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.parametro`(periodo STRING);
INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.parametro` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso;");

-- CARGAS DAS AREAS DE STAGE

-- TABELA CURSO
-- DELETANDO DADOS
DELETE
FROM
  `projeto-final-bq-ds-345222.BitbyteDW.curso`
WHERE
  periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`);

-- INSERINDO DADOS

INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.curso` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT * FROM Bitbyte.curso where periodo_id = (SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso);");

-- TABELA EXERCICIO
DELETE
FROM
  `projeto-final-bq-ds-345222.BitbyteDW.exercicio`
WHERE
  periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`);

-- INSERINDO DADOS

INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.exercicio` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT * FROM Bitbyte.exercicio where periodo_id = (SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso);");

-- TABELA MATRICULA
DELETE
FROM
  `projeto-final-bq-ds-345222.BitbyteDW.matricula`
WHERE
  periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`);

-- INSERINDO DADOS

INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.matricula` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT * FROM Bitbyte.matricula where periodo_id = (SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso);");

-- TABELA NOTA
DELETE
FROM
  `projeto-final-bq-ds-345222.BitbyteDW.nota`
WHERE
  periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`);

-- INSERINDO DADOS

INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.nota` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT * FROM Bitbyte.nota where periodo_id = (SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso);");

-- TABELA RESPOSTA
DELETE
FROM
  `projeto-final-bq-ds-345222.BitbyteDW.resposta`
WHERE
  periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`);

-- INSERINDO DADOS

INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.resposta` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT * FROM Bitbyte.resposta where periodo_id = (SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso);");

-- TABELA SECAO
DELETE
FROM
  `projeto-final-bq-ds-345222.BitbyteDW.secao`
WHERE
  periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`);

-- INSERINDO DADOS

INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.secao` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT * FROM Bitbyte.secao where periodo_id = (SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso);");

DELETE FROM `projeto-final-bq-ds-345222.BitbyteDW.aluno` aluno
WHERE aluno.id IN(SELECT DISTINCT aluno.id FROM `projeto-final-bq-ds-345222.BitbyteDW.matricula` WHERE periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`));

INSERT INTO `projeto-final-bq-ds-345222.BitbyteDW.aluno` 
SELECT * FROM EXTERNAL_QUERY("projects/projeto-final-bq-ds-345222/locations/southamerica-east1/connections/Banco_Bitbyte", 
"SELECT DISTINCT A.* FROM aluno A, matricula M WHERE A.id = M.aluno_id AND periodo_id = (SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso);");

-- CARGA DO DW

DELETE FROM `projeto-final-bq-ds-345222.BitbyteDW.bitbyte_DW` WHERE perido_do_curso = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`);
INSERT INTO  `projeto-final-bq-ds-345222.BitbyteDW.bitbyte_DW`
SELECT
    A.nome AS nome_aluno,
    C.nome AS nome_do_curso,
    M.tipo AS tipo_de_pagamento,
    C.periodo_id AS perido_do_curso,
    C.semestre AS semestre_do_curso,
    C.ano AS ano_do_curso,
    MAX(C.preco) AS preco_do_curso,
    Count(Distinct M.id) AS matricula,
    ROUND((SUM(N.nota)/SUM(1))*10) AS nota_final,

FROM --FAZENDO INNER JOINS
    `projeto-final-bq-ds-345222.BitbyteDW.aluno` A,
    `projeto-final-bq-ds-345222.BitbyteDW.resposta` R,
    `projeto-final-bq-ds-345222.BitbyteDW.nota` N,
    `projeto-final-bq-ds-345222.BitbyteDW.exercicio` E,
    `projeto-final-bq-ds-345222.BitbyteDW.secao` S,
    `projeto-final-bq-ds-345222.BitbyteDW.curso` C,
    `projeto-final-bq-ds-345222.BitbyteDW.matricula` M
WHERE
    A.id = R.aluno_id       AND 
    R.id = N.resposta_id    AND 
    E.id = R.exercicio_id   AND
    S.id = E.secao_id       AND
    C.id = S.curso_id       AND
    C.id = M.curso_id       AND
    A.id = M.aluno_id       AND
  --FILTRANDO O PERIODO
    R.periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`) AND
    N.periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`) AND
    E.periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`) AND
    S.periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`) AND 
    C.periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`) AND
    M.periodo_id = (SELECT periodo FROM `projeto-final-bq-ds-345222.BitbyteDW.parametro`)
  GROUP BY 
    A.nome,
    C.nome ,
    M.tipo ,
    C.periodo_id ,
    C.semestre ,
    C.ano ;
  
  