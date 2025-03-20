CREATE SCHEMA ecommerce;

CREATE  TABLE ecommerce.tb_cliente ( 
	codigo_cliente       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	email                VARCHAR(100)       ,
	ddd                  VARCHAR(3)       ,
	telefone             VARCHAR(9)       ,
	codigo_endereco      INT    NOT NULL   ,
	CONSTRAINT unq_tb_cliente UNIQUE ( codigo_endereco ) 
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_cliente_pessoa_fisica ( 
	codigo_cliente       INT    NOT NULL   PRIMARY KEY,
	cpf                  VARCHAR(9)    NOT NULL   ,
	nome                 VARCHAR(120)    NOT NULL   ,
	CONSTRAINT unq_tb_cliente_pessoa_fisica UNIQUE ( cpf ) ,
	CONSTRAINT fk_tb_cliente_pessoa_fisica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES ecommerce.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_compra ( 
	codigo_compra        INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	valor_total_compra   DECIMAL(0,2)    NOT NULL   ,
	data_pagamento_compra DATETIME    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_departamento ( 
	codigo_departamento  INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_departamento VARCHAR(50)       
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_estoque ( 
	codigo_produto       INT    NOT NULL   ,
	codigo_vendedor      INT    NOT NULL   ,
	preco_custo          DECIMAL(0,4) UNSIGNED   NOT NULL   ,
	quantidade           INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_estoque PRIMARY KEY ( codigo_produto, codigo_vendedor )
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_pedido ( 
	codigo_pedido        INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	status_pedido        INT    NOT NULL   ,
	data_pedido          DATETIME    NOT NULL   ,
	data_devolucao       DATETIME    NOT NULL   ,
	valor_total_produtos DECIMAL(0,4) UNSIGNED   NOT NULL   ,
	valor_frete          DECIMAL(0,2) UNSIGNED   NOT NULL   ,
	desconto_pedido      DECIMAL(0,2) UNSIGNED   NOT NULL   ,
	valor_total_pedido   DECIMAL(0,2) UNSIGNED   NOT NULL   ,
	codigo_cliente       INT    NOT NULL   ,
	codigo_compra        INT    NOT NULL   ,
	CONSTRAINT fk_tb_pedido_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES ecommerce.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_pedido_tb_compra FOREIGN KEY ( codigo_compra ) REFERENCES ecommerce.tb_compra( codigo_compra ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_pessoa_juridica ( 
	codigo_pessoa_juridica INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	razao_social         VARCHAR(100)    NOT NULL   ,
	nome_fantasia        VARCHAR(100)    NOT NULL   ,
	cnpj                 VARCHAR(14)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_produto ( 
	codigo_produto       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao            VARCHAR(50)    NOT NULL   ,
	data_cadastro        DATE    NOT NULL   ,
	codigo_departamento  INT UNSIGNED   NOT NULL   ,
	CONSTRAINT fk_tb_produto_tb_departamento FOREIGN KEY ( codigo_departamento ) REFERENCES ecommerce.tb_departamento( codigo_departamento ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_tipo_pessoa_juridica ( 
	codigo_tipo_pj       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_tipo_pj    VARCHAR(30)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_vendedor ( 
	codigo_vendedor      INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_pessoa_juridica INT    NOT NULL   ,
	codigo_tipo_pj       INT    NOT NULL   ,
	codigo_endereco      INT    NOT NULL   ,
	CONSTRAINT unq_tb_vendedor UNIQUE ( codigo_pessoa_juridica ) ,
	CONSTRAINT unq_tb_vendedor_0 UNIQUE ( codigo_endereco ) ,
	CONSTRAINT unq_tb_vendedor_1 UNIQUE ( codigo_tipo_pj ) ,
	CONSTRAINT fk_tb_vendedor_tb_pessoa_juridica FOREIGN KEY ( codigo_pessoa_juridica ) REFERENCES ecommerce.tb_pessoa_juridica( codigo_pessoa_juridica ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_vendedor_tb_tipo_pessoa_juridica FOREIGN KEY ( codigo_tipo_pj ) REFERENCES ecommerce.tb_tipo_pessoa_juridica( codigo_tipo_pj ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_vendedor_produto ( 
	codigo_vendedor      INT    NOT NULL   ,
	codigo_produto       INT    NOT NULL   ,
	preco_venda          DECIMAL(0,2) UNSIGNED   NOT NULL   ,
	perc_desconto        DECIMAL(0,4)    NOT NULL   ,
	preco_custo          DECIMAL(0,4) UNSIGNED   NOT NULL   ,
	quantidade           INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_vendedor_produto PRIMARY KEY ( codigo_vendedor, codigo_produto ),
	CONSTRAINT unq_tb_vendedor_produto_codigo_vendedor UNIQUE ( codigo_vendedor ) ,
	CONSTRAINT fk_tb_vendedor_produto_tb_vendedor FOREIGN KEY ( codigo_vendedor ) REFERENCES ecommerce.tb_vendedor( codigo_vendedor ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_vendedor_produto_tb_produto FOREIGN KEY ( codigo_produto ) REFERENCES ecommerce.tb_produto( codigo_produto ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_cliente_pessoa_juridica ( 
	codigo_cliente       INT    NOT NULL   PRIMARY KEY,
	codigo_pessoa_juridica INT    NOT NULL   ,
	codigo_tipo_pj       INT    NOT NULL   ,
	CONSTRAINT unq_tb_cliente_pessoa_juridica UNIQUE ( codigo_pessoa_juridica ) ,
	CONSTRAINT unq_tb_cliente_pessoa_juridica_0 UNIQUE ( codigo_tipo_pj ) ,
	CONSTRAINT fk_tb_cliente_pessoa_juridica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES ecommerce.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_cliente_pessoa_juridica_tb_pessoa_juridica FOREIGN KEY ( codigo_pessoa_juridica ) REFERENCES ecommerce.tb_pessoa_juridica( codigo_pessoa_juridica ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_cliente_pessoa_juridica_tb_tipo_pessoa_juridica FOREIGN KEY ( codigo_tipo_pj ) REFERENCES ecommerce.tb_tipo_pessoa_juridica( codigo_tipo_pj ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_detalhamento_pedido ( 
	codigo_pedido        INT    NOT NULL   ,
	codigo_vendedor      INT    NOT NULL   ,
	codigo_produto       INT    NOT NULL   ,
	quantidade_produto   INT UNSIGNED   NOT NULL   ,
	preco_venda          DECIMAL(0,2) UNSIGNED   NOT NULL   ,
	valor_desconto       DECIMAL(0,2)    NOT NULL   ,
	CONSTRAINT pk_tb_detalha_pedido PRIMARY KEY ( codigo_pedido, codigo_vendedor, codigo_produto ),
	CONSTRAINT fk_tb_detalhamento_pedido_tb_pedido FOREIGN KEY ( codigo_pedido ) REFERENCES ecommerce.tb_pedido( codigo_pedido ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_detalhamento_pedido_tb_produto FOREIGN KEY ( codigo_produto ) REFERENCES ecommerce.tb_produto( codigo_produto ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_detalhamento_pedido_tb_vendedor_produto FOREIGN KEY ( codigo_vendedor ) REFERENCES ecommerce.tb_vendedor_produto( codigo_vendedor ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_fornecedor ( 
	codigo_fornecedor    INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_pessoa_juridica INT    NOT NULL   ,
	codigo_tipo_pj       INT    NOT NULL   ,
	codigo_endereco      INT    NOT NULL   ,
	prazo_pagamento      INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_fornecedor UNIQUE ( codigo_pessoa_juridica ) ,
	CONSTRAINT unq_tb_fornecedor_0 UNIQUE ( codigo_endereco ) ,
	CONSTRAINT unq_tb_fornecedor_1 UNIQUE ( codigo_tipo_pj ) ,
	CONSTRAINT fk_tb_fornecedor_tb_pessoa_juridica FOREIGN KEY ( codigo_pessoa_juridica ) REFERENCES ecommerce.tb_pessoa_juridica( codigo_pessoa_juridica ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_fornecedor_tb_tipo_pessoa_juridica FOREIGN KEY ( codigo_tipo_pj ) REFERENCES ecommerce.tb_tipo_pessoa_juridica( codigo_tipo_pj ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_fornecedor_produto ( 
	codigo_fornecedor    INT    NOT NULL   ,
	codigo_produto       INT    NOT NULL   ,
	preco_custo          DECIMAL(0,4)    NOT NULL   ,
	CONSTRAINT pk_tb_fornecedor_produto PRIMARY KEY ( codigo_fornecedor, codigo_produto ),
	CONSTRAINT fk_tb_fornecedor_produto_tb_produto FOREIGN KEY ( codigo_produto ) REFERENCES ecommerce.tb_produto( codigo_produto ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_fornecedor_produto_tb_fornecedor FOREIGN KEY ( codigo_fornecedor ) REFERENCES ecommerce.tb_fornecedor( codigo_fornecedor ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE ecommerce.tb_endereco ( 
	codigo_endereco      INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	logradouro           VARCHAR(125)    NOT NULL   ,
	numero               VARCHAR(10)       ,
	complemento          VARCHAR(100)       ,
	bairro               VARCHAR(100)    NOT NULL   ,
	cidade               VARCHAR(100)    NOT NULL   ,
	estado               VARCHAR(35)    NOT NULL   ,
	cep                  VARCHAR(8)    NOT NULL   ,
	CONSTRAINT fk_tb_endereco_tb_cliente FOREIGN KEY ( codigo_endereco ) REFERENCES ecommerce.tb_cliente( codigo_endereco ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_endereco_tb_vendedor FOREIGN KEY ( codigo_endereco ) REFERENCES ecommerce.tb_vendedor( codigo_endereco ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_endereco_tb_fornecedor FOREIGN KEY ( codigo_endereco ) REFERENCES ecommerce.tb_fornecedor( codigo_endereco ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) engine=InnoDB;

