import 'package:flutter/material.dart';

// Importe EXATAMENTE os arquivos que criamos na pasta screens
import '../screens/lista_produtos.dart';
import '../screens/cadastro_produto.dart';
import '../screens/detalhe_produto.dart';
import '../models/produto.dart'; // Precisamos importar o modelo para a rota de detalhes

class AppRoutes {
  // Definindo as strings das rotas
  static const produtos = '/';
  static const cadastro = '/cadastro';
  static const detalhes = '/detalhes';
  // static const carrinho = '/carrinho'; // Deixei comentado até criarmos a tela!

  // Mapa de rotas
  static Map<String, WidgetBuilder> routes = {
    produtos: (_) => const ListaProdutos(),
    cadastro: (_) => const CadastroProduto(),
    
    // Na rota de detalhes, precisamos extrair o "produto" que foi passado na navegação
    detalhes: (context) {
      final produto = ModalRoute.of(context)!.settings.arguments as Produto;
      return DetalheProduto(produto: produto);
    },
  };
}