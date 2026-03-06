/*
Crie 3 funções assíncronas: autenticar() que retorna um token, 
buscarPerfil(token) que retorna dados do usuário, e buscarPedidos(userId) 
que retorna uma lista de pedidos. Execute-as em sequência usando 
async/await, onde cada uma depende do resultado da anterior.
*/
Future<String> autenticar() async {
  return "123456";
}

Future<String> buscarPerfil(token) async {
  if (token == '123456') {
    return '1';
  } else {
    throw Exception("Token inválido");
  }
}

Future<List<String>> buscarPedidos(userId) async {
  if (userId == "1") {
    return ["Pizza", "Refrigerante", "Sorvete"];
  } else {
    throw Exception("Usuário não encontrado!");
  }
}

void main() async {
  print("Iniciando busca...");

  try {
    String cToken = await autenticar();
    print("Autenticado: $cToken");

    String cUserId = await buscarPerfil(cToken);
    print("Sucesso: $cUserId");

    List<String> aPedidos = await buscarPedidos(cUserId);
    print("Pedidos encontrados: $aPedidos");
  } catch (e) {
    // Se a função der 'throw', o erro cai direto aqui
    print("Erro capturado: $e");
  }

  print("Fim do processo.");
}
