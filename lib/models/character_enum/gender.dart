import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/res/icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Gender {
  male,
  female,
  @JsonValue('unknown')
  unknown;

  String get genderIcon {
    switch (this) {
      case Gender.male:
        return ProjectIcons.male;
      case Gender.female:
        return ProjectIcons.female;
      case Gender.unknown:
        return ProjectIcons.unknownGender;
    }
  }

  String get genderUpperCase {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.unknown:
        return 'unknown';
    }
  }
}
