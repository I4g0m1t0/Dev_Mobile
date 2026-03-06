/*
Crie um Stream que emite números de 1 a 20. Use .where() para filtrar 
apenas números pares, .map() para multiplicar cada um por 2, e .take() 
para pegar apenas os 5 primeiros resultados. Imprima o resultado final.
*/

Stream<int> numerosStream() async* {
  for (int i = 1; i <= 20; i++) {
    // Simula um fluxo de dados chegando aos poucos
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

void main() {
  print("Processando Stream...");

  numerosStream()
      .where((n) => n % 2 == 0) 
      .map((n) => n * 2)       
      .take(5)                 
      .listen((n) => print("$n"));
}