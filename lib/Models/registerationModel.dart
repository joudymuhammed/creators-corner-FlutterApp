// user_model.dart
class User {
  String name;
  String email;
  String address;
  String password;
  String username;
  String phoneNumber;
  String? image; // Image in Base64 format

  User({
    required this.name,
    required this.email,
    required this.address,
    required this.password,
    required this.username,
    required this.phoneNumber,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'password': password,
      'username': username,
      'phoneNumber': phoneNumber,
      'image': image, // Add image path to JSON
    };
  }
}
