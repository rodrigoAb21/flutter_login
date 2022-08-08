import 'package:flutter/material.dart';
import 'package:flutter_login/src/pages/home_page.dart';
import 'package:flutter_login/src/pages/login_page.dart';
import 'package:flutter_login/src/utils/preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(Preferences.nombre),
            accountEmail: Text(Preferences.email),
            /* decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/menu-img2.jpg'),
                    fit: BoxFit.cover)), */
          ),
          ListTile(
            leading: const Icon(Icons.pages_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.blue,
            ),
            title: const Text('Log out'),
            onTap: () {
              Preferences.nombre = '';
              Preferences.email = '';
              Preferences.token = '';
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
