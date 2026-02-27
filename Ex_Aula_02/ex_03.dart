/*
Crie uma String contendo o número '42'. Converta-a para int e double.
Depois, crie um int com valor 100 e converta-o para String. Imprima todos
os resultados mostrando os tipos antes e depois da conversão.
*/

String numero = '42';
int valor = 100;

void main() {
  print('Numero $numero ${numero.runtimeType}');
  var numeroInt = int.parse(numero);
  print('Numero $numeroInt ${numeroInt.runtimeType}');
  var numeroDouble = double.parse(numero);
  print('Numero $numeroDouble ${numeroDouble.runtimeType}');
 
  print('Numero $valor ${valor.runtimeType}');
  var valorStr = valor.toString();
  print('Numero $valorStr ${valorStr.runtimeType}');
}
