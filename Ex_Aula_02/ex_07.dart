/*
Crie uma lista de números inteiros de 1 a 10. Adicione o número 11 ao final.
Remova o número 5. Exiba o tamanho da lista, o primeiro e o último
elemento. Por fim, use forEach para imprimir todos os elementos.
*/

List<int> nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
void main() {
  nums.add(11);
  nums.remove(5);

  print('Tamanho da lista: ${nums.length}');
  print('Primeiro elemento: ${nums.first}');  
  print('Último elemento: ${nums.last}');
  nums.forEach((num) => print(num));
}
