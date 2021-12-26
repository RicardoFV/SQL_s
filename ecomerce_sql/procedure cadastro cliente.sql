-- criqcao da procedure clientes
-- procedure resposnavel cadastrar e alterar um cliente
DELIMITER //
CREATE PROCEDURE proc_cliente_cadastrar(IN id INT , 
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
		SELECT  'O id tem pode ser 0 ou um numero positivo' AS erro;
		leave Cadastrar;
		ROLLBACK;
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
	
	ELSE  -- significa que sera feito um atuaalizar 
	
	SELECT  'Erro ao salvar Cliente' AS erro;
	END if;
	
END;

clientesclientesCALL proc_cliente_cadastrar(0, 'Ricardo', 'emailtext@gmail.com', '12345678901' , '1212345678');