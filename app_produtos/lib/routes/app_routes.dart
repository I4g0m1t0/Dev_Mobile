import 'package:flutter/material.dart';
import '../screens/lista_produtos.dart';
import '../screens/cadastro_produto.dart';
import '../screens/detalhe_produto.dart';
import '../models/produto.dart';

class AppRoutes {
  // strings das rotas
  static const produtos = '/';
  static const cadastro = '/cadastro';
  static const detalhes = '/detalhes';

  // Mapa de rotas
  static Map<String, WidgetBuilder> routes = {
    produtos: (_) => const ListaProdutos(),
    cadastro: (_) => const CadastroProduto(),
    
    detalhes: (context) {
      final produto = ModalRoute.of(context)!.settings.arguments as Produto;
      return DetalheProduto(produto: produto);
    },
  };
}