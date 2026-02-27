/*
Crie uma classe 'ContaBancaria' com atributos: titular (String), saldo
(double). Adicione métodos: depositar(valor) e sacar(valor). Crie uma classe
'ContaPoupanca' que herda de ContaBancaria e adiciona um método
'aplicarRendimento(taxa)' que aumenta o saldo pela taxa informada.
*/

class ContaBancaria {
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    this.saldo += valor;
  }

  void sacar(double valor) {
    this.saldo -= valor;
  }

  void exrato() {
    print(this.saldo);
  }
}

class ContaPoupanca extends ContaBancaria {
  ContaPoupanca(String titular, double saldo) : super(titular, saldo);
  void aplicarRendimento(double taxa) {
    saldo += saldo * taxa;
  }
}

void main() {
  var c1 = ContaPoupanca('Iago', 0);
  c1.exrato();
  c1.depositar(10);
  c1.exrato();
  c1.sacar(5);
  c1.exrato();
  c1.aplicarRendimento(20);
  c1.exrato();
}
