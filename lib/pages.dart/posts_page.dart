import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotest_app/base/utils/app_text_styles.dart';
import 'package:physiotest_app/base/widgets/app_button.dart';
import 'package:physiotest_app/controllers/post_controller.dart';

@RoutePage()
class PostsPage extends ConsumerStatefulWidget {
  const PostsPage({super.key});

  @override
  ConsumerState<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends ConsumerState<PostsPage> {
  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postController);
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: postState.when(
        data: (data) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref.read(postController.notifier).fetchPosts();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final post = data[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          post.title,
                          style: AppTextStyles.medium(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(post.body),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Failed to load posts', style: AppTextStyles.medium()),
                  const SizedBox(height: 8),
                  AppButton(
                    text: 'Retry',
                    onPressed: () {
                      ref.read(postController.notifier).fetchPosts();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
