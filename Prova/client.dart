import 'dart:io';
import 'dart:convert';

void main() async {
  try {
    final socket = await Socket.connect(InternetAddress.loopbackIPv4, 3000);
    print('Conectado ao servidor! Pode começar a digitar.');
    print('--------------------------------------------------');

    // SOLUÇÃO AQUI: Adicionado o .cast<List<int>>() antes do transform
    socket
        .cast<List<int>>()
        .transform(utf8.decoder)
        .listen(
          (String data) {
            print('Servidor diz: ${data.trim()}');
          },
          onError: (error) {
            print('Erro na conexão: $error');
            socket.destroy();
          },
          onDone: () {
            print('Servidor encerrou a conexão.');
            socket.destroy();
            exit(0);
          },
        );

    // stdin continua igual
    stdin.transform(utf8.decoder).listen((String input) {
      socket.write(input);
    });
  } catch (e) {
    print('Não foi possível conectar ao servidor: $e');
  }
}
