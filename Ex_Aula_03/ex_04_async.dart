/*
Crie 4 funções que simulam chamadas de API diferentes: buscarProdutos(), 
buscarCategorias(), buscarPromocoes() e buscarDestaques(). Use 
Future.wait() para executar todas ao mesmo tempo. Meça o tempo total de 
execução e compare com execução sequencial.
*/

import 'dart:async';

// Simulações de API (todas demoram 1 segundo)
Future<String> buscarProdutos() async => await Future.delayed(Duration(seconds: 1), () => "Produtos");
Future<String> buscarCategorias() async => await Future.delayed(Duration(seconds: 1), () => "Categorias");
Future<String> buscarPromocoes() async => await Future.delayed(Duration(seconds: 1), () => "Promoções");
Future<String> buscarDestaques() async => await Future.delayed(Duration(seconds: 1), () => "Destaques");

void main() async {
  // --- TESTE 1: SEQUENCIAL (Um por um) ---
  var inicioSeq = DateTime.now();
  print("Iniciando busca sequencial...");

  await buscarProdutos();
  await buscarCategorias();
  await buscarPromocoes();
  await buscarDestaques();

  var fimSeq = DateTime.now();
  print(
    "Tempo Sequencial: ${fimSeq.difference(inicioSeq).inSeconds} segundos\n",
  );

  // --- TESTE 2: PARALELO (Tudo junto) ---
  var inicioPar = DateTime.now();
  print("Iniciando busca em paralelo com Future.wait...");

  // Executa todas as funções ao mesmo tempo
  List<String> resultados = await Future.wait([
    buscarProdutos(),
    buscarCategorias(),
    buscarPromocoes(),
    buscarDestaques(),
  ]);

  var fimPar = DateTime.now();
  print("Resultados: $resultados");
  print("Tempo Paralelo: ${fimPar.difference(inicioPar).inSeconds} segundo");
}
