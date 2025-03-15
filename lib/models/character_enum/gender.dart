enum Gender {
  Male,
  Female,
  unknown;

  String get GenderIcon {
    switch (this) {
      case Gender.Male:
        return 'assets/icons/male.svg';
      case Gender.Female:
        return 'assets/icons/female.svg';
      case Gender.unknown:
        return 'assets/icons/unknown_gender.svg';
    }
  }
}
