import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:localstorage/localstorage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:sindoexpress/library/api_network.dart';
import 'package:sindoexpress/screen/about_us.dart';
import 'package:sindoexpress/screen/gallery.dart';
import 'package:sindoexpress/screen/login.dart';
import 'package:sindoexpress/screen/news.dart';
import 'package:sindoexpress/screen/notifView.dart';
import 'package:sindoexpress/screen/profil.dart';
import 'package:sindoexpress/screen/socialmedia.dart';
import 'package:sindoexpress/screen/tracking.dart';
import 'package:sindoexpress/screen/schedule.dart';
import 'package:sindoexpress/screen/message.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/carousel_pro/carousel_pro.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'dataTracking.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final LocalStorage storage = new LocalStorage('Sindo_app');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _loadingInProgress = false,
      flagjadwal = false,
      flagberita = false,
      flagHistory = false;
  RestDatasource _rest = RestDatasource();
  NoResi _noresi = NoResi();
  SharedPref sharedPref = SharedPref();
  List<DataSlide> _dataSlide = List();
  List<DataGallery> galleryGeneral = List();
  List<DataGallery> galleryCar = List();
  List<DataGallery> galleryMotor = List();
  List<DataGallery> galleryHeavy = List();
  List<DataGallery> galleryFleet = List();
  List slide = List();
  int selectedIndex = 0;
  NotificationAppLaunchDetails notificationAppLaunchDetails;

  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  void _requestIOSPermissions() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void onNavbarTaped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 2) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //     return loginScreen();
          return LoginPage();
        }));
      }
      if (index == 1) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SocialmediaPage();
        }));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    callNotiffunction();
    _requestIOSPermissions();
    _cancelNotification();
    getFcm();
    slide = [];
    ambilSlide();
    ambilGallery();
    super.initState();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  callNotiffunction() async {
    var nama = await sharedPref.read('NAMA');
    var initializationSettingsAndroid =
        AndroidInitializationSettings('notif_logo_big');
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          print('tes');
        });

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      print('ini payload' + payload);
      if (payload != null) {
        if (payload == 'berita') {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NewsPage()),
          );
          setState(() {
            flagberita = false;
          });
        } else if (payload == 'jadwal') {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => schedule()),
          );
          setState(() {
            flagjadwal = false;
          });
        } else if (payload == 'history') {
          setState(() {
            flagHistory = true;
          });
          if (nama != null) {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => profil()),
            );
            setState(() {
              flagHistory = false;
            });
          }
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NotifView(title: 'Notification Detail', id: payload)),
          );
          setState(() {
            flagHistory = false;
          });
        }
      }
      //selectNotificationSubject.add(payload);
    });
  }

  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
      // );
    });
  }

  getFcm() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> pesan) async {
        var message;
        var keyname;
        if (Platform.isIOS) {
          message = pesan['aps']['alert'];
          keyname = pesan['keyname'];
        } else {
          message = pesan;
          keyname = message['data']['keyname'];
        }
        if (keyname == 'berita') {
          setState(() {
            flagberita = true;
          });
        } else if (keyname == 'jadwal') {
          setState(() {
            flagjadwal = true;
          });
        } else {
          setState(() {
            flagHistory = true;
          });
        }
        onDidReceiveLocalNotification(
            keyname: keyname, title: message['title'], body: message['body']);
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        //print("onLaunch: $message");
        if (message['keyname'] == 'berita') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewsPage()),
          );
          setState(() {
            flagberita = false;
          });
        } else if (message['keyname'] == 'jadwal') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => schedule()),
          );
          setState(() {
            flagjadwal = false;
          });
        }
      },
      onResume: (Map<String, dynamic> message) async {
        if (message['keyname'] == 'berita') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewsPage()),
          );
          setState(() {
            flagberita = false;
          });
        } else if (message['keyname'] == 'jadwal') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => schedule()),
          );
          setState(() {
            flagjadwal = false;
          });
        }
        // _navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      // print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      _rest
          .sendToken('sindo/token', token: token, nama: ''.toString(), kode: '')
          .then((onValue) {
        if (onValue['data']['gagal'].toString() == 'true') {
          showInSnackBar('Save Notification Token failed.. ');
        }
      });
      setState(() {
        //print(token.toString());
        storage.setItem('fcm', token.toString());
      });
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value.toString()),
      duration: Duration(seconds: 2),
    ));
  }

  Future onDidReceiveLocalNotification(
      {int id, String title, String body, String keyname}) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              if (keyname == 'berita') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage()),
                );
                setState(() {
                  flagberita = false;
                });
              } else if (keyname == 'jadwal') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => schedule()),
                );
                setState(() {
                  flagjadwal = false;
                });
              }
            },
          )
        ],
      ),
    );
  }

  ambilSlide() async {
    setState(() {
      _loadingInProgress = true;
    });
    _rest.getSlide('content/slide/get?id&is_enabled').then((onValue) {
      setState(() {
        _loadingInProgress = false;
      });
      for (var x in onValue['data']) {
        _dataSlide.add(DataSlide.map(x));
        slide.add(NetworkImage(x['picture_url']));
      }
    });
  }

  ambilGallery() async {
    setState(() {
      _loadingInProgress = true;
    });
    _rest.getgallery('content/gallery/get?id&is_enabled').then((onValue) {
      setState(() {
        _loadingInProgress = false;
      });
      for (var x in onValue['data']) {
        if (x['category'] == 1) {
          galleryGeneral.add(DataGallery.map(x));
        }
        if (x['category'] == 2) {
          galleryCar.add(DataGallery.map(x));
        }
        if (x['category'] == 3) {
          galleryMotor.add(DataGallery.map(x));
        }
        if (x['category'] == 4) {
          galleryHeavy.add(DataGallery.map(x));
        }
        if (x['category'] == 5) {
          galleryFleet.add(DataGallery.map(x));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      //home(),
      message(),
      // SocialmediaPage()
    ];

    callPhone(nomor) async {
      await launch("tel://" + nomor);
    }

    final bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Container(
            height: 30,
            width: 30,
            child: selectedIndex == 0
                ? Image.asset(
                    'assets/homeicon.png',
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    'assets/homeicon.png',
                    fit: BoxFit.fill,
                  ),
          ),
          title: Text("")),
      BottomNavigationBarItem(
          icon: Container(
            height: 30,
            width: 30,
            child: selectedIndex == 1
                ? Image.asset(
                    'assets/sosmedicon.png',
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    'assets/sosmedicon.png',
                    fit: BoxFit.fill,
                  ),
          ),
          title: Text("")),
      BottomNavigationBarItem(
          icon: Container(
            height: 30,
            width: 30,
            child: Stack(
              children: <Widget>[
                flagHistory
                    ? Positioned(
                        top: -1,
                        right: -1,
                        child: Icon(
                          MdiIcons.circle,
                          color: Colors.red[700],
                          size: 10,
                        ),
                      )
                    : Container(),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(right: 2),
                    child: selectedIndex == 2
                        ? Image.asset(
                            'assets/accicon.png',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/accicon.png',
                            fit: BoxFit.fill,
                          ),
                  ),
                )
              ],
            ),
          ),
          title: Text(""))
    ];

    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: selectedIndex,
      onTap: onNavbarTaped,
    );

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.grey,  color body
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue[900],
            actions: <Widget>[
              new Container(
                padding: EdgeInsets.only(right: 15, left: 10),
                width: (MediaQuery.of(context).size.width),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: new Image.asset(
                        'assets/sindo-express-text.png',
                        width: 150,
                      ),
                    ),
                    Container(
                      width: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              callPhone('+628113286800');
                            },
                            child: new Image.asset(
                              'assets/csicon.png',
                              width: 30,
                              color: Colors.white,
                            ),
                          ),
                          // SizedBox(width: 20,),
                          //     new Image.asset(
                          // 'assets/notification.png',
                          //  width: 30,),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height / 1.2,
                child: Image.asset("assets/background02.jpg"),
              ),
              Container(
                  height: MediaQuery.of(context).size.height - 120,
                  child: body(
                    berita: flagberita,
                    jadwal: flagjadwal,
                    slide: slide,
                    galleryCar: galleryCar,
                    galleryMotor: galleryMotor,
                    galleryFleet: galleryFleet,
                    galleryHeavy: galleryHeavy,
                    galleryGeneral: galleryGeneral,
                  )),
            ],
          )),
          bottomNavigationBar: bottomNavBar),
    );
  }
}

