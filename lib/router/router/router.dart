import 'package:auto_route/auto_route.dart';
import 'package:physiotest_app/router/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      initial: true,
      page: HomeRoute.page,
      children: [
        AutoRoute(path: 'home', page: PostsRoute.page),
        AutoRoute(path: 'users', page: UserListRoute.page),
      ],
    ),
    AutoRoute(path: '/user-form', page: UserFormRoute.page),
  ];
}
