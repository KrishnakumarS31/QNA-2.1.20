class Student {
  String firstName;
  String lastName;
  String dob;
  String gender;
  String nationality;
  String residentCountry;
  String email;
  String rollNumber;
  String organisationName;
  String isTeacher;
  String password;

  // "firstName": "user1",
  // "lastName": "123",
  // "dob": "01/01/2001",
  // "gender": "female",
  // "nationality":"India",
  // "residentCountry": "United States",
  // "email": "user1.123@itc.com",
  // "rollNumber": "A0987654",
  // "organisationName": "abcde",
  // "isTeacher": false,
  // "password": "acsdfvb7@0987"

  Student(
      {required this.firstName,
        required this.lastName,
        required this.dob,
        required this.gender,
        required this.nationality,
        required this.residentCountry,
        required this.email,
        required this.rollNumber,
        required this.organisationName,
        required this.password,
        required this.isTeacher});

  factory Student.fromJson(Map<String, dynamic> data) => Student(
      firstName: data["firstName"],
      lastName: data["lastName"],
      dob: data["dob"],
      gender: data["gender"],
      nationality: data["nationality"],
      residentCountry: data["residentCountry"],
      password: data["password"],
      email: data["email"],
      rollNumber: data["rollNumber"],
      organisationName: data["organisationName"],
      isTeacher: data["isTeacher"]
  );

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "dob": dob,
      "gender": gender,
      "nationality": nationality,
      "residentCountry": residentCountry,
      "email": email,
      "rollNumber": rollNumber,
      "organisationName": organisationName,
      "isTeacher":isTeacher,
    };
  }

  @override
  String toString() {
    return 'Student{firstName: $firstName, lastName: $lastName, dob: $dob, gender: $gender, nationality: $nationality, residentCountry: $residentCountry, email: $email, rollNumber: $rollNumber, organisationName: $organisationName,isTeacher:$isTeacher,password: $password}';
  }
}
