import 'package:flutter/material.dart';

void main() => runApp(const DashboardApp());

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Iago Rech Tramontin',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.white),
      home: const MediaQueryPage(),
    );
  }
}

class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget layoutEscolhido;
    
    if (screenWidth < 600) {
      // Mobile: Grid de 1 coluna (com childAspectRatio para não ficar gigante)
      layoutEscolhido = _buildGrid(columns: 1, ratio: 2.5);
    } else if (screenWidth < 900) {
      // Tablet: Grid de 2 colunas
      layoutEscolhido = _buildGrid(columns: 2, ratio: 1.0);
    } else {
      // Desktop: Grid de 4 colunas
      layoutEscolhido = _buildGrid(columns: 4, ratio: 1.0);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Iago Rech Tramontin')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: layoutEscolhido,
      ),
    );
  }

  // Função auxiliar para gerar o GridView limpo
  Widget _buildGrid({required int columns, required double ratio}) {
    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: ratio,
      // Gera os 8 cards passando o índice de 0 a 7
      children: List.generate(8, (i) => DashboardCard(index: i)),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final int index;

  const DashboardCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final titulos = ['Vendas', 'Receita', 'Clientes', 'Conversão', 'Visitas', 'Metas', 'Alertas', 'Ajustes'];
    final valores = ['1.234', 'R\$ 5.000', '850', '3.5%', '10k', '80%', '3', '15'];
    final icones = [Icons.shopping_cart, Icons.attach_money, Icons.person, Icons.trending_up, Icons.visibility, Icons.flag, Icons.warning, Icons.settings];
    final cores = [Colors.blue, Colors.green, Colors.purple, Colors.orange, Colors.teal, Colors.indigo, Colors.red, Colors.blueGrey];

    return Card(
      elevation: 2,
      color: cores[index],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icones[index], color: Colors.white, size: 28),
            
            // O Expanded vai ocupar todo o espaço vazio do meio, empurrando os textos lá pra baixo
            Expanded(
              child: Container(), 
            ),

            Text(
              titulos[index],
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              valores[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}