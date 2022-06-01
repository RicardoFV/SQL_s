-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: ecomerce_sql
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `cpf` varchar(255) NOT NULL,
  `telefone` varchar(255) NOT NULL DEFAULT '',
  `dt_criacao` timestamp NULL DEFAULT NULL,
  `dt_alteracao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_clientes` (`id`,`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Mariah Agatha da Paz','mariah_dapaz@righettorosa.com.br','856.490.022-07','(94)3507-8932','2022-05-31 23:49:20',NULL),(2,'Lucca Levi Marcos Martins','lucca_levi_martins@capua.com.br','282.634.949-07','(34) 3973-8140','2022-05-31 23:49:20',NULL),(3,'Sueli Ester Stefany Carvalho','sueli_ester_carvalho@ppe.ufrj.br','542.881.329-67','(55) 3776-2078','2022-05-31 23:49:20',NULL),(4,'Laís Marli Pinto','lais_marli_pinto@omnibrasil.com.br','699.022.666-81','(85) 3759-6077','2022-05-31 23:49:20',NULL),(5,'Renan Guilherme da Costa','renanguilhermedacosta@vinax.com.br','952.163.969-50','(28) 2824-5624','2022-05-31 23:49:20',NULL),(6,'Clara Vera da Paz','clara.vera.dapaz@nipbr.com','306.878.006-33','(63) 2870-2643','2022-05-31 23:49:20',NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_itens`
--

DROP TABLE IF EXISTS `pedido_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_itens` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_pedido` int unsigned NOT NULL,
  `id_produto` int unsigned NOT NULL,
  `quantidade` int NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `dt_criacao` timestamp NULL DEFAULT NULL,
  `dt_alteracao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_itens_id_pedido_foreign` (`id_pedido`),
  KEY `pedido_itens_id_produto_foreign` (`id_produto`),
  CONSTRAINT `pedido_itens_id_pedido_foreign` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`),
  CONSTRAINT `pedido_itens_id_produto_foreign` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_itens`
--

LOCK TABLES `pedido_itens` WRITE;
/*!40000 ALTER TABLE `pedido_itens` DISABLE KEYS */;
INSERT INTO `pedido_itens` VALUES (1,1,1,2,501.16,'2022-06-01 00:34:34',NULL),(2,2,2,1,899.00,'2022-06-01 00:36:24',NULL),(3,3,5,1,1995.00,'2022-06-01 00:43:15',NULL),(4,4,6,1,450.50,'2022-06-01 00:43:15',NULL),(5,5,1,1,250.58,'2022-06-01 00:43:15',NULL),(6,6,4,1,99.00,'2022-06-01 00:43:15',NULL),(7,7,3,2,10000.00,'2022-06-01 00:45:05',NULL),(8,8,3,2,10000.00,'2022-06-01 01:17:06',NULL),(9,9,5,2,3990.00,'2022-06-01 01:22:30',NULL),(10,10,1,2,501.16,'2022-06-01 01:22:46',NULL);
/*!40000 ALTER TABLE `pedido_itens` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trig_subtrair_estoque_ao_cadastrar` BEFORE INSERT ON `pedido_itens` FOR EACH ROW BEGIN

	-- consulta se tem produto inormado
	if(SELECT COUNT(*) FROM produtos AS prod WHERE prod.id =NEW.id_produto) = 0 then 
		signal sqlstate '45000' set message_text = 'Esse produto não existe !';
		
		ELSE 
	
		-- realiza a atualizaçao de estoque
		UPDATE produtos AS prod SET prod.quantidade = (prod.quantidade - NEW.quantidade )  WHERE  prod.id = NEW.id_produto;
					  				
	END if;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trig_subtrair_estoque_ao_atualizar` BEFORE UPDATE ON `pedido_itens` FOR EACH ROW BEGIN

	-- consulta se tem produto inormado
	if(SELECT COUNT(*) FROM produtos AS prod WHERE prod.id =old.id_produto) = 0 then 
		signal sqlstate '45000' set message_text = 'Esse produto não existe !';
		
		ELSE 
	
		-- realiza a atualizaçao de estoque
		UPDATE produtos AS prod SET prod.quantidade = (prod.quantidade - NEW.quantidade )  WHERE  prod.id = old.id_produto;
					  				
	END if;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `numero_pedido` int NOT NULL DEFAULT '0',
  `status` enum('pendente','recusado','aprovado') DEFAULT NULL,
  `cliente_id` int unsigned NOT NULL,
  `dt_criacao` timestamp NULL DEFAULT NULL,
  `dt_alteracao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedidos_cliente_id_foreign` (`cliente_id`) USING BTREE,
  CONSTRAINT `pedidos_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,494,'aprovado',5,'2022-06-01 00:34:34','2022-06-01 01:31:11'),(2,676,'aprovado',5,'2022-06-01 00:36:24','2022-06-01 01:31:11'),(3,899,'aprovado',6,'2022-06-01 00:43:15','2022-06-01 01:31:11'),(4,469,'aprovado',6,'2022-06-01 00:43:15','2022-06-01 01:31:11'),(5,647,'aprovado',6,'2022-06-01 00:43:15','2022-06-01 01:31:11'),(6,829,'aprovado',6,'2022-06-01 00:43:15','2022-06-01 01:31:11'),(7,209,'aprovado',1,'2022-06-01 00:45:05','2022-06-01 01:31:11'),(8,554,'aprovado',2,'2022-06-01 01:17:06','2022-06-01 01:31:11'),(9,145,'aprovado',3,'2022-06-01 01:22:30','2022-06-01 01:31:11'),(10,61,'aprovado',3,'2022-06-01 01:22:46','2022-06-01 01:31:11');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `preco` decimal(10,2) NOT NULL DEFAULT '0.00',
  `quantidade` int NOT NULL DEFAULT '0',
  `dt_criacao` timestamp NULL DEFAULT NULL,
  `dt_alteracao` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_produtos` (`id`,`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Mochila Dell Gaming 17','Mantenha seu laptop para jogos em segurança enquanto estiver em movimento com a Mochila Dell Gaming',250.58,95,'2022-06-01 00:13:47',NULL),(2,'HEADSET GAMER ALIENWARE 7.1 | AW510H','Seja envolvido pelos sons dos jogos usando o Alienware 7.1 Gaming Headset, que oferece som surround 7.1 com a tecnologia de áudio imersivo da Alienware.',899.00,49,'2022-06-01 00:13:47',NULL),(3,'Monitor 165Hz Gamer 27\" Dell S2721DGF','Monitor Gamer QHD de 27\". As taxas de atualização de 165 Hz, tempo de resposta real de 1 ms GtG e o novo design de refrigeração oferecem jogabilidade ágil e com grande capacidade de resposta.',5000.00,46,'2022-06-01 00:13:47',NULL),(4,'Combo Teclado e Mouse Gamer Com Fio Detalhes Azuis Multilaser - TC195','O teclado conta com 10 teclas multimídia com opção de troca por teclas direcionais transparentes extras, que darão melhor visibilidade para dar mais ritmo e performance ao seu jogo; se você procura conforto, este é o produto ideal.',99.00,99,'2022-06-01 00:13:47',NULL),(5,'CPC Gamer Completo AMD 6-Core CPU 3.8Ghz 8GB (Placa de vídeo Radeon R5 2GB) SSD 120GB Skill Monitor HDMI LED 19.5','PC Gamer Completo AMD 6-Core CPU 3.8Ghz 8GB (Placa de vídeo Radeon R5 2GB) SSD 120GB Skill Monitor HDMI LED 19.5.',1995.00,47,'2022-06-01 00:13:47',NULL),(6,'Mesa de Canto em L Para Escritório com 2 Gavetas e 3 Portas NT2005 Notável Móveis','Versátil e espaçosa a Mesa Office NT2005 da Notável Móveis, oferece para você um local de trabalho ou estudo que permite organizar melhor seus objetos de uso diário, e ela se adequa a sua necessidade, pois o gaveteiro pode ser monta.',450.50,49,'2022-06-01 00:13:47',NULL);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_pedidos_realizados`
