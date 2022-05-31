-- EXECUTANDO A CRIAÇAO DE PRODUTO

-- cadastrando o produtuo
CALL proc_cadastrar_produtos(
0, 
'produto teste', 
'esse e um produto teste',
20.58,
10
)

-- REALIZANDO A CONSULTA 

SELECT * FROM produtos;

-- MODIIFCNAOD O PRODUTO 
-- CASO QUEIRA MODIFICAR, BASTA NO LUGAR DO 0 COLOCAR O ID DO PRODUTO E PREENCHER AS INFORMAÇÕES DELE

CALL proc_cadastrar_produtos(
2, 
'teclado com fio', 
'teclado com fio da microsoft',
39.99,
25
)