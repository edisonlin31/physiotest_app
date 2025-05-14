import 'package:freezed_annotation/freezed_annotation.dart';
part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const Post._();
  factory Post({
    required int id,
    required String title,
    required String body,
    int? userId,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
