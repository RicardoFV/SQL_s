select FLOOR(RAND() * 999);

call proc_montar_pedido(
21, -- id_pedido
1, -- id_cliente
1, -- id_produto 
1 -- quantidade
);
 
SELECT * FROM pedidos;

SELECT * FROM produtos;

SELECT * FROM clientes;

SELECT * FROM pedido_itens;

SELECT (preco * 3) FROM produtos WHERE id = 1;