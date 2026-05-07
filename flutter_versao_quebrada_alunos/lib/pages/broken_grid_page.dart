import 'package:flutter/material.dart';

class BrokenGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List.generate(200, (i) => i);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('RUIM — GridView(children)')),
        body: GridView.count(
          crossAxisCount: 2,
          children: items.map((i) {
            return Container(
              margin: EdgeInsets.all(8),
              color: Colors.pinkAccent,
              child: Column(
                children: [
                  Expanded(child: Image.network('https://picsum.photos/800/600')),
                  Text('Item $i'),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}