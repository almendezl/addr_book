import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String id;
  final String country;
  final String department;
  final String municipality;
  final String details;

  const Address({
    required this.id,
    required this.country,
    required this.department,
    required this.municipality,
    required this.details,
  });

  @override
  List<Object?> get props => [id, country, department, municipality, details];
}

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<Address> addresses;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.addresses = const [],
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    List<Address>? addresses,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, birthDate, addresses];
}
