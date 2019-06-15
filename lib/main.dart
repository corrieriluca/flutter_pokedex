import 'package:flutter/material.dart';

void main() => runApp(PokedexApp());

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      home: Scaffold(
        appBar: AppBar(
          title: new Text('Pokédex'),
        ),
        body: Center(
          child: Text('Hello, World !'),
        ),
      ),
    );
  }
}
