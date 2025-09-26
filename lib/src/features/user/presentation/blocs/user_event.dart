part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsersEvent extends UserEvent {}

class CreateUserEvent extends UserEvent {
  final User user;
  CreateUserEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class AddAddressEvent extends UserEvent {
  final String userId;
  final Address address;
  AddAddressEvent(this.userId, this.address);
  @override
  List<Object?> get props => [userId, address];
}

class SelectUserEvent extends UserEvent {
  final String userId;
  SelectUserEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class DeleteUserEvent extends UserEvent {
  final String userId;
  DeleteUserEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class DeleteAddressEvent extends UserEvent {
  final String userId;
  final String addressId;
  DeleteAddressEvent(this.userId, this.addressId);
  @override
  List<Object?> get props => [userId, addressId];
}
