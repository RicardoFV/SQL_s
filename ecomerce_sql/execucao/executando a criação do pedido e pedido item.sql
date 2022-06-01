-- EXECUTANDO A CRIAÇÃO DO PEDIDO E PEDIDO ITEM
 -- consulta o cliente
 SELECT * FROM clientes;
 -- consulta o produto
SELECT * FROM produtos;
-- consulta o pedido
SELECT * FROM pedidos;
-- consulta o pedido item
SELECT * FROM pedido_itens;

call proc_montar_pedido(
0, -- id_pedido
5, -- id_cliente
1, -- id_produto 
2 -- quantidade
);

call proc_montar_pedido(
0, -- id_pedido
5, -- id_cliente
2, -- id_produto 
1 -- quantidade
);

call proc_montar_pedido(
0, -- id_pedido
6, -- id_cliente
5, -- id_produto 
1 -- quantidade
);
 
 call proc_montar_pedido(
0, -- id_pedido
6, -- id_cliente
6, -- id_produto 
1 -- quantidade
);

 call proc_montar_pedido(
0, -- id_pedido
6, -- id_cliente
1, -- id_produto 
1 -- quantidade
);

 call proc_montar_pedido(
0, -- id_pedido
6, -- id_cliente
4, -- id_produto 
1 -- quantidade
);

call proc_montar_pedido(
0, -- id_pedido
1, -- id_cliente
3, -- id_produto 
2 -- quantidade
);

