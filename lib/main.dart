import 'package:addr_book/app.dart';
import 'package:addr_book/src/features/user/data/models/user_hive_model.dart';
import 'package:addr_book/src/features/user/data/repositories/user_hive_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(AddressHiveAdapter());
  Hive.registerAdapter(UserHiveAdapter());

  final usersBox = await Hive.openBox<UserHive>('users_box');
  final hiveRepo = HiveUserRepository(usersBox);
  runApp(MyApp(userRepository: hiveRepo));
}
