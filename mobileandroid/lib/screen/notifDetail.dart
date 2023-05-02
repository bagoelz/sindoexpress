import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sindoexpress/screen/notifView.dart';

class NotifDetail extends StatefulWidget {
  List<DataNotif> notif;
  final String kode;
  final String title;
  final String param;
  NotifDetail({Key key, this.param, this.kode, this.notif, this.title})
      : super(key: key);

  @override
  _NotifDetailState createState() => _NotifDetailState();
}

class _NotifDetailState extends State<NotifDetail> {
  bool _loadingInProgress = false;
  RestDatasource _rest = new RestDatasource();
  List<DataNotif> notifData = <DataNotif>[];
  String datatamper = 'No data yet';
  @override
  void initState() {
    // TODO: implement initState
    notifData = widget.notif;
    super.initState();
  }

  getNotif() {
    //  SJ = SURAT JALAN
    // , ST = SERAH TERIMA / TERKIRIM
    // , BRK = KAPAL BERANGKAT
    // , DTG = KEDATANGAN KAPAL
    setState(() {
      notifData = [];
      _loadingInProgress = true;
      datatamper = 'Loading....';
    });
    var dari = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().subtract(new Duration(days: 14)));
    var sampai = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _rest
        .getNotif('&tgl_not1=' +
            dari +
            '&tgl_not2=' +
            sampai +
            '&kd_sub=' +
            widget.kode)
        .then((onValue) {
      onValue.forEach((item) async {
        if (item['modul'] == widget.param) {
          setState(() {
            notifData.add(DataNotif.map(item));
            _loadingInProgress = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: <Widget>[
        ModalProgressHUD(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                widget.title.toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: "Montserrat"),
              ),
            ),
            body: Container(
                margin: EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background02.jpg'),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  border: new Border.all(width: 1.0, color: Colors.grey[200]),
                  borderRadius: new BorderRadius.circular(10),
                ),
                child: notifData.length > 0
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Column(
                              children:
                                  List.generate(notifData.length, (index) {
                                return InkWell(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  new NotifView(
                                                    title:
                                                        notifData[index].judul,
                                                    id: notifData[index].id,
                                                  )));
                                      getNotif();
                                    },
                                    child: Container(
                                        child: Column(
                                      children: <Widget>[
                                        Row(children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              notifData[index].judul,
                                              style: TextStyle(
                                                  color: notifData[index]
                                                              .tglbaca ==
                                                          null
                                                      ? Colors.black
                                                      : Colors.grey[800],
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: notifData[index]
                                                              .tglbaca ==
                                                          null
                                                      ? FontWeight.w800
                                                      : FontWeight.w500),
                                            ),
                                          ),
                                        ]),
                                        Row(children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 5),
                                            child: Text(
                                              DateFormat("dd MMM yyyy").format(
                                                  DateTime.parse(
                                                      notifData[index].tgl)),
                                              style: TextStyle(
                                                  color: notifData[index]
                                                              .tglbaca ==
                                                          null
                                                      ? Colors.black
                                                      : Colors.grey[800],
                                                  fontSize: 12,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: notifData[index]
                                                              .tglbaca ==
                                                          null
                                                      ? FontWeight.w800
                                                      : FontWeight.w500),
                                            ),
                                          )
                                        ]),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Divider(
                                            color: Colors.black38,
                                            height: 2.0,
                                          ),
                                        ),
                                      ],
                                    )));
                              }),
                            ),
                          ],
                        ))
                    : Center(
                        child: Text(
                          datatamper,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                      )),
          ),
          inAsyncCall: _loadingInProgress,
          color: Colors.black,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.black12,
          ),
        ),
        Positioned(
            bottom: 10,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 100,
                      child: Image.asset(
                        "assets/sindocopyrightlogo.png",
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  ],
                )))
      ]),
    );
  }
}
