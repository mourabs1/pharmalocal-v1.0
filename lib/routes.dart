import 'package:flutter/material.dart';
import 'package:pharmalocal/screen/homepage/homepage.dart';
import 'package:pharmalocal/screen/medicamentos/medicamentos.screen.dart';
import 'package:pharmalocal/screen/perfil/perfil.screen.dart';

class PaginasRota extends StatefulWidget {
  @override
  _PaginasRotaState createState() => _PaginasRotaState();
}

class _PaginasRotaState extends State<PaginasRota> {
  int _indexSelecionado = 0;

  static List<Widget> _opcoesTelas = <Widget>[
    Homepage(),
    MedicamentosScreen(),
    Perfil(),
  ];

  void _telaClicada(int index) {
    setState(() {
      _indexSelecionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _opcoesTelas.elementAt(_indexSelecionado),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_outlined),
              label: 'Medicamentos',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.blue,
        onTap: _telaClicada,
      ),
    );
  }
}
