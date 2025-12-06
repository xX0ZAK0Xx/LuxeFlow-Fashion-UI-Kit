import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      await localDataSource.login(email, password);
      return Right(const UserEntity(id: '1', email: 'user@luxeflow.com', name: 'Luxe User'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String name, String email, String password) async {
    // Mock register
     try {
      // Simulate successful registration returning the user
      await Future.delayed(const Duration(seconds: 1));
       final newUser = const UserEntity(
        id: '1', 
        email: 'user@luxeflow.com', 
        name: 'Luxe User'
      );
      return Right(newUser);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
