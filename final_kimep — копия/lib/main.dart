import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/news_page.dart';
import 'screens/post_page.dart';
import 'screens/animation_page.dart';
import 'screens/profile_page.dart';

class AuthState {
  final bool isAuthenticated;
  final String? email;

  AuthState({required this.isAuthenticated, this.email});
}

final ValueNotifier<AuthState> authNotifier = ValueNotifier(
  AuthState(isAuthenticated: false),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/localization',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthState>(
      valueListenable: authNotifier,
      builder: (context, authState, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KIMEP University',
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          initialRoute: authState.isAuthenticated ? '/home' : '/login',
          routes: {
            '/login': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
            '/news': (context) => const NewsPage(),
            '/post': (context) => const PostPage(),
            '/animation': (context) => const AnimationPage(),
            '/profile': (context) => const ProfilePage(),
          },
        );
      },
    );
  }
}
