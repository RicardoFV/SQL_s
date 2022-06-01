create view v_quantidade_de_valor_por_produto as
-- consultando o quanto eu tenho em dinheiro por cada produto
select id, nome, (preco * quantidade) as total from produtos group by nome;