# Uso do Comando Sed

É case sentive
> -i altera o arquivo
> -e imprime na tela sem alterar o arquivo
> -n faz a supressão, mostra só o resutado do comando
> s substitui um trecho de texto por outro
> ! inverte a lógica do comando
> ; separador de comandos
> | separador de strings
> d no final deleta
> p no final imprime
> g no final (como se usa o d e p) altera todas as ocorrências
> q sai do sed , não continua o comando

 - Troca todas as palavras em um arquivo por outra
```sh
sed -i 's/palavra/outra/' arquivo.txt
```
 - Imprime só a nona linha
```sh
sed -n '9p' arquivo.txt
```
 - Imprime da sexta linha até a nona linha
```sh
sed -n '6,9p' arquivo.txt
```
 - Deleta todas as lihas que contém a palavra string no arquivo
```sh
sed -i '/string/d' arquivo.txt
```
 - Coloca uma palavra no INÍCIO de cada linha
```sh
sed 's/^/palavra/' arquivo.txt
```
 - Coloca uma palavra no final de cada linha
```sh
sed 's/$/palavra/' arquivo.txt
```
 - Imprime só as linhas que COMEÇAM com a string ‘http’
```sh
sed -n '/^http/p' arquivo.txt
```
 - Deleta só as linhas que COMEÇAM com a string ‘http’
```sh
sed -n '/^http/d' arquivo.txt
```
 - Troca TODAS ocorrências da palavra “marcos”, “eric”, “camila” pela palavra “pinguim”
```sh
sed 's/marcos\|eric\|camila/pinguim/g' arquivo.txt
```
 - Troca tudo que estiver ENTRE as palavras “Marcos” e “Eric” pela palavra “eles”, exemplo, o texto, **No sábado Marcos saiu de pra brincar de bicicleta com o Eric, mas não ficaram até tarde.** e ficará assim: **No sábado eles, mas não ficaram até tarde.**
```sh
sed 's/Marcos.*Eric/eles/' arquivo.txt
```
 - Deleta linha em branco e altera o arquivo
```sh
sed -i '/^$/d' arquivo.txt
```
 - Substitui “foo” por “bar” somente as linhas que contém “plop”
```sh
sed '/plop/s/foo/bar/g' arquivo.txt
```
 - Substitui “foo” por “bar” exceto as linhas que contém “plop”
```sh
sed '/plop/!s/foo/bar/g' arquivo.txt
```
 - Insere da Linha 2 a linha 7 o “#” no início de cada linha
```sh
sed '2,7s/^/#/' arquivo.txt
```
 - Insere a palavra ‘NEW’ no início de cada linha, da linha 21 até a linha 28
```sh
sed -i '21,28s/^/NEW/' arquivo.txt
```
 - Troca tudo entre as tags “<” e “>” pela palavra “CODIGO”:
```sh
sed 's/<[^>]*>/CODIGO/g' arquivo.txt
```
 - Imprime somente a primeira ocorrência da linha com determinada string
```sh
sed -n '/dia/{p;q;}' arquivo.txt
```
 - Inclue texto no final da linha 9
```sh
sed '9s/$/final da linha/' arquivo.txt
```
 - Coloca todas as linhas em uma só
```sh
sed ':a;$!N;s/\n//;ta;' arquivo.txt
```
 - Substitui a palavra “BELEZA” por “SIM” somente entre determinadas linhas
```sh
sed '3,6s/BELEZA/SIM/' arquivo.txt
```
 - Apaga o que está entre a palavra “falou” e “segundo” ( delimitadores )
```sh
sed '/segundo/{/falou/{s/segundo.*falou//;t};:a;/falou/!{N;s/\n//;ta;};s/segundo.*falou/\n/;}' arquivo.txt
```
 - Retira comandos HTML (tudo entre < e > )
```sh
sed 's/<[^>]*>//g' arquivo.txt
```
 - Apaga o 1o caracter da frase
```
sed 's/.//' arquivo.txt
```
 - Apaga o 4o caractere da frase
```sh
sed 's/.//4' arquivo.txt
```
 - Apaga os 4 primeiros caracteres
```sh
sed 's/.\{4\}//' arquivo.txt
```
 - Apaga no mínimo 4 caracteres
```sh
sed 's/.\{4,\}//' arquivo.txt
```
 - Apaga de 2 a 4 caracteres (o máx. que tiver)
```sh
sed 's/.\{2,4\}//' arquivo.txt
```
 - Exemplos de intervalo
```sh
echo "aáeéiíoóuú" | sed "s/[a-u]//g" áéíóú
```
```sh
echo "aáeéiíoóuú" | sed "s/[á-ú]//g"
```
Transforma texto (URL) em tags HTML de links.

Era : `http://www.com`

Fica: `<a href=”http://www.com”>http://www.com</a>`
```sh
sed 's_\<\(ht\|f\)tp://[^ ]*_<a href="&">&</a>_' arquivo.txt
```
 - Expressões Regulares com SED ( sed regex )
###### tags: `example`Este sed lê dados do arquivo.txt e apaga (comando d) desde a primeira linha, até a linha que contenha 3 números seguidos, jogando o resultado na tela. Se quiser gravar o resultado, redirecione-o para outro arquivo, não o próprio arquivo.txt .
```sh
sed '1,/[0-9]\{3\}/d' arquivo.txt
```
 - Apagar números
```sh
sed s/[0-9]\+//g' arquivo.txt
```
 - Imprime só linhas que contém PONTUAÇÃO
```sh
sed -n '/[[:punct:]]/p' arquivo.txt
```
 - Imprime só linhas que começam com Números
```sh
sed -n '/^[[:digit:]]/p' arquivo.txt
```
### Formatando numero de telefone
 - Temos um arquivo com os números de telefone assim:
> 
> 7184325689
> 4333285236
> 1140014004
> 3633554488
> 
 - Executando alguns desse modos de comando em SED:

#### Modo Neandertal
Substitui 2 caracteres “..” por “&” que é a saída da solicitação Executa outro sed pra substituir 8 caracteres de novo pelo “&” Obs.: Precisa sempre escapar os parênteses “\(“ e “\)”
```sh
sed 's/../\(&\)/' arquivo.txt | sed 's/......../&-/' arquivo.txt
```
#### Modo Medieval
O mesmo do de cima, só pus o “{8}” pra marcar 8 caracteres “.” Também precisa, SEMPRE, escapar as chaves “\{“ e “/}”
```sh
sed 's/../\(&\)/' arquivo.txt | sed 's/.\{8\}/&-/' arquivo.txt
```
#### Modo Moderno
Ao invés de jogar a saída, separei o comando com ponto-vírgula “;” e lancei outro sed “s”
```sh
sed 's/../\(&\)/;s/.\{8\}/&-/' arquivo.txt
```
#### Modo Pós-Moderno
Esse modo é pra entender o seguinte O primeiro comando entre parênteses “\(..\)” Depois separado por barra \ Lancei ou comando entre parênteses “\(.\{4\}\)” A saída do primeiro comando vai pro barra 1 “\1” E a do segundo comando pro barra 2 “\2” Poderia ter também o barra 3, n, …
```sh
sed 's/\(..\)\(.\{4\}\)/(\1)\2-/g' arquivo.txt
```
> Fica assim:
> (71)8432-5689
> (43)3328-5236
> (11)4001-4004
> (36)3355-4488