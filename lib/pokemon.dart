class Pokemon {
  final String name;
  final String spriteURL;

  //constructor
  Pokemon(this.name, this.spriteURL) {
    if (name == null) {
      throw ArgumentError('name of Pokemon cannot be null'
        'Received : "$name"');
    }
    if (spriteURL == null) {
      throw ArgumentError('spriteURL of Pokemon cannot be null'
        'Received : "$spriteURL"');
    }
  }

  String formatName() => name.replaceFirst(name[0], name[0].toUpperCase());
}