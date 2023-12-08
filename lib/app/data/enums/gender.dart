// ignore: constant_identifier_names
enum Gender { MALE, FEMALE, OTHER, NOTTOSAY }

String getGenderString(Gender gender) {
  switch (gender) {
    case Gender.MALE:
      return 'Male';
    case Gender.FEMALE:
      return 'Female';
    case Gender.OTHER:
      return 'Other';
    case Gender.NOTTOSAY:
      return 'Prefer not to say';
    default:
      return 'Prefer not to say';
  }
}

Gender getGender(String gender) {
  switch (gender) {
    case 'Male':
      return Gender.MALE;
    case 'Female':
      return Gender.FEMALE;
    case 'Other':
      return Gender.OTHER;
    case 'Prefer not to say':
      return Gender.NOTTOSAY;
    default:
      return Gender.MALE;
  }
}
