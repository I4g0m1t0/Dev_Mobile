import 'dart:io';
import 'dart:convert';

void main() async {
  final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 3000);
  print(
    'Servidor aguardando conexões em ${server.address.address}:${server.port}...',
  );

  server.listen((Socket client) {
    print(
      'Cliente conectado de: ${client.remoteAddress.address}:${client.remotePort}',
    );
    print('--------------------------------------------------');

    // SOLUÇÃO AQUI: Adicionado o .cast<List<int>>() antes do transform
    client
        .cast<List<int>>()
        .transform(utf8.decoder)
        .listen(
          (String data) {
            print('Cliente diz: ${data.trim()}');
          },
          onError: (error) {
            print('Erro na conexão com o cliente: $error');
            client.close();
          },
          onDone: () {
            print('Cliente desconectado.');
            client.close();
          },
        );

    // stdin continua igual, pois ele já é Stream<List<int>> por padrão
    stdin.transform(utf8.decoder).listen((String input) {
      client.write(input);
    });
  });
}
