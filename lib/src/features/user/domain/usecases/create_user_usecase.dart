import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;
  CreateUserUseCase(this.repository);

  Future<void> call(User user) async {
    if (user.firstName.trim().isEmpty) throw Exception('Nombre requerido');
    if (user.lastName.trim().isEmpty) throw Exception('Apellido requerido');
    if (user.birthDate.isAfter(DateTime.now())) {
      throw Exception('Fecha de nacimiento inválida');
    }
    await repository.saveUser(user);
  }
}
