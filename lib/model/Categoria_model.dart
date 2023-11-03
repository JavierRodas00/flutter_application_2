// ignore_for_file: file_names, non_constant_identifier_names

class CategoriaModel {
  String id_categoria = "";
  String descripcion_categoria = "";

  CategoriaModel(this.id_categoria, this.descripcion_categoria);

  CategoriaModel.fromJson(Map<String, dynamic> json) {
    id_categoria = json["id_categoria"];
    descripcion_categoria = json["descripcion_categoria"];
  }
}
