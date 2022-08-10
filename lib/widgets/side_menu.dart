import 'package:flutter/material.dart';
import 'package:flutter_login/src/pages/home_page.dart';
import 'package:flutter_login/src/pages/login_page.dart';
import 'package:flutter_login/src/utils/preferences.dart';
import 'package:http/http.dart' as http;

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  _logout(BuildContext context) async {
    final resp = await http.post(Uri.http('192.168.1.163:8000', '/api/logout'),
        headers: {
          "Accept": "application/json",
          "Authorization": Preferences.token
        });

    if (resp.statusCode == 200) {
      Preferences.token = '';
      Preferences.email = '';
      Preferences.nombre = '';
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      debugPrint('ERRRRROR');
    }
  }
}
