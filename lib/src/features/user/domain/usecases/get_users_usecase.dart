import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;
  GetUsersUseCase(this.repository);

  Future<List<User>> call() => repository.getAllUsers();
}
