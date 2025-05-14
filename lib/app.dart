import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:physiotest_app/base/utils/app_text_styles.dart';
import 'package:physiotest_app/base/utils/colors.dart';
import 'package:physiotest_app/router/router/router.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  createState() => _App();
}

class _App extends State<App> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Test App",
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      routerConfig: _router.config(),

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.lightGrey,
        fontFamily: GoogleFonts.openSans().fontFamily,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, // Change this to your desired base color
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          titleTextStyle: AppTextStyles.medium(
            fontSize: 16,
            color: Colors.black,
          ),
          elevation: 0.3,
          iconTheme: const IconThemeData(color: AppColors.primary),
        ),
      ),
    );
  }
}
