import 'package:uuid/uuid.dart';

class Alarme {
  String id = Uuid().v4();
  String usuario = "Saulo";
  String titulo;
  String horaInicial;
  int recorrencia;
  int prazo;

  Alarme({
    this.id,
    this.titulo,
    this.usuario,
    this.horaInicial,
    this.recorrencia,
    this.prazo,
  });

  Alarme.novo({this.titulo, this.horaInicial, this.recorrencia, this.prazo});

  Alarme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    horaInicial = json['horaInicial'];
    recorrencia = json['recorrencia'];
    prazo = json['prazo'];
  }

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'user': usuario,
        'horaInicial': horaInicial,
        'recorrencia': recorrencia,
        'prazo': prazo
      };

  @override
  String toString() {
    return 'ID: ${this.id}, TITULO: ${this.titulo}, HORA INICIAL: ${this.horaInicial}, RECOR: ${this.recorrencia}, PRAZO: ${this.prazo}';
  }
}
