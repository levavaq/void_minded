enum Quality {
  MAJOR,
  MINOR,
}

extension QualityExtension on Quality {
  String get name {
    switch (this) {
      case Quality.MAJOR:
        return "MAJOR";
      case Quality.MINOR:
        return "MINOR";
      default:
        return null;
    }
  }
}
