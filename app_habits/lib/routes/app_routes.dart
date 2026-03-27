import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/register_habit.dart';
import '../screens/habit_details_screen.dart';
import '../models/habito.dart';

class AppRoutes {
  // strings das rotas
  static const habitos = '/';
  static const cadastro = '/cadastro';
  static const detalhes = '/detalhes';

  // Mapa de rotas
  static Map<String, WidgetBuilder> routes = {
    habitos: (_) => const ListaHabitos(),
    cadastro: (_) => const CadastroHabito(),
    
    detalhes: (context) {
      final habito = ModalRoute.of(context)!.settings.arguments as Habito;
      return DetalheHabito(habito: habito);
    },
  };
}