class UserModel {
  final String userID;
  final String fullName;
  final String email;
  final String dateOfBirth;
  final String registDate;
  final String phoneNumber;
  final String gender;
  final String? profilePicture;

  UserModel(
      {required this.userID,
      required this.fullName,
      required this.email,
      required this.dateOfBirth,
      required this.registDate,
      required this.phoneNumber,
      required this.gender,
      required this.profilePicture});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      fullName: json['fullName'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      registDate: json['registrationDate'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'] as String?,
    );
  }
}
