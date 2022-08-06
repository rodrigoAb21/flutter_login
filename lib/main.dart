import 'package:flutter/material.dart';

import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName : ( BuildContext context ) => const LoginPage(),
        HomePage.routeName : ( BuildContext context ) => const HomePage(),
      },
    );
  }
}