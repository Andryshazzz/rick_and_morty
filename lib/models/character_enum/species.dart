import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/res/icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Species {
  human,
  alien;

  String get speciesIcon {
    switch (this) {
      case Species.human:
        return ProjectIcons.human;
      case Species.alien:
        return ProjectIcons.alien;
    }
  }

  String get speciesUpperCase {
    switch (this) {
      case Species.human:
        return 'Human';
      case Species.alien:
        return 'Alien';
    }
  }
}
