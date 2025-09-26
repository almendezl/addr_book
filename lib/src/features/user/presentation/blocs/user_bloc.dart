import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/domain/usecases/add_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/create_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_address_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_user_usecase.dart';
import 'package:addr_book/src/features/user/domain/usecases/get_users_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUserUseCase createUser;
  final AddAddressUseCase addAddress;
  final GetUsersUseCase getUsers;
  final GetUserUseCase getUser;
  final DeleteUserUseCase deleteUser;
  final DeleteAddressUseCase deleteAddress;

  UserBloc({
    required this.createUser,
    required this.addAddress,
    required this.getUsers,
    required this.getUser,
    required this.deleteUser,
    required this.deleteAddress,
  }) : super(UserInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<CreateUserEvent>(_onCreateUser);
    on<AddAddressEvent>(_onAddAddress);
    on<SelectUserEvent>(_onSelectUser);
    on<DeleteUserEvent>(_onDeleteUser);
    on<DeleteAddressEvent>(_onDeleteAddress);
  }
  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await deleteUser.call(event.userId);
      final users = await getUsers.call();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onDeleteAddress(
    DeleteAddressEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await deleteAddress.call(event.userId, event.addressId);
      final user = await getUser.call(event.userId);
      if (user != null) {
        emit(UserSelected(user));
      } else {
        final users = await getUsers.call();
        emit(UsersLoaded(users));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final users = await getUsers.call();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await createUser.call(event.user);
      final users = await getUsers.call();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onAddAddress(
    AddAddressEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await addAddress.call(event.userId, event.address);
      final users = await getUsers.call();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onSelectUser(
    SelectUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final users = await getUsers.call();
      final selected = users.firstWhere(
        (u) => u.id == event.userId,
        orElse: () => throw Exception('Usuario no encontrado'),
      );
      emit(UserSelected(selected));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
