// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:physiotest_app/models/user.dart' as _i7;
import 'package:physiotest_app/pages.dart/home_page.dart' as _i1;
import 'package:physiotest_app/pages.dart/posts_page.dart' as _i2;
import 'package:physiotest_app/pages.dart/user_form_page.dart' as _i3;
import 'package:physiotest_app/pages.dart/user_list_page.dart' as _i4;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.PostsPage]
class PostsRoute extends _i5.PageRouteInfo<void> {
  const PostsRoute({List<_i5.PageRouteInfo>? children})
    : super(PostsRoute.name, initialChildren: children);

  static const String name = 'PostsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.PostsPage();
    },
  );
}

/// generated route for
/// [_i3.UserFormPage]
class UserFormRoute extends _i5.PageRouteInfo<UserFormRouteArgs> {
  UserFormRoute({
    _i6.Key? key,
    _i7.User? user,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         UserFormRoute.name,
         args: UserFormRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'UserFormRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserFormRouteArgs>(
        orElse: () => const UserFormRouteArgs(),
      );
      return _i3.UserFormPage(key: args.key, user: args.user);
    },
  );
}

class UserFormRouteArgs {
  const UserFormRouteArgs({this.key, this.user});

  final _i6.Key? key;

  final _i7.User? user;

  @override
  String toString() {
    return 'UserFormRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i4.UserListPage]
class UserListRoute extends _i5.PageRouteInfo<void> {
  const UserListRoute({List<_i5.PageRouteInfo>? children})
    : super(UserListRoute.name, initialChildren: children);

  static const String name = 'UserListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.UserListPage();
    },
  );
}
