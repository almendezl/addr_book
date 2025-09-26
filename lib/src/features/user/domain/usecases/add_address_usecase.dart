import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';

class AddAddressUseCase {
  final UserRepository repository;
  AddAddressUseCase(this.repository);

  Future<void> call(String userId, Address address) async {
    if (address.country.trim().isEmpty) throw Exception('País requerido');
    if (address.department.trim().isEmpty) {
      throw Exception('Departamento requerido');
    }
    if (address.municipality.trim().isEmpty) {
      throw Exception('Municipio requerido');
    }
    if (address.details.trim().isEmpty) {
      throw Exception('Detalles de dirección requeridos');
    }
    await repository.addAddress(userId, address);
  }
}