--

DROP TABLE IF EXISTS `v_pedidos_realizados`;
/*!50001 DROP VIEW IF EXISTS `v_pedidos_realizados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_pedidos_realizados` AS SELECT 
 1 AS `nome_cliente`,
 1 AS `id_pedido`,
 1 AS `numero_pedido`,
 1 AS `status`,
 1 AS `data_criacao_pedido`,
 1 AS `nome_produto`,
 1 AS `quantidade`,
 1 AS `valor`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_quantidade_de_valor_por_produto`
--

DROP TABLE IF EXISTS `v_quantidade_de_valor_por_produto`;
/*!50001 DROP VIEW IF EXISTS `v_quantidade_de_valor_por_produto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_quantidade_de_valor_por_produto` AS SELECT 
 1 AS `id`,
 1 AS `nome`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'ecomerce_sql'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `event_mudar_status_pedido` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `event_mudar_status_pedido` ON SCHEDULE EVERY 10 MINUTE STARTS '2022-05-31 22:21:11' ON COMPLETION NOT PRESERVE ENABLE DO begin

update pedidos set status = 'aprovado', dt_alteracao = now();
end */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'ecomerce_sql'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_cadastrar_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cadastrar_clientes`(IN id INT , 
													IN nome TEXT , 
													IN email TEXT , 
													IN cpf TEXT , 
													IN telefone TEXT)
Cadastrar:BEGIN 
	-- configurando os parametros para devolutiva de enventuais erros
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_cadastrar_produtos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cadastrar_produtos`(IN id INT , 
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_montar_pedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_montar_pedido`(
IN id_pedido INT,
IN id_cliente INT,
IN id_produto INT,
IN quantidade_escolhida INT)
cadastrar:BEGIN -- inicio
		-- variaveis 
	DECLARE num_pedido VARCHAR(100); 
	DECLARE ultimo_id INT;
	DECLARE valor_produto DECIMAL(10,2);
	DECLARE qtde_estoque INT DEFAULT 0;
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
			
			-- consulta a quantidade em estoque
				SELECT quantidade INTO qtde_estoque FROM produtos WHERE id = id_produto;
				-- caso a quantidade em estoque seja menor do que foi solicitado.
				if qtde_estoque < quantidade_escolhida then
						SELECT  'Erro ao salvar Pedido, Estoque insuficiente !' AS erro;
						leave cadastrar;
				
				END if; -- veriifca a quantidade em estoque
			
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
							UPDATE pedido_itens AS itens SET itens.quantidade = quantidade_escolhida , 
							itens.valor = (quantidade_escolhida * valor_produto), itens.dt_alteracao = NOW() 
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
	
END; ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_pedidos_realizados`
--

/*!50001 DROP VIEW IF EXISTS `v_pedidos_realizados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_pedidos_realizados` AS select `cli`.`nome` AS `nome_cliente`,`ped`.`id` AS `id_pedido`,`ped`.`numero_pedido` AS `numero_pedido`,`ped`.`status` AS `status`,`ped`.`dt_criacao` AS `data_criacao_pedido`,`prod`.`nome` AS `nome_produto`,`itens`.`quantidade` AS `quantidade`,`itens`.`valor` AS `valor` from (((`pedidos` `ped` join `pedido_itens` `itens` on((`itens`.`id_pedido` = `ped`.`id`))) join `produtos` `prod` on((`itens`.`id_produto` = `prod`.`id`))) join `clientes` `cli` on((`ped`.`cliente_id` = `cli`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_quantidade_de_valor_por_produto`
--

/*!50001 DROP VIEW IF EXISTS `v_quantidade_de_valor_por_produto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_quantidade_de_valor_por_produto` AS select `produtos`.`id` AS `id`,`produtos`.`nome` AS `nome`,(`produtos`.`preco` * `produtos`.`quantidade`) AS `total` from `produtos` group by `produtos`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-31 22:40:49
