class Customer {
  final String firstName;
  final String middleName;
  final String lastName;
  final String dateOfBirth;
  final String passportSeries;
  final String passportNum;
  final String passportEmitter;
  final String passportDateOfEmit;
  final String id;
  final String placeOfBirth;
  final String city;
  final String address;
  final String mobilePhoneNumber;
  final String homePhoneNumber;
  final String email;
  final String workPlace;
  final String workPosition;
  final String familyStatus;
  final String citizenship;
  final String disabilityStatus;
  final String monthlyIncome;
  final bool isPensioner;
  final bool isDutyBound;

  Customer({
      this.firstName,
      this.middleName,
      this.lastName,
      this.dateOfBirth,
      this.passportSeries,
      this.passportNum,
      this.passportEmitter,
      this.passportDateOfEmit,
      this.id,
      this.placeOfBirth,
      this.city,
      this.address,
      this.mobilePhoneNumber,
      this.homePhoneNumber,
      this.email,
      this.workPlace,
      this.workPosition,
      this.familyStatus,
      this.citizenship,
      this.disabilityStatus,
      this.monthlyIncome,
      this.isPensioner,
      this.isDutyBound});

//  factory Engineer.fromJSON(Map<dynamic, dynamic> parsedJson) {
//    if (parsedJson == null) {
//      return null;
//    }
//    String techStack = parsedJson['Tech Stack'] ?? '';
//    Set<String> techStackSet =
//        Set.of(techStack.split(';').map((skill) => skill.trim()));
//
//    return Engineer(
//      name: parsedJson['Name'] ?? '',
//      level: parsedJson['Level'] ?? '',
//      skills: parsedJson['Skills'] ?? '',
//      techStack: techStack,
//      techStackSet: techStackSet,
//      foreignLanguages: parsedJson['Foreign Languages'] ?? '',
//      location: parsedJson['Location'] ?? '',
//      group: parsedJson['Group'] ?? '',
//      id: parsedJson['Id'],
//    );
//  }
}