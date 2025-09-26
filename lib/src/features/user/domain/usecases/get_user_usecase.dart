import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;
  GetUserUseCase(this.repository);

  Future<User?> call(String id) => repository.getUserById(id);
}
