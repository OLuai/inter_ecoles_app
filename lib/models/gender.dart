enum Gender {
  homme,
  dame,
}
String getGender(Gender genre) {
  switch (genre) {
    case Gender.homme:
      return "Homme";
    case Gender.dame:
      return "Dame";
    default:
      return "Homme";
  }
}
