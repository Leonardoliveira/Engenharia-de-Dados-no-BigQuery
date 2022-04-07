  -- CRIANDO A VIEW MATERIALIZADA
CREATE MATERIALIZED VIEW
  `projeto-final-bq-ds-345222.BitbyteDW.VW_Faturamento_Curso_Materalizada` AS
-- A partir do "as", deve se colocar a consulta da view
SELECT
  nome_do_curso AS Curso,
  semestre_do_curso AS Semestre,
  ano_do_curso AS Ano,
  SUM(preco_do_curso) AS Faturamento
FROM
  `projeto-final-bq-ds-345222.BitbyteDW.bitbyte_DW`
GROUP BY
  nome_do_curso,
  semestre_do_curso,
  ano_do_curso;