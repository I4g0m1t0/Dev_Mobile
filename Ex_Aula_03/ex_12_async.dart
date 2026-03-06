/*
Crie um sistema completo que: 
(1) autentica o usuário (Future), 
(2) busca dados de múltiplas fontes em paralelo (Future.wait),
(3) escuta atualizações em tempo real via Stream, 
(4) usa null safety para lidar com dados opcionais. Implemente tratamento 
de erros robusto em todas as etapas.
*/

import 'dart:async';

// 1. Autenticação (Future)
Future<String?> autenticar(String user, String pass) async {
  await Future.delayed(Duration(seconds: 1));
  if (user == "admin" && pass == "123") return "token_valido";
  throw Exception("Falha na autenticação!");
}

// 2. Busca em Paralelo (Future.wait)
Future<List<String>> buscarDados(String token) async {
  if (token.isEmpty) throw Exception("Token vazio!");

  // Dispara as duas ao mesmo tempo
  return await Future.wait([
    Future.delayed(Duration(seconds: 2), () => "Saldo: R\$ 500,00"),
    Future.delayed(Duration(seconds: 2), () => "Notificações: 3 novas"),
  ]);
}

// 3. Atualizações em Tempo Real (Stream)
Stream<String> ouvirLogs() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield "Log do sistema #$i";
  }
}

void main() async {
  print("--- SISTEMA INICIADO ---");

  try {
    // Passo 1: Autenticar (usando Null Safety)
    String? token = await autenticar("admin", "123");

    // O operador '!' diz: "Eu sei que o token não é nulo aqui"
    print("Login realizado. Token: ${token!}");

    // Passo 2: Buscar dados em paralelo
    print("Buscando dados das fontes...");
    var dados = await buscarDados(token);
    print("Dados carregados: $dados");

    // Passo 3: Escutar a Stream (ouvinte)
    print("Iniciando monitoramento...");
    await for (var log in ouvirLogs()) {
      print(">>> $log");
    }
  } catch (e) {
    // Tratamento de erro que pega qualquer falha no caminho
    print("ERRO NO SISTEMA: $e");
  } finally {
    print("--- SISTEMA ENCERRADO ---");
  }
}
