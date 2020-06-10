Nesse trabalho foi implementado com YACC/BISON, C e FLEX/LEX uma simples calculadora para gerar um codigo assembly para o seguinte simulador:
https://schweigi.github.io/assembler-simulator/
Nele existe dois codigos para bison pois eu tentei otimizar o meu codigo adicionando rotinas para entao conseguir resolver expressoes mais complicadas
mesmo com a memoria RAM do simulador bastante limitada.
Porem, com os testes mais longos dados eu nao obtive sucesso, embora com os de menor tamanho eu obtive, ficando o arquivo apenas como uma historia do desenvolvimento da mnha solucao. O arquivo para ser avaliado de fato eh, portanto, o bison.y.
Para testar o programa basta usar make ( Foi usado no gcc a flag ldl, ou seja, a dynamic linking library ) e executar o ./main.
De resto o codigo gerado tem que ser copiado e colado no site do simulador.
