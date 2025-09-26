import 'package:addr_book/core/ui/atoms/custom_text.dart';
import 'package:addr_book/core/ui/molecules/address_card.dart';
import 'package:addr_book/core/ui/organisms/custom_appbar.dart';
import 'package:addr_book/l10n/app_localizations.dart';
import 'package:addr_book/src/features/user/presentation/blocs/user_bloc.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailPage extends StatefulWidget {
  static const routeName = '/user_detail';
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  String? userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is String) userId = args;
    if (userId != null) {
      context.read<UserBloc>().add(SelectUserEvent(userId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.userDetailTitle,
        showBack: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserSelected) {
            final u = state.user;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: '${u.firstName} ${u.lastName}',
                      isBold: true,
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text:
                          '${AppLocalizations.of(context)!.birthDate}: ${u.birthDate.toIso8601String().split('T').first}',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 12),
                    CustomText(
                      text: AppLocalizations.of(context)!.addresses,
                      isBold: true,
                      fontSize: 18,
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: u.addresses.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/caja_vacia.png',
                                    width: 120,
                                    height: 120,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomText(
                                    text: AppLocalizations.of(
                                      context,
                                    )!.noAddresses,
                                    isBold: true,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: u.addresses.length,
                              itemBuilder: (_, i) {
                                final a = u.addresses[i];
                                return AddressCard(
                                  country: a.country,
                                  department: a.department,
                                  municipality: a.municipality,
                                  details: a.details,
                                  onDelete: () {
                                    context.read<UserBloc>().add(
                                      DeleteAddressEvent(u.id, a.id),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is UserError) {
            return Center(
              child: CustomText(
                text:
                    '${AppLocalizations.of(context)!.error}: ${state.message}',
                isBold: true,
                color: Colors.black,
                fontSize: 18,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          onPressed: () {
            if (context.read<UserBloc>().state is UserSelected) {
              final u = (context.read<UserBloc>().state as UserSelected).user;
              Navigator.pushNamed(
                context,
                UserFormPage.routeName,
                arguments: {'mode': 'add_address', 'userId': u.id},
              );
            }
          },
          icon: const Icon(Icons.add),
          label: CustomText(
            text: AppLocalizations.of(context)!.addAddressButton,
            isBold: true,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
