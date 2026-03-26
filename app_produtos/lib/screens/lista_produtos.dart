// lib/screens/lista_produtos.dart
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../routes/app_routes.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  // Lista que vai armazenar os produtos criados
  List<Produto> produtos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(produto.nome),
            subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
            onTap: () {
              // NAVEGAÇÃO 1: Vai para a página de Detalhes
              Navigator.pushNamed(
                context, 
                AppRoutes.detalhes, 
                arguments: produto,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // NAVEGAÇÃO 2: Vai para a página de Cadastro e aguarda (await) o retorno
          final produtoRetornado = await Navigator.pushNamed(
            context, 
            AppRoutes.cadastro,
          );
          
          // Se o utilizador guardou um produto (não cancelou a ação) e é do tipo Produto:
          if (produtoRetornado != null && produtoRetornado is Produto) {
            // Atualiza o ecrã para mostrar o novo item na lista
            setState(() {
              produtos.add(produtoRetornado);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}