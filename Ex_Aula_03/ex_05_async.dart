/*
Crie uma função que busca dados de uma API lenta (delay de 5 segundos). 
Use .timeout() para cancelar a operação se demorar mais de 3 segundos. 
Trate a exceção TimeoutException e exiba uma mensagem amigável ao 
usuário.
*/

import 'dart:async';

// Função que demora 5 segundos
Future<String> funcao() async {
  await Future.delayed(Duration(seconds: 5));
  return "Teste";
}

void main() async {
  print("Iniciando operação com limite de 3 segundos...");

  try {
    // Se a função demorar mais que 3 segundos, o .timeout interrompe
    final resultado = await funcao().timeout(Duration(seconds: 3));
    print(resultado);
  } on TimeoutException {
    // Cai aqui se o tempo limite for atingido
    print('Erro: A operação demorou muito e foi cancelada!');
  } catch (e) {
    // Cai aqui para outros erros genéricos
    print('Ocorreu um erro inesperado: $e');
  }
}