/*
Crie dois Sets de números: A = {1, 2, 3, 4, 5} e B = {4, 5, 6, 7, 8}. Calcule e
imprima: (1) a união dos conjuntos, (2) a interseção, (3) a diferença (A - B),
(4) verifique se 3 está no conjunto A.
*/

var a = {1, 2, 3, 4, 5};
var b = {4, 5, 6, 7, 8};

void main() {
  print(a.union(b)); // União
  print(a.intersection(b)); // Interseção
  print(a.difference(b)); // Diferença
  print(a.contains(3));
}
