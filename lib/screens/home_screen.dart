import 'package:firebase_demo/models/arbol.dart';
import 'package:firebase_demo/preferences/preferences.dart';
import 'package:firebase_demo/screens/login_screen.dart';
import 'package:firebase_demo/services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../ui/ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<ArbolService>(context);
    List<Arbol> arboles = userService.arboles;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
  icon: const Icon(Icons.exit_to_app),
  // Al presionar para cerrar sesión
  onPressed: () {
    // Limpia las credenciales guardadas
    Preferences.clearCredentials();

 

    // Redirige al usuario a la pantalla de login
    Navigator.pushReplacementNamed(context, 'login');
  },
),

        ],
      ),
      //Si no hay usuarios muestra un loading y si no hay arboles muestra la lista(tarda un poco en cargar la lista)
      body: arboles.isEmpty
          ? Loading()
          : ListView.builder(
              itemCount: arboles.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: GestureDetector(
                    child: UserCard(arbol: arboles[index]),
                    //Vamos a la pantalla de detalles del arbol
                    onTap: () {
                      userService.tempArbol = arboles[index].copyWith();
                      Navigator.of(context).pushNamed('detail');
                    },
                  ),
                  //Borramos el arbol si deslizamos a la izquierda
                  onDismissed: (direction) {
                    if (arboles.length < 2) {
                      userService.loadArboles();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('No es pot esborrar tots els elements!')));
                    } else {
                      userService.deleteArbol(arboles[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${userService.arboles[index].nom} esborrat')));
                    }
                  },
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        //Creamos un arbol nuevo
        onPressed: () {
          
          userService.tempArbol = Arbol(
              autocton: false,
              detall: '',
              foto: '',
              nom: '',
              tipus: '',
              varietat: '');
          Navigator.of(context).pushNamed('detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
