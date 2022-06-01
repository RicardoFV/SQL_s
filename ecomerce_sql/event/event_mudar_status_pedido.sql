-- habilitando a funcao evento
set global event_scheduler = on;

-- criando  o evento para mudar o status do pedido de pendente para aprovado
DELIMITER //
create event event_mudar_status_pedido
on schedule
every  10 minute
starts now()	
do
begin

update pedidos set status = 'aprovado', dt_alteracao = now();
end;

-- ver o evento criado
show events from ecomerce_sql;