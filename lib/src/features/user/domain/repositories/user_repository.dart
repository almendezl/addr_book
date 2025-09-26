import 'package:addr_book/src/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<void> saveUser(User user);
  Future<User?> getUserById(String id);
  Future<void> addAddress(String userId, Address address);
  Future<void> deleteUser(String userId);
  Future<void> deleteAddress(String userId, String addressId);
}
