-- criqcao da procedure clientes
-- procedure resposnavel cadastrar e alterar um cliente
DELIMITER //
CREATE PROCEDURE proc_cadastrar_clientes(IN id INT , 
													IN nome TEXT , 
													IN email TEXT , 
													IN cpf TEXT , 
													IN telefone TEXT)
												
Cadastrar:BEGIN 

	DECLARE excecao smallint DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION set excecao = 1;
	
	-- inicia a transação 
	START TRANSACTION;
	-- caso o numero informado seja negativo
	if id < 0 then 
		SELECT  'O id tem pode ser 0 ou um ecomerce_sqlnumero positivo' AS erro;
		leave Cadastrar;
	END if;
	
	-- caso seja 0 significa que sera feito um cadastro
	if id = 0 then
	
		INSERT INTO clientes (nome, email, cpf , telefone , dt_criacao) VALUES (nome, email, cpf, telefone, NOW());
	
		if excecao = 1 then 
		
			SELECT  'Erro ao salvar Cliente' AS erro;
			leave Cadastrar;
			ROLLBACK;
		
		ELSE 
		
			SELECT  'Cliente Salvo com Sucesso !' AS sucesso;
			COMMIT;
		END if;
	
	END IF;
	
	-- caso seja maior que  0 significa que sera feito uma atualizaçao de cadastro
	if id > 0 then
		
			UPDATE clientes AS cli SET cli.nome = nome, cli.email=email, cli.cpf=cpf, cli.telefone=telefone, 
			cli.dt_alteracao=NOW() WHERE cli.id= id;
			
		if excecao = 1 then 
		
			SELECT  'Erro ao alterar Cliente' AS erro;
			leave Cadastrar;
			ROLLBACK;
		
		ELSE 
		
			SELECT  'Cliente alterado com Sucesso !' AS sucesso;
			COMMIT;
		END if;
					
	END IF;
	
END;