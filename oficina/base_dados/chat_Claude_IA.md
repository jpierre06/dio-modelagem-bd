# Geração de dados para teste com IA Generativa - Oficina

## Para geração de dados foi utilizado a Claude.AI

> Conta gratuita

> Modelo Claude 3.7 Sonnet

> O arquivo anexado ao chat pode ser encontra em "/oficina/docs/modelo_fisico.sql"

> Como a conta gratuita tem limites de geração de tokens por chat, será necessário criar mais de uma chat
<br>
Nesse caso será necessário repetir a Entrada 1 para contextualizar o chat e seguir com as solicitações de geração de tabela
<br> Em casos de ter que recomeçar em um novo chat, pode ser necessário anexar algum arquivo csv criado em chat anterior para que haja contextualização coêrenciar entre as tabelas criadas em chats diferentes



## Exemplos de prompts que podem ser utilizados

<br>

* Entrada 1

```
Em anexo está o arquivo modelo_fisico.sql com a modelagem física de uma banco de dados criado para um curso.

Preciso popular as tabelas de acordo com as especificações do arquivo e algumas regras que informarei gradativamente.

Os dados gerados devem estar no formato "csv", utilizando "vírgula" como delimitador de campo e "ponto" como separador decimal.
Disponibilizar os arquivos "csv" gerados para download.

Favor aguardar instruções para a geração de dados de cada tabela.
```

<br>

* Entrada 2

```
Agora preciso que sejam gerados dados para as tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_cliente com 200 registros;
2 - Gerar dados para a tabela tb_pessoa_fisica com 150 registros, do 1 ao 150;
3 - O campo codigo_cliente da tabela tb_pessoa_fisica deve relacionar com a tabela tb_cliente;
4 - O campo cpf deve ser único e ter 11 caracteres numericos. Caso seja gerado valor com menos de 11 caracteres numericos, preencher com "zeros" a esquerda;
5 - Gerar dados para a tabela tb_pessoa_juridica com 50 registros, do 151 ao 200;
6 - O campo codigo_cliente da tabela tb_pessoa_juridica deve relacionar com a tabela tb_cliente;
7 - O campo cnpj deve ser único e ter 14 caracteres numericos. Caso seja gerado valor com menos de 14 caracteres numericos, preencher com "zeros" a esquerda;
```

<br>

* Entrada 3

```
Agora preciso que sejam gerados dados para as tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_endereco com 200 registros;
2 - O campo codigo_endereco da tabela tb_endereco deve relacionar com a tabela tb_cliente;
3 - Gerar dados para a tabela tb_contato com 200 registros;
4 - O campo codigo_contato da tabela tb_contato deve relacionar com a tabela tb_cliente;
5 - Para os primeiros 150 registros, o campo email da tabela tb_contato deve ser coerente com o campo nome_cliente no arquivo tb_pessoa_fisica.csv anexo;
6 - Para os registros entre 151 e 200, o campo email da tabela tb_contato deve ser coerente com o campo nome_fantasia no arquivo tb_pessoa_juridica.csv anexo;
```

<br>

* Entrada 4

```
Agora preciso que sejam gerados dados para as tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_fabricante com 20 registros;
2 - Gerar dados para a tabela tb_modelo_veiculo em média com 7 modelos por fabricante;
3 - A tabela tb_fabricante se relaciona com a tabela tb_modelo_veiculo;
```

<br>

* Entrada 5

```
Agora preciso que sejam gerados dados para as tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_cor com 20 registros;
2 - Gerar dados para a tabela tb_veiculo com 300 registros;
3 - Os campos placa e renavam devem ser únicos;
4 - Um cliente pode ser mais de um carro que é identificado pelo chave composta codigo_cliente e placa;
5 - A tabela tb_veiculo se relaciona com a tabela tb_cliente e campo codigo_cliente de ser entre 1 e 200;
6 - A tabela tb_veiculo se relaciona com a tabela tb_modelo_veiculo e campo codigo_modelo de ser entre 1 e 140;
```

