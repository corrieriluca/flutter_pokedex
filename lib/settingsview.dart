import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  final List<Widget> _rows = <Widget>[
    Row(
      children: <Widget>[
        ListTile(
          title: Text('Use Dark Mode'),
          trailing: Switch(
            value: false,
            onChanged: (bool value) {},
          ),
        )
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Text('Settings View here...'),
        ));
  }
}
