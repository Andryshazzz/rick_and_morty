// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: json['info'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'results': instance.results,
      'info': instance.info,
    };
