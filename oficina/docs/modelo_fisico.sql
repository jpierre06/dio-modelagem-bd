CREATE SCHEMA curso_oficina;

CREATE  TABLE curso_oficina.tb_cliente ( 
	codigo_cliente       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_endereco      INT UNSIGNED   NOT NULL   ,
	codigo_contato       INT UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_cliente_codigo_endereco UNIQUE ( codigo_endereco ) ,
	CONSTRAINT unq_tb_cliente_codigo_contato UNIQUE ( codigo_contato ) 
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_contato ( 
	codigo_contato       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	email                VARCHAR(50)       ,
	ddd                  CHAR(3)    NOT NULL   ,
	telefone             VARCHAR(9)    NOT NULL   ,
	eh_whatsapp          BOOLEAN    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_cor ( 
	codigo_cor           INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	nome_cor             VARCHAR(30)    NOT NULL   ,
	data_cadastro        DATE    NOT NULL   
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
	CONSTRAINT unq_tb_mecanico_codigo_endereco UNIQUE ( codigo_endereco ) 
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_mecanico_equipe ( 
	codigo_mecanico      INT UNSIGNED   NOT NULL   ,
	codigo_equipe        INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_mecanico_equipe PRIMARY KEY ( codigo_mecanico, codigo_equipe )
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_modelo_veiculo ( 
	codigo_modelo        INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_fabricante    INT UNSIGNED   NOT NULL   ,
	descricao_modelo     VARCHAR(40)    NOT NULL   ,
	quantidade_portas    INT UNSIGNED   NOT NULL   ,
	potencia_hp          INT UNSIGNED   NOT NULL   ,
	cilindradas_cc       INT UNSIGNED   NOT NULL   ,
	peso_kg              INT UNSIGNED   NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_peca ( 
	codigo_peca          INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_peca       VARCHAR(64)    NOT NULL   ,
	valor_peca           DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	custo_peca           DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	garantia_dias        INT UNSIGNED   NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_pessoa_fisica ( 
	codigo_cliente       INT UNSIGNED   NOT NULL   PRIMARY KEY,
	nome_cliente         VARCHAR(120)    NOT NULL   ,
	cpf                  CHAR(11)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_pessoa_juridica ( 
	codigo_cliente       INT UNSIGNED   NOT NULL   PRIMARY KEY,
	razao_social         VARCHAR(120)    NOT NULL   ,
	nome_fantasia        VARCHAR(120)    NOT NULL   ,
	prazo_pagamento      INT UNSIGNED   NOT NULL   ,
	cnpj                 CHAR(14)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_servico ( 
	codigo_servico       INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_servico    VARCHAR(32)    NOT NULL   ,
	valor_servico        DECIMAL(8,2) UNSIGNED   NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_tipo_servico ( 
	codigo_tipo_servico  INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	descricao_tipo_servico VARCHAR(32)    NOT NULL   
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_veiculo ( 
	codigo_veiculo       INT UNSIGNED   NOT NULL AUTO_INCREMENT   ,
	codigo_cliente       INT UNSIGNED   NOT NULL   ,
	placa                CHAR(7)    NOT NULL   ,
	renavan              VARCHAR(20)    NOT NULL   ,
	codigo_modelo        INT UNSIGNED   NOT NULL   ,
	codigo_cor           INT UNSIGNED   NOT NULL   ,
	ano_fabricacao       INT UNSIGNED   NOT NULL   ,
	ano_modelo           INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_veiculo PRIMARY KEY ( codigo_cliente, placa ),
	CONSTRAINT unq_tb_veiculo UNIQUE ( codigo_veiculo, codigo_cliente ) ,
	CONSTRAINT unq_tb_veiculo_codigo_veiculo UNIQUE ( codigo_veiculo ) 
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

CREATE  TABLE curso_oficina.tb_especialidade_mecanico ( 
	codigo_especialidade INT UNSIGNED   NOT NULL   ,
	codigo_mecanico      INT UNSIGNED   NOT NULL   ,
	ano_especializacao   INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_especialidade_mecanico PRIMARY KEY ( codigo_especialidade, codigo_mecanico )
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_modelo_peca ( 
	codigo_modelo        INT UNSIGNED   NOT NULL   ,
	codigo_peca          INT UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_modelo_peca PRIMARY KEY ( codigo_modelo, codigo_peca )
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_ordem_servico ( 
	codigo_os            INT UNSIGNED   NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	codigo_tipo_servico  INT UNSIGNED   NOT NULL   ,
	codigo_veiculo       INT UNSIGNED   NOT NULL   ,
	codigo_equipe        INT UNSIGNED   NOT NULL   ,
	data_emissao         DATE  DEFAULT (CURRENT_DATE)  NOT NULL   ,
	data_conclusao       DATE    NOT NULL   ,
	status_os            INT UNSIGNED   NOT NULL   ,
	total_valor_pecas    DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	total_valor_servico  DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	valor_desconto       DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	total_valor_os       DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	CONSTRAINT unq_tb_ordem_servico_codigo_equipe UNIQUE ( codigo_equipe ) 
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_detalhamento_os_peca ( 
	codigo_os            INT UNSIGNED   NOT NULL   ,
	codigo_peca          INT UNSIGNED   NOT NULL   ,
	quantidade           INT UNSIGNED   NOT NULL   ,
	valor_peca_os        DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_detalhamento_os_peca PRIMARY KEY ( codigo_os, codigo_peca )
 ) engine=InnoDB;

CREATE  TABLE curso_oficina.tb_detalhamento_os_servico ( 
	codigo_os            INT UNSIGNED   NOT NULL   ,
	codigo_servico       INT UNSIGNED   NOT NULL   ,
	quantidade           INT UNSIGNED   NOT NULL   ,
	valor_servico_os     DECIMAL(8,2) UNSIGNED   NOT NULL   ,
	CONSTRAINT pk_tb_detalhamento_os_servico PRIMARY KEY ( codigo_os, codigo_servico )
 ) engine=InnoDB;

ALTER TABLE curso_oficina.tb_contato ADD CONSTRAINT fk_tb_contato_tb_cliente FOREIGN KEY ( codigo_contato ) REFERENCES curso_oficina.tb_cliente( codigo_contato ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_detalhamento_os_peca ADD CONSTRAINT fk_tb_detalhamento_os_peca_tb_peca FOREIGN KEY ( codigo_peca ) REFERENCES curso_oficina.tb_peca( codigo_peca ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_detalhamento_os_peca ADD CONSTRAINT fk_tb_detalhamento_os_peca_tb_ordem_servico FOREIGN KEY ( codigo_os ) REFERENCES curso_oficina.tb_ordem_servico( codigo_os ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_detalhamento_os_servico ADD CONSTRAINT fk_tb_detalhamento_os_servico_tb_ordem_servico FOREIGN KEY ( codigo_os ) REFERENCES curso_oficina.tb_ordem_servico( codigo_os ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_detalhamento_os_servico ADD CONSTRAINT fk_tb_detalhamento_os_servico_tb_servico FOREIGN KEY ( codigo_servico ) REFERENCES curso_oficina.tb_servico( codigo_servico ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_endereco ADD CONSTRAINT fk_tb_endereco_tb_cliente FOREIGN KEY ( codigo_endereco ) REFERENCES curso_oficina.tb_cliente( codigo_endereco ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_endereco ADD CONSTRAINT fk_tb_endereco_tb_mecanico FOREIGN KEY ( codigo_endereco ) REFERENCES curso_oficina.tb_mecanico( codigo_endereco ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_especialidade_mecanico ADD CONSTRAINT fk_tb_especialidade_mecanico_tb_especialidade FOREIGN KEY ( codigo_especialidade ) REFERENCES curso_oficina.tb_especialidade( codigo_especialidade ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_especialidade_mecanico ADD CONSTRAINT fk_tb_especialidade_mecanico_tb_mecanico FOREIGN KEY ( codigo_mecanico ) REFERENCES curso_oficina.tb_mecanico( codigo_mecanico ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_mecanico_equipe ADD CONSTRAINT fk_tb_mecanico_equipe_tb_mecanico FOREIGN KEY ( codigo_mecanico ) REFERENCES curso_oficina.tb_mecanico( codigo_mecanico ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_mecanico_equipe ADD CONSTRAINT fk_tb_mecanico_equipe_tb_equipe_atendimento FOREIGN KEY ( codigo_equipe ) REFERENCES curso_oficina.tb_equipe_atendimento( codigo_equipe ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_modelo_peca ADD CONSTRAINT fk_tb_modelo_peca_tb_modelo_veiculo FOREIGN KEY ( codigo_modelo ) REFERENCES curso_oficina.tb_modelo_veiculo( codigo_modelo ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_modelo_peca ADD CONSTRAINT fk_tb_modelo_peca_tb_peca FOREIGN KEY ( codigo_peca ) REFERENCES curso_oficina.tb_peca( codigo_peca ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_modelo_veiculo ADD CONSTRAINT fk_tb_modelo_veiculo_tb_fabricante FOREIGN KEY ( codigo_fabricante ) REFERENCES curso_oficina.tb_fabricante( codigo_fabricante ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_ordem_servico ADD CONSTRAINT fk_tb_ordem_servico_tb_tipo_servico FOREIGN KEY ( codigo_tipo_servico ) REFERENCES curso_oficina.tb_tipo_servico( codigo_tipo_servico ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_ordem_servico ADD CONSTRAINT fk_tb_ordem_servico_tb_veiculo FOREIGN KEY ( codigo_veiculo ) REFERENCES curso_oficina.tb_veiculo( codigo_veiculo ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_ordem_servico ADD CONSTRAINT fk_tb_ordem_servico_tb_equipe_atendimento FOREIGN KEY ( codigo_equipe ) REFERENCES curso_oficina.tb_equipe_atendimento( codigo_equipe ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_pessoa_fisica ADD CONSTRAINT fk_tb_pessoa_fisica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_oficina.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_pessoa_juridica ADD CONSTRAINT fk_tb_pessoa_juridica_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_oficina.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_veiculo ADD CONSTRAINT fk_tb_veiculo_tb_cor FOREIGN KEY ( codigo_cor ) REFERENCES curso_oficina.tb_cor( codigo_cor ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_veiculo ADD CONSTRAINT fk_tb_veiculo_tb_cliente FOREIGN KEY ( codigo_cliente ) REFERENCES curso_oficina.tb_cliente( codigo_cliente ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_veiculo ADD CONSTRAINT fk_tb_veiculo_tb_modelo_veiculo FOREIGN KEY ( codigo_modelo ) REFERENCES curso_oficina.tb_modelo_veiculo( codigo_modelo ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE curso_oficina.tb_tipo_servico COMMENT 'Tipo de Serviços
1 - Conserto
2 - Revisão períodica na garantia
3 - Revisão períodica fora da garantia';

