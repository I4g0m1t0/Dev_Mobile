import 'package:flutter/material.dart';

class BrokenListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List.generate(200, (i) => i);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('RUIM — Column + Scroll + Imagens')),
        body: SingleChildScrollView(
          child: Column(
            children: items.map((i) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network('https://picsum.photos/800/600'),
                    SizedBox(height: 12),
                    Text('Item $i'),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}