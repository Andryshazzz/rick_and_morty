enum Status {
  Alive,
  Dead,
  unknown;

  String get StatusIcon {
    switch (this) {
      case Status.Alive:
        return 'assets/icons/alive.svg';
      case Status.Dead:
        return 'assets/icons/dead.svg';
      case Status.unknown:
        return 'assets/icons/unknown.svg';
    }
  }
}
