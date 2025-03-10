import 'package:json_annotation/json_annotation.dart';
import '../entities/content_dart_entities.dart';

part 'content_card_dto.g.dart';

@JsonSerializable()
class ContentCardDto {
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

  ContentCardDto({
    required this.imageUrl,
    required this.name,
    this.status,
    this.species,
    this.gender,
  });

  ContentCardEntities toEntity() {
    return ContentCardEntities(
      imageUrl: imageUrl,
      name: name,
      status: status,
      species: species,
      gender: gender,
    );
  }

  factory ContentCardDto.fromJson(Map<String, Object?> json) =>
      _$ContentCardDtoFromJson(json);
}
