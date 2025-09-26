import 'package:addr_book/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/usecases/add_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/create_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_users_usecase.dart';
import 'package:addr_book/src/features/user/presentation/blocs/user_bloc.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra datos del usuario', (WidgetTester tester) async {
    final repo = UserRepositoryImpl();
    final user = User(
      id: '1',
      firstName: 'Test',
      lastName: 'User',
      birthDate: DateTime(2000, 1, 1),
      addresses: [],
    );
    await repo.saveUser(user);
    final bloc = UserBloc(
      createUser: CreateUserUseCase(repo),
      addAddress: AddAddressUseCase(repo),
      getUsers: GetUsersUseCase(repo),
      getUser: GetUserUseCase(repo),
      deleteUser: DeleteUserUseCase(repo),
      deleteAddress: DeleteAddressUseCase(repo),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserBloc>.value(
          value: bloc,
          child: Builder(
            builder: (context) {
              bloc.add(SelectUserEvent('1'));
              return UserDetailPage();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Test User'), findsOneWidget);
    expect(find.textContaining('2000-01-01'), findsOneWidget);
    expect(find.textContaining('Direcciones'), findsOneWidget);
  });
}
