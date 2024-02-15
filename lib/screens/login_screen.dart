import 'package:firebase_demo/preferences/preferences.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  void _loadCredentials() {

    setState(() {
      _userController.text = Preferences.nom;
      _passwordController.text = Preferences.contrasenya; 
      _rememberMe = Preferences.comprobar;
    });
  }

  void _login() {
    // Guarda o elimina las credenciales según el estado de _rememberMe
    if (_rememberMe) {
      Preferences.nom = _userController.text;
      Preferences.contrasenya = _passwordController.text; 
      Preferences.comprobar = _rememberMe;
    } else {
      Preferences.clearCredentials(); 
    }
    // Navega al HomeScreen
    Navigator.pushReplacementNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'Usuari'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contrasenya'),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
                Text('Recorda\'m'),
              ],
            ),
            ElevatedButton(onPressed: _login, child: Text('Inicia Sessió')),
          ],
        ),
      ),
    );
  }
}
