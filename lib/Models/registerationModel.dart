class User {
  final String name;
  final String email;
  final String address;
  final String password;
  final String username;
  final String phoneNumber;
  final String imageUrl;

  User({
    required this.name,
    required this.email,
    required this.address,
    required this.password,
    required this.username,
    required this.phoneNumber,
    required this.imageUrl
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "address": address,
      "password": password,
      "username": username,
      "phoneNumber": phoneNumber,
      "ImageUrl":imageUrl
    };
  }
}
