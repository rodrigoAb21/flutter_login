import 'package:flutter_login/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/utils/preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 30),
              child: Center(
                  child: SizedBox(
                      width: 250,
                      height: 150,
                      child: Image.asset('images/flutter-logo.png'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    /* focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    labelStyle: TextStyle(color: Colors.grey), */
                    labelText: 'Email',
                    hintText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 30),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    /* focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    labelStyle: TextStyle(color: Colors.grey), */
                    labelText: 'Password',
                    hintText: 'Password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  _enviar();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  _enviar() async {
    final datos = {
      'email': emailController.text,
      'password': passwordController.text,
      'device_name': 'flutter App'
    };

    final resp = await http.post(Uri.http('192.168.1.163:8000', '/api/login'),
        body: datos,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        });

    var decodedResp = convert.jsonDecode(resp.body);
    //debugPrint(decodedResp);

    if (decodedResp.containsKey('access_token')) {
      Preferences.token = 'Bearer ${decodedResp['access_token']}';

      final r2 = await http.get(Uri.http('192.168.1.163:8000', '/api/user'),
          headers: {
            "Accept": "application/json",
            "Authorization": Preferences.token
          });
      if (r2.statusCode == 200) {
        debugPrint("entra a if 200");
        var decodedResp = convert.jsonDecode(r2.body);
        Preferences.email = decodedResp['email'];
        Preferences.nombre = decodedResp['nombre'];
        debugPrint("entra a if 200    2");
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        debugPrint('ERRRRROR!');
      }
    }
  }
}
