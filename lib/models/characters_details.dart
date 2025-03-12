import 'package:json_annotation/json_annotation.dart';

part 'characters_details.g.dart';

@JsonSerializable()
class Character {
  final String? image;
  final String? name;
  final String? status;
  final String? species;
  final String? gender;
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
