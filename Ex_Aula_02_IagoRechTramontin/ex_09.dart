Map<int, String> produtos = {
  1: 'Camiseta',
  2: 'Calça',
  3: 'Tênis',
  4: 'Boné',
  5: 'Óculos',
};

bool buscar({required Map lista, required int chave}) {
  if (lista.containsKey(chave)) {
    print('Tem');
    return true;
  } else {
    print('Não Tem');
    return false;
  }
}

void listar({required Map lista}) {
  lista.forEach((i, valor) => print('$i: $valor'));
}

void remover({required Map lista, required int codigo}) {
  lista.remove(codigo);
}
void main() {
  print('============================');
  buscar(lista: produtos, chave: 1);
  buscar(lista: produtos, chave: 6);
  print('============================');
  listar(lista: produtos);
  remover(lista: produtos, codigo: 3);
  print('============================');
  listar(lista: produtos);
}

//  Map<int, String> produtos = {}; e os métodos .containsKey(), .remove(), .forEach()
