import 'package:addr_book/src/features/user/domain/entities/user.dart'
    as domain;
import 'package:hive/hive.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 0)
class AddressHive {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String country;

  @HiveField(2)
  final String department;

  @HiveField(3)
  final String municipality;

  @HiveField(4)
  final String details;

  AddressHive({
    required this.id,
    required this.country,
    required this.department,
    required this.municipality,
    required this.details,
  });

  domain.Address toDomain() => domain.Address(
    id: id,
    country: country,
    department: department,
    municipality: municipality,
    details: details,
  );

  factory AddressHive.fromDomain(domain.Address a) => AddressHive(
    id: a.id,
    country: a.country,
    department: a.department,
    municipality: a.municipality,
    details: a.details,
  );
}

@HiveType(typeId: 1)
class UserHive {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final DateTime birthDate;

  @HiveField(4)
  final List<AddressHive> addresses;

  UserHive({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.addresses,
  });

  domain.User toDomain() => domain.User(
    id: id,
    firstName: firstName,
    lastName: lastName,
    birthDate: birthDate,
    addresses: addresses.map((a) => a.toDomain()).toList(),
  );

  factory UserHive.fromDomain(domain.User u) => UserHive(
    id: u.id,
    firstName: u.firstName,
    lastName: u.lastName,
    birthDate: u.birthDate,
    addresses: u.addresses.map((a) => AddressHive.fromDomain(a)).toList(),
  );
}