class body extends StatefulWidget {
  bool berita, jadwal;
  List slide;
  List<DataGallery> galleryGeneral = List();
  List<DataGallery> galleryCar = List();
  List<DataGallery> galleryMotor = List();
  List<DataGallery> galleryHeavy = List();
  List<DataGallery> galleryFleet = List();
  body(
      {Key key,
      this.berita,
      this.jadwal,
      this.slide,
      this.galleryGeneral,
      this.galleryCar,
      this.galleryMotor,
      this.galleryHeavy,
      this.galleryFleet});
  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool isHTML = false;
  List<String> attachments = [];
  final _recipientController = TextEditingController(
    text: 'info@ptsindo.com',
  );

  final _subjectController = TextEditingController(text: 'Customer Service');

  final _bodyController = TextEditingController(
    text: 'Please write your text here ',
  );

  Future<void> sendEmail() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;
    opendialog(platformResponse);
  }

  opendialog(isi) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text('Warning'),
              content: new Text(isi.toString()),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            ));
  }

  void whatsAppOpen(nomor) async {
    bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");
    if (whatsapp) {
      await FlutterLaunch.launchWathsApp(
          phone: "628113286800", message: "Hallo Sindo Express");
    } else {
      sendEmail();
    }
  }

// // end bottom navigation bar
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.slide.length > 0
            ? Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: widget.slide,
                  boxFit: BoxFit.cover,
                  showIndicator: true,
                  dotColor: Color(0xFF6991C7).withOpacity(0.8),
                  dotSize: 5.5,
                  dotSpacing: 16.0,
                  dotBgColor: Colors.transparent,
                  autoplay: true,
                ),
              )
            : Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 13),
              child: Text(
                "",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "sans",
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 20),
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return tracking();
                    }));
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/tracking.png',
                        width: 53,
                      ),
                      Text("Tracking")
                    ],
                  ),
                )),
            Container(
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    widget.jadwal
                        ? Positioned(
                            top: 1,
                            right: 1,
                            child: Icon(
                              MdiIcons.circle,
                              color: Colors.red[700],
                              size: 15,
                            ),
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return schedule();
                          }));
                        },
                        child: Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: Image.asset(
                              'assets/schedule.png',
                              width: 53,
                            ),
                          ),
                          Text("Schedule")
                        ]),
                      ),
                    ),
                  ],
                )),
            Container(
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    widget.berita
                        ? Positioned(
                            top: 1,
                            right: 1,
                            child: Icon(
                              MdiIcons.circle,
                              color: Colors.red[700],
                              size: 15,
                            ),
                          )
                        : Container(),
                    Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return NewsPage();
                            }));
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 25),
                                child: Image.asset(
                                  'assets/news.png',
                                  width: 53,
                                ),
                                width: 50,
                              ),
                              Text("News")
                            ],
                          ),
                        ))
                  ],
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 25),
                margin: EdgeInsets.only(top: 20),
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return about_us();
                      }));
                    },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/aboutus.png',
                          width: 60,
                        ),
                        Text("About Us")
                      ],
                    ))),
            Container(
                padding: EdgeInsets.only(top: 25),
                margin: EdgeInsets.only(top: 20),
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: InkWell(
                  onTap: () {
                    whatsAppOpen('+628113286800');
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/contact.png',
                        width: 55,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Contact Us"),
                      )
                    ],
                  ),
                )),
            Container(
                padding: EdgeInsets.only(top: 25),
                margin: EdgeInsets.only(top: 20),
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return
                          //  GalleryDetail(dataGallery: widget.dataGallery,);
                          GalleryDetail(
                        galleryCar: widget.galleryCar,
                        galleryFleet: widget.galleryFleet,
                        galleryGeneral: widget.galleryGeneral,
                        galleryMotor: widget.galleryMotor,
                        galleryHeavy: widget.galleryHeavy,
                      );
                    }));
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/gallery.jpeg',
                        width: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Gallery"),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
