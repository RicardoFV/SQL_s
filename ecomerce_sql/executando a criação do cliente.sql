-- EXECUTANDO A CRIAÇÃO DO CLIENTE

-- CRINAOD O CLIENTE
CALL proc_cadastrar_clientes(
0, 
'Mariah Agatha da Paz', 
'mariah_dapaz@righettorosa.com.br', 
'85649002207', 
'(94)35078932'
);

-- CONSULTANDO OS CLIENTES

SELECT * FROM clientes;

-- MODIIFCNAOD O CLIENTE 
-- CASO QUEIRA MODIFICAR, BASTA NO LUGAR DO 0 COLOCAR O ID DO CLIENTE E PREENCHER AS INFORMAÇÕES DELE
/*
CALL proc_cadastrar_clientes(
0, 
'Mariah Agatha da Paz',  
'mariah_dapaz@righettorosa.com.br', 
'85649002207', 
'(94)35078932'
);
*/