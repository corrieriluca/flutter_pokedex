import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pokemon.dart';

/// Class which represents an evolution chain identified with its unique ID and
/// its members.
class EvolutionChain {
  final int id;
  final List<Pokemon> members;

  EvolutionChain(this.id, this.members);
}