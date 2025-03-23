// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      image: json['image'] as String,
      name: json['name'] as String,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      species: const SpeciesConverter().fromJson(json['species'] as String),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'status': _$StatusEnumMap[instance.status]!,
      'species': const SpeciesConverter().toJson(instance.species),
      'gender': _$GenderEnumMap[instance.gender]!,
      'id': instance.id,
    };

const _$StatusEnumMap = {
  Status.alive: 'Alive',
  Status.dead: 'Dead',
  Status.unknown: 'unknown',
};

const _$GenderEnumMap = {
  Gender.male: 'Male',
  Gender.female: 'Female',
  Gender.genderless: 'Genderless',
  Gender.unknown: 'unknown',
};
