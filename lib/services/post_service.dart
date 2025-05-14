import 'package:dio/dio.dart';
import 'package:physiotest_app/models/post.dart';
import 'package:retrofit/retrofit.dart';

part 'post_service.g.dart';

@RestApi()
abstract class PostService {
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  @GET('/posts')
  Future<List<Post>> fetchPosts();
}
