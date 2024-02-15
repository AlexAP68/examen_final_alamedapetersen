import 'dart:convert';

//Clase Arbol de lla firebase
class Arbol {
  Arbol({
    this.id,
    required this.autocton,
    required this.detall,
    required this.foto,
    required this.nom,
    required this.tipus,
    required this.varietat,
  });

  String? id;
  bool autocton;
  String detall;
  String foto;
  String nom;
  String tipus;
  String varietat;

  // Convertir de JSON (String) a Arbol
  factory Arbol.fromJson(String str) => Arbol.fromMap(json.decode(str));

  // Convertir de Arbol a JSON (String)
  String toJson() => json.encode(toMap());

  // Crear un Arbol a partir de un Map
  factory Arbol.fromMap(Map<String, dynamic> json) => Arbol(
        id: json["id"],
        autocton: json["autocton"],
        detall: json["detall"],
        foto: json["foto"],
        nom: json["nom"],
        tipus: json["tipus"],
        varietat: json["varietat"],
      );

  // Convertir un Arbol a Map
  Map<String, dynamic> toMap() => {
         "id": id,
        "autocton": autocton,
        "detall": detall,
        "foto": foto,
        "nom": nom,
        "tipus": tipus,
        "varietat": varietat,
      };

  // Método para crear una copia de un Arbol con la posibilidad de cambiar algunos campos
  Arbol copyWith({
    String? id,
    bool? autocton,
    String? detall,
    String? foto,
    String? nom,
    String? tipus,
    String? varietat,
  }) =>
      Arbol(
        id: id ?? this.id,
        autocton: autocton ?? this.autocton,
        detall: detall ?? this.detall,
        foto: foto ?? this.foto,
        nom: nom ?? this.nom,
        tipus: tipus ?? this.tipus,
        varietat: varietat ?? this.varietat,
      );
}
