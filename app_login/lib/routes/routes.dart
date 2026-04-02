import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/cadastro_screen.dart';
import '../screens/login_screen.dart';
import '../models/user.dart';

class AppRoutes {
  // strings das rotas
  static const login = '/';
  static const cadastro = '/register';
  static const home = '/home';

  // Mapa de rotas
  static Map<String, WidgetBuilder> routes = {
    cadastro: (_) => const CadastroUser(),
    login: (_) => const LoginUser(),
    home: (_) => const Home()
  };
}