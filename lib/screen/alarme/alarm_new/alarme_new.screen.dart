import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:pharmalocal/data/remote/alarm.api.dart';
import 'package:pharmalocal/model/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmNewScreen extends StatefulWidget {
  @override
  _AlarmNewScreenState createState() => _AlarmNewScreenState();
}

class _AlarmNewScreenState extends State<AlarmNewScreen> {
  AlarmeApi _alarmeApi;
  Alarme alarmeCriado;
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _recorrenciaController = TextEditingController();
  final TextEditingController _prazoController = TextEditingController();

  @override
  void initState() {
    _initData();
    Provider.of<NotificationService>(context, listen: false).initialize();
    alarmeCriado = Alarme.novo(
        titulo: 'Titulo', horaInicial: '1', recorrencia: 3, prazo: 2);
    _alarmeApi = AlarmeApi();
    super.initState();
  }

  Future<void> _initData() async {
    tz.initializeTimeZones();
    final _timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(_timezone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo alarme'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        _tituloTextField(),
        _recorrenciaTextField(),
        _prazoTextField(),
        Container(
          child: Consumer<NotificationService>(
            builder: (context, model, widget) => Container(
              width: 400,
              height: 50,
              child: TextButton(
                  onPressed: () {
                    final String titulo = _tituloController.text;
                    final int recorrencia =
                        int.tryParse(_recorrenciaController.text);
                    final alarmeCriado = Alarme.novo(
                        titulo: titulo,
                        horaInicial: '1',
                        recorrencia: 3,
                        prazo: 2);
                    print(alarmeCriado);
                    _alarmeApi.save(alarmeCriado).then((alarme) =>
                        {alarme != null ? Navigator.pop(context) : null});
                    model.scheduled(titulo, recorrencia);
                  },
                  child: Text('SALVAR')),
            ),
          ),
        ),
      ],
    );
  }

  _tituloTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _tituloController,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(labelText: 'Título'),
        keyboardType: TextInputType.text,
      ),
    );
  }

  _recorrenciaTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _recorrenciaController,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(labelText: 'Recorrência'),
        keyboardType: TextInputType.number,
      ),
    );
  }

  _prazoTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _prazoController,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(labelText: 'Prazo'),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future instantNotification(String titulo) async {
  //   var android = AndroidNotificationDetails("id", "canal", "descricao");
  //   var plataform = new NotificationDetails(android: android);

  //   // await _flutterLocalNotificationsPlugin.show(0, titulo, null, plataform,
  //   //     payload: 'Bem-vindo ao Pharmalocal');

  // }

  Future scheduled(String titulo, int recorrencia) async {
    var android = AndroidNotificationDetails("id", "canal", "descricao");
    var plataform = new NotificationDetails(android: android);

    // var interval = RepeatInterval.everyMinute;
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        titulo,
        null,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: recorrencia)),
        plataform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
