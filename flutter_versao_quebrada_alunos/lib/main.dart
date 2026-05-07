import 'package:flutter/material.dart';
import 'pages/broken_list_page.dart';
import 'pages/broken_grid_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 20)),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Versão Consertada 🫡')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => counter++),
          child: Icon(Icons.refresh),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Lista'),
              onTap: () => runApp(BrokenListPage()),
            ),
            ListTile(
              title: Text('Grid'),
              onTap: () => runApp(BrokenGridPage()),
            ),
          ],
        ),
      ),
    );
  }
}