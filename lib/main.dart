import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/create/create_page.dart';
import 'package:nakya/home/home_page.dart';
import 'package:nakya/login/login_page.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/create':
            return MaterialPageRoute(builder: (context) => const CreatePage());
          default:
            return MaterialPageRoute(builder: (context) => const HomePage());
        }
      },
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/create': (context) => const CreatePage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
