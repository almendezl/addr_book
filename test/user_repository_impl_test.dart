import 'package:addr_book/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserRepositoryImpl', () {
    late UserRepositoryImpl repo;
    setUp(() {
      repo = UserRepositoryImpl();
    });

    test('Guardar y obtener usuario', () async {
      final user = User(
        id: '',
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: DateTime(2000, 1, 1),
      );
      await repo.saveUser(user);
      final users = await repo.getAllUsers();
      expect(users.length, 1);
      expect(users.first.firstName, 'Juan');
    });

    test('Eliminar usuario', () async {
      final user = User(
        id: '',
        firstName: 'Ana',
        lastName: 'Gonzales',
        birthDate: DateTime(1995, 5, 5),
      );
      await repo.saveUser(user);
      final id = (await repo.getAllUsers()).first.id;
      await repo.deleteUser(id);
      final users = await repo.getAllUsers();
      expect(users, isEmpty);
    });

    test('agregar y eliminar direccion', () async {
      final user = User(
        id: '',
        firstName: 'Luis',
        lastName: 'Mendez',
        birthDate: DateTime(1990, 3, 3),
      );
      await repo.saveUser(user);
      final id = (await repo.getAllUsers()).first.id;
      final address = Address(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'medellin',
        details: 'Calle 123',
      );
      await repo.addAddress(id, address);
      var userWithAddress = await repo.getUserById(id);
      expect(userWithAddress!.addresses.length, 1);
      await repo.deleteAddress(id, 'addr1');
      userWithAddress = await repo.getUserById(id);
      expect(userWithAddress!.addresses, isEmpty);
    });
  });
}
