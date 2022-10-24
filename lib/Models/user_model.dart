class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? surname;
  String? universityName;
  String? role;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.surname,
      this.universityName,
      this.role});

  // Getting data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      surname: map['surname'],
      universityName: map['universityName'],
      role: map['role']
    );
  }
  // Sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'surname': surname,
      'universityName': universityName,
      'role': role,
    };
  }
}
