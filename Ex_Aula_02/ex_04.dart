/*
Crie duas versões de uma função que calcula a área de um retângulo: uma
tradicional com corpo {} e outra usando arrow function (=>). Ambas devem
receber largura e altura como parâmetros e retornar a área. Teste com
valores 5 e 10.
*/
double calcularArea(double largura, double altura) {
  return largura * altura;
}

double calcularAreaArrow(double l, double h) => l * h;

void main() {
  print(calcularArea(2, 3));
  print(calcularAreaArrow(2, 3));
}
