class Habito {
  final String nome;
  final String descricao;
  final DateTime criadoEm;
  bool concluidoHoje;

  Habito({
    required this.nome,
    this.descricao = '',
    this.concluidoHoje = false,
  }) : criadoEm = DateTime.now();

  // Um método para alternar o status
  void alternarConclusao() {
    concluidoHoje = !concluidoHoje;
  }
}