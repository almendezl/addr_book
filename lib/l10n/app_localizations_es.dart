// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get userListTitle => 'Usuarios';

  @override
  String get noUsers => 'No hay usuarios registrados';

  @override
  String get noAddresses => 'No hay direcciones registradas';

  @override
  String get addUserButton => 'Agregar usuario';

  @override
  String get userDetailTitle => 'Detalle del usuario';

  @override
  String get addAddressButton => 'Agregar dirección';

  @override
  String get addresses => 'Direcciones';

  @override
  String get formTitleAddUser => 'Crear usuario';

  @override
  String get formTitleAddAddress => 'Agregar dirección';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get birthDate => 'Fecha de nacimiento';

  @override
  String get country => 'País';

  @override
  String get state => 'Departamento';

  @override
  String get city => 'Municipio';

  @override
  String get address => 'Dirección física';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get requiredField => 'Este campo es obligatorio';

  @override
  String get invalidDate => 'Fecha inválida';

  @override
  String get error => 'Error';

  @override
  String get select => 'Seleccionar';

  @override
  String get form8MinCharacter => 'Debe tener al menos 8 caracteres';

  @override
  String get form3MinCharacter => 'Debe tener al menos 3 caracteres';

  @override
  String get formMaxCharacter => 'Debe tener máximo 30 caracteres';

  @override
  String get selectBirthDate => 'Seleccione una fecha de nacimiento';
}
