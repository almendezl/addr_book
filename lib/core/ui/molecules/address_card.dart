import 'package:addr_book/core/ui/atoms/custom_icon_button.dart';
import 'package:addr_book/core/ui/atoms/custom_text.dart';
import 'package:addr_book/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String country;
  final String department;
  final String municipality;
  final String details;
  final VoidCallback onDelete;

  const AddressCard({
    super.key,
    required this.country,
    required this.department,
    required this.municipality,
    required this.details,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color.fromARGB(255, 190, 176, 214),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: '${AppLocalizations.of(context)!.country}: $country',
                    fontSize: 16,
                  ),
                  CustomText(
                    text: '${AppLocalizations.of(context)!.state}: $department',
                    fontSize: 16,
                  ),
                  CustomText(
                    text:
                        '${AppLocalizations.of(context)!.city}: $municipality',
                    fontSize: 16,
                  ),
                  CustomText(text: details, fontSize: 16),
                ],
              ),
            ),
            CustomIconButton(
              icon: Icons.delete_forever,
              color: Theme.of(context).colorScheme.primary,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
