import 'dart:io';
import 'dart:convert';

// Reutilizável: lê qualquer Stream<List<int>> e emite Strings
Stream<String> lerStream(Stream<List<int>> fonte) async* {
  await for (final chunk in fonte.cast<List<int>>().transform(utf8.decoder)) {
    yield chunk.trim();
  }
}

void main() async {
  final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 3000);
  print('Servidor aguardando em ${server.address.address}:${server.port}...');

  await for (final client in server) {
    print(
      'Cliente conectado: ${client.remoteAddress.address}:${client.remotePort}',
    );
    print('--------------------------------------------------');

    // Escuta mensagens do cliente via stream
    lerStream(client).listen(
      (mensagem) => print('Cliente diz: $mensagem'),
      onError: (e) {
        print('Erro: $e');
        client.close();
      },
      onDone: () {
        print('Cliente desconectado.');
        client.close();
      },
    );

    // Envia input do servidor ao cliente via stream
    lerStream(stdin).listen((input) => client.write(input));
  }
}
