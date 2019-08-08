import '../tools.dart';

/// Class which represents an evolution chain identified with its unique ID and
/// its members.
class EvolutionChain {
  final List<String> members;

  EvolutionChain(String input) : members = _buildMembers(input);

  static List<String> _buildMembers(String input) {
    var _members = input.split(";");
    var res = <String>[];
    for (var pokemon in _members) {
      if (pokemon != '') {
        res.add(Tools.capitalizeFirst(pokemon));
      }
    }
    return res;
  }
}