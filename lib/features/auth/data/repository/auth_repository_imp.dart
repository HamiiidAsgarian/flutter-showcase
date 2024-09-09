import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_showcase/features/auth/data/models/user_model.dart';
import 'package:flutter_showcase/features/auth/data/remote/auth_data_layer.dart';
import 'package:flutter_showcase/features/auth/domain/models/user.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemote authRemote})
      : _authRemote = authRemote;
  final AuthRemote _authRemote;

  @override
  Future<NetworkResponse<User>> getUser({required String endpoint}) async {
    final userModeledNetworkResponse =
        await _authRemote.getUser(endpoint: endpoint);

    return NetworkResponse<User>(
      //make [User] out of [UserModel]
      data: userModeledNetworkResponse.data?.toUser(),
      error: userModeledNetworkResponse.error,
      isSuccess: userModeledNetworkResponse.isSuccess,
      statusCode: userModeledNetworkResponse.statusCode,
    );
  }
}

extension UserModelToUser on UserModel {
  User toUser() => User(id: id, email: email, password: password);
}
