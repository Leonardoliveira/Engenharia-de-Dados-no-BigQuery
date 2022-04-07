-- CRIANDO TABELA DE PAREMETRO

DROP TABLE parametro;
CREATE TABLE parametro
(periodo VARCHAR(10));
-- PERIODO DE CARGA
INSERT INTO parametro VALUES ('2017.2');
SELECT * FROM parametro;

-- 2014.1, 2014.2, 2015.1, 2015.2, 2016.1, 2016.2, 2017.1, 2017.2, 2018.1, 2018.2,  2019.1, 2019.2 
SELECT * FROM Bitbyte.curso;
SELECT distinct periodo_id FROM Bitbyte.curso;
-- RODAR A PROCEDURE
SET SQL_SAFE_UPDATES = 0;
CALL INCLUIR_EXCLUIR_SEMESTRE('2017.2');

SELECT MAX(periodo_id) AS PERIODO FROM Bitbyte.curso;

-- alimentando com o próximo semestre

CALL INCLUIR_EXCLUIR_SEMESTRE('2018.1');

CALL INCLUIR_EXCLUIR_SEMESTRE('2018.2');

CALL INCLUIR_EXCLUIR_SEMESTRE('2019.1');

CALL INCLUIR_EXCLUIR_SEMESTRE('2019.2');

