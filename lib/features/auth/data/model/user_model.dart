class UserModel {
  final String name;
  final String email;
  final String? profileImage;
  final String? token;
  final String? debitCard;
  final String? address;

  UserModel({
    required this.name,
    required this.email,
    this.profileImage,
    this.token,
    this.debitCard,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      profileImage: json['image'] ?? "",
      token: json['token'] ?? "",
      address: json['address'] ?? "",
      debitCard: json['Visa'] ?? "",
    );
  }
}
