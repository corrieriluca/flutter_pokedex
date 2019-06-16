import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokedexview.dart';
import 'favouritesview.dart';

void main() => runApp(PokedexApp());

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        primaryColor: Colors.red.shade800,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 2,
        child: MainView(),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  void _searchPokemon() {}

  void _settings() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pokédex'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _searchPokemon,
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: _settings,
            ),
          ],
          bottom: TabBar(
            isScrollable: false,
            tabs: <Tab>[
              Tab(text: 'POKÉMON'),
              Tab(text: 'FAVOURITES'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PokedexView(),
            FavouritesView(),
          ],
        ));
  }
}