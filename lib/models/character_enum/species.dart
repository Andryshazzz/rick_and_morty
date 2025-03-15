enum Species {
  Human,
  Alien;

  String get SpeciesIcon {
    switch (this) {
      case Species.Human:
        return 'assets/icons/human.svg';
      case Species.Alien:
        return 'assets/icons/alien.svg';
    }
  }
}
