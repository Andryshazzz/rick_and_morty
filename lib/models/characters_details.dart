import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/character_enum/gender.dart';
import 'package:rick_and_morty/models/character_enum/species.dart';

import 'character_enum/status.dart';

part 'characters_details.g.dart';

@JsonSerializable()
class Character {
  final String image;
  final String name;
  final Status status;
  @SpeciesConverter()
  final Species species;
  final Gender gender;
  final int id;

  const Character({
    required this.image,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.id,
  });

  factory Character.fromJson(Map<String, Object?> json) =>
      _$CharacterFromJson(json);
}

class SpeciesConverter implements JsonConverter<Species, String> {
  const SpeciesConverter();

  @override
  Species fromJson(String json) {
    switch (json) {
      case 'Human':
        return Species.human;
      case 'Alien':
        return Species.alien;
      default:
        return Species.unknown;
    }
  }

  @override
  String toJson(Species object) {
    return object.name;
  }
}
