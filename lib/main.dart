import 'package:flutter/material.dart';
import 'package:pharmalocal/routes.dart';
import 'package:pharmalocal/screen/alarme/alarm_new/alarme_new.screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // ServiceLocator().setupLocator();
  runApp(Pharmalocal());
}

class Pharmalocal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
          home: PaginasRota(),
        ),
        providers: [
          ChangeNotifierProvider(
            create: (_) => NotificationService(),
          )
        ]);
  }
}
