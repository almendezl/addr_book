import 'package:addr_book/core/ui/atoms/custom_text.dart';
import 'package:addr_book/core/ui/organisms/custom_appbar.dart';
import 'package:addr_book/l10n/app_localizations.dart';
import 'package:addr_book/src/features/user/domain/entities/user.dart';
import 'package:addr_book/src/features/user/presentation/blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class UserFormPage extends StatefulWidget {
  static const routeName = '/user_form';
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  DateTime? _birthDate;

  final _country = TextEditingController();
  final _department = TextEditingController();
  final _municipality = TextEditingController();
  final _details = TextEditingController();

  String mode = 'create';
  String? userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Map) {
      mode = args['mode'] ?? 'create';
      userId = args['userId'];
      if (mode == 'add_address') setState(() {});
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _country.dispose();
    _department.dispose();
    _municipality.dispose();
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showUserSection = mode == 'create';

    return Scaffold(
      appBar: CustomAppBar(
        title: mode == 'create'
            ? AppLocalizations.of(context)!.formTitleAddUser
            : AppLocalizations.of(context)!.formTitleAddAddress,
        showBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (showUserSection) ...[
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _firstName,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.firstName,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return AppLocalizations.of(context)!.requiredField;
                      }
                      if (v.trim().length < 3) {
                        return AppLocalizations.of(context)!.form3MinCharacter;
                      }
                      if (v.trim().length > 30) {
                        return AppLocalizations.of(context)!.formMaxCharacter;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _lastName,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.lastName,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return AppLocalizations.of(context)!.requiredField;
                      }
                      if (v.trim().length < 3) {
                        return AppLocalizations.of(context)!.form3MinCharacter;
                      }
                      if (v.trim().length > 30) {
                        return AppLocalizations.of(context)!.formMaxCharacter;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _birthDate == null
                              ? AppLocalizations.of(context)!.birthDate
                              : _birthDate!.toIso8601String().split('T').first,
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime(1990),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2020),
                          );
                          if (date != null) setState(() => _birthDate = date);
                        },
                        child: CustomText(
                          text: AppLocalizations.of(context)!.select,
                          color: Colors.white,
                          isBold: true,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).colorScheme.primary),
                ],

                TextFormField(
                  controller: _country,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.country,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return AppLocalizations.of(context)!.requiredField;
                    }
                    if (v.trim().length < 3) {
                      return AppLocalizations.of(context)!.form3MinCharacter;
                    }
                    if (v.trim().length > 30) {
                      return AppLocalizations.of(context)!.formMaxCharacter;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _department,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.state,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return AppLocalizations.of(context)!.requiredField;
                    }
                    if (v.trim().length < 3) {
                      return AppLocalizations.of(context)!.form3MinCharacter;
                    }
                    if (v.trim().length > 30) {
                      return AppLocalizations.of(context)!.formMaxCharacter;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _municipality,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.city,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return AppLocalizations.of(context)!.requiredField;
                    }
                    if (v.trim().length < 3) {
                      return AppLocalizations.of(context)!.form3MinCharacter;
                    }
                    if (v.trim().length > 30) {
                      return AppLocalizations.of(context)!.formMaxCharacter;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _details,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.address,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return AppLocalizations.of(context)!.requiredField;
                    }
                    if (v.trim().length < 8) {
                      return AppLocalizations.of(context)!.form8MinCharacter;
                    }
                    if (v.trim().length > 30) {
                      return AppLocalizations.of(context)!.formMaxCharacter;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red[400]!,
                        side: BorderSide(color: Colors.red[400]!),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: CustomText(
                        text: AppLocalizations.of(context)!.cancel,
                        isBold: true,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue[400]!,
                        side: BorderSide(color: Colors.blue[400]!),
                      ),
                      onPressed: _save,
                      child: CustomText(
                        text: AppLocalizations.of(context)!.save,
                        isBold: true,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (mode == 'create') {
      if (_birthDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(
              text: AppLocalizations.of(context)!.selectBirthDate,
              isBold: true,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
        return;
      }
      final id = const Uuid().v4();
      final user = User(
        id: id,
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        birthDate: _birthDate!,
        addresses: [
          Address(
            id: const Uuid().v4(),
            country: _country.text.trim(),
            department: _department.text.trim(),
            municipality: _municipality.text.trim(),
            details: _details.text.trim(),
          ),
        ],
      );
      context.read<UserBloc>().add(CreateUserEvent(user));
      Navigator.pop(context);
    } else if (mode == 'add_address' && userId != null) {
      final address = Address(
        id: const Uuid().v4(),
        country: _country.text.trim(),
        department: _department.text.trim(),
        municipality: _municipality.text.trim(),
        details: _details.text.trim(),
      );
      context.read<UserBloc>().add(AddAddressEvent(userId!, address));
      Navigator.pop(context);
    }
  }
}
