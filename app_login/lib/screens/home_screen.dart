import 'package:flutter/material.dart';
import '../models/livro.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Livro> livros = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      // Dados estáticos de livros
      livros = [
        Livro(
          titulo: 'Cristianismo puro e simples',
          autor: 'C. S. Lewis',
          imagem: 'https://thomasnelson.com.br/cdn/shop/files/9788578601577.jpg?v=1721832609',
        ),
        Livro(
          titulo: 'O Pequeno Príncipe',
          autor: 'Antoine De Saint Exupéry',
          imagem: 'https://a-static.mlcdn.com.br/%7Bw%7Dx%7Bh%7D/livro-o-pequeno-principe-antoine-de-saint-exupery/magazineluiza/230998500/64ef6a6aeefdbb47bd715d78ef21ca8e.png',
        ),
        Livro(
          titulo: 'O Alquimista',
          autor: 'Paulo Coelho',
          imagem: 'https://m.media-amazon.com/images/I/8179uX60WpL.jpg',
        ),
        Livro(
          titulo: 'Dom Casmurro',
          autor: 'Machado de Assis',
          imagem: 'https://m.media-amazon.com/images/I/81aY1SPhuUL.jpg',
        ),
        Livro(
          titulo: '1984',
          autor: 'George Orwell',
          imagem: 'https://m.media-amazon.com/images/I/91SZ869GvHL.jpg',
        ),
      ];
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Captura o nome passado pelo Navigator
    final String nomeUsuario =
        ModalRoute.of(context)?.settings.arguments as String? ?? "Leitor";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Estante'),
        centerTitle: true,
        elevation: 0,
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- MENSAGEM DE BOAS-VINDAS ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, $nomeUsuario!',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Estes são os livros na sua coleção:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // --- LISTA DE LIVROS ---
                Expanded(
                  child: livros.isEmpty
                      ? const Center(child: Text('A sua estante está vazia.'))
                      : ListView.builder(
                          itemCount: livros.length,
                          padding: const EdgeInsets.only(bottom: 20),
                          itemBuilder: (context, index) {
                            final item = livros[index];

                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    // Capa do Livro
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item.imagem,
                                        width: 70,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) =>
                                            const Icon(Icons.book, size: 70),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Informações do Livro
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.titulo,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Autor: ${item.autor}',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
