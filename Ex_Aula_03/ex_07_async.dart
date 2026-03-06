/*
Use StreamController para simular um chat. Crie um controller, adicione 5 
mensagens com intervalos de 1 segundo, e use listen() para imprimir cada 
mensagem. Não esqueça de fechar o controller ao final.
*/

import 'dart:async';

// 1. Criamos o controlador (geralmente tipado, ex: <int> ou <String>)
final streamController = StreamController<String>(
  onPause: () => print('Fluxo Pausado'),
  onResume: () => print('Fluxo Retomado'),
  onCancel: () => print('Ouvinte Cancelado'),
  onListen: () => print('Alguém começou a ouvir!'),
);

void main() async {
  // 2. Configuramos o que fazer com os dados que chegarem
  final subscription = streamController.stream.listen(
    (event) => print('Evento recebido: $event'),
    onDone: () => print('Stream finalizada (Done)'),
    onError: (error) => print('Erro na stream: $error'),
  );

  // 3. Enviando dados manualmente para a stream
  streamController.sink.add("Primeira mensagem");
  
  await Future.delayed(Duration(seconds: 1));
  streamController.sink.add("Segunda mensagem após 1s");

  // 4. Simulando um erro
  streamController.addError("Opa, algo deu errado!");

  // 5. IMPORTANTE: Sempre feche o controller para evitar vazamento de memória (memory leak)
  await Future.delayed(Duration(seconds: 1));
  print("Fechando controlador...");
  await streamController.close();
}