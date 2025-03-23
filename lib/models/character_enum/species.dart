import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/res/icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Species {
  human,
  alien,
  humanoid,
  @JsonValue('unknown')
  unknown,
  @JsonValue('Mythological Creature')
  mythologicalcreature,
  poopybutthole,
  animal;

  String get speciesIcon {
    switch (this) {
      case Species.human:
        return ProjectIcons.human;
      case Species.alien:
        return ProjectIcons.alien;
      case Species.humanoid:
        return ProjectIcons.alien;
      case Species.mythologicalcreature:
        return ProjectIcons.alien;
      case Species.poopybutthole:
        return ProjectIcons.unknown;
      case Species.animal:
        return ProjectIcons.unknown;
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
      case Species.humanoid:
        return 'Humanoid';
      case Species.mythologicalcreature:
        return 'Mythological Creature';
      case Species.animal:
        return 'Animal';
      case Species.poopybutthole:
        return 'Poopybutthole';
      case Species.unknown:
        return 'unknown';
    }
  }
}
