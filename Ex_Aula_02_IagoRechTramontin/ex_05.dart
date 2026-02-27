/*
Crie uma função 'saudar' que recebe nome (obrigatório), titulo (opcional,
padrão 'Sr.') e mostrarHora (opcional, padrão false). Se mostrarHora for
true, inclua a hora atual na saudação. Use parâmetros nomeados.
*/
void saudacao({required String nome, String titulo = 'Sr.', bool mostrarHora = false}) {
  if (mostrarHora) {
    print('Olá $titulo $nome, agora são ${DateTime.now()}');
  } else {
    print('Olá $titulo $nome');
  }
}
void main() {
  saudacao(nome: 'Iago', mostrarHora: true);
  saudacao(nome: 'Iago');
}
