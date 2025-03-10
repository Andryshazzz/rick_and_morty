// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentCardDto _$ContentCardDtoFromJson(Map<String, dynamic> json) =>
    ContentCardDto(
      imageUrl: json['image'] as String,
      name: json['name'] as String,
      status: json['status'] as String?,
      species: json['species'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$ContentCardDtoToJson(ContentCardDto instance) =>
    <String, dynamic>{
      'image': instance.imageUrl,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'gender': instance.gender,
    };
