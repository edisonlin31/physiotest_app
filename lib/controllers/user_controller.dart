import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, List<User>>((ref) {
      return UserController();
    });

class UserController extends StateNotifier<List<User>> {
  UserController() : super([]);

  void addUser(User user) {
    state = [...state, user.copyWith(id: state.length + 1)];
  }

  bool emailExists(String email, int? id) {
    return state.any(
      (user) => user.email == email && (id == null || user.id != id),
    );
  }

  void updateUser(User user) {
    state = [
      for (final existingUser in state)
        if (existingUser.id == user.id) user else existingUser,
    ];
  }

  void deleteUser(int id) {
    state = state.where((user) => user.id != id).toList();
  }

  void incrementQuantity(int userId) {
    state = [
      for (final user in state)
        if (user.id == userId)
          user.copyWith(quantity: user.quantity + 1)
        else
          user,
    ];
  }

  void decrementQuantity(int userId) {
    state = [
      for (final user in state)
        if (user.id == userId && user.quantity > 0)
          user.copyWith(quantity: user.quantity - 1)
        else
          user,
    ];
  }
}
