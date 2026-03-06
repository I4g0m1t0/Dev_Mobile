/*Crie uma função buscarUsuario() que retorna um Future<String>. Use 
Future.delayed para simular um atraso de 2 segundos e retorne um nome 
de usuário. Na função main(), chame buscarUsuario() usando .then() e 
imprima o resultado.*/


// Função que simula a busca de um usuário de forma assíncrona
Future<String> buscarUsuario() {
  return Future.delayed(Duration(seconds: 2), () {
    return "Lucas Silva"; // O valor que será retornado após o atraso
  });
}

void main() {
  print("Iniciando busca...");

  // Chamando a função e tratando o resultado com .then()
  buscarUsuario().then((nome) {
    print("Usuário encontrado: $nome");
  });

  print("Processando outras tarefas enquanto o usuário não chega...");
}