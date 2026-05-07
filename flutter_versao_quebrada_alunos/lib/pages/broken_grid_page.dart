import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BrokenGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const int itemCount = 200;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Grid View + Cache')),
        body: GridView.builder(
          itemCount: itemCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Container(
              color: Colors.pinkAccent,
              child: Column(
                children: [
                  Expanded(
                    // Substituímos o Image.network pelo CachedNetworkImage
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/800/600?random=$index',
                      // Mostra um indicador enquanto a imagem baixa pela primeira vez
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      // Mostra um ícone de erro caso falhe o download
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Item $index',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
