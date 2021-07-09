import 'package:flutter/material.dart';
import 'package:pharmalocal/data/remote/alarm.api.dart';
import 'package:pharmalocal/model/alarm.dart';
import 'package:pharmalocal/screen/alarme/alarm_edit/alarme_edit.screen.dart';
import 'package:pharmalocal/screen/alarme/alarm_new/alarme_new.screen.dart';

class AlarmeListScreen extends StatefulWidget {
  @override
  _AlarmeListScreenState createState() => _AlarmeListScreenState();
}

class _AlarmeListScreenState extends State<AlarmeListScreen> {
  AlarmeApi _alarmeApi;

  @override
  void initState() {
    _alarmeApi = AlarmeApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarmes'),
      ),
      body: FutureBuilder<List<Alarme>>(
        future: _alarmeApi.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Alarme> alarmes = snapshot.data;
            alarmes.sort((a, b) {
              return a.titulo.compareTo(b.titulo);
            });
            return ListView.builder(
                itemCount: alarmes.length,
                itemBuilder: (context, index) {
                  final Alarme alarme = alarmes[index];
                  return AlarmeItem(
                    alarme,
                    onClick: () async {
                      await Navigator.push(context, PageRouteBuilder(
                          pageBuilder: (context, anim1, anim2) {
                        return AlarmeDetailScreen(alarme: alarme);
                      }));
                    },
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, anim1, anim2) {
            return AlarmNewScreen();
          }));
          _alarmeApi.getAll();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AlarmeItem extends StatelessWidget {
  final Alarme alarme;
  final Function onClick;

  AlarmeItem(this.alarme, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          onClick();
        },
        leading: Icon(Icons.timer),
        title: Text(
          alarme.titulo,
        ),
      ),
    );
  }
}
