/*
Crie uma função buscarConfiguracao(String chave) que retorna 
Future<String?>.
Implemente um cache local (Map) que pode ou não ter o valor. 
Use os operadores ?., ??, e ! Adequadamente.
Se o valor não estiver no cache, busque de uma 'API' (simule com 
Future.delayed).
*/

import 'dart:async';

Map<String, String>? cache = {}; // Cache que pode ser nulo

Future<String?> buscarDaAPI(String chave) async {
  await Future.delayed(Duration(seconds: 2));
  return "Valor_da_API";
}

Future<String?> buscarConfiguracao(String chave) async {
  // 1. ?. (Acessa o cache se ele não for nulo)
  // 2. ?? (Se o resultado for null, executa o que está à direita)
  String? valor = cache?[chave] ?? await buscarDaAPI(chave);

  // 3. ! (Afirma que o valor não é nulo para salvar no cache)
  if (valor != null) {
    cache![chave] = valor;
  }

  return valor;
}

void main() async {
  print("Buscando...");

  // Primeira vez: demora 2s (API)
  print("Resultado 1: ${await buscarConfiguracao('tema')}");

  // Segunda vez: instantâneo (Cache)
  print("Resultado 2: ${await buscarConfiguracao('tema')}");
}
