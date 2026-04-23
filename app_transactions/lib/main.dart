import 'package:flutter/material.dart';

void main() {
  runApp(const LivrariaApp());
}

// Modelo simples de Livro
class Livro {
  final String titulo;
  final String autor;
  final String caminhoImagem;
  final String status;

  const Livro({
    required this.titulo,
    required this.autor,
    required this.caminhoImagem,
    required this.status,
  });
}

// Dados para a lista
const List<Livro> meusLivros = [
  Livro(
    titulo: 'O Alquimista',
    autor: 'Paulo Coelho',
    caminhoImagem: '../assets/images/livro1.jpg',
    status: 'Lido',
  ),
  Livro(
    titulo: 'Dom Casmurro',
    autor: 'Machado de Assis',
    caminhoImagem: '../assets/images/livro2.jpg',
    status: 'Lendo',
  ),
  Livro(
    titulo: '1984',
    autor: 'George Orwell',
    caminhoImagem: '../assets/images/livro3.jpg',
    status: 'Quero Ler',
  ),
  Livro(
    titulo: 'O Pequeno Príncipe',
    autor: 'Saint-Exupéry',
    caminhoImagem: '../assets/images/livro4.jpg',
    status: 'Lido',
  ),
];

// 4. MATERIAL DESIGN 3
class LivrariaApp extends StatelessWidget {
  const LivrariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const LivrosScreen(),
    );
  }
}

// 5. WIDGET CUSTOMIZADO REUTILIZÁVEL
class StatusBadge extends StatelessWidget {
  final String texto;
  const StatusBadge({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(texto, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}

class LivrosScreen extends StatefulWidget {
  const LivrosScreen({super.key});

  @override
  State<LivrosScreen> createState() => _LivrosScreenState();
}

class _LivrosScreenState extends State<LivrosScreen> with SingleTickerProviderStateMixin {
  // Animação Implícita (Estado)
  bool _isGrid = false;

  // Animação Explícita
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Estante'),
        actions: [
          // ANIMAÇÃO EXPLÍCITA: Ícone pulsante
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) => Transform.scale(
              scale: _pulseAnimation.value,
              child: child,
            ),
            child: const Icon(Icons.favorite, color: Colors.red),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        itemCount: meusLivros.length,
        itemBuilder: (context, index) {
          final livro = meusLivros[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              // HERO ANIMATION (Origem)
              leading: Hero(
                tag: 'capa_${livro.titulo}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset( // Mudou de network para asset
                    livro.caminhoImagem,
                    width: 50,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(livro.titulo),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(livro.autor),
                  const SizedBox(height: 4),
                  // Uso do widget customizado
                  StatusBadge(texto: livro.status),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetalheLivroScreen(livro: livro)),
              ),
            ),
          );
        },
      ),
      // ANIMAÇÃO IMPLÍCITA: Botão que muda de forma e cor
      floatingActionButton: GestureDetector(
        onTap: () => setState(() => _isGrid = !_isGrid),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isGrid ? Colors.orange : Colors.brown,
            borderRadius: BorderRadius.circular(_isGrid ? 12 : 30),
          ),
          child: Icon(
            _isGrid ? Icons.grid_view : Icons.list,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DetalheLivroScreen extends StatelessWidget {
  final Livro livro;
  const DetalheLivroScreen({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(livro.titulo)),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // HERO ANIMATION (Destino)
            Hero(
              tag: 'capa_${livro.titulo}',
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset( // Mudou de network para asset
                    livro.caminhoImagem,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(livro.titulo, style: Theme.of(context).textTheme.headlineMedium),
            Text(livro.autor, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            // Reuso do widget customizado
            StatusBadge(texto: livro.status),
            const Spacer(),
            // Componente Material 3
            Padding(
              padding: const EdgeInsets.all(24),
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check),
                label: const Text('Marcar como Lido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
