enum Notation {
  Latin,
  English,
}

extension NotationExtension on Notation {
  String get name {
    switch (this) {
      case Notation.English:
        return "English";
      case Notation.Latin:
        return "Latin";
      default:
        return null;
    }
  }
}
