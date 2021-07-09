import 'package:flutter/material.dart';
import 'package:pharmalocal/model/alarm.dart';

class AlarmeDetailScreen extends StatefulWidget {
  final Alarme alarme;

  AlarmeDetailScreen({@required this.alarme});
  @override
  _AlarmeDetailScreenState createState() => _AlarmeDetailScreenState();
}

class _AlarmeDetailScreenState extends State<AlarmeDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarme.titulo),
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '${widget.alarme.usuario}, ${widget.alarme.titulo}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'A cada: ${widget.alarme.recorrencia} horas, durante ${widget.alarme.prazo} dias.',
          style: TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
