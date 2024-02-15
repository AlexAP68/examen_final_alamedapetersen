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

//Se inicia
  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

//Carga las credenciales y si existen envia al usuario directamente al homescreen
  void _loadCredentials() {
  final userName = Preferences.nom;
  final password = Preferences.contrasenya;


  _userController.text = userName;
  _passwordController.text = password;


  if (userName.isNotEmpty && password.isNotEmpty) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }
}

//Al darle al boton de login guarda las variables
  void _login() {
    final userName = _userController.text;
    final password = _passwordController.text;

    // Solo guarda las credenciales si los campos no están vacíos.
    if (userName.isNotEmpty && password.isNotEmpty) {
      Preferences.nom = userName;
      Preferences.contrasenya = password;

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
            ElevatedButton(onPressed: _login, child: Text('Inicia Sessió')),
          ],
        ),
      ),
    );
  }
}






