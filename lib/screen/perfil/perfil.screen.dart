import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 48),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Saulo Moura',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Text('moura.bsaulo@gmail.com')
        ],
      ),
    );
  }
}
