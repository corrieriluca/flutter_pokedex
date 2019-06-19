import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokemon.dart';
import 'package:flutter_pokedex/pokemontype.dart';
import "package:http/http.dart" as http;

class PokedexView extends StatefulWidget {
  @override
  createState() => PokedexViewState();
}

class PokedexViewState extends State<PokedexView>
    with AutomaticKeepAliveClientMixin<PokedexView> {
  var _pokemons = <Pokemon>[];
  final int _pokeNumber = 20;

  /// For keeping alive this state even if it is not the current tab
  @override
  bool get wantKeepAlive => true;

  /// Loads the data from the PokeAPI
  _loadData() async {
    for (int i = 1; i <= _pokeNumber; i++) {
      String pokeURL = "https://pokeapi.co/api/v2/pokemon/$i/";
      http.Response response = await http.get(pokeURL);
      final pokemonJSON = await jsonDecode(response.body);
      final Pokemon pokemon = Pokemon.fromJson(pokemonJSON);
      if (mounted) {
        setState(() {
          _pokemons.add(pokemon);
        });
      }
    }
  }

  /// Called at the starting of the app (when the widget is loaded in the tree)
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// ItemBuilder for the ListView widget in the `build` method below.
  /// Calls `getListTile()` for each Pokemon.
  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: _pokemons[i].getListTile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //needed by AutomaticKeepAliveClientMixin
    return ListView.builder(
      itemCount: _pokemons.length * 2,
      itemBuilder: (BuildContext context, int pos) {
        if (pos.isOdd) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Divider(),
          );
        }

        final index = pos ~/ 2;
        return _buildRow(index);
      },
    );
  }
}
