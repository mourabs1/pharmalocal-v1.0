import 'package:flutter/material.dart';
import 'package:pharmalocal/model/medicamentos.dart';

class MedicamentosDetailScreen extends StatefulWidget {
  final Medicamentos medicamentos;

  MedicamentosDetailScreen({@required this.medicamentos});
  @override
  _MedicamentosDetailScreenState createState() =>
      _MedicamentosDetailScreenState();
}

class _MedicamentosDetailScreenState extends State<MedicamentosDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicamentos.nomeComercial),
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Nome comercial: ${widget.medicamentos.nomeComercial}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Laboratorio: ${widget.medicamentos.laboratorio}',
          style: TextStyle(fontSize: 18),
        ),
        // Text(
        //   'Genérico: $',
        //   style: TextStyle(fontSize: 18),
        // ),
        Text(
          'Principio Ativo: ${widget.medicamentos.nomePrincipioAtivo}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Forma Farmaceutica: ${widget.medicamentos.formaFarmaceutica}',
          style: TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
