import 'package:addr_book/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/usecases/add_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/create_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User UseCases', () {
    late UserRepositoryImpl repo;
    late CreateUserUseCase createUser;
    late DeleteUserUseCase deleteUser;
    late AddAddressUseCase addAddress;
    late DeleteAddressUseCase deleteAddress;

    setUp(() {
      repo = UserRepositoryImpl();
      createUser = CreateUserUseCase(repo);
      deleteUser = DeleteUserUseCase(repo);
      addAddress = AddAddressUseCase(repo);
      deleteAddress = DeleteAddressUseCase(repo);
    });

    test('Crear y eliminar usuario', () async {
      final user = User(
        id: '',
        firstName: 'Carlos',
        lastName: 'Perez',
        birthDate: DateTime(1988, 8, 8),
      );
      await createUser.call(user);
      var users = await repo.getAllUsers();
      expect(users.length, 1);
      await deleteUser.call(users.first.id);
      users = await repo.getAllUsers();
      expect(users, isEmpty);
    });

    test('Agregar y eliminar direccion', () async {
      final user = User(
        id: '',
        firstName: 'Paula',
        lastName: 'Lopez',
        birthDate: DateTime(1992, 2, 2),
      );
      await createUser.call(user);
      final id = (await repo.getAllUsers()).first.id;
      final address = Address(
        id: 'addr2',
        country: 'Mexico',
        department: 'CDMX',
        municipality: 'Benito Juárez',
        details: 'Algun lugar de mexico',
      );
      await addAddress.call(id, address);
      var userWithAddress = await repo.getUserById(id);
      expect(userWithAddress!.addresses.length, 1);
      await deleteAddress.call(id, 'addr2');
      userWithAddress = await repo.getUserById(id);
      expect(userWithAddress!.addresses, isEmpty);
    });
  });
}
