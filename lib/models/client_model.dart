import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  Client({
    required this.email,
    required this.name,
    required this.phone,
    this.profilePicture,
    required this.role,
    required this.company,
     this.userId,
  });

  String email;
  String name;
  String phone;
  String? profilePicture;
  String role;
  String company;
  String? userId;

  //factory Client.fromJson(String str) => Client.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory Client.fromDocumantSnaphot(
          DocumentSnapshot<Map<String, dynamic>> doc) =>
      Client(
        email: doc.data()!["email"],
        name: doc.data()!["name"],
        phone: doc.data()!["phonenumber"],
        profilePicture: doc.data()!["profile_picture"],
        role: doc.data()!["role"],
        company: doc.data()!["company"],
        userId: doc.data()!["user_id"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "name": name,
        "phone": phone,
        "profile_picture": profilePicture,
        "role": role,
        "company":company,
        "user_id": userId,
      };
}
