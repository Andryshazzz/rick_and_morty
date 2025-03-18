import 'package:json_annotation/json_annotation.dart';

import '../../res/icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Status {
  alive,
  dead,
  @JsonValue('unknown')
  unknown;

  String get statusIcon {
    switch (this) {
      case Status.alive:
        return ProjectIcons.alive;
      case Status.dead:
        return ProjectIcons.dead;
      case Status.unknown:
        return ProjectIcons.unknown;
    }
  }
}
