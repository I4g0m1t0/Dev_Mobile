/*
Crie uma lista de nomes de frutas (no mínimo 6). Use o método .where()
para filtrar apenas as frutas que começam com a letra 'M'. Converta o
resultado para uma lista e imprima. Depois, use .map() para criar uma nova
lista com os nomes em MAIÚSCULAS.
*/

void main() {
  List<String> frutas = ['Maçã', 'Morango', 'Melancia', 'Banana', 'Mirtilo', 'Laranja'];
  
  // Filtra frutas que começam com 'M'
  List<String> frutasComM = frutas.where((fruta) => fruta.startsWith('M')).toList();
  print('Frutas com M: $frutasComM');
  
  // Converte para maiúsculas
  List<String> frutasEmMaiusculas = frutas.map((fruta) => fruta.toUpperCase()).toList();
  print('Frutas em maiúsculas: $frutasEmMaiusculas');
}