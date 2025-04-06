# Arquivos gerados para carga - e-commerce

## Durante a carga de dados através de arquivos CSV os arquivos foram carregado na seguinte ordem:

#### Obs.: Embora a ordem da carga possa variar de acordo com as restrições de relacionamento, essa foi a ordem testada.


>tb_tipo_pessoa_juridica.csv
<br>
tb_departamento.csv

>tb_cliente-pf.csv (com registros PF)
<br>
tb_cliente_pessoa_fisica.csv

>tb_pessoa_juridica-cli.csv (com registros de clientes)
<br>
tb_cliente-pj.csv (com registros PJ)
<br>
tb_cliente_pessoa_juridica.csv


>tb_endereco-cli.csv (com registros de clientes)


>tb_pessoa_juridica-vend.csv (com registros de vendedor)
<br>
tb_endereco-vend.csv (com registros de vendedor)
<br>
tb_vendedor.csv

>tb_pessoa_juridica-forn.csv (com registros de fornecedor)
<br>
tb_endereco-forn.csv (com registros de fornecedor)
<br>
tb_fornecedor.csv



>tb_produto.csv
<br>
tb_vendedor_produto.csv
<br>
tb_fornecedor_produto.csv



>tb_compra.csv
<br>
tb_pedido.csv
<br>
tb_detalhamento_pedido.csv

<br>
<br>



[Retornar página Carga de Dados para Teste](../Base_dados.md)
