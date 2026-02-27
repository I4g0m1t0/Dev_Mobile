/*
Estenda a classe 'Produto' do exercício anterior adicionando dois
construtores nomeados: (1) 'Produto.semEstoque()' que cria um produto
com estoque zero, (2) 'Produto.promocao()' que cria um produto com
desconto de 20% no preço. Teste ambos.
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

class Produtao extends Produto {
  Produtao.semEstoque(String nome, double preco) : super(nome, preco, 0);

  Produtao.promocao(String nome, double preco, int estoque)
    : super(nome, preco * 0.8, estoque);
}

void main() {
  var p1 = Produtao.semEstoque('Camiseta', 50.0);
  var p2 = Produtao.promocao('Boné', 30.0, 1);

  p1.exibirInfo();
  p2.exibirInfo();
}
