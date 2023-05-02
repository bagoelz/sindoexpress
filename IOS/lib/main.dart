import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:sindoexpress/library/api_network.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'screen/splashscrren_view.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:background_fetch/background_fetch.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void backgroundFetchHeadlessTask(String taskId) async {
  print('[BackgroundFetch] Headless event received.');
  BackgroundFetch.finish(taskId);
}

void main() async {
  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RestDatasource net = RestDatasource();
  SharedPref pref = SharedPref();
  UserData _userData = UserData();
  final LocalStorage storage = new LocalStorage('Sindo_app');
  NetworkUtil _netUtil = NetworkUtil();
  String tokenServer;
  var auth;
  bool notif = false;
  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void checking() async {
    List<String> isi = [];
    List<String> notif = [];
    var kode = await pref.read('KODE');
    var nama = await pref.read('NAMA');
    var menit = int.parse(DateFormat("m").format(DateTime.now()));
    var jam = int.parse(DateFormat("HH").format(DateTime.now()));
    DateTime now = new DateTime.now();
    //var dari = DateFormat("yyyy-MM-dd").format(now.subtract(new Duration(days: 7)));
    var dari = DateFormat("yyyy-MM-dd").format(now);
    var jadwalDari =
        DateFormat("yyyy-MM-dd").format(now.subtract(new Duration(days: 7)));
    var sampai = DateFormat("yyyy-MM-dd").format(now);
    var hariini = DateFormat("dd/MM/yyyy").format(now);
    tokenServer = storage.getItem('fcm');
    var tglNot = await pref.read('tglNotif');
    if (tglNot != hariini) {
      await pref.save('tglNotif', hariini);
      await storage.deleteItem('notif');
    }

    if (kode != null) {
      Future.delayed(Duration(seconds: 5), () async {
        net
            .getNotif('&tgl_not1=${dari}&tgl_not2=${sampai}&kd_sub=' +
                kode.toString())
            .then((onValue) {
          onValue.forEach((item) async {
            bool hasil = false;
            var data = await storage.getItem('notif');
            Future.delayed(Duration(seconds: 1));
            if (data != null) {
              hasil = data.contains(item['id'].toString());
              return hasil;
            }
            //print('ini hasil '+ hasil.toString());
            if (item.length > 0) {
              if (hasil == false) {
                notif.add(item['id']);
                await storage.setItem('notif', notif);
                if (nama != null) {
                  var isi = "Dear " +
                      nama +
                      " Container status " +
                      DateFormat("dd/MM/yyyy")
                          .format(DateTime.parse(item['tgl']));

                  // isi.add('Ship <b>'+item['kapal']);
                  // isi.add('<b>'+item['nmrute'] +'</b> has depart the port');
                  // isi.add('Thank you <b>'+ nama +'</b>,');
                  // isi.add('for using our services');
                  // var pesan='Thank you '+ nama;
                  _netUtil.sendNotif(
                      id: item['id'],
                      title: item['judul'],
                      body: isi,
                      server: tokenServer);
                  // _showPublicNotification(
                  //     id: item['id'],
                  //     judul: item['judul'].toString(),
                  //     pesan: pesan,
                  //     isi: isi);
                }
              }
            }
          });
        });
      });
    }
    ;
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: false,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      // This is the fetch-event callback.
      //print("[BackgroundFetch] Event received $taskId");
      checking();
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
    }).then((int status) {
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      setState(() {
        _status = e;
      });
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Sindo Express",
      // theme: ThemeData(
      //     brightness: Brightness.light,
      //     backgroundColor: Colors.white,
      //     primaryColorLight: Colors.white,
      //     primaryColorBrightness: Brightness.light,
      //     primaryColor: Colors.blue
      //     ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),

      // home: OurclientPage()
      /// Move splash screen to ChoseLogin Layout
      /// Routes
    );
  }
}
