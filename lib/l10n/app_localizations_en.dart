// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get userListTitle => 'Users';

  @override
  String get noUsers => 'No users registered';

  @override
  String get noAddresses => 'No addresses registered';

  @override
  String get addUserButton => 'Add user';

  @override
  String get userDetailTitle => 'User details';

  @override
  String get addAddressButton => 'Add address';

  @override
  String get addresses => 'Addresses';

  @override
  String get formTitleAddUser => 'Create user';

  @override
  String get formTitleAddAddress => 'Add address';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get birthDate => 'Birth date';

  @override
  String get country => 'Country';

  @override
  String get state => 'State';

  @override
  String get city => 'City';

  @override
  String get address => 'Physical address';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidDate => 'Invalid date';

  @override
  String get error => 'Error';

  @override
  String get select => 'Select';

  @override
  String get form8MinCharacter => 'Must be at least 8 characters long';

  @override
  String get form3MinCharacter => 'Must be at least 3 characters long';

  @override
  String get formMaxCharacter => 'Must be no longer than 30 characters';

  @override
  String get selectBirthDate => 'Please enter a date of birth';
}
