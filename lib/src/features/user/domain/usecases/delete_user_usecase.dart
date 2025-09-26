import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository repository;
  DeleteUserUseCase(this.repository);

  Future<void> call(String userId) => repository.deleteUser(userId);
}
