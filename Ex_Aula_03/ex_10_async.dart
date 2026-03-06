/*
Simule eventos de usuário (cliques, scrolls, inputs) usando um Stream. Crie 
uma função que emite eventos aleatórios a cada 500ms. Implemente 
debounce (aguardar 1 segundo de inatividade) usando Stream.periodic e 
lógica customizada para processar apenas o último evento.
Avançado
*/

import 'dart:async';
import 'dart:math';

void main() {
  final controller = StreamController<String>();
  Timer? debounceTimer;

  // 1. Ouvinte que aplica a lógica de Debounce
  controller.stream.listen((evento) {
    // Reinicia o cronômetro a cada novo evento
    debounceTimer?.cancel();

    debounceTimer = Timer(Duration(seconds: 1), () {
      print('>>> Processando último evento após inatividade: $evento');
    });
  });

  // 2. Simulação de eventos aleatórios
  int cliques = 0;
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    cliques++;
    final eventos = ['Clique', 'Scroll', 'Input'];
    final acao = eventos[Random().nextInt(eventos.length)];

    print('Evento detectado: $acao $cliques');

    controller.sink.add('$acao $cliques');

    if (cliques >= 10) {
      timer.cancel();
      // Não fechamos o controller imediatamente para dar tempo ao último debounce
      Future.delayed(Duration(seconds: 2), () => controller.close());
    }
  });
}
