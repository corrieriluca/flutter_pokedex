import 'package:flutter/material.dart';
import 'package:flutter_pokedex/classes/pokemon.dart';
import 'package:flutter_pokedex/views/pokedexview.dart';

import 'pokedexentryview.dart';

class PokedexSearch extends SearchDelegate<Pokemon> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? PokedexViewState.pokemons
        : PokedexViewState.pokemons
            .where(
                (p) => p.name.startsWith(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Divider(),
          );
        }

        final i = index ~/ 2;
        return Container(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.asset(
                'assets/pokemonSprites/${suggestionList[i].pokedexID}.png'),
            title: RichText(
              text: TextSpan(
                  text: suggestionList[i].name.substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                      text: suggestionList[i].name.substring(query.length),
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            onTap: () {
              // Builds the Pokedex Entry View according to that Pokemon.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PokedexEntryView(pokemon: suggestionList[i]),
                ),
              );
            },
          ),
        );
      },
      itemCount: suggestionList.length * 2,
    );
  }
}
