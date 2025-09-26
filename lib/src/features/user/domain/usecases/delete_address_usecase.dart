import 'package:addr_book/src/features/user/domain/repositories/user_repository.dart';

class DeleteAddressUseCase {
  final UserRepository repository;
  DeleteAddressUseCase(this.repository);

  Future<void> call(String userId, String addressId) =>
      repository.deleteAddress(userId, addressId);
}
