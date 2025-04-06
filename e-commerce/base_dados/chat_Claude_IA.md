# Geração de dados para teste com IA Generativa - e-commerce

## Para geração de dados foi utilizado a Claude.AI

> Conta gratuita

> Modelo Claude 3.7 Sonnet

> O arquivo anexado ao chat pode ser encontra em "/e-commerce/docs/modelo_fisico.sql"

> Como a conta gratuita tem limites de geração de tokens por chat, será necessário criar mais de uma chat
<br>
Nesse caso será necessário repetir a Entrada 1 para contextualizar o chat e seguir com as solicitações de geração de tabela



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
2 - Gerar dados para a tabela tb_cliente_pessoa_fisica com 200 registros;
3 - O campo codigo_cliente da tabela tb_cliente_pessoa_fisica deve relacionar com a tabela tb_cliente;
4 - O campo nome deve ser coerente com o campo email gerado na tabela tb_cliente;
5 - O campo cpf deve ter 11 caracteres numericos. Caso seja gerado valor com menos de 11 caracteres numericos, preencher com "zeros" a esquerda;
```

<br>

* Entrada 3

```
Agora preciso que sejam gerados dados para as tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_pessoa_juridica com 100 registros;
2 - O campo cnpj deve ter 14 caracteres numericos. Caso seja gerado valor com menos de 14 caracteres numericos, preencher com "zeros" a esquerda;
3 - Gerar dados para a tabela tb_cliente_pessoa_juridica com 100 registros;
4 - A tabela tb_cliente_pessoa_juridica se relaciona com a tabela tb_pessoa_juridica;
5 - O campo codigo_tipo_pj na tb_cliente_pessoa_juridica deve ter sempre valor 3;
6 - Gerar dados para a tabela tb_cliente com 100 registros;
7 - A tabela tb_cliente se relaciona com a tabela tb_cliente_pessoa_juridica;
```

<br>

* Entrada 4

```
Agora preciso que sejam gerados dados para as tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_endereco com 300 registros;
2 - A tabela tb_endereco se relaciona com a tabela tb_cliente;
3 - Os 200 primeiros registros devem ter caracteristicas de clientes pessoa física;
4 - Os demais 100 registros (do 201 ao 300) devem ter caracteristicas de pessoa jurídica;
```

<br>

* Entrada 5

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_pessoa_juridica com 50 registros;
2 - A coluna codigo_pessoa_juridica da tabela tb_pessoa_juridica deve começar com valor 101;
3 - Gerar dados para a tabela tb_vendedor com 50 registros;
4 - O campo codigo_tipo_pj da tb_vendedor deve ser igual a 2;
5 - A tabela tb_vendedor se relaciona com a tabela tb_pessoa_juridica;
6 - Gerar dados para a tabela tb_endereco com 50 registros;
7 - A coluna codigo_endereco da tabela tb_endereco deve começar com valor 301;
8 - A tabela tb_endereco se relaciona com a tabela tb_vendedor;
```

<br>

* Entrada 6

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_pessoa_juridica com 20 registros;
2 - A coluna codigo_pessoa_juridica da tabela tb_pessoa_juridica deve começar com valor 151;
3 - Gerar dados para a tabela tb_fornecedor com 20 registros;
4 - O campo codigo_tipo_pj  da tb_fornecedor deve ser igual a 1;
5 - A tabela tb_fornecedor se relacionar com a tabela tb_pessoa_juridica;
6 - Gerar dados para a tabela tb_endereco com 20 registros;
7 - A coluna codigo_endereco da tabela tb_endereco deve começar com valor 351;
8 - A tabela tb_endereco se relaciona com a tabela tb_fornecedor;
```

<br>

* Entrada 7

```
Preciso que sejam criadas as seguintes base de dados com as respectivas regras:

1 - Gerar dados para a tabela tb_departamento com no máximo dez departamentos;
2 - Gerar dados para a tabela tb_produto com duzentos produtos;
3 - Os dados gerado para a tabela tb_produto devem se relacionar com a tabela tb_departamento;
```

<br>

* Entrada 8

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

1 - Gerar dados para tabela tb_vendedor_produto;
2 - A tabela tb_vendedor_produto é uma relação muitos para muitos entre as tabelas tb_produto e tb_vendedor;
3 - A tabela tb_vendedor já está populada com codigo_vendedor entre 1 e 50;
4 - Gerar dados para tabela tb_fornecedor_produto;
5 - A tabela tb_fornecedor_produto é uma relação muitos para muitos entre as tabelas tb_produto e tb_fornecedor;
6 - A tabela tb_fornecedor já está populada com codigo_fornecedor entre 1 e 20;
```

<br>

* Entrada 9

```
Agora preciso que seja gerado dados para as seguintes tabelas com as respectivas regras:

Agora preciso que sejam gerados dados para as tabelas com as respectivas regras:

1 - Gerar dados para a tabela tb_compra com 50 registros;
2 - O campo codigo_cliente deve estar entre 1 e 300;
3 - O campo valor_total_compra deve ser 0. Esse campo será atualizado posteriormente através de uma trigger;
4 - Gerar dados para a tabela tb_pedido;
5 - Uma compra pode ter um ou mais pedidos;
6 - As colunas valor_total_produtos e valor_total_pedido deve ser 0. Esses campos serão atualizados posteriormente através de triggers;
7 - Gerar dados para a tabela tb_detalhamento_pedido;
8 - No mesmo pedido pode ter um ou mais produto desde que seja do mesmo vendedor;
9 - Em média cada pedido deve ter 3 produtos;
10 - Considerar o arquivo tb_vendedor_produto.csv para utilizar a relação vendedor e produto;
```


<br>

[Retornar página Carga de Dados para Teste](../Base_dados.md)

