import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotest_app/base/extensions/string_extensions.dart';
import 'package:physiotest_app/base/utils/app_text_styles.dart';
import 'package:physiotest_app/router/router/router.gr.dart';
import '../controllers/user_controller.dart';

@RoutePage()
class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body:
          users.isEmpty
              ? const Center(child: Text('No users added yet.'))
              : SafeArea(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 80),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final userController = ref.read(
                      userControllerProvider.notifier,
                    );
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName.capitalizeFirst(),
                                style: AppTextStyles.medium(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(user.email),
                              Row(
                                children: [
                                  Text('Total'),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color:
                                          user.quantity == 0
                                              ? Colors.grey
                                              : Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      userController.decrementQuantity(
                                        user.id!,
                                      );
                                    },
                                  ),
                                  Text(
                                    '${user.quantity}',
                                    style: AppTextStyles.medium(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      userController.incrementQuantity(
                                        user.id!,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              context.router.push(UserFormRoute(user: user));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(UserFormRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
