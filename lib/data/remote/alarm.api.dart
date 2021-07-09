import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmalocal/model/alarm.dart';

class AlarmeApi {
  var url = Uri.https('pharmalocal.herokuapp.com', '/alarm');

  Future<List<Alarme>> getAll() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> decodeJson = jsonDecode(response.body);
      return decodeJson.map((json) => Alarme.fromJson(json)).toList();
    } else {
      throw Exception('Erro');
    }
  }

  Future<Alarme> save(Alarme alarme) async {
    final String transacaoJson = jsonEncode(alarme.toJson());
    final response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: transacaoJson);

    if (response.statusCode == 201) {
      return Alarme.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create alarm.');
    }
  }
}
