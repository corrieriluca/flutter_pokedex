import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../classes/pokemon.dart';

class PokedexView extends StatefulWidget {
  @override
  createState() => PokedexViewState();
}

class PokedexViewState extends State<PokedexView>
    with AutomaticKeepAliveClientMixin<PokedexView> {
  /*
  var _pokemons = <Pokemon>[];
  final int _pokeNumber = 20;

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
  */

  Database _db;
  bool _initialized = false;
  var _pokemons = <Pokemon>[];

  /// Copy the database from the assets to the device in order to access it later.
  _initializeDB() async {
    // Construct a file path to copy database to
    String path = join(await getDatabasesPath(), "pokemonDatabase.db");

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
          await rootBundle.load(join('assets', 'pokemonDatabase.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
  }

  _connectToDatabase() async {
    _initializeDB();
    String databasePath = join(await getDatabasesPath(), 'pokemonDatabase.db');
    this._db = await openDatabase(databasePath);
    this._initialized = true;
  }

  _loadData() async {
    if (!_initialized) await _connectToDatabase();
    final List<Map<String, dynamic>> pokemonMaps = await _db.query('POKEMONS');
    if (mounted) {
      setState(() {
        _pokemons = List.generate(pokemonMaps.length, (i) {
          return Pokemon.fromDB(pokemonMaps[i]);
        });
      });
    }
  }

  /// For keeping alive this state even if it is not the current tab
  @override
  bool get wantKeepAlive => true;

  /// Called at the starting of the app (when the widget is loaded in the tree)
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// ItemBuilder for the ListView widget in the `build` method below.
  /// Calls `getListTile()` for each Pokemon.
  Widget _buildRow(int i) {
    final Pokemon current = _pokemons[i];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PokemonTile(pokemon: current),
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
