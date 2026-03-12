import 'dart:io';
import 'dart:convert';

// Função geradora de Stream que lê do socket
Stream<String> lerDoSocket(Socket socket) async* {
  await for (final chunk in socket.cast<List<int>>().transform(utf8.decoder)) {
    yield chunk.trim();
  }
}

// Função geradora de Stream que lê do stdin
Stream<String> lerDoStdin() async* {
  await for (final linha in stdin.transform(utf8.decoder)) {
    yield linha;
  }
}

void main() async {
  try {
    final socket = await Socket.connect(InternetAddress.loopbackIPv4, 3000);
    print('Conectado ao servidor! Pode começar a digitar.');
    print('--------------------------------------------------');

    // Escuta mensagens do servidor via stream
    lerDoSocket(socket).listen(
      (mensagem) => print('Servidor diz: $mensagem'),
      onError: (e) {
        print('Erro: $e');
        socket.destroy();
      },
      onDone: () {
        print('Servidor encerrou a conexão.');
        socket.destroy();
        exit(0);
      },
    );

    // Envia input do usuário ao servidor via stream
    await for (final input in lerDoStdin()) {
      socket.write(input);
    }
  } catch (e) {
    print('Não foi possível conectar: $e');
  }
}
