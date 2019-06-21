import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../classes/pokemon.dart';

class PokedexEntryView extends StatelessWidget {
  final Pokemon pokemon;

  PokedexEntryView({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('${pokemon.name}'),
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                  margin: EdgeInsets.all(16.0),
                  elevation: 6.0,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                          tag: '${pokemon.name}_sprite',
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/pokemonSprites/${pokemon.pokedexID}.png',
                                fit: BoxFit.fill,
                              ))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('${pokemon.name}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600))),
                          Text(
                            'Height : ${pokemon.height}',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.grey.shade700),
                          ),
                          Text(
                            'Weight : ${pokemon.weight}',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.grey.shade700),
                          ),
                        ],
                      )
                    ],
                  )),
              Card(
                  margin: EdgeInsets.all(16.0),
                  elevation: 6.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('${pokemon.description}'),
                  ))
            ]),
          ),
        ],
      ),
      floatingActionButton: FavouriteButton(),
    );
  }
}

/// This represents the Favourite FAB (Floating Action Button) for displaying
/// in the PokedexEntryView.
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
