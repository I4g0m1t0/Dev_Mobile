import 'package:flutter/material.dart';

class BrokenListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List.generate(200, (i) => i);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('List View')),
          body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Image.network('https://picsum.photos/800/600'),
                    SizedBox(height: 12),
                    Text('Item $index'),
                  ],
                );
              })),
    );
  }
}
