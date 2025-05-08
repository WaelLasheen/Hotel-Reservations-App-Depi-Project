class Client {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String idImagePath;

  Client({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.idImagePath,
  });

  Map<String, dynamic> toMap() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'idImagePath': idImagePath,
      };

  factory Client.fromMap(Map<String, dynamic> map) => Client(
        firstName: map['firstName'],
        lastName: map['lastName'],
        phoneNumber: map['phoneNumber'],
        email: map['email'],
        idImagePath: map['idImagePath'],
      );
}
