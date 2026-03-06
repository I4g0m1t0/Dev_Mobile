/*
Pegue o exercício anterior e reescreva a chamada na main() usando 
async/await ao invés de .then(). Adicione tratamento de erros com try/catch. 
Para testar o erro, faça a função lançar uma exceção ocasionalmente
*/

import 'dart:math';

Future<String> buscarUsuario() async {
  await Future.delayed(Duration(seconds: 2));

  // Simula um erro ocasional (50% de chance)
  if (Random().nextBool()) {
    throw Exception("Falha na conexão com o servidor!");
  }

  return "Lucas Silva";
}

void main() async{
  print("Iniciando busca...");

  try {
    String nome = await buscarUsuario();
    print("Usuário encontrado: $nome");
  } catch (e) {
    print("Erro ao buscar o usuário: $e");
  }
}
