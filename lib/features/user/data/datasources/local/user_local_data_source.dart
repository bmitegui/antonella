import 'package:antonella/features/user/data/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract interface class UserLocalDataSource {
  Future<void> uploadLocalUser({required UserModel userModel});
  UserModel loadLocalUser();
  Future<UserModel?> checkUserAuthentication();
  Future<void> signOut();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;

  UserLocalDataSourceImpl({required this.box});

  @override
  UserModel loadLocalUser() {
    final dynamic userModelJsonBox = box.get('UserModel');
    final Map<String, dynamic> userModelJson = {};
    userModelJsonBox.forEach((key, value) {
      userModelJson[key] = value;
    });
    return UserModel.fromJson(userModelJson);
  }

  @override
  Future<void> uploadLocalUser({required UserModel userModel}) async {
    await box.clear();
    // await box.put('UserModel', userModel.toJson());
  }

  @override
  Future<UserModel?> checkUserAuthentication() async {
    final userJson = box.get('UserModel');
    final value = userJson != null && userJson.isNotEmpty;
    if (value) {
      final user = loadLocalUser();
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await box.clear();
  }
}
