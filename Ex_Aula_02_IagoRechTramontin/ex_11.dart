/*
Crie uma classe 'Produto' com os atributos: nome (String), preco (double) e
estoque (int). Implemente um construtor e um método 'exibirInfo()' que
imprime todas as informações do produto formatadas. Crie 3 objetos e
exiba suas informações.
*/

class Produto {
  String nome;
  double preco;
  int estoque;

  Produto(this.nome, this.preco, this.estoque);

  void exibirInfo() {
    print('Produto: $nome | R\$ $preco | Estoque: $estoque');
  }
}

var p1 = Produto('Teste', 10, 25);
var p2 = Produto('Tijolo', 30, 100);
var p3 = Produto('Cimento', 120, 50);

void main() {
  p1.exibirInfo();
  p2.exibirInfo();
  p3.exibirInfo();
}
