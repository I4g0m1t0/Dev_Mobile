/*
Crie três mixins: 'Voador' (método voar()), 'Nadador' (método nadar()) e
'Corredor' (método correr()).
Crie classes: 'Pato' (nada e voa), 'Golfinho' (nada) e 'Avestruz' (corre). Use
mixins para adicionar as capacidades. Crie objetos e teste todos os
métodos.
*/

mixin Nadador {
  void nadar() => print('Nadando...');
}

mixin Voador {
  void voar() => print('Voando...');
}

mixin Corredor {
  void correr() => print('Correndo...');
}

class Pato with Nadador, Voador {
  String nome;
  Pato(this.nome);
}

class Golfinho with Nadador {
  String nome;
  Golfinho(this.nome);
}

class Avestruz with Corredor {
  String nome;
  Avestruz(this.nome);
}

void main() {
  var pato = Pato('José');
  var golf = Golfinho('Rodolfo');
  var ave = Avestruz('XLR8');

  print('Pato ${pato.nome}:');
  pato.nadar();
  pato.voar();

  print('Golfinho ${golf.nome}:');
  golf.nadar();

  print('Avestruz ${ave.nome}:');
  ave.correr();
}