<br>

* Entrada 6

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_peca com 200 registros;
2 - A tabela tb_peca se relacionar com a tabela tb_modelo_veiculo, como pode existirem uma relação muito para muitos entre tb_peca e tb_modelo_veiculo, gerar dados para tabela tb_modelo_peca com as colunas codigo_peca e codigo_modelo;
3 - Cada modelo de carro deve ter pelo menos 30 peças. E uma peças pode servir para mais de um modelo de carro;
4 - A tabela tb_modelo_veiculo já foi criada conforme arquivo tb_modelo_veiculo.csv anexo;
```

<br>

* Entrada 7

```
Agora preciso que sejam criadas as seguintes base de dados com as respectivas regras:

1 - Gerar dados para a tabela tb_servico;
2 - A tabela tb_servico deve ser coerente com a tabela tb_peca (conforme arquivo tb_peca.csv anexo) embora não haja relação direta;
3 - Adicionar pelo menos 30 serviços que não tenham relação direta com uso de peças;
```

<br>

* Entrada 8

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

1 - Gerar dados para tabela tb_mecanico com 40 registros;
2 - Gerar dados para tabela tb_especialidade com entre 20 e 30 registros de especialização em mecânica;
3 - As tabela tb_mecanico e tb_especialidade é uma relação muitos para muitos e deve ser realizada através da tabela tb_especialidade_mecanico;
4 - Na tabela tb_especialidade_mecanico incluir o ano de especialização de cada mecânico em cada tipo de especialização;
5 - Gerar dados para tabela tb_equipe_atendimento de mecânicos;
6 - Existem 40 mecânicos na oficina, considerar que em média 5 mecânicos estão de folga por dia;
7 - As equipes variam entre 3 e 6 mecânicos com a maior variedade de especialização possível, distribuir todos os mecânicos possíveis no maior número de equipes possíveis;
8 - Montar equipes para período de 30 dias contando a partir de hoje;
9 - A relação entre as tabelas tb_mecanico e tb_equipe_atendimento é de muitos para muitos e deve acontecer através da tabela tb_mecanico_equipe;
```

<br>

* Entrada 9

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_ordem_servico com 50 registros;
2 - O campo codigo_veiculo deve ter valor entre 1 e 397;
3 - O campo codigo_equipe deve ser gerado em coerência com arquivo tb_equipe_atendimento.csv anexo;
4 - A campo data_emissao da tabela tb_ordem_servico deve ser igual ao campo data_equipe da tabela tb_equipe_atendimento;
6 - O campo data_conclusao deve ser igual ou maior que data_emissao;
7 - O campo codigo_tipo_servico deve considerar 3 tipos sendo eles:
	'''
	1	Conserto
	2	Revisão períodica na garantia
	3	Revisão períodica fora da garantia
	'''
8 - Os campo total_valor_peca, total_valor_servico e total_valor_os devem ser 0. Esses campos serão atualizados posteriormente através de triggers. Gerar eventualmente valor para o campo valor_desconto;
```

<br>

* Entrada 10

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_detalhamento_os_peca;
2 - A tabela tb_detalhamento_os_peca informa que pode existir mais de uma peça por ordem de serviço. É a relação entre a tabela tb_ordem_servico e a tabela tb_peca que está no arquivo anexo tb_peca.csv
3 - Gerar dados para a tabela tb_detalhamento_os_servico;
4 - A tabela tb_detalhamento_os_servico informa que pode existir mais de um serviço por ordem de serviço. É a relação entre a tabela tb_ordem_servico e a tabela tb_servico que está no arquivo anexo tb_servico.csv;
5 - Para ambas as tabelas geradas considerar codigo_os com valores entre 1 e 50;
```


<br>

[Retornar página Carga de Dados para Teste](../Base_dados.md)

