import 'package:json_annotation/json_annotation.dart';

import '../../entities/character.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDto {
  @JsonKey(name: 'image')
  final String imageUrl;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'species')
  final String? species;

  @JsonKey(name: 'gender')
  final String? gender;

  CharacterDto({
    required this.imageUrl,
    required this.name,
    this.status,
    this.species,
    this.gender,
  });

  CharacterEntities toEntity() {
    return CharacterEntities(
      imageUrl: imageUrl,
      name: name,
      status: status,
      species: species,
      gender: gender,
    );
  }

  factory CharacterDto.fromJson(Map<String, Object?> json) =>
      _$CharacterDtoFromJson(json);
}
