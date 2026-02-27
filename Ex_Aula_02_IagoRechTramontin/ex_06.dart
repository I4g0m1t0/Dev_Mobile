double executarOperacao(double a, double b, Function operacao) {
  return operacao(a, b);
}

double somar(a, b) {
  return a + b;
}

double multpl(a, b) {
  return a * b;
}

void main() {
  print(executarOperacao(1, 2, somar));
  print(executarOperacao(1, 2, multpl));
}
