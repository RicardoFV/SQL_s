create view v_pedidos_realizados as
select 
cli.nome as nome_cliente,
ped.id as id_pedido, ped.numero_pedido, ped.status, ped.dt_criacao as data_criacao_pedido,
prod.nome as nome_produto,
itens.quantidade, itens.valor 
from 
pedidos as ped inner join pedido_itens as itens
on itens.id_pedido = ped.id
inner join produtos as prod 
on itens.id_produto = prod.id 
inner join clientes as cli
on ped.cliente_id = cli.id;