import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const User._();
  factory User({
    required String fullName,
    required String email,
    int? id,
    @Default(0) int quantity,
  }) = _User;
}
