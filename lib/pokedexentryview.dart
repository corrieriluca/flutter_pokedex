import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/tools.dart';
import 'pokemon.dart';
import 'pokemontype.dart';
import "package:http/http.dart" as http;

class PokedexEntryView extends StatelessWidget {
  final Pokemon pokemon;

  PokedexEntryView({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _debugFavourite = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(Tools.capitalizeFirst(pokemon.name)),
      ),
      body: Center(
        child: Hero(
          tag: '${pokemon.name}_sprite',
          child: Image.network(
            pokemon.spriteURL,
          ),
        ),
      ),
      floatingActionButton: FavouriteButton(),
    );
  }
}

class FavouriteButton extends StatefulWidget {
  @override
  createState() => FavouriteState();
}

class FavouriteState extends State<FavouriteButton> {
  bool _debugFavourite = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red.shade700,
      child: Icon(_debugFavourite ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        setState(() {
          _debugFavourite = !_debugFavourite;
        });
      },
    );
  }
}
