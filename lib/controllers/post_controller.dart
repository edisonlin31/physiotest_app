import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotest_app/repositories/post_repository.dart';
import '../models/post.dart';

final postController =
    StateNotifierProvider<PostController, AsyncValue<List<Post>>>(
      (ref) => PostController(ref),
    );

class PostController extends StateNotifier<AsyncValue<List<Post>>> {
  final Ref _ref;

  PostController(this._ref) : super(const AsyncLoading()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    state = const AsyncLoading();
    try {
      final posts = await _ref.read(postRepositoryProvider).fetchPosts();
      state = AsyncData(posts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
