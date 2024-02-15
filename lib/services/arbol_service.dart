import 'dart:convert';
import '../models/models.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArbolService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String _baseUrl = "pruebaexamen-d2eea-default-rtdb.europe-west1.firebasedatabase.app";
  List<Arbol> arboles = [];
  late Arbol tempArbol; // Usado para formularios temporales

//Constructor carga los arboles
  ArbolService() {
    this.loadArboles();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

// Cargamos los arboles
  loadArboles() async {
    arboles.clear();
    final url = Uri.https(_baseUrl, 'Arbol.json'); 
    final response = await http.get(url);
    final Map<String, dynamic> arbolesMap = json.decode(response.body) ?? {};

    arbolesMap.forEach((key, value) {
      final tempValue = Map<String, dynamic>.from(value);
      tempValue["id"] = key; // Asegura asignar el ID correcto desde la clave de Firebase
      final auxArbol = Arbol.fromMap(tempValue);
      arboles.add(auxArbol);
    });

    notifyListeners();
  }

// Guardamos o creamos un árbol
  Future saveOrCreateArbol() async {
    if (tempArbol.id == null) {
      await this.createArbol(); // Creamos el árbol si no tiene ID
    } else {
      await this.updateArbol(); // Actualizamos si ya tiene ID
    }
    loadArboles();
  }

//actualizamos el arbol
  updateArbol() async {
    final url = Uri.https(_baseUrl, 'Arbol/${tempArbol.id}.json');
    final response = await http.put(url, body: tempArbol.toJson());
    final decodedData = json.decode(response.body);
  }

//creamos el arbol
  createArbol() async {
    final url = Uri.https(_baseUrl, 'Arbol.json');
    final response = await http.post(url, body: tempArbol.toJson());
    final decodedData = json.decode(response.body);
    if (decodedData != null && decodedData["name"] != null) {
      tempArbol.id = decodedData["name"];
    }
  }

//borramos el arbol
  deleteArbol(Arbol arbol) async {
    // Asegúrate de usar el ID para eliminar, no el nombre
    final url = Uri.https(_baseUrl, 'Arbol/${arbol.id}.json');
    final response = await http.delete(url);
    final decodedData = json.decode(response.body);
    print(decodedData); // Opcional: manejar la respuesta
    loadArboles();
  }
}
