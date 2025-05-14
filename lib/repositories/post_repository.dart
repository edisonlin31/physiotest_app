import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotest_app/base/api/api.dart';
import 'package:physiotest_app/models/post.dart';
import 'package:physiotest_app/services/post_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

class PostRepository {
  final PostService service = PostService(
    Api.client,
    baseUrl: 'https://jsonplaceholder.typicode.com',
  );

  PostRepository();

  Future<List<Post>> fetchPosts() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final posts = await service.fetchPosts();
      final encodedPosts = jsonEncode(posts.map((e) => e.toJson()).toList());
      await prefs.setString('cached_posts', encodedPosts);
      return posts;
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionError) {
        final cachedPosts = prefs.getString('cached_posts');
        if (cachedPosts != null) {
          final List<dynamic> decoded = jsonDecode(cachedPosts);
          final posts = decoded.map((e) => Post.fromJson(e)).toList();
          return posts;
        }
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
