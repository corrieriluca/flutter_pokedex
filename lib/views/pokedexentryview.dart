import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/views/pokedexview.dart';
import 'favouritesview.dart';

import '../classes/pokemon.dart';
import '../classes/move.dart';
import '../tools.dart';

class PokedexEntryView extends StatelessWidget {
  final Pokemon pokemon;

  PokedexEntryView({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pokemon.name}'),
        backgroundColor: pokemon.types[0].color,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            _PokemonBaseContainer(pokemon: pokemon),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(color: Colors.black38),
            ),
            _PokemonDescriptionContainer(pokemon: pokemon),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(color: Colors.black38),
            ),
            _PokemonStatsView(pokemon: pokemon),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(color: Colors.black38),
            ),
            _PokemonEvolutionView(
              pokemon: pokemon,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
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
      floatingActionButton: FavouriteButton(pokemon: pokemon),
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
                ),
              ),
            ),
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
              ),
            ),
          ],
        ),
      );
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

/// Containing the stats of the Pokemon
class _PokemonStatsView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonStatsView({Key key, @required this.pokemon}) : super(key: key);

  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Base Stats',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
                margin: EdgeInsets.all(4.0),
              ),
              pokemon.getStatWidgets(),
            ],
          ),
        ),
      );
}

/// Display the Evolution Chain of the Pokemon
class _PokemonEvolutionView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonEvolutionView({Key key, @required this.pokemon})
      : super(key: key);

  /// Retreives the Pokemon by its name and build its little thumbnail
  Widget _buildThumbnail(BuildContext context, int i) {
    final String pokemonName = pokemon.evolutionChain.members[i];
    final Pokemon currentPoke =
        PokedexViewState.pokemons.firstWhere((Pokemon poke) {
      return poke.name == pokemonName;
    }, orElse: () => Pokemon.unknown());

    if (currentPoke.name == 'unknown')
    {
      return Container();
    }

    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: GestureDetector(
          onTap: () {
            if (currentPoke == pokemon) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    'You are already looking at the page of this Pokémon...'),
                duration: const Duration(seconds: 2),
              ));
            } else {
              // Builds the Pokedex Entry View according to that Pokemon.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokedexEntryView(pokemon: currentPoke),
                ),
              );
            }
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/pokemonSprites/${currentPoke.pokedexID}.png',
              ),
              Container(
                child: Text(
                  '${currentPoke.name}',
                  style: TextStyle(fontSize: 14.0),
                ),
                margin: EdgeInsets.all(4.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Evolution Chain',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              margin: EdgeInsets.all(4.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                pokemon.evolutionChain.members.length >= 1
                    ? _buildThumbnail(context, 0)
                    : Container(),
                pokemon.evolutionChain.members.length >= 2
                    ? _buildThumbnail(context, 1)
                    : Container(),
                pokemon.evolutionChain.members.length >= 3
                    ? _buildThumbnail(context, 2)
                    : Container(),
              ],
            )
          ],
        ),
      );
}

/// Idem for the displaying the Pokemon Moves
class _PokemonMoveListView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonMoveListView({Key key, @required this.pokemon})
      : super(key: key);

  /// Retreives the move object by its name
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
  final Pokemon pokemon;
  FavouriteButton({@required this.pokemon});

  @override
  createState() => FavouriteState(pokemon: pokemon);
}

class FavouriteState extends State<FavouriteButton> {
  bool isFavourite = false;
  final Pokemon pokemon;

  FavouriteState({@required this.pokemon});

  @override
  void initState() {
    super.initState();
    isFavourite = FavouritesViewState.isFavourite(pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: this.pokemon.types[0].color,
      child: Icon(isFavourite ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        setState(() {
          if (isFavourite) {
            FavouritesViewState.removeFav(pokemon);
          } else {
            FavouritesViewState.addFavourite(pokemon);
          }
          isFavourite = !isFavourite;
        });
      },
    );
  }
}
