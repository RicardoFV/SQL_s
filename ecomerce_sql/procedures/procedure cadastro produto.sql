-- crinado o produto 
DELIMITER //
CREATE PROCEDURE proc_cadastrar_produtos(IN id INT , 
													IN nome TEXT , 
													IN descricao TEXT , 
													IN preco DECIMAL(10,2) , 
													IN quantidade int)
													
cadastrar:BEGIN 

	-- configurando os parametros para devolutiva de enventuais erros
	DECLARE excecao smallint DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION set excecao = 1;
	
		-- inicia a transação 
	START TRANSACTION;
	-- caso o numero informado seja negativo
	if id < 0 then 
		SELECT  'O id tem pode ser 0 ou um ecomerce_sqlnumero positivo' AS erro;
		leave cadastrar;
	END if;
	
		-- caso seja 0 significa que sera feito um cadastro
	if id = 0 then
	
		INSERT INTO produtos (nome, descricao, preco , quantidade , dt_criacao) 
		VALUES (nome, descricao, preco , quantidade, NOW());
	
		if excecao = 1 then 
		
			SELECT  'Erro ao salvar Cliente' AS erro;
			leave Cadastrar;
			ROLLBACK;
		
		ELSE 
		
			SELECT  'Produto Salvo com Sucesso !' AS sucesso;
			COMMIT;
		END if;
	
	END IF;
	
		-- caso seja maior que  0 significa que sera feito uma atualizaçao de cadastro
	if id > 0 then
		
			UPDATE produtos AS prod SET prod.nome = nome, prod.descricao=descricao, prod.preco=preco, 
			prod.quantidade=quantidade, prod.dt_alteracao=NOW() WHERE prod.id= id;
			
		if excecao = 1 then 
		
			SELECT  'Erro ao alterar Produto' AS erro;
			leave Cadastrar;
			ROLLBACK;
		
		ELSE 
		
			SELECT  'Produto alterado com Sucesso !' AS sucesso;
			COMMIT;
		END if;
					
	END IF;
END;