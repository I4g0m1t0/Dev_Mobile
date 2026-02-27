/*
Crie uma classe abstrata 'Veiculo' com um método abstrato 'acelerar()'.
Implemente duas classes concretas: 'Carro' e 'Moto', cada uma com sua
própria implementação de acelerar() que imprime uma mensagem diferente.
Crie uma lista de veículos e chame acelerar() para cada um.
*/

abstract class Veiculo {
  void acelerar();
}

class Carro extends Veiculo {
  @override
  void acelerar() {
    print("O carro está acelerando!");
  }
}

class Moto extends Veiculo {
  @override
  void acelerar() {
    print("A moto está acelerando rápido!");
  }
}

void main() {
  List<Veiculo> veiculos = [
    Carro(),
    Moto(),
    Carro(),
    Moto(),
  ];

  for (var v in veiculos) {
    v.acelerar();
  }
}

