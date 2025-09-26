import 'package:addr_book/core/ui/atoms/custom_text.dart';
import 'package:addr_book/core/ui/molecules/user_card.dart';
import 'package:addr_book/core/ui/organisms/custom_appbar.dart';
import 'package:addr_book/l10n/app_localizations.dart';
import 'package:addr_book/src/features/user/presentation/blocs/user_bloc.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_detail_page.dart';
import 'package:addr_book/src/features/user/presentation/pages/user_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatefulWidget {
  static const routeName = '/';
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsersEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<UserBloc>().add(LoadUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.userListTitle,
        showBack: false,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UsersLoaded) {
            final users = state.users;
            if (users.isEmpty) {
              return Center(
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
                      text: AppLocalizations.of(context)!.noUsers,
                      isBold: true,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) {
                final u = users[i];
                return UserCard(
                  title: '${u.firstName} ${u.lastName}',
                  subtitle:
                      '${AppLocalizations.of(context)!.addresses}: ${u.addresses.length}',
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      UserDetailPage.routeName,
                      arguments: u.id,
                    );
                    context.read<UserBloc>().add(LoadUsersEvent());
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.alert),
                        content: Text(
                          AppLocalizations.of(context)!.deleteMessage,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<UserBloc>().add(
                                DeleteUserEvent(u.id),
                              );
                            },
                            child: Text(AppLocalizations.of(context)!.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
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
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            UserFormPage.routeName,
            arguments: {'mode': 'create'},
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
