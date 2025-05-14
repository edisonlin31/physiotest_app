import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotest_app/base/widgets/app_button.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class UserFormPage extends ConsumerStatefulWidget {
  final User? user;

  const UserFormPage({super.key, this.user});

  @override
  ConsumerState<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends ConsumerState<UserFormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _formChanged = false;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _formKey.currentState?.patchValue({
          'fullName': widget.user!.fullName,
          'email': widget.user!.email,
        });
      });
    }
  }

  _onSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final user = User(fullName: values['fullName'], email: values['email']);
      final userController = ref.read(userControllerProvider.notifier);
      if (userController.emailExists(user.email, widget.user?.id)) {
        _formKey.currentState?.fields['email']?.invalidate(
          'Email already exists!',
        );
        return;
      }
      if (widget.user == null) {
        userController.addUser(user);
      } else {
        userController.updateUser(user);
      }

      context.router.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.user == null
                ? 'User added successfully!'
                : 'User updated successfully!',
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  _onDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      ref.read(userControllerProvider.notifier).deleteUser(widget.user!.id!);
      context.router.back();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User deleted successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  _onPop(bool didPop, Object? result) async {
    if (!didPop) {
      if (!_formChanged) {
        context.router.back();
        return;
      }
      final shouldPop = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Discard Changes?'),
              content: const Text(
                'Are you sure you want to discard your changes?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Discard'),
                ),
              ],
            ),
      );
      if (shouldPop == true && context.mounted) {
        context.router.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user != null ? 'Edit User' : 'Add User'),
          actions:
              widget.user != null
                  ? [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: _onDelete,
                    ),
                  ]
                  : null,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    onChanged: () {
                      setState(() {
                        _formChanged = true;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name'),
                        const SizedBox(height: 8),
                        FormBuilderTextField(
                          name: 'fullName',
                          maxLength: 50,
                          decoration: formDecoration.copyWith(
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        Text('Email'),
                        const SizedBox(height: 8),
                        FormBuilderTextField(
                          name: 'email',
                          decoration: formDecoration.copyWith(
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(onPressed: _onSubmit, text: 'Submit'),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
