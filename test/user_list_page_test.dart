import 'package:addr_book/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/usecases/add_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/create_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_users_usecase.dart';
import 'package:addr_book/src/features/user/presentation/blocs/user_bloc.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra usuarios y permite eliminar', (
    WidgetTester tester,
  ) async {
    final repo = UserRepositoryImpl();
    final bloc = UserBloc(
      createUser: CreateUserUseCase(repo),
      addAddress: AddAddressUseCase(repo),
      getUsers: GetUsersUseCase(repo),
      getUser: GetUserUseCase(repo),
      deleteUser: DeleteUserUseCase(repo),
      deleteAddress: DeleteAddressUseCase(repo),
    );

    // Agregar usuario de prueba
    await repo.saveUser(
      User(
        id: 'test1',
        firstName: 'Test',
        lastName: 'User',
        birthDate: DateTime(2000, 1, 1),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: bloc, child: const UserListPage()),
      ),
    );

    // espera a que se cargue la lista
    await tester.pumpAndSettle();

    // verificar q aparece el usuario
    expect(find.text('Test User'), findsOneWidget);

    // Elimina usuario
    final deleteButton = find.byIcon(Icons.delete_forever);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // verifica quw ya no este
    expect(find.text('Test User'), findsNothing);
  });
}
