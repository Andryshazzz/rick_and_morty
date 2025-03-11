// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDto _$CharacterDtoFromJson(Map<String, dynamic> json) => CharacterDto(
      imageUrl: json['image'] as String,
      name: json['name'] as String,
      status: json['status'] as String?,
      species: json['species'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$CharacterDtoToJson(CharacterDto instance) =>
    <String, dynamic>{
      'image': instance.imageUrl,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'gender': instance.gender,
    };
