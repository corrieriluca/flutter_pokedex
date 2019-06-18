import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'settingsview.dart';
import 'pokedexview.dart';
import 'favouritesview.dart';

void main() => runApp(PokedexApp());

class PokedexApp extends StatelessWidget {
  static final ThemeData defaultTheme = ThemeData(
    primaryColor: Colors.red.shade800,
    accentColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: defaultTheme,
      home: DefaultTabController(
        length: 2,
        child: MainView(),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  void _searchPokemon() {}

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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsView()));
              },
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
