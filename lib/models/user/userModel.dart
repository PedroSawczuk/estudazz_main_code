class UserModel {
  final String uid;
  final String displayName;
  final String username;
  final String email;
  final String birthDate;
  final String institution;
  final String course;
  final String expectedGraduation;
  final bool profileCompleted;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.username,
    required this.email,
    required this.birthDate,
    required this.institution,
    required this.course,
    required this.expectedGraduation,
    required this.profileCompleted,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      displayName: map['display_name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      birthDate: map['birth_date'] ?? '',
      institution: map['institution'] ?? '',
      course: map['course'] ?? '',
      expectedGraduation: map['expected_graduation'] ?? '',
      profileCompleted: map['profileCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'display_name': displayName,
      'username': username,
      'email': email,
      'birth_date': birthDate,
      'institution': institution,
      'course': course,
      'expected_graduation': expectedGraduation,
      'profileCompleted': profileCompleted,
    };
  }
}
