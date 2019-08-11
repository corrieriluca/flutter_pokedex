import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/pokemon.dart';
import 'pokedexview.dart';

class FavouritesView extends StatefulWidget {
  @override
  createState() => FavouritesViewState();
}

class FavouritesViewState extends State<FavouritesView>
    with AutomaticKeepAliveClientMixin<FavouritesView> {
  static var favouritePokemons = <Pokemon>[];

  /// Gets the IDs of the Pokemons marked as favourites from the
  /// SharedPreferences and creates the list of favourite Pokemons objects
  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final favouritesID = prefs.getStringList("fav") ?? <String>[];
    if (mounted) {
      setState(() {
        favouritePokemons = List.generate(favouritesID.length, (i) {
          return PokedexViewState.pokemons.firstWhere((Pokemon poke) {
            return poke.pokedexID == int.parse(favouritesID[i]);
          });
        });
      });
    }
  }

  /// Adds this Pokemon to the list of favourites (called by the favourite
  /// button in the Pokedex Entry View)
  static void addFavourite(Pokemon poke) async {
    if (!isFavourite(poke)) {
      favouritePokemons.add(poke);

      final prefs = await SharedPreferences.getInstance();
      var favouritesID = prefs.getStringList("fav") ?? <String>[];
      favouritesID.add(poke.pokedexID.toString());
      prefs.setStringList("fav", favouritesID);
    }
  }
  
  /// Removes this pokemon from the favourite list (and from the shared
  /// preferences)
  static void removeFav(Pokemon poke) async {
    if (isFavourite(poke)) {
      favouritePokemons.remove(poke);

      final prefs = await SharedPreferences.getInstance();
      var favouritesID = prefs.getStringList("fav") ?? <String>[];
      favouritesID.remove(poke.pokedexID.toString());
      prefs.setStringList("fav", favouritesID);
    }
  }

  /// Checks is this Pokemon is a favourite (for favourite button in Pokedex
  /// Entry View)
  static bool isFavourite(Pokemon poke) => favouritePokemons.contains(poke);

  /// For keeping alive this state even if it is not the current tab
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// ItemBuilder for the ListView widget in the `build` method below.
  /// Creates a PokemonTile widget for each Pokemon.
  Widget _buildRow(int i) {
    final Pokemon current = favouritePokemons[i];
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: PokemonTile(pokemon: current),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // needed by AutomaticKeepAliveClientMixin
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int pos) {
          if (pos.isOdd) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Divider(),
            );
          }

          final index = pos ~/ 2;
          return _buildRow(index);
        }, childCount: favouritePokemons.length * 2),
      ),
    ]);
  }
}
