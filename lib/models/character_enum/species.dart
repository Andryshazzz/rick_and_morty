import 'package:json_annotation/json_annotation.dart';

import '../../res/icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Species {
  human,
  alien,
  unknown;

  String get speciesIcon {
    switch (this) {
      case Species.human:
        return ProjectIcons.human;
      case Species.alien:
        return ProjectIcons.alien;
      case Species.unknown:
        return ProjectIcons.unknown;
    }
  }

  String get speciesUpperCase {
    switch (this) {
      case Species.human:
        return 'Human';
      case Species.alien:
        return 'Alien';
      case Species.unknown:
        return 'unknown';
    }
  }
}
