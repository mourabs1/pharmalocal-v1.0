import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmalocal/model/medicamentos.dart';

class MedicamentosApi {
  var url = Uri.https('pharmalocal.herokuapp.com', '/meds');

  Future<List<Medicamentos>> getAll() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> decodeJson = jsonDecode(response.body);
      return decodeJson.map((json) => Medicamentos.fromJson(json)).toList();
    } else {
      throw Exception('Erro');
    }
  }
}
