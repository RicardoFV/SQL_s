-- criacao do banco de dados
create database ecomerce_sql;

-- usando o database
USE ecomerce_sql;

-- criação da tabela produtos
CREATE TABLE produtos (
	id INT(10) UNSIGNED AUTO_INCREMENT primary key ,
	nome VARCHAR(255) NOT NULL,
	descricao VARCHAR(255) NOT NULL,
	preco DECIMAL(10,2) NOT NULL DEFAULT 0.00,
	quantidade INT(10) NOT NULL DEFAULT 0,
	dt_criacao TIMESTAMP NULL DEFAULT NULL,
	dt_alteracao TIMESTAMP NULL DEFAULT NULL,
	INDEX idx_produtos (id,nome)
);
-- criação da tabela clientes
CREATE TABLE clientes (
	id INT(10) UNSIGNED AUTO_INCREMENT primary key ,
	nome VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	cpf VARCHAR(255) NOT NULL,
	telefone VARCHAR(255) NOT NULL DEFAULT '',
	dt_criacao TIMESTAMP NULL DEFAULT NULL,
	dt_alteracao TIMESTAMP NULL DEFAULT NULL,
	INDEX idx_clientes (id,nome)
);

-- criação da tabela pedidos
CREATE TABLE pedidos (
	id INT(10) UNSIGNED AUTO_INCREMENT primary key ,
	numero_pedido INT(10) NOT NULL DEFAULT 0,
	status ENUM('pendente','recusado','aprovado'),
	cliente_id INT(10) UNSIGNED NOT NULL,
	dt_criacao TIMESTAMP NULL DEFAULT NULL,
	dt_alteracao TIMESTAMP NULL DEFAULT NULL,
	INDEX pedidos_cliente_id_foreign (cliente_id) USING BTREE,
	CONSTRAINT pedidos_cliente_id_foreign FOREIGN KEY (`cliente_id`) REFERENCES clientes(`id`)
);

-- criação da tabela pedido_itens
CREATE TABLE pedido_itens (
	id INT(11) UNSIGNED AUTO_INCREMENT primary key ,
	id_pedido INT(10) UNSIGNED NOT NUll,
	id_produto INT(10) UNSIGNED NOT NULL,
	quantidade INT(10) NOT NULL,
	valor DECIMAL(10,2) NOT NULL DEFAULT 0.00,
	dt_criacao TIMESTAMP NULL DEFAULT NULL,
	dt_alteracao TIMESTAMP NULL DEFAULT NULL,
	INDEX pedido_itens_id_pedido_foreign (id_pedido),
	INDEX pedido_itens_id_produto_foreign (id_produto),
	CONSTRAINT pedido_itens_id_pedido_foreign FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
	CONSTRAINT pedido_itens_id_produto_foreign FOREIGN KEY (id_produto) REFERENCES produtos (id) 
);



