# Criação de script para atualização de arquivo .md

<br>

## Na criação de documentação da modelagem lógica foi definido a utilização de dois arquivo para cada modelagem

### Modelagem e-commerce

* e-commerce/Modelo_logico.md

* e-commerce/docs/modelo_fisico.sql


### Modelagem Oficina

* oficina/Modelo_logico.md

* oficina/docs/modelo_fisico.sql

<br>

## O arquivo .sql permite acesso direto ao conteúdo SQL para criação das estruturas do banco de dados

> Pode ser feito um copia-cola direto em uma ferramenta de execução de código SQL (DBeaver, por exemplo)

<br>

## O arquivo .md inclui o conteúdo SQL em formato de documentação

<br>

## Inconsistência no conteúdo dos arquivos

>Porém, esse cenário estava gerando inconsistência entre os arquivos uma vez que após a atualização do arquivo .sql a atualização do arquivo .md era manual
<br>
Por isso, foi criado o script de atualização automatica para o arquivo .md
<br>
<br>
Para leitura do arquivo acessar "scripts/atualizar_md_modelo_logico.sh"

<br>

## Configurando um pre-commit hook para analisar quando o arquivo especifíco será "comitado"

>Por exemplo:
<br>
<br>
Ao executar o commit no arquivo "e-commerce/docs/modelo_fisico.sql"
<br>
O script "scripts/atualizar_md_modelo_logico.sh" é executado
<br>
O conteúdo do arquivo "e-commerce/Modelo_logico.md" é atualizado
<br>
E o arquivo "e-commerce/Modelo_logico.md" é incluído no mesmo commit do arquivo "e-commerce/docs/modelo_fisico.sql"

<br>

## Como configurar o pre-commit hook

>Para configurar o pre-commit hook é necessário criar o arquivo ".git/hooks/pre-commit", caso ainda não exista
<br>
E adicionar comandos para monitorar commit, executar script e incluir outro arquivo no commit

### Exemplo de configuração do arquivo ".git/hooks/pre-commit" para o cenário de e-commerce

```bash
#!/bin/bash

# Verificar se o arquivo do modelo físico de e-commerce está sendo commitado
if git diff --cached --name-only | grep -q "e-commerce/docs/modelo_fisico.sql"; then
    echo "[Hook] Arquivo de modelo físico SQL detectado no commit."
    
    # 1. Executar o script de atualização
    echo "[Hook] Executando script atualizar_md.sh..."
    ./scripts/atualizar_md_modelo_logico.sh "./e-commerce/docs/modelo_fisico.sql" "./e-commerce/Modelo_fisico.md"
    
    if [ $? -ne 0 ]; then
        echo "[Hook] ERRO: O script atualizar_md.sh falhou."
        exit 1
    fi
    
    # 2. Verificar se o arquivo MD foi atualizado
    if [ -f "e-commerce/Modelo_fisico.md" ]; then
        echo "[Hook] Arquivo MD atualizado com sucesso."
        
        # 3. Adicionar o arquivo MD atualizado ao commit atual
        echo "[Hook] Adicionando arquivo MD ao commit atual..."
        git add e-commerce/Modelo_fisico.md
        
        if [ $? -ne 0 ]; then
            echo "[Hook] ERRO: Não foi possível adicionar o arquivo MD ao commit."
            exit 1
        fi
        
        echo "[Hook] Arquivo MD adicionado ao commit com sucesso."
    else
        echo "[Hook] ERRO: O arquivo MD não foi encontrado após execução do script."
        exit 1
    fi
fi

# Permitir que o commit continue
exit 0
```


<br>
<br>

[Retornar README principal](README.md)