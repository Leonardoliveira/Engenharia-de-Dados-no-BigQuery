  --CRIANDO AS TABELAS -- TABELA ALUNO
DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.aluno`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.aluno` 
  ( id INT64,
    nome STRING,
    email STRING,
    ); 
    
--TABELA CURSO
DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.curso`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.curso`
    ( id INT64,
    nome STRING,
    semestre STRING,
    ano STRING,
    periodo_id STRING,
    preco FLOAT64
    );

-- TABELA EXERCICIO
DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.exercicio`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.exercicio` (
  id INT64,
  secao_id INT64,
  pergunta STRING,
  resposta_oficial STRING,
  periodo_id STRING
);

-- TABELA MATRICULA
DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.matricula`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.matricula` (
  id INT64,
  aluno_id INT64,
  curso_id INT64,
  data DATETIME,
  tipo STRING,
  periodo_id STRING
) ;

--TABELA NOTA

DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.nota`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.nota` (
  id INT64,
  resposta_id INT64,
  nota FLOAT64,
  periodo_id STRING
) ;

-- TABELA RESPOSTA
DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.resposta`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.resposta` (
  id INT64,
  exercicio_id INT64,
  aluno_id INT64,
  resposta_dada STRING,
  periodo_id STRING
);


--TABELA SECAO
DROP TABLE IF EXISTS `projeto-final-bq-ds-345222.BitbyteDW.secao`;
CREATE TABLE `projeto-final-bq-ds-345222.BitbyteDW.secao` (
  id INT64,
  curso_id INT64,
  titulo STRING,
  explicacao STRING,
  numero INT64,
  periodo_id STRING
) ;
