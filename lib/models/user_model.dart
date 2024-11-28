class UserModel {
  final String fullname;
  final String email;
  final String password;
  final String dateOfBirth;
  final String phoneNumber;

  UserModel({
    required this.fullname,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullname: json['fullname'],
        email: json['email'],
        password: json['password'],
        dateOfBirth: json['dateofBirth'],
        phoneNumber: json['phoneNumber']);
  }
}
