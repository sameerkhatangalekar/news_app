import 'package:news_app/core/common/domain/entity/user.dart';

final class UserModel extends UserEntity {
  UserModel({required super.id, required super.email, super.name});

  UserModel copyWith({String? email, String? id, String? name}) => UserModel(
        email: email ?? this.email,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "name": name,
      };
}
