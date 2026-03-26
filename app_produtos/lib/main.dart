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
      title: 'Produtos',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // Usando as rotas nomeadas aqui:
      initialRoute: AppRoutes.produtos,
      routes: AppRoutes.routes,
    );
  }
}