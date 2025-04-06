#!/bin/bash

# Verificar se foram fornecidos exatamente 2 parâmetros
if [ $# -ne 2 ]; then
    echo "Erro: O script precisa de exatamente 2 parâmetros."
    echo "Uso: $0 <arquivo_entrada> <arquivo_saida>"
    exit 1
fi

# Primeiro parâmetro se refere ao arquivo com comandos SQL
# Segundo parâmetro se refere ao arquivo markdown que precisa atualizar seu conteúdo 

#arquivo_sql="./e-commerce/docs/modelo_fisico.sql"
#arquivo_markdown="./e-commerce/Modelo_fisico.md"
arquivo_sql=$1
arquivo_markdown=$2

if [ ! -f "$arquivo_sql" ]; then
  echo "Erro: Arquivo SQL não encontrado."
  exit 1
fi

if [ ! -f "$arquivo_markdown" ]; then
  echo "Erro: Arquivo Markdown não encontrado."
  exit 1
fi

conteudo_sql=$(cat "$arquivo_sql")

awk -v sql_content="$conteudo_sql" '
BEGIN {
  in_block = 0;
}
/^```sql$/ {
  in_block = 1;
  print;
  print sql_content;
  next;
}
/^```$/ {
  if (in_block) {
    in_block = 0;
    print; # Adicionada a impressão do delimitador final
    next;
  }
}
{
  if (!in_block) {
    print;
  }
}
' "$arquivo_markdown" > "$arquivo_markdown.tmp" && mv "$arquivo_markdown.tmp" "$arquivo_markdown"

echo "Conteúdo do arquivo SQL inserido com sucesso no arquivo Markdown."