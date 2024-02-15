import 'package:firebase_demo/services/arbol_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/input_decorations.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arbolService = Provider.of<ArbolService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Árbol'),
      ),
      body: _ArbolForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (arbolService.isValidForm()) {
            arbolService.saveOrCreateArbol();
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _ArbolForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arbolService = Provider.of<ArbolService>(context);
    final tempArbol = arbolService.tempArbol;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: arbolService.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                // Mostramos la foto si existe
                if (tempArbol.foto.isNotEmpty)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        tempArbol.foto,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                SizedBox(height: 20),
                //Mostramos el nombre
                TextFormField(
                  initialValue: tempArbol.nom,
                  onChanged: (value) => tempArbol.nom = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'El nombre es obligatorio';
                    return null; // Corregido para incluir return null en validators
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del árbol', labelText: 'Nombre:'),
                ),
                SizedBox(height: 30),
                //Mostramos la variedad
                TextFormField(
                  initialValue: tempArbol.varietat,
                  onChanged: (value) => tempArbol.varietat = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'La variedad es obligatoria';
                    return null; // Corregido para incluir return null en validators
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Variedad', labelText: 'Variedad:'),
                ),
                SizedBox(height: 30),
                //Mostramos el tipo
                TextFormField(
                  initialValue: tempArbol.tipus,
                  onChanged: (value) => tempArbol.tipus = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'El tipo es obligatorio';
                    return null; // Corregido para incluir return null en validators
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Tipo de árbol', labelText: 'Tipo:'),
                ),
                SizedBox(height: 30),
                //Mostramos si es autóctono seleccionando un switch
                SwitchListTile(
                  title: Text('¿Autóctono?'),
                  value: tempArbol.autocton,
                 onChanged: (value) {
                  print("Cambiando autocton a $value");
                  arbolService.tempArbol.autocton = value;
                  // Si ArbolService es un ChangeNotifier, puedes necesitar llamar a notifyListeners aquí
                  arbolService.notifyListeners();
},
                ),
                SizedBox(height: 30),
                //Mostramos la url de la foto
                TextFormField(
                  initialValue: tempArbol.foto,
                  onChanged: (value) => tempArbol.foto = value,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'URL de la foto', labelText: 'Foto:'),
                ),
                SizedBox(height: 30),
                //Mostramos el detalle. Si es una URL, se muestra un icono para abrir el enlace
                TextFormField(
                controller: TextEditingController(text: tempArbol.detall),
                onChanged: (value) => tempArbol.detall = value,
                decoration: InputDecoration(
                  hintText: 'Detalle del árbol',
                  labelText: 'Detalle:',
                  suffixIcon: IconButton( 
                    icon: Icon(Icons.link),
                    onPressed: () async {
                      if (await canLaunchUrl(tempArbol.detall as Uri)) {
                        await launch(tempArbol.detall);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No se pudo abrir el enlace')),
                        );
                      }
                    },
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}
