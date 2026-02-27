
const pi = 3.14159; 
final dataAtual = DateTime.now();

void main() {
  // pi = 3.14; // Erro: Não é possível atribuir um valor a uma constante
  // dataAtual = DateTime(2022, 1, 1); // Erro  
}

/*
ex_02.dart:6:3: Error: Setter not found: 'pi'.
  pi = 3.14; // Erro: Não é possível atribuir um valor a uma constante
  ^^
ex_02.dart:7:3: Error: Setter not found: 'dataAtual'.
  dataAtual = DateTime(2022, 1, 1); // Erro  
  ^^^^^^^^^
*/