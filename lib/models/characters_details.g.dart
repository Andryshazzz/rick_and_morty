// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      image: json['image'] as String,
      name: json['name'] as String,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      species: $enumDecode(_$SpeciesEnumMap, json['species']),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'status': _$StatusEnumMap[instance.status]!,
      'species': _$SpeciesEnumMap[instance.species]!,
      'gender': _$GenderEnumMap[instance.gender]!,
      'id': instance.id,
    };

const _$StatusEnumMap = {
  Status.Alive: 'Alive',
  Status.Dead: 'Dead',
  Status.unknown: 'unknown',
};

const _$SpeciesEnumMap = {
  Species.Human: 'Human',
  Species.Alien: 'Alien',
};

const _$GenderEnumMap = {
  Gender.Male: 'Male',
  Gender.Female: 'Female',
  Gender.unknown: 'unknown',
};
