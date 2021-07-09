import 'package:flutter/material.dart';
import 'package:pharmalocal/screen/alarme/alarm_list/alarme_list.screen.dart';
import 'package:pharmalocal/screen/medicamentos/medicamentos.screen.dart';
import 'package:pharmalocal/screen/qr_code/qr_code.screen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bem vindo, Saulo')),
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  Card(
                    child: InkWell(
                      onTap: () {
                        return Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AlarmeListScreen(),
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.alarm), Text('Alarmes')],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        return Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MedicamentosScreen(),
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.medical_services_outlined),
                            Text('Medicamentos'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        return Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QRCodeScreen(),
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code),
                            Text('QR Code'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));

    //   body: CustomScrollView(
    // slivers: <Widget>[
    //   SliverAppBar(
    //     flexibleSpace: FlexibleSpaceBar(
    //       title: Text('Saulo Moura'),
    //     ),
    //   ),

    // SliverList(
    //   delegate: SliverChildBuilderDelegate(
    //     (BuildContext context, int index) {
    //       return ItemMedicamentos(_viewModel.medicamento[index]);
    //     },
    //     childCount: _viewModel.medicamento.length,
    //   ),
    // ),
  }
}
