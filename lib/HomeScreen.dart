import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_push_notifications/Notification.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    //Android Settings
    //here to parse the app icon that is in the folder : android/app/src/main/res/drawable
    final settingsAndroid = AndroidInitializationSettings('app_icon');

    //iOS Settings
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload!));

    notifications.initialize(
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
        onSelectNotification:
            onSelectNotification); //the action when click the notification
  }

  Future onSelectNotification(String? payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LocalNotificationWidget()),
      );

  Widget title(String text) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          //style: Theme.of(context).textTheme.title,
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        padding: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.pink[700]!,
              Colors.pink[100]!,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: 
            ElevatedButton(
                      child: Text("            Ding Dong            ",
                      style: TextStyle(fontSize: 19),),
                      onPressed: () => showOngoingNotification(notifications,
                  title: 'Good Morning', body: 'A strong woman is one who is able to smile this morning like she wasn’t crying last night.'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[900],
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}