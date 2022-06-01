-- EXECUTANDO A CRIAÇÃO DO CLIENTE
-- CRIANDO O CENARIO

-- CRINAOD O CLIENTE
CALL proc_cadastrar_clientes(
0, -- 0 quando se quer cadastrar, maior que zero, quando deseja alterar
'Mariah Agatha da Paz',  -- nome
'mariah_dapaz@righettorosa.com.br', -- e-mail 
'856.490.022-07',  -- cpf
'(94)3507-8932' -- telefone
);

CALL proc_cadastrar_clientes(
0, 
'Lucca Levi Marcos Martins', 
'lucca_levi_martins@capua.com.br', 
'282.634.949-07', 
'(34) 3973-8140'
);

CALL proc_cadastrar_clientes(
0, 
'Sueli Ester Stefany Carvalho', 
'sueli_ester_carvalho@ppe.ufrj.br', 
'542.881.329-67', 
'(55) 3776-2078'
);

CALL proc_cadastrar_clientes(
0, 
'Laís Marli Pinto', 
'lais_marli_pinto@omnibrasil.com.br', 
'699.022.666-81', 
'(85) 3759-6077'
);

CALL proc_cadastrar_clientes(
0, 
'Renan Guilherme da Costa', 
'renanguilhermedacosta@vinax.com.br', 
'952.163.969-50', 
'(28) 2824-5624'
);

CALL proc_cadastrar_clientes(
0, 
'Clara Vera da Paz', 
'clara.vera.dapaz@nipbr.com', 
'306.878.006-33', 
'(63) 2870-2643'
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