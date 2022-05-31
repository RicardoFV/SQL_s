-- trigger atualiza pedido
-- trigger deve ativar antes da atualização de um pedido e de pedido item
-- deve verificar se tem o produto

DELIMITER //
CREATE TRIGGER trig_subtrair_estoque_ao_atualizar BEFORE UPDATE 
ON pedido_itens
FOR EACH ROW
BEGIN

	-- consulta se tem produto inormado
	if(SELECT COUNT(*) FROM produtos AS prod WHERE prod.id =old.id_produto) = 0 then 
		signal sqlstate '45000' set message_text = 'Esse produto não existe !';
		
		ELSE 
	
		-- realiza a atualizaçao de estoque
		UPDATE produtos AS prod SET prod.quantidade = (prod.quantidade - NEW.quantidade )  WHERE  prod.id = old.id_produto;
					  				
	END if;
	
END; 