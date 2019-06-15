import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(PokedexApp());

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        primaryColor: Colors.red.shade800,
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

class PokedexView extends StatefulWidget {
  @override
  createState() => PokedexViewState();
}

class PokedexViewState extends State<PokedexView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pokédex View here...'),
    );
  }
}

class FavouritesView extends StatefulWidget {
  @override
  createState() => FavouritesViewState();
}

class FavouritesViewState extends State<FavouritesView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favourites Viex here...'),
    );
  }
}
