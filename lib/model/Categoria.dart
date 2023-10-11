class Categoria {
  String id_categoria = "";
  String descripcion_categoria = "";

  Categoria(this.id_categoria, this.descripcion_categoria);

  Categoria.fromJson(Map<String, dynamic> json) {
    id_categoria = json["id_categoria"];
    descripcion_categoria = json["descripcion_categoria"];
  }
}
