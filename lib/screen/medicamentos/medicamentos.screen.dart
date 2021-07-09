import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmalocal/data/remote/medicamentos.api.dart';
import 'package:pharmalocal/model/medicamentos.dart';
import 'package:pharmalocal/screen/medicamentos/medicamentos_detail.screen.dart';

class MedicamentosScreen extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<MedicamentosScreen> {
  bool comercialOuPrincipio = true;
  List<Medicamentos> _medicamentos = <Medicamentos>[];
  String query = '';

  MedicamentosApi _medicamentosApi;

  @override
  void initState() {
    _medicamentosApi = MedicamentosApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicamentos'),
      ),
      body: _body(),
    );
  }

  _body() {
    return FutureBuilder<List<Medicamentos>>(
      future: _medicamentosApi.getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Medicamentos> medicamentos = snapshot.data;
          medicamentos.sort((a, b) {
            return a.nomeComercial.compareTo(b.nomeComercial);
          });
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: comercialOuPrincipio == true
                            ? 'Procure por nome comercial...'
                            : 'Procure por principio ativo...'),
                    onChanged: (text) {
                      text = text.toLowerCase();
                      comercialOuPrincipio == true
                          ? nomeComercialSearch(medicamentos, text)
                          : medicamentos.where((m) {
                              final titulo = m.nomePrincipioAtivo.toLowerCase();
                              return titulo.contains(text);
                            }).toList();
                    }),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: TextButton(
                        onPressed: () {
                          setState(() => comercialOuPrincipio = true);
                        },
                        child: Text('Nome Comercial')),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() => comercialOuPrincipio = false);
                      },
                      child: Text('Principio Ativo')),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: medicamentos.length,
                    itemBuilder: (context, index) {
                      final Medicamentos medicamento = medicamentos[index];

                      return ItemMedicamentos(
                        medicamento,
                        onClick: () async {
                          await Navigator.push(context, PageRouteBuilder(
                              pageBuilder: (context, anim1, anim2) {
                            return MedicamentosDetailScreen(
                                medicamentos: medicamento);
                          }));
                        },
                      );
                    }),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  nomeComercialSearch(List<Medicamentos> medicamentos, String text) {
    medicamentos.where((m) {
      final titulo = m.nomeComercial.toLowerCase();
      print(titulo.contains(text));
      return titulo.contains(text);
    }).toList();

    setState(() {
      _medicamentos = medicamentos;
    });
  }
}

class ItemMedicamentos extends StatelessWidget {
  final Medicamentos medicamentos;
  final Function onClick;

  ItemMedicamentos(this.medicamentos, {@required this.onClick});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text(medicamentos.nomeComercial), onTap: () => onClick())
      ],
    );
  }
}
