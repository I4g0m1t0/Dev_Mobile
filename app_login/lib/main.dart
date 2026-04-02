import 'package:flutter/material.dart';
import 'routes/routes.dart'; // Ajuste o caminho conforme sua pasta

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loginzao do Iago',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          // ···
          brightness: Brightness.dark,
        ),
      ),
      // Usando as rotas nomeadas aqui:
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}