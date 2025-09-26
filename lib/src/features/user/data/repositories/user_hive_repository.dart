import 'package:addr_book/src/features/user/data/models/user_hive_model.dart';
import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:hive/hive.dart';

class HiveUserRepository implements UserRepository {
  final Box<UserHive> _box;

  HiveUserRepository(this._box);

  static Future<HiveUserRepository> init() async {
    final box = await Hive.openBox<UserHive>('users_box');
    return HiveUserRepository(box);
  }

  @override
  Future<List<User>> getAllUsers() async {
    final values = _box.values.toList();
    return values.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> saveUser(User user) async {
    final model = UserHive.fromDomain(user);
    await _box.put(user.id, model);
  }

  @override
  Future<User?> getUserById(String id) async {
    final model = _box.get(id);
    return model?.toDomain();
  }

  @override
  Future<void> addAddress(String userId, Address address) async {
    final model = _box.get(userId);
    if (model == null) throw Exception('Usuario no encontrado');
    final newAddr = AddressHive.fromDomain(address);
    final updated = UserHive(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      birthDate: model.birthDate,
      addresses: [...model.addresses, newAddr],
    );
    await _box.put(userId, updated);
  }

  @override
  Future<void> deleteAddress(String userId, String addressId) async {
    final model = _box.get(userId);
    if (model == null) throw Exception('Usuario no encontrado');
    final updatedAddresses = model.addresses
        .where((a) => a.id != addressId)
        .toList();
    final updated = UserHive(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      birthDate: model.birthDate,
      addresses: updatedAddresses,
    );
    await _box.put(userId, updated);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _box.delete(userId);
  }
}
