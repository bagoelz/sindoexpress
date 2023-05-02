import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/screen/dataTracking.dart';
import 'screen/splashscrren_view.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

RestDatasource net = RestDatasource();
SharedPref pref = SharedPref();
UserData _userData = UserData();
final LocalStorage storage = new LocalStorage('Sindo_app');
var auth;
bool notif = false;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
 
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  
  loadStat();
  runApp(myApp());
}



 loadStat() async{
    DateTime now = new DateTime.now();
    await AndroidAlarmManager.periodic(
        const Duration(minutes: 1), 0, checking,wakeup: true, exact: true,startAt: DateTime(now.year, now.month, now.day, now.hour,now.minute));
  }
 void checking()async{
   List<String> isi=[];
   List<String> notif=[];
  var kode= await pref.read('KODE');
  var nama = await pref.read('NAMA');
  var menit =int.parse(DateFormat("m").format(DateTime.now()));
  var jam =int.parse(DateFormat("HH").format(DateTime.now()));
  DateTime now = new DateTime.now();
   //var dari = DateFormat("yyyy-MM-dd").format(now.subtract(new Duration(days: 7)));
  var dari = DateFormat("yyyy-MM-dd").format(now);
  var jadwalDari = DateFormat("yyyy-MM-dd").format(now.subtract(new Duration(days: 7)));
  var sampai = DateFormat("yyyy-MM-dd").format(now);
  var hariini = DateFormat("dd/MM/yyyy").format(now);

  var tglNot= await pref.read('tglNotif');
  if(tglNot != hariini){
      await pref.save('tglNotif', hariini);
      await storage.deleteItem('notif');
  }
  
  if(kode != null){
   Future.delayed(Duration(seconds: 5),()async{
  net.getNotif('&tgl_not1=${dari}&tgl_not2=${sampai}&kd_sub='+kode.toString()).then((onValue){
         onValue.forEach((item) async {
           bool hasil = false;
           var data = await storage.getItem('notif');
           Future.delayed(Duration(seconds: 1));
            if(data != null){
             hasil = data.contains(item['id'].toString());
             return hasil;
           }
           //print('ini hasil '+ hasil.toString());
           if(item.length > 0){
           if(hasil == false)
           {
             notif.add(item['id']);
             await storage.setItem('notif', notif);
              if(nama != null)
                {
                 
                        isi=[];
                        isi.add('Dear <b>'+ nama +'</b>,');
                        isi.add('<b>'+DateFormat("dd/MM/yyyy").format(DateTime.parse(item['tgl']))+'</b>');
                        isi.add('Thank You '+nama+'</b>');
                        var pesan=item['judul'];
                        // isi.add('Ship <b>'+item['kapal']);
                        // isi.add('<b>'+item['nmrute'] +'</b> has depart the port');
                        // isi.add('Thank you <b>'+ nama +'</b>,');
                        // isi.add('for using our services');
                        // var pesan='Thank you '+ nama;
                          _showPublicNotification(id:item['id'],judul: item['judul'].toString(),pesan: pesan, isi: isi);
                }
           }
           }
              });
      });
   });
  };
  }

Future<void> _showPublicNotification({id,judul,pesan, List<String> isi}) async {
    // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //     'id', 'absensi', 'absensi notifikasi',
    //     importance: Importance.Max,
    //     priority: Priority.High,
    //     ticker: 'ticker',
    //     visibility: NotificationVisibility.Public);
    var vibrationPattern = Int64List(4);
      var inboxStyleInformation = InboxStyleInformation(isi,
        htmlFormatLines: true,
        contentTitle: judul.toString(),
        htmlFormatContentTitle: true,
        summaryText: judul.toString(),
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        id.toString(),
        'Sindoexpress',
        'Sindoexpress Notifikasi',
        icon: 'notif_logo_big',
        ticker: 'ticker',
        largeIconBitmapSource: BitmapSource.Drawable,
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        style: AndroidNotificationStyle.Inbox,
        styleInformation: inboxStyleInformation,
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, judul,
        pesan, platformChannelSpecifics,
        payload: id.toString());
  }

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return new MaterialApp(
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


