import '../models/models.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Arbol arbol;
  const UserCard({super.key, required this.arbol});

  @override
  Widget build(BuildContext context) {
    // Muestra la información del arbol
    return ListTile(
      leading: CircleAvatar(child: Text(arbol.nom[0])), // Muestra la primera letra del nombre
      title: Text(arbol.nom), // Muestra el nombre del arbol
      subtitle: Text(
        arbol.varietat, // Muestra la variedad del arbol
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
    );
  }
}
