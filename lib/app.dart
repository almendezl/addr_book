import 'package:addr_book/l10n/app_localizations.dart';
import 'package:addr_book/src/features/user/data/repositories/user_hive_repository.dart';
import 'package:addr_book/src/features/user/domain/usecases/add_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/create_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_users_usecase.dart';
import 'package:addr_book/src/features/user/presentation/blocs/user_bloc.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_detail_page.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_form_page.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_list_page.dart';
import 'package:flutter/material.dart'
    show StatelessWidget, MaterialApp, Colors, ThemeData;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final HiveUserRepository userRepository;

  const MyApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    final createUser = CreateUserUseCase(userRepository);
    final addAddress = AddAddressUseCase(userRepository);
    final getUsers = GetUsersUseCase(userRepository);
    final deleteUser = DeleteUserUseCase(userRepository);
    final deleteAddress = DeleteAddressUseCase(userRepository);
    final getUser = GetUserUseCase(userRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(
            createUser: createUser,
            addAddress: addAddress,
            getUsers: getUsers,
            deleteUser: deleteUser,
            deleteAddress: deleteAddress,
            getUser: getUser,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Address Book',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
        initialRoute: UserListPage.routeName,
        routes: {
          UserListPage.routeName: (_) => const UserListPage(),
          UserFormPage.routeName: (_) => const UserFormPage(),
          UserDetailPage.routeName: (_) => const UserDetailPage(),
        },
      ),
    );
  }
}
