import 'package:json_annotation/json_annotation.dart';

import 'content_card_dto.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  final List<ContentCardDto> results;
  final Map<String, dynamic> info;

  Content({
    required this.results,
    required this.info,
  });

  factory Content.fromJson(Map<String, Object?> json) =>
      _$ContentFromJson(json);
}
