CREATE SCHEMA curso_oficina;

CREATE  TABLE curso_oficina.tb_cor ( 
	codigo_cor           INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	nome_cor             VARCHAR(30)    NOT NULL   ,
	data_cadastro        DATE    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_endereco ( 
	codigo_endereco      INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	logradouro           VARCHAR(120)    NOT NULL   ,
	numero               VARCHAR(6)       ,
	complemento          VARCHAR(60)       ,
	cep                  CHAR(8)    NOT NULL   ,
	bairro               VARCHAR(30)    NOT NULL   ,
	cidade               VARCHAR(50)    NOT NULL   ,
	estado               VARCHAR(30)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_equipe_atendimento ( 
	codigo_equipe        INT UNSIGNED   NOT NULL AUTO_INCREMENT   ,
	data_equipe          DATE    NOT NULL   ,
	tb_descricao_equipe  VARCHAR(24)    NOT NULL   ,
	CONSTRAINT pk_tb_equipe_mecanico PRIMARY KEY ( codigo_equipe, data_equipe ),
	CONSTRAINT unq_tb_equipe_atendimento_codigo_equipe UNIQUE ( codigo_equipe ) 
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_especialidade ( 
	codigo_especialidade INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_especialidade VARCHAR(64)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_fabricante ( 
	codigo_fabricante    INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_fabricante VARCHAR(32)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_mecanico ( 
	codigo_mecanico      INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	nome_mecanico        VARCHAR(64)    NOT NULL   ,
	codigo_endereco      INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_mecanico_codigo_endereco UNIQUE ( codigo_endereco ) ,
	CONSTRAINT fk_tb_mecanico_tb_endereco FOREIGN KEY ( codigo_endereco ) REFERENCES curso_oficina.tb_endereco( codigo_endereco ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_mecanico_equipe ( 
	codigo_mecanico      INT UNSIGNED   NOT NULL   ,
	codigo_equipe        INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_mecanico_equipe PRIMARY KEY ( codigo_mecanico, codigo_equipe ),
	CONSTRAINT fk_tb_mecanico_equipe_tb_mecanico FOREIGN KEY ( codigo_mecanico ) REFERENCES curso_oficina.tb_mecanico( codigo_mecanico ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_mecanico_equipe_tb_equipe_atendimento FOREIGN KEY ( codigo_equipe ) REFERENCES curso_oficina.tb_equipe_atendimento( codigo_equipe ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_mecanico_equipe_tb_equipe_atendimento ON curso_oficina.tb_mecanico_equipe ( codigo_equipe );

CREATE  TABLE curso_oficina.tb_modelo_veiculo ( 
	codigo_modelo        INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_fabricante    INT UNSIGNED   NOT NULL   ,
	descricao_modelo     VARCHAR(40)    NOT NULL   ,
	quantidade_portas    INT UNSIGNED   NOT NULL   ,
	potencia_hp          INT UNSIGNED   NOT NULL   ,
	cilindradas_cc       INT UNSIGNED   NOT NULL   ,
	peso_kg              INT UNSIGNED   NOT NULL   ,
	CONSTRAINT fk_tb_modelo_veiculo_tb_fabricante FOREIGN KEY ( codigo_fabricante ) REFERENCES curso_oficina.tb_fabricante( codigo_fabricante ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_modelo_veiculo_tb_fabricante ON curso_oficina.tb_modelo_veiculo ( codigo_fabricante );

CREATE  TABLE curso_oficina.tb_peca ( 
	codigo_peca          INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_peca       VARCHAR(64)    NOT NULL   ,
	valor_peca           DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	custo_peca           DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	garantia_dias        INT UNSIGNED   NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_servico ( 
	codigo_servico       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_servico    VARCHAR(32)    NOT NULL   ,
	valor_servico        DECIMAL(8,2) UNSIGNED   NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_tipo_servico ( 
	codigo_tipo_servico  INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_tipo_servico VARCHAR(40)   CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_cliente ( 
	codigo_cliente       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_endereco      INT UNSIGNED   NOT NULL   ,
	codigo_contato       INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_cliente_codigo_endereco UNIQUE ( codigo_endereco ) ,
	CONSTRAINT unq_tb_cliente_codigo_contato UNIQUE ( codigo_contato ) ,
	CONSTRAINT fk_tb_cliente_tb_endereco FOREIGN KEY ( codigo_endereco ) REFERENCES curso_oficina.tb_endereco( codigo_endereco ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_contato ( 
	codigo_contato       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	email                VARCHAR(50)       ,
	ddd                  CHAR(3)    NOT NULL   ,
	telefone             VARCHAR(9)    NOT NULL   ,
	eh_whatsapp          BOOLEAN    NOT NULL   ,
	CONSTRAINT fk_tb_contato_tb_cliente FOREIGN KEY ( codigo_contato ) REFERENCES curso_oficina.tb_cliente( codigo_contato ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_especialidade_mecanico ( 
	codigo_especialidade INT UNSIGNED   NOT NULL   ,
	codigo_mecanico      INT UNSIGNED   NOT NULL   ,
	ano_especializacao   INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_especialidade_mecanico PRIMARY KEY ( codigo_especialidade, codigo_mecanico ),
	CONSTRAINT fk_tb_especialidade_mecanico_tb_especialidade FOREIGN KEY ( codigo_especialidade ) REFERENCES curso_oficina.tb_especialidade( codigo_especialidade ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_especialidade_mecanico_tb_mecanico FOREIGN KEY ( codigo_mecanico ) REFERENCES curso_oficina.tb_mecanico( codigo_mecanico ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_especialidade_mecanico_tb_mecanico ON curso_oficina.tb_especialidade_mecanico ( codigo_mecanico );

CREATE  TABLE curso_oficina.tb_modelo_peca ( 
	codigo_modelo        INT UNSIGNED   NOT NULL   ,
	codigo_peca          INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_modelo_peca PRIMARY KEY ( codigo_modelo, codigo_peca ),
	CONSTRAINT fk_tb_modelo_peca_tb_modelo_veiculo FOREIGN KEY ( codigo_modelo ) REFERENCES curso_oficina.tb_modelo_veiculo( codigo_modelo ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_modelo_peca_tb_peca FOREIGN KEY ( codigo_peca ) REFERENCES curso_oficina.tb_peca( codigo_peca ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_modelo_peca_tb_peca ON curso_oficina.tb_modelo_peca ( codigo_peca );

CREATE  TABLE curso_oficina.tb_pessoa_fisica ( 
	codigo_cliente       INT UNSIGNED   NOT NULL   PRIMARY KEY,
	nome_cliente         VARCHAR(120)    NOT NULL   ,
	cpf                  CHAR(11)    NOT NULL   ,
	CONSTRAINT unq_tb_pessoa_fisica UNIQUE ( cpf ) ,
	CONSTRAINT fk_tb_pessoa_fisica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_oficina.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_pessoa_juridica ( 
	codigo_cliente       INT UNSIGNED   NOT NULL   PRIMARY KEY,
	razao_social         VARCHAR(120)    NOT NULL   ,
	nome_fantasia        VARCHAR(120)    NOT NULL   ,
	prazo_pagamento      INT UNSIGNED   NOT NULL   ,
	cnpj                 CHAR(14)    NOT NULL   ,
	CONSTRAINT unq_tb_pessoa_juridica UNIQUE ( cnpj ) ,
	CONSTRAINT fk_tb_pessoa_juridica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_oficina.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_veiculo ( 
	codigo_veiculo       INT UNSIGNED   NOT NULL AUTO_INCREMENT   ,
	codigo_cliente       INT UNSIGNED   NOT NULL   ,
	placa                CHAR(7)    NOT NULL   ,
	renavan              VARCHAR(16)    NOT NULL   ,
	codigo_modelo        INT UNSIGNED   NOT NULL   ,
	codigo_cor           INT UNSIGNED   NOT NULL   ,
	ano_fabricacao       INT UNSIGNED   NOT NULL   ,
	ano_modelo           INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_veiculo PRIMARY KEY ( codigo_cliente, placa ),
	CONSTRAINT unq_tb_veiculo UNIQUE ( codigo_veiculo, codigo_cliente ) ,
	CONSTRAINT unq_tb_veiculo_codigo_veiculo UNIQUE ( codigo_veiculo ) ,
	CONSTRAINT fk_tb_veiculo_tb_cor FOREIGN KEY ( codigo_cor ) REFERENCES curso_oficina.tb_cor( codigo_cor ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_veiculo_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_oficina.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_veiculo_tb_modelo_veiculo FOREIGN KEY ( codigo_modelo ) REFERENCES curso_oficina.tb_modelo_veiculo( codigo_modelo ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_veiculo_tb_cor ON curso_oficina.tb_veiculo ( codigo_cor );

CREATE INDEX fk_tb_veiculo_tb_modelo_veiculo ON curso_oficina.tb_veiculo ( codigo_modelo );

CREATE  TABLE curso_oficina.tb_ordem_servico ( 
	codigo_os            INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_tipo_servico  INT UNSIGNED   NOT NULL   ,
	codigo_veiculo       INT UNSIGNED   NOT NULL   ,
	codigo_equipe        INT UNSIGNED   NOT NULL   ,
	data_emissao         DATE  DEFAULT (curdate())  NOT NULL   ,
	data_conclusao       DATE    NOT NULL   ,
	status_os            INT UNSIGNED   NOT NULL   ,
	total_valor_pecas    DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	total_valor_servico  DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	valor_desconto       DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	total_valor_os       DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_ordem_servico_codigo_equipe UNIQUE ( codigo_equipe ) ,
	CONSTRAINT fk_tb_ordem_servico_tb_veiculo UNIQUE ( codigo_veiculo ) ,
	CONSTRAINT fk_tb_ordem_servico_tb_tipo_servico FOREIGN KEY ( codigo_tipo_servico ) REFERENCES curso_oficina.tb_tipo_servico( codigo_tipo_servico ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_ordem_servico_tb_equipe_atendimento FOREIGN KEY ( codigo_equipe ) REFERENCES curso_oficina.tb_equipe_atendimento( codigo_equipe ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_ordem_servico_tb_veiculo_0 FOREIGN KEY ( codigo_veiculo ) REFERENCES curso_oficina.tb_veiculo( codigo_veiculo ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_ordem_servico_tb_tipo_servico ON curso_oficina.tb_ordem_servico ( codigo_tipo_servico );

CREATE  TABLE curso_oficina.tb_detalhamento_os_peca ( 
	codigo_os            INT UNSIGNED   NOT NULL   ,
	codigo_peca          INT UNSIGNED   NOT NULL   ,
	quantidade           INT UNSIGNED   NOT NULL   ,
	valor_peca_os        DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_detalhamento_os_peca PRIMARY KEY ( codigo_os, codigo_peca ),
	CONSTRAINT fk_tb_detalhamento_os_peca_tb_peca FOREIGN KEY ( codigo_peca ) REFERENCES curso_oficina.tb_peca( codigo_peca ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_detalhamento_os_peca_tb_ordem_servico FOREIGN KEY ( codigo_os ) REFERENCES curso_oficina.tb_ordem_servico( codigo_os ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_detalhamento_os_peca_tb_peca ON curso_oficina.tb_detalhamento_os_peca ( codigo_peca );

CREATE  TABLE curso_oficina.tb_detalhamento_os_servico ( 
	codigo_os            INT UNSIGNED   NOT NULL   ,
	codigo_servico       INT UNSIGNED   NOT NULL   ,
	quantidade           INT UNSIGNED   NOT NULL   ,
	valor_servico_os     DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_detalhamento_os_servico PRIMARY KEY ( codigo_os, codigo_servico ),
	CONSTRAINT fk_tb_detalhamento_os_servico_tb_ordem_servico FOREIGN KEY ( codigo_os ) REFERENCES curso_oficina.tb_ordem_servico( codigo_os ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_tb_detalhamento_os_servico_tb_servico FOREIGN KEY ( codigo_servico ) REFERENCES curso_oficina.tb_servico( codigo_servico ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) engine=InnoDB;

CREATE INDEX fk_tb_detalhamento_os_servico_tb_servico ON curso_oficina.tb_detalhamento_os_servico ( codigo_servico );

CREATE VIEW curso_oficina.vw_clientes_consolidado AS select `cli`.`codigo_cliente` AS `codigo_cliente`,if((`pf`.`nome_cliente` is null),'Pessoa Jurídica','Pessoa Física') AS `tipo_cliente`,if((`pf`.`nome_cliente` is null),2,1) AS `codigo_tipo_cliente`,if((`pf`.`nome_cliente` is null),`pj`.`nome_fantasia`,`pf`.`nome_cliente`) AS `nome`,`cli`.`codigo_endereco` AS `codigo_endereco`,`cli`.`codigo_contato` AS `codigo_contato` from ((`curso_oficina`.`tb_cliente` `cli` left join `curso_oficina`.`tb_pessoa_fisica` `pf` on((`cli`.`codigo_cliente` = `pf`.`codigo_cliente`))) left join `curso_oficina`.`tb_pessoa_juridica` `pj` on((`cli`.`codigo_cliente` = `pj`.`codigo_cliente`)));

CREATE VIEW curso_oficina.vw_total_valor_os AS select `curso_oficina`.`cli`.`codigo_cliente` AS `codigo_cliente`,`curso_oficina`.`cli`.`nome` AS `nome`,`curso_oficina`.`cli`.`codigo_tipo_cliente` AS `codigo_tipo_cliente`,`curso_oficina`.`cli`.`tipo_cliente` AS `tipo_cliente`,`tv`.`placa` AS `placa`,`tos`.`codigo_os` AS `codigo_os`,`tos`.`total_valor_os` AS `total_valor_os` from ((`curso_oficina`.`vw_clientes_consolidado` `cli` join `curso_oficina`.`tb_veiculo` `tv` on((`curso_oficina`.`cli`.`codigo_cliente` = `tv`.`codigo_cliente`))) join `curso_oficina`.`tb_ordem_servico` `tos` on((`tv`.`codigo_veiculo` = `tos`.`codigo_veiculo`))) order by `tos`.`total_valor_os` desc;

CREATE VIEW curso_oficina.vw_total_valor_os_cliente AS select `curso_oficina`.`vw_total_valor_os`.`codigo_cliente` AS `codigo_cliente`,`curso_oficina`.`vw_total_valor_os`.`nome` AS `nome`,`curso_oficina`.`vw_total_valor_os`.`codigo_tipo_cliente` AS `codigo_tipo_cliente`,`curso_oficina`.`vw_total_valor_os`.`tipo_cliente` AS `tipo_cliente`,sum(`curso_oficina`.`vw_total_valor_os`.`total_valor_os`) AS `total_valor_os` from `curso_oficina`.`vw_total_valor_os` group by `curso_oficina`.`vw_total_valor_os`.`codigo_cliente`,`curso_oficina`.`vw_total_valor_os`.`nome`,`curso_oficina`.`vw_total_valor_os`.`codigo_tipo_cliente`,`curso_oficina`.`vw_total_valor_os`.`tipo_cliente` order by `total_valor_os` desc;

CREATE VIEW curso_oficina.vw_total_valor_os_veiculo AS select `curso_oficina`.`vw_total_valor_os`.`codigo_cliente` AS `codigo_cliente`,`curso_oficina`.`vw_total_valor_os`.`nome` AS `nome`,`curso_oficina`.`vw_total_valor_os`.`codigo_tipo_cliente` AS `codigo_tipo_cliente`,`curso_oficina`.`vw_total_valor_os`.`tipo_cliente` AS `tipo_cliente`,`curso_oficina`.`vw_total_valor_os`.`placa` AS `placa`,sum(`curso_oficina`.`vw_total_valor_os`.`total_valor_os`) AS `total_valor_os` from `curso_oficina`.`vw_total_valor_os` group by `curso_oficina`.`vw_total_valor_os`.`codigo_cliente`,`curso_oficina`.`vw_total_valor_os`.`nome`,`curso_oficina`.`vw_total_valor_os`.`codigo_tipo_cliente`,`curso_oficina`.`vw_total_valor_os`.`tipo_cliente`,`curso_oficina`.`vw_total_valor_os`.`placa` order by `total_valor_os` desc;

CREATE TRIGGER curso_oficina.trg_after_insert_tb_detalhamento_os_peca AFTER INSERT ON tb_detalhamento_os_peca FOR EACH ROW BEGIN
     CALL upsert_tb_ordem_servico_from_peca(NEW.codigo_os);
END;

CREATE TRIGGER curso_oficina.trg_after_insert_tb_detalhamento_os_servico AFTER INSERT ON tb_detalhamento_os_servico FOR EACH ROW BEGIN
     CALL upsert_tb_ordem_servico_from_servico(NEW.codigo_os);
END;

CREATE TRIGGER curso_oficina.trg_after_update_tb_detalhamento_os_peca AFTER UPDATE ON tb_detalhamento_os_peca FOR EACH ROW BEGIN
     CALL upsert_tb_ordem_servico_from_peca(NEW.codigo_os);
END;

CREATE TRIGGER curso_oficina.trg_after_update_tb_detalhamento_os_servico AFTER UPDATE ON tb_detalhamento_os_servico FOR EACH ROW BEGIN
     CALL upsert_tb_ordem_servico_from_servico(NEW.codigo_os);
END;

CREATE PROCEDURE curso_oficina.upsert_tb_ordem_servico_from_peca(IN p_codigo_os INT)
BEGIN
    DECLARE v_total_pecas DECIMAL(10,2);
 
    -- Calcula o valor total das peças para a ordem de serviço
    SELECT 
        SUM(quantidade * valor_peca_os)
    INTO 
        v_total_pecas
    FROM 
        tb_detalhamento_os_peca
    WHERE 
        codigo_os = p_codigo_os;

    -- Se não houver itens, define como zero
    IF v_total_pecas IS NULL THEN
        SET v_total_pecas = 0;
    END IF;

    -- Atualiza o valor das peças
    UPDATE tb_ordem_servico
    SET total_valor_pecas = v_total_pecas
    WHERE codigo_os = p_codigo_os;


    -- Atualiza o valor total da ordem de serviço
	UPDATE tb_ordem_servico
	SET total_valor_os = IF(
	    CAST(total_valor_pecas AS SIGNED) + 
	    CAST(total_valor_servico AS SIGNED) - 
	    CAST(valor_desconto AS SIGNED) < 0,
	    0,
	    total_valor_pecas + total_valor_servico - valor_desconto
	)
	WHERE codigo_os = p_codigo_os;
	    
END;

CREATE PROCEDURE curso_oficina.upsert_tb_ordem_servico_from_servico(IN p_codigo_os INT)
BEGIN
    DECLARE v_total_servico DECIMAL(10,2);

    -- Calcula o valor total dos serviços para a ordem de serviço
    SELECT 
        SUM(quantidade * valor_servico_os)
    INTO 
        v_total_servico
    FROM 
        tb_detalhamento_os_servico
    WHERE 
        codigo_os = p_codigo_os;

    -- Se não houver itens, define como zero
    IF v_total_servico IS NULL THEN
        SET v_total_servico = 0;
    END IF;

    -- Atualiza o valor dos serviços
    UPDATE tb_ordem_servico
    SET total_valor_servico = v_total_servico
    WHERE codigo_os = p_codigo_os;


    -- Atualiza o valor total da ordem de serviço
	UPDATE tb_ordem_servico
	SET total_valor_os = IF(
	    CAST(total_valor_pecas AS SIGNED) + 
	    CAST(total_valor_servico AS SIGNED) - 
	    CAST(valor_desconto AS SIGNED) < 0,
	    0,
	    total_valor_pecas + total_valor_servico - valor_desconto
	)
	WHERE codigo_os = p_codigo_os;    
    
END;

ALTER TABLE curso_oficina.tb_tipo_servico COMMENT 'Tipo de Serviços
1 - Conserto
2 - Revisão períodica na garantia
3 - Revisão períodica fora da garantia';

