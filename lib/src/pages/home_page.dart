import 'package:flutter/material.dart';
import '../utils/preferences.dart';
import '../../widgets/side_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const SideMenu(),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: ${Preferences.nombre}'),
            const Divider(),
            Text('Email: ${Preferences.email}'),
            const Divider(),
            Text('Token: ${Preferences.token}'),
            const Divider(),
          ],
        ));
  }
}
