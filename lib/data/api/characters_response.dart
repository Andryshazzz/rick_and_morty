import 'package:json_annotation/json_annotation.dart';

import '../../models/characters_details.dart';

part 'characters_response.g.dart';

@JsonSerializable()
class CharactersResponse {
  final List<Character> results;
  final Map<String, dynamic> info;

  CharactersResponse({
    required this.results,
    required this.info,
  });

  factory CharactersResponse.fromJson(Map<String, Object?> json) =>
      _$CharactersResponseFromJson(json);
}
