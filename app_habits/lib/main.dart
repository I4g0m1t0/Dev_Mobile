import 'package:flutter/material.dart';
import 'routes/app_routes.dart'; // Ajuste o caminho conforme sua pasta

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hábitos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
          // ···
          brightness: Brightness.dark,
        ),
      ),
      // Usando as rotas nomeadas aqui:
      initialRoute: AppRoutes.habitos,
      routes: AppRoutes.routes,
    );
  }
}