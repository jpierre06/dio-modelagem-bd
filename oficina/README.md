# A atividade faz parte do desafio do curso de refinamento do projeto de oficina

<br>
<br>

# Premissas da atividade Sistema de controle e gerenciamento de execução de ordens de serviço

<br>

## Clientes levam veículos à oficina para dois tipos de serviços

> Conserto

> Revisão períodica

<br>


## Cada veículo é designado a uma equipe de mecânicos

> Identificação do serviço

> Abertura de OS com data de entrega

<br>


## Cálculo de valor de cada serviço

> Tabela de referência de mão-de-obra

> Valor de cada peça também irá compor OS

<br>


## Execução do serviço

> Cliente autoriza a execução dos serviços

> A mesma equipe avalia e executa os serviços

<br>


## Mecânicos

> Possuem, código, nome, endereço e especialidade

<br>


## Ordem de Serviço (OS)

> Número da OS, data de emissão, valor, status, data conclusão

> Uma OS pode ser composta por vários serviços e um mesmo serviço pode estar contido em mais de uma OS

> Uma OS pode ter vários tipo de peça e uma peça pode estar presente em mais de uma OS

<br>
<br>

# Considerações de atributos derivados

<br>

## Entidade Ordem de serviço

> Embora o atributo valor_total_pecas na Entidade Ordem-Servico possa ser derivado dos atributos quantidade e valor_peca_os, da relação  entre as Entidaes Ordem-Servico e Detalhamento-Peca, no modelo lógico foi mantido como campo gravado

<br>

## Entidade Ordem de serviço

> Embora o atributo valor_total_servicos na Entidade Ordem-Servico possa ser derivado dos atributos quantidade e valor_servico_os, da relação  entre as Entidaes Ordem-Servico e Detalhamento-Servico, no modelo lógico foi mantido como campo gravado

<br>
<br>


# Modelo Conceitual (Diagrama Entidade Relacionamento)

> O modelo conceitual foi desenvolvido através do aplicativo brModelo

> Caso tenha interesse em usar o diagramam criado pelo aplicativo brModelo, o mesmo pode ser encontrado em "./diagramas/modelo_conceitual.xml"

<br>

## Digrama do modelo conceitual 

![Modelo Conceitual](docs/modelo_conceitual.png)

<br>
