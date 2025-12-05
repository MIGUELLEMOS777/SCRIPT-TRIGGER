
CREATE OR REPLACE VIEW vw_detalhes_venda AS
SELECT
    p.nome_produto AS nome_produto,
    v.quantidade AS quantidade_vendida,
    v.valor_compra AS valor_total_venda
FROM vendas v
JOIN produtos p ON p.cod_produto = v.cod_produto;

SELECT * FROM vw_detalhes_venda LIMIT 10;




SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;


SELECT 
    table_name,
    string_agg(column_name, ', ') AS colunas
FROM information_schema.columns 
WHERE table_schema = 'public'
GROUP BY table_name
ORDER BY table_name;


SELECT 
    table_name,
    column_name,
    data_type
FROM information_schema.columns 
WHERE table_schema = 'public'
AND (column_name LIKE '%cid%' 
     OR column_name LIKE '%municipio%'
     OR column_name LIKE '%local%'
     OR column_name LIKE '%endereco%')
ORDER BY table_name, column_name;



CREATE TABLE IF NOT EXISTS cidades (
    cod_cidade SERIAL PRIMARY KEY,
    nome_cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2)
);


ALTER TABLE vendas ADD COLUMN IF NOT EXISTS cod_cidade INT;


ALTER TABLE vendas 
ADD CONSTRAINT fk_vendas_cidades 
FOREIGN KEY (cod_cidade) REFERENCES cidades(cod_cidade);

SELECT 
    table_name,
    column_name,
    data_type
FROM information_schema.columns 
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY table_name;


CREATE OR REPLACE VIEW vw_cidade_mais_vendas_2023 AS
SELECT 
    u.cidade AS cidade,
    COUNT(*)::integer AS quantidade_total_vendas,
    SUM(CAST(v.valor_compra AS DECIMAL(10,2))) AS valor_total_vendas
FROM vendas v
JOIN usuarios u ON u.cod_usuario = v.cod_usuario
WHERE DATE_PART('year', CAST(v.data_compra AS DATE)) = 2023
GROUP BY u.cidade
ORDER BY quantidade_total_vendas DESC
LIMIT 1;


SELECT 
    data_compra,
    CAST(data_compra AS DATE) AS data_convertida,
    EXTRACT(YEAR FROM CAST(data_compra AS DATE)) AS ano
FROM vendas 
LIMIT 3;



SELECT valor_compra, data_compra FROM vendas LIMIT 3;


SELECT 
    valor_compra,
    REPLACE(valor_compra, ',', '.') AS valor_convertido,
    data_compra,
    CAST(data_compra AS DATE) AS data_convertida
FROM vendas 
LIMIT 3;


SELECT 
    u.cidade AS cidade,
    COUNT(*) AS quantidade_total_vendas,
    SUM(CAST(REPLACE(v.valor_compra, ',', '.') AS DECIMAL(10,2))) AS valor_total_vendas
FROM vendas v
JOIN usuarios u ON u.cod_usuario = v.cod_usuario
WHERE EXTRACT(YEAR FROM CAST(v.data_compra AS DATE)) = 2023
GROUP BY u.cidade
ORDER BY quantidade_total_vendas DESC
LIMIT 3;


