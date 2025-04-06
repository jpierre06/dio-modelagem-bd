CREATE SCHEMA curso_ecommerce;

CREATE  TABLE curso_ecommerce.tb_departamento ( 
	codigo_departamento  INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	descricao_departamento VARCHAR(50)       
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE curso_ecommerce.tb_endereco ( 
	codigo_endereco      INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	logradouro           VARCHAR(125)    NOT NULL   ,
	numero               VARCHAR(10)       ,
	complemento          VARCHAR(100)       ,
	bairro               VARCHAR(100)    NOT NULL   ,
	cidade               VARCHAR(100)    NOT NULL   ,
	estado               VARCHAR(35)    NOT NULL   ,
	cep                  VARCHAR(8)    NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE curso_ecommerce.tb_pessoa_juridica ( 
	codigo_pessoa_juridica INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	razao_social         VARCHAR(100)    NOT NULL   ,
	nome_fantasia        VARCHAR(100)    NOT NULL   ,
	cnpj                 CHAR(14)    NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE curso_ecommerce.tb_produto ( 
	codigo_produto       INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	descricao            VARCHAR(50)    NOT NULL   ,
	data_cadastro        DATE    NOT NULL   ,
	codigo_departamento  INT UNSIGNED   NOT NULL   ,
	CONSTRAINT fk_tb_produto_tb_departamento FOREIGN KEY ( codigo_departamento ) REFERENCES curso_ecommerce.tb_departamento( codigo_departamento ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_produto_tb_departamento ON curso_ecommerce.tb_produto ( codigo_departamento );

CREATE  TABLE curso_ecommerce.tb_tipo_pessoa_juridica ( 
	codigo_tipo_pj       INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	descricao_tipo_pj    VARCHAR(30)    NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE curso_ecommerce.tb_vendedor ( 
	codigo_vendedor      INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	codigo_pessoa_juridica INT UNSIGNED   NOT NULL   ,
	codigo_tipo_pj       INT UNSIGNED   NOT NULL   ,
	codigo_endereco      INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_vendedor UNIQUE ( codigo_pessoa_juridica ) ,
	CONSTRAINT unq_tb_vendedor_0 UNIQUE ( codigo_endereco ) ,
	CONSTRAINT fk_tb_vendedor_tb_pessoa_juridica FOREIGN KEY ( codigo_pessoa_juridica ) REFERENCES curso_ecommerce.tb_pessoa_juridica( codigo_pessoa_juridica ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_vendedor_tb_tipo_pessoa_juridica FOREIGN KEY ( codigo_tipo_pj ) REFERENCES curso_ecommerce.tb_tipo_pessoa_juridica( codigo_tipo_pj ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_vendedor_tb_endereco FOREIGN KEY ( codigo_endereco ) REFERENCES curso_ecommerce.tb_endereco( codigo_endereco ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_vendedor_tb_tipo_pessoa_juridica ON curso_ecommerce.tb_vendedor ( codigo_tipo_pj );

CREATE  TABLE curso_ecommerce.tb_vendedor_produto ( 
	codigo_vendedor      INT UNSIGNED   NOT NULL   ,
	codigo_produto       INT UNSIGNED   NOT NULL   ,
	preco_venda          DECIMAL(8,2)    NOT NULL   ,
	perc_desconto        DECIMAL(8,4)    NOT NULL   ,
	preco_custo          DECIMAL(10,4)    NOT NULL   ,
	quantidade           INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_vendedor_produto PRIMARY KEY ( codigo_vendedor, codigo_produto ),
	CONSTRAINT unq_tb_vendedor_produto_codigo_vendedor PRIMARY KEY ( codigo_vendedor, codigo_produto ),
	CONSTRAINT fk_tb_vendedor_produto_tb_produto FOREIGN KEY ( codigo_produto ) REFERENCES curso_ecommerce.tb_produto( codigo_produto ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_vendedor_produto_tb_vendedor FOREIGN KEY ( codigo_vendedor ) REFERENCES curso_ecommerce.tb_vendedor( codigo_vendedor ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_vendedor_produto_tb_produto ON curso_ecommerce.tb_vendedor_produto ( codigo_produto );

CREATE  TABLE curso_ecommerce.tb_cliente ( 
	codigo_cliente       INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	email                VARCHAR(100)       ,
	ddd                  VARCHAR(3)       ,
	telefone             VARCHAR(9)       ,
	codigo_endereco      INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_cliente UNIQUE ( codigo_endereco ) ,
	CONSTRAINT fk_tb_cliente_tb_endereco FOREIGN KEY ( codigo_endereco ) REFERENCES curso_ecommerce.tb_endereco( codigo_endereco ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE curso_ecommerce.tb_cliente_pessoa_fisica ( 
	codigo_cliente       INT UNSIGNED   NOT NULL   PRIMARY KEY,
	cpf                  CHAR(11)    NOT NULL   ,
	nome                 VARCHAR(120)    NOT NULL   ,
	CONSTRAINT unq_tb_cliente_pessoa_fisica UNIQUE ( cpf ) ,
	CONSTRAINT fk_tb_cliente_pessoa_fisica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_ecommerce.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE  TABLE curso_ecommerce.tb_cliente_pessoa_juridica ( 
	codigo_cliente       INT UNSIGNED   NOT NULL   PRIMARY KEY,
	codigo_pessoa_juridica INT UNSIGNED   NOT NULL   ,
	codigo_tipo_pj       INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_cliente_pessoa_juridica UNIQUE ( codigo_pessoa_juridica ) ,
	CONSTRAINT fk_tb_cliente_pessoa_juridica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_ecommerce.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_cliente_pessoa_juridica_tb_pessoa_juridica FOREIGN KEY ( codigo_pessoa_juridica ) REFERENCES curso_ecommerce.tb_pessoa_juridica( codigo_pessoa_juridica ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_cliente_pessoa_juridica_tb_tipo_pessoa_juridica FOREIGN KEY ( codigo_tipo_pj ) REFERENCES curso_ecommerce.tb_tipo_pessoa_juridica( codigo_tipo_pj ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_cliente_pessoa_juridica_tb_tipo_pessoa_juridica ON curso_ecommerce.tb_cliente_pessoa_juridica ( codigo_tipo_pj );

CREATE  TABLE curso_ecommerce.tb_compra ( 
	codigo_compra        INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	valor_total_compra   DECIMAL(11,2)    NOT NULL   ,
	data_pagamento_compra DATETIME    NOT NULL   ,
	codigo_cliente       INT UNSIGNED   NOT NULL   ,
	CONSTRAINT fk_tb_compra_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_ecommerce.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_compra_tb_cliente ON curso_ecommerce.tb_compra ( codigo_cliente );

CREATE  TABLE curso_ecommerce.tb_fornecedor ( 
	codigo_fornecedor    INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	codigo_pessoa_juridica INT UNSIGNED   NOT NULL   ,
	codigo_tipo_pj       INT UNSIGNED   NOT NULL   ,
	codigo_endereco      INT UNSIGNED   NOT NULL   ,
	prazo_pagamento      INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_fornecedor UNIQUE ( codigo_pessoa_juridica ) ,
	CONSTRAINT unq_tb_fornecedor_0 UNIQUE ( codigo_endereco ) ,
	CONSTRAINT fk_tb_fornecedor_tb_pessoa_juridica FOREIGN KEY ( codigo_pessoa_juridica ) REFERENCES curso_ecommerce.tb_pessoa_juridica( codigo_pessoa_juridica ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_fornecedor_tb_tipo_pessoa_juridica FOREIGN KEY ( codigo_tipo_pj ) REFERENCES curso_ecommerce.tb_tipo_pessoa_juridica( codigo_tipo_pj ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_fornecedor_tb_endereco FOREIGN KEY ( codigo_endereco ) REFERENCES curso_ecommerce.tb_endereco( codigo_endereco ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_fornecedor_tb_tipo_pessoa_juridica ON curso_ecommerce.tb_fornecedor ( codigo_tipo_pj );

CREATE  TABLE curso_ecommerce.tb_fornecedor_produto ( 
	codigo_fornecedor    INT UNSIGNED   NOT NULL   ,
	codigo_produto       INT UNSIGNED   NOT NULL   ,
	preco_custo          DECIMAL(10,4)    NOT NULL   ,
	CONSTRAINT pk_tb_fornecedor_produto PRIMARY KEY ( codigo_fornecedor, codigo_produto ),
	CONSTRAINT fk_tb_fornecedor_produto_tb_fornecedor FOREIGN KEY ( codigo_fornecedor ) REFERENCES curso_ecommerce.tb_fornecedor( codigo_fornecedor ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_fornecedor_produto_tb_produto FOREIGN KEY ( codigo_produto ) REFERENCES curso_ecommerce.tb_produto( codigo_produto ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_fornecedor_produto_tb_produto ON curso_ecommerce.tb_fornecedor_produto ( codigo_produto );

CREATE  TABLE curso_ecommerce.tb_pedido ( 
	codigo_pedido        INT UNSIGNED   NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	status_pedido        INT    NOT NULL   ,
	data_pedido          DATETIME    NOT NULL   ,
	data_devolucao       DATETIME    NOT NULL   ,
	valor_total_produtos DECIMAL(10,4)    NOT NULL   ,
	valor_frete          DECIMAL(8,2)    NOT NULL   ,
	desconto_pedido      DECIMAL(8,2)    NOT NULL   ,
	valor_total_pedido   DECIMAL(8,2)    NOT NULL   ,
	codigo_compra        INT UNSIGNED   NOT NULL   ,
	CONSTRAINT fk_tb_pedido_tb_compra FOREIGN KEY ( codigo_compra ) REFERENCES curso_ecommerce.tb_compra( codigo_compra ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_pedido_tb_compra ON curso_ecommerce.tb_pedido ( codigo_compra );

CREATE  TABLE curso_ecommerce.tb_detalhamento_pedido ( 
	codigo_pedido        INT UNSIGNED   NOT NULL   ,
	codigo_vendedor      INT UNSIGNED   NOT NULL   ,
	codigo_produto       INT UNSIGNED   NOT NULL   ,
	quantidade_produto   INT UNSIGNED   NOT NULL   ,
	preco_venda          DECIMAL(8,2)    NOT NULL   ,
	valor_desconto       DECIMAL(8,2)    NOT NULL   ,
	CONSTRAINT pk_tb_detalhamento_pedido PRIMARY KEY ( codigo_pedido, codigo_vendedor, codigo_produto ),
	CONSTRAINT fk_tb_detalhamento_pedido_tb_pedido FOREIGN KEY ( codigo_pedido ) REFERENCES curso_ecommerce.tb_pedido( codigo_pedido ) ON DELETE NO ACTION ON UPDATE RESTRICT,
	CONSTRAINT fk_tb_detalhamento_pedido_tb_vendedor_produto FOREIGN KEY ( codigo_vendedor, codigo_produto ) REFERENCES curso_ecommerce.tb_vendedor_produto( codigo_vendedor, codigo_produto ) ON DELETE NO ACTION ON UPDATE RESTRICT
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX fk_tb_detalhamento_pedido_tb_vendedor_produto ON curso_ecommerce.tb_detalhamento_pedido ( codigo_vendedor, codigo_produto );

CREATE VIEW curso_ecommerce.vw_cliente_consolidado AS select `cli`.`codigo_cliente` AS `codigo_cliente`,ifnull(`pf`.`nome`,`tpj`.`nome_fantasia`) AS `nome`,(case when (`pf`.`nome` is not null) then 1 when (`tpj`.`nome_fantasia` is not null) then 2 else 0 end) AS `codigo_tipo_cliente`,(case when (`pf`.`nome` is not null) then 'Pessoa Física' when (`tpj`.`nome_fantasia` is not null) then 'Pessoa Jurídica' else 'Tipo não Identicado' end) AS `tipo_cliente`,`endr`.`codigo_endereco` AS `codigo_endereco`,`endr`.`logradouro` AS `logradouro`,`endr`.`numero` AS `numero`,`endr`.`complemento` AS `complemento`,`endr`.`bairro` AS `bairro`,`endr`.`cidade` AS `cidade`,`endr`.`estado` AS `estado`,`endr`.`cep` AS `cep` from ((((`curso_ecommerce`.`tb_cliente` `cli` left join `curso_ecommerce`.`tb_cliente_pessoa_fisica` `pf` on((`cli`.`codigo_cliente` = `pf`.`codigo_cliente`))) left join `curso_ecommerce`.`tb_cliente_pessoa_juridica` `pj` on((`cli`.`codigo_cliente` = `pj`.`codigo_cliente`))) left join `curso_ecommerce`.`tb_pessoa_juridica` `tpj` on((`pj`.`codigo_pessoa_juridica` = `tpj`.`codigo_pessoa_juridica`))) join `curso_ecommerce`.`tb_endereco` `endr` on((`cli`.`codigo_endereco` = `endr`.`codigo_endereco`)));

CREATE VIEW curso_ecommerce.vw_total_vendas_vendedor_produto AS select `dped`.`codigo_vendedor` AS `codigo_vendedor`,`vpj`.`nome_fantasia` AS `vendedor`,`dped`.`codigo_produto` AS `codigo_produto`,`prod`.`descricao` AS `descricao_produto`,sum((`dped`.`preco_venda` * `dped`.`quantidade_produto`)) AS `total_venda_sem_desconto`,sum(`dped`.`valor_desconto`) AS `total_desconto`,sum(((`dped`.`preco_venda` * `dped`.`quantidade_produto`) - `dped`.`valor_desconto`)) AS `total_venda_com_desconto` from (((`curso_ecommerce`.`tb_detalhamento_pedido` `dped` left join `curso_ecommerce`.`tb_vendedor` `vend` on((`dped`.`codigo_vendedor` = `vend`.`codigo_vendedor`))) left join `curso_ecommerce`.`tb_pessoa_juridica` `vpj` on((`vend`.`codigo_pessoa_juridica` = `vpj`.`codigo_pessoa_juridica`))) left join `curso_ecommerce`.`tb_produto` `prod` on((`dped`.`codigo_produto` = `prod`.`codigo_produto`))) group by `dped`.`codigo_vendedor`,`vpj`.`nome_fantasia`,`dped`.`codigo_produto`,`prod`.`descricao` order by `dped`.`codigo_vendedor`,`dped`.`codigo_produto`;

CREATE VIEW curso_ecommerce.vw_vendas_cliente AS select `curso_ecommerce`.`cc`.`codigo_cliente` AS `codigo_cliente`,`curso_ecommerce`.`cc`.`nome` AS `nome`,`curso_ecommerce`.`cc`.`codigo_tipo_cliente` AS `codigo_tipo_cliente`,`curso_ecommerce`.`cc`.`tipo_cliente` AS `tipo_cliente`,sum(`cpr`.`valor_total_compra`) AS `valor_total_compra` from (`curso_ecommerce`.`tb_compra` `cpr` join `curso_ecommerce`.`vw_cliente_consolidado` `cc` on((`cpr`.`codigo_cliente` = `curso_ecommerce`.`cc`.`codigo_cliente`))) group by `curso_ecommerce`.`cc`.`codigo_cliente`,`curso_ecommerce`.`cc`.`nome`,`curso_ecommerce`.`cc`.`codigo_tipo_cliente`,`curso_ecommerce`.`cc`.`tipo_cliente` order by `valor_total_compra` desc;

CREATE VIEW curso_ecommerce.vw_total_vendas_produto AS select `curso_ecommerce`.`vp`.`codigo_produto` AS `codigo_produto`,`curso_ecommerce`.`vp`.`descricao_produto` AS `descricao_produto`,sum(`curso_ecommerce`.`vp`.`total_venda_sem_desconto`) AS `total_venda_sem_desconto`,sum(`curso_ecommerce`.`vp`.`total_desconto`) AS `total_desconto`,sum(`curso_ecommerce`.`vp`.`total_venda_com_desconto`) AS `total_venda_com_desconto` from `curso_ecommerce`.`vw_total_vendas_vendedor_produto` `vp` group by `curso_ecommerce`.`vp`.`codigo_produto`,`curso_ecommerce`.`vp`.`descricao_produto`;

CREATE TRIGGER curso_ecommerce.trg_after_insert_detalhamento_pedido AFTER INSERT ON tb_detalhamento_pedido FOR EACH ROW BEGIN
    DECLARE v_total_produtos DECIMAL(10,2);
    
    -- Calcula o valor total dos produtos para o pedido específico
    SELECT SUM((quantidade_produto * preco_venda) - valor_desconto) 
    INTO v_total_produtos
    FROM tb_detalhamento_pedido
    WHERE codigo_pedido = NEW.codigo_pedido;
    -- Atualiza a coluna valor_total_produtos na tabela tb_pedido
    UPDATE tb_pedido
    SET valor_total_produtos = v_total_produtos
    WHERE codigo_pedido = NEW.codigo_pedido;
    -- Atualiza o valor_total_pedido com base no novo valor_total_produtos e valor_frete
    UPDATE tb_pedido
    SET valor_total_pedido = (valor_total_produtos - valor_frete - desconto_pedido)
    WHERE codigo_pedido = NEW.codigo_pedido;
    
END;

CREATE TRIGGER curso_ecommerce.trg_after_insert_pedido AFTER INSERT ON tb_pedido FOR EACH ROW BEGIN
    DECLARE v_total_compra DECIMAL(10,2);
    
    -- Calcula o valor total dos pedidos para a compra específica
    SELECT SUM(valor_total_pedido) 
    INTO v_total_compra
    FROM tb_pedido
    WHERE codigo_compra = NEW.codigo_compra;
    -- Atualiza a coluna valor_total_compra na tabela tb_compra
    UPDATE tb_compra
    SET valor_total_compra = v_total_compra
    WHERE codigo_compra = NEW.codigo_compra;
END;

CREATE TRIGGER curso_ecommerce.trg_after_update_detalhamento_pedido AFTER UPDATE ON tb_detalhamento_pedido FOR EACH ROW BEGIN
    DECLARE v_total_produtos DECIMAL(10,2);
    
    -- Calcula o valor total dos produtos para o pedido específico
    SELECT SUM((quantidade_produto * preco_venda) - valor_desconto) 
    INTO v_total_produtos
    FROM tb_detalhamento_pedido
    WHERE codigo_pedido = NEW.codigo_pedido;
    -- Atualiza a coluna valor_total_produtos na tabela tb_pedido
    UPDATE tb_pedido
    SET valor_total_produtos = v_total_produtos
    WHERE codigo_pedido = NEW.codigo_pedido;
    -- Atualiza o valor_total_pedido com base no novo valor_total_produtos e valor_frete
    UPDATE tb_pedido
    SET valor_total_pedido = (valor_total_produtos - valor_frete - desconto_pedido)
    WHERE codigo_pedido = NEW.codigo_pedido;
    
END;

CREATE TRIGGER curso_ecommerce.trg_after_update_pedido AFTER UPDATE ON tb_pedido FOR EACH ROW BEGIN
    DECLARE v_total_compra DECIMAL(10,2);
    
    -- Calcula o valor total dos pedidos para a compra específica
    SELECT SUM(valor_total_pedido) 
    INTO v_total_compra
    FROM tb_pedido
    WHERE codigo_compra = NEW.codigo_compra;
    -- Atualiza a coluna valor_total_compra na tabela tb_compra
    UPDATE tb_compra
    SET valor_total_compra = v_total_compra
    WHERE codigo_compra = NEW.codigo_compra;
END;

