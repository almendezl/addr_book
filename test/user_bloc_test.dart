import 'package:addr_book/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/usecases/add_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/create_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_users_usecase.dart';
import 'package:addr_book/src/features/user/presentation/blocs/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserBloc', () {
    late UserBloc bloc;
    late UserRepositoryImpl repo;

    setUp(() {
      repo = UserRepositoryImpl();
      bloc = UserBloc(
        createUser: CreateUserUseCase(repo),
        addAddress: AddAddressUseCase(repo),
        getUsers: GetUsersUseCase(repo),
        getUser: GetUserUseCase(repo),
        deleteUser: DeleteUserUseCase(repo),
        deleteAddress: DeleteAddressUseCase(repo),
      );
    });

    test('carga usuarios', () async {
      bloc.add(LoadUsersEvent());
      await Future.delayed(const Duration(milliseconds: 200));
      expect(bloc.state, isA<UsersLoaded>());
      expect((bloc.state as UsersLoaded).users, isEmpty);
    });

    test('crear y eliminar usuario', () async {
      final user = User(
        id: '',
        firstName: 'Pedro',
        lastName: 'Perez',
        birthDate: DateTime(1985, 9, 13),
      );
      bloc.add(CreateUserEvent(user));
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 50));
        return bloc.state is! UsersLoaded;
      });
      expect((bloc.state as UsersLoaded).users.length, 1);
      final id = (bloc.state as UsersLoaded).users.first.id;
      bloc.add(DeleteUserEvent(id));
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 50));
        return bloc.state is! UsersLoaded;
      });
      expect((bloc.state as UsersLoaded).users, isEmpty);
    });

    test('agregar y eliminar direccion', () async {
      final user = User(
        id: '',
        firstName: 'Juan',
        lastName: 'Diaz',
        birthDate: DateTime(1990, 4, 4),
      );
      bloc.add(CreateUserEvent(user));
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 50));
        return bloc.state is! UsersLoaded;
      });
      final id = (bloc.state as UsersLoaded).users.first.id;
      final address = Address(
        id: 'addr3',
        country: 'Colombia',
        department: 'Cundinamarca',
        municipality: 'Chia',
        details: 'Calle 7 # 5-23',
      );
      bloc.add(AddAddressEvent(id, address));
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 50));
        return bloc.state is! UsersLoaded;
      });
      final userWithAddress = (bloc.state as UsersLoaded).users.first;
      expect(userWithAddress.addresses.length, 1);
      bloc.add(DeleteAddressEvent(id, 'addr3'));
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 50));
        return bloc.state is! UsersLoaded && bloc.state is! UserSelected;
      });
      if (bloc.state is UsersLoaded) {
        final userAfterDelete = (bloc.state as UsersLoaded).users.first;
        expect(userAfterDelete.addresses, isEmpty);
      } else if (bloc.state is UserSelected) {
        final userAfterDelete = (bloc.state as UserSelected).user;
        expect(userAfterDelete.addresses, isEmpty);
      } else {
        fail('Estado inesperado: ${bloc.state.runtimeType}');
      }
    });
  });
}
