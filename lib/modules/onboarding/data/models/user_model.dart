import 'package:grade_management_app/modules/onboarding/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String? name,
    required String email,
  }) : super(id: id, name: name, email: email);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
