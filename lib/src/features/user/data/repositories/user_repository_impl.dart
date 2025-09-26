import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserRepositoryImpl implements UserRepository {
  final Map<String, User> _db = {};
  final _uuid = const Uuid();

  @override
  Future<List<User>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _db.values.toList();
  }

  @override
  Future<void> saveUser(User user) async {
    final id = user.id.isEmpty ? _uuid.v4() : user.id;
    final toSave = user.copyWith(id: id);
    await Future.delayed(const Duration(milliseconds: 120));
    _db[id] = toSave;
  }

  @override
  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 80));
    return _db[id];
  }

  @override
  Future<void> addAddress(String userId, Address address) async {
    final user = _db[userId];
    if (user == null) throw Exception('User not found');
    final newList = List<Address>.from(user.addresses)..add(address);
    _db[userId] = user.copyWith(addresses: newList);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 80));
    _db.remove(userId);
  }

  @override
  Future<void> deleteAddress(String userId, String addressId) async {
    final user = _db[userId];
    if (user == null) throw Exception('User not found');
    final newList = user.addresses.where((a) => a.id != addressId).toList();
    _db[userId] = user.copyWith(addresses: newList);
  }
}
