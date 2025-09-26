import 'package:addr_book/core/ui/atoms/custom_icon_button.dart';
import 'package:addr_book/core/ui/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const UserCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color.fromARGB(255, 190, 176, 214),
          width: 1,
        ),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      isBold: true,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: subtitle,
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              CustomIconButton(
                icon: Icons.delete_forever,
                color: Theme.of(context).colorScheme.primary,
                onPressed: onDelete ?? () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
