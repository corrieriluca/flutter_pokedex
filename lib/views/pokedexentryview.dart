import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/views/pokedexview.dart';

import '../classes/pokemon.dart';
import '../classes/move.dart';
import '../tools.dart';

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
            _PokemonBaseContainer(pokemon: pokemon),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Divider(color: Colors.black38),
            ),
            _PokemonDescriptionContainer(pokemon: pokemon),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Divider(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Moves',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
                margin: EdgeInsets.all(4.0),
              ),
            ),
          ])),
          _PokemonMoveListView(pokemon: pokemon),
        ],
      ),
      floatingActionButton: FavouriteButton(),
    );
  }
}

/// This is the base Container widget which displays the Pokemon's sprite,
/// its name, types and height/weight
class _PokemonBaseContainer extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonBaseContainer({Key key, @required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
              tag: '${pokemon.name}_sprite',
              child: Container(
                  margin: EdgeInsets.fromLTRB(14, 8, 14, 8),
                  child: Image.asset(
                    'assets/pokemonSprites/${pokemon.pokedexID}.png',
                  ))),
          Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      Tools.displayWithZeroes(pokemon.pokedexID),
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                    margin: EdgeInsets.all(2.0),
                  ),
                  Container(
                    child: Text('${pokemon.name}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600)),
                    margin: EdgeInsets.all(4.0),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        pokemon.getTypeWidget(0),
                        pokemon.getTypeWidget(1),
                      ],
                    ),
                    margin: EdgeInsets.all(4.0),
                  ),
                  Container(
                    child: Text(
                      'Height : ${pokemon.height} dm',
                      style: TextStyle(
                          fontSize: 12.0, color: Colors.grey.shade700),
                    ),
                    margin: EdgeInsets.all(4.0),
                  ),
                  Container(
                    child: Text(
                      'Weight : ${pokemon.weight} hg',
                      style: TextStyle(
                          fontSize: 12.0, color: Colors.grey.shade700),
                    ),
                    margin: EdgeInsets.all(4.0),
                  )
                ],
              )),
        ],
      ));
}

/// Idem for the displaying the Pokemon Description
class _PokemonDescriptionContainer extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonDescriptionContainer({Key key, @required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Description',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
                margin: EdgeInsets.all(4.0),
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                child: Text(
                  '${pokemon.description}',
                ),
              )
            ],
          ),
        ),
      );
}

class _PokemonMoveListView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonMoveListView({Key key, @required this.pokemon})
      : super(key: key);

  Widget _buildRow(int i) {
    final String moveName = pokemon.moves[i];
    final Move currentMove =
        PokedexViewState.pokemonMoves.firstWhere((Move mv) {
      return mv.name == moveName;
    }, orElse: () => Move('Not in the database'));
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: MoveTile(move: currentMove),
    );
  }

  @override
  Widget build(BuildContext context) => SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int pos) {
        if (pos.isOdd) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Divider(),
          );
        }
        final index = pos ~/ 2;
        return _buildRow(index);
      },
      childCount: pokemon.moves.length * 2,
    ));
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
