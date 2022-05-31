-- procedure gerar pedido pedido 

DELIMITER //
CREATE PROCEDURE proc_montar_pedido(
IN id_pedido INT,
IN id_cliente INT,
IN id_produto INT,
IN quantidade_escolhida INT)

cadastrar:BEGIN -- inicio
		-- variaveis 
	DECLARE num_pedido VARCHAR(100); 
	DECLARE ultimo_id INT;
	DECLARE valor_produto DECIMAL(10,2);
-- configurando os parametros para devolutiva de enventuais erros
	DECLARE excecao smallint DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION set excecao = 1;

	
	-- inicia a transação 
	START TRANSACTION;
	
	-- inicia o processo de criaçao de pedido
	
	-- consulta o cliente 	
	if (SELECT COUNT(*) FROM clientes WHERE id = id_cliente) > 0 THEN
	
		-- consulta o produto
		if (SELECT COUNT(*) FROM produtos WHERE id = id_produto) > 0 then 
		
			-- cria o numero randomico do numero do pedido
			select FLOOR(RAND() * 999) INTO num_pedido;
			
			-- busca o valor do produto 
			SELECT prod.preco INTO valor_produto FROM produtos AS prod WHERE prod.id = id_produto;
			
			-- se id_pedido for igual a 0 significa que eu quero inserir um novo pedido
			if id_pedido = 0 then 
				
				-- monta o pedido
				INSERT INTO pedidos (numero_pedido, status , cliente_id, dt_criacao) 
				VALUES(num_pedido, 'pendente', id_cliente, NOW());
				
				if excecao = 1 then -- caso de erro no pedido
		
					SELECT  'Erro ao salvar Pedido' AS erro;
					leave cadastrar;
					ROLLBACK;
					
					ELSE 
					
						COMMIT; -- registra o pedido 
						
						-- inicia o cadastro do pedido item
			
						-- busca o ultino pedido
						SELECT MAX(id) INTO ultimo_id FROM pedidos AS ped WHERE ped.cliente_id = cliente_id;
						
						-- consulta se o produto ja foi ou não colcoado no pedido_itens
						if (SELECT COUNT(*) from pedido_itens AS itens WHERE itens.id_pedido =  ultimo_id AND itens.id_produto = id_produto) > 0 then 
							
							-- realiza o update
							UPDATE pedido_itens AS itens SET itens.quantidade = itens.quantidade + quantidade_escolhida , 
							itens.valor = (itens.quantidade * valor_produto), itens.dt_alteracao = NOW() 
							WHERE itens.id_pedido =  ultimo_id AND itens.id_produto = id_produto;
							
							if excecao = 1 then 
		
								SELECT  'Erro ao atualizar Pedido Item ' AS erro;
								leave cadastrar;
								ROLLBACK;
		
							ELSE
		
								SELECT  'Pedido Item Atualizado com Sucesso !' AS sucesso;
								COMMIT;
								
							END if; -- fim do cadastro do pedido item
							
							ELSE 
							
							-- insere um novo pedido item 
							INSERT INTO pedido_itens (id_pedido, id_produto, quantidade, valor, dt_criacao) 
							VALUES (ultimo_id, id_produto, quantidade_escolhida, (quantidade_escolhida * valor_produto), NOW());
							
								if excecao = 1 then 
		
									SELECT  'Erro ao cadastrar Pedido Item ' AS erro;
									leave cadastrar;
									ROLLBACK;
		
								ELSE
		
									SELECT  'Pedido Item Cadastrado com Sucesso !' AS sucesso;
									COMMIT;
								
								END if;
							
							
						END if; -- fim do if se o pedido foi ou nao cadastrada
												
				END if; -- fim do erro da inserçao do pedido
			
			END if; -- fim de verificaçao do pedido igual a 0
			
			-- se id_pedido for maior que 0 significa que o pedido deve ser alterado
			if id_pedido > 0 then 
					
					-- consulto a o pedido existente 
					if (SELECT COUNT(*) FROM pedidos AS ped WHERE ped.id = id_pedido) > 0 then
					
						-- realiza o update
							UPDATE pedido_itens AS itens SET itens.quantidade = itens.quantidade + quantidade_escolhida , 
							itens.valor = (itens.quantidade * valor_produto), itens.dt_alteracao = NOW() 
							WHERE itens.id_pedido =  id_pedido AND itens.id_produto = id_produto;
							
							if excecao = 1 then 
		
								SELECT  'Erro ao atualizar Pedido Item ' AS erro;
								leave cadastrar;
								ROLLBACK;
		
							ELSE
		
								SELECT  'Pedido Item Atualizado com Sucesso !' AS sucesso;
								COMMIT;
							END if;
					
						ELSE 
							SELECT  'Erro ao encontrar pedido' AS erro;
							leave cadastrar;
					
					END if; -- fim  consulta o pedido 
					
			END if; -- fim de verificaçao do pedido igual a 0
			
				
		END if; -- fim do if da consulta produto
	
	END if; -- fim do if consulta cliente
	
END; -- fim 