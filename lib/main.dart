import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'views/favouritesview.dart';
import 'views/pokedexsearch.dart';
import 'views/pokedexview.dart';
import 'views/settingsview.dart';

void main() => runApp(PokedexApp());

class PokedexApp extends StatelessWidget {
  static final ThemeData defaultTheme = ThemeData(
    primaryColor: Colors.red.shade800,
    accentColor: Colors.white,
    cursorColor: Colors.white,
    hintColor: Colors.white70,
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

class MainView extends StatefulWidget {
  @override
  createState() => MainViewState();
}

class MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Pokédex'),
              pinned: true,
              snap: true,
              floating: true,
              forceElevated: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: PokedexSearch());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsView(),
                      ),
                    );
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: false,
                tabs: <Widget>[
                  Tab(text: 'POKÉMON'),
                  Tab(text: 'FAVOURITES'),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            PokedexView(),
            FavouritesView(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
