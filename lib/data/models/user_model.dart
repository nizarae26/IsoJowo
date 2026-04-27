class UserModel {
  final String id;
  final String jeneng;
  final String email;

  UserModel({required this.id, required this.jeneng, required this.email});

  // Untuk konversi dari JSON (API Laravel)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      jeneng: json['name'],
      email: json['email'],
    );
  }
}