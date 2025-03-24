import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/character_enum/gender.dart';
import 'package:rick_and_morty/models/character_enum/species.dart';

import 'character_enum/status.dart';

part 'characters.g.dart';

@JsonSerializable()
class Character {
  final String image;
  final String name;
  final Status status;
  @JsonKey(unknownEnumValue: Species.unknown)
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
