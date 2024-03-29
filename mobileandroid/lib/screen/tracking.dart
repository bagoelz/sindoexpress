import 'package:flutter/material.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:sindoexpress/screen/codeScanner.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/validation.dart';
import 'package:flutter/services.dart';
import 'package:sindoexpress/screen/dataTracking.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class tracking extends StatefulWidget {
  @override
  _trackingState createState() => _trackingState();
}

class _trackingState extends State<tracking> {
  bool _loadingInProgress = false, _autovalidate = false, landscape = false;
  RestDatasource _rest = RestDatasource();
  NoResi _noresi = NoResi();
  List<DataResi> _dataResi = List();
  ValidationsLogin _validations = ValidationsLogin();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPref sharedPref = SharedPref();
  bool _login = false;
  String _kode, _kodeScan;
  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

  @override
  void dispose() {
    //_portraitModeOnly();
    // TODO: implement dispose
    super.dispose();
  }

  checkLogin() async {
    bool _hasil = await sharedPref.read('USERNAME') != null ? true : false;
    var kode = await sharedPref.read('KODE');
    setState(() {
      _login = _hasil;
      _kode = kode;
    });
  }

  ambilDataResi() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;
    } else {
      form.save();
      setState(() {
        _loadingInProgress = true;
      });
      _rest.getResi(_noresi.resi).then((onValue) {
        setState(() {
          _loadingInProgress = false;
          _kodeScan = onValue[0]['penerima'].toString();
        });
        bool detail = _kode == _kodeScan ? true : false;
        if (onValue != false) {
          for (var x in onValue) {
            _dataResi.add(DataResi.map(x));
          }
          //showChart();

          if (_login && !detail) {
            showInSnackBar('Wrong Tracking number');
          } else {
            showChart();
          }
        } else {
          setState(() {
            _loadingInProgress = false;
          });
          showInSnackBar('Wrong Number, please input correct tracking number');
        }
      }).catchError((PlatformException onError) {
        setState(() {
          _loadingInProgress = false;
        });
        showInSnackBar(onError.message);
      });
    }
  }

  _portraitModeOnly() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Navigator.of(context).pop();
  }

  void _enableRotation() {
    setState(() {
      landscape = true;
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  showChart() async {
    if (_dataResi.length > 0) {
      bool detail = _kode == _kodeScan ? true : false;
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => dataTracking(
                title: 'TRACKING RESULT',
                login: _login,
                detail: detail,
                dataTrack: _dataResi,
              )));
      _dataResi = [];
    } else {
      showInSnackBar('Wrong Number, please input correct tracking number');
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromRGBO(1, 12, 50, 1),
            iconTheme: IconThemeData(color: Colors.white),
            title: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                "TRACKING",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: "sans"),
              ),
            )),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              autovalidate: _autovalidate,
              child: bodyTracking(
                onTap: () {
                  ambilDataResi();
                },
                onSaved: (val) {
                  _noresi.resi = val;
                },
                validations: _validations.validateResi,
                rotate: landscape,
              ),
            ),
          ),
        ),
      ),
      inAsyncCall: _loadingInProgress,
      color: Colors.black,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: Colors.black12,
      ),
    ));
  }
}

class bodyTracking extends StatefulWidget {
  GestureTapCallback onTap;
  var onSaved;
  var validations;
  bool rotate;
  bodyTracking(
      {Key key, this.onTap, this.onSaved, this.validations, this.rotate})
      : super(key: key);
  @override
  _bodyTrackingState createState() => _bodyTrackingState();
}

class _bodyTrackingState extends State<bodyTracking> {
  TextEditingController inputNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/background.png"),
          //     fit: BoxFit.cover
          //   )
          // ),
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
              Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    'Insert Your Tracking Number',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height - 90,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(1, 12, 50, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              //margin: EdgeInsets.only(left:15),
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              width: MediaQuery.of(context).size.width / 4,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text('TR NUMB',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500))),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: (MediaQuery.of(context).size.width - 50) /
                                  1.5,
                              child: Center(
                                  child: TextFormField(
                                onSaved: widget.onSaved,
                                validator: widget.validations,
                                controller: inputNumber,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  labelStyle:
                                      TextStyle(color: Colors.grey[400]),
                                  //icon: Image.asset('assets/icon_container.png',scale: 1.0, width: 40.0, height: 40.0),
                                  //hintText: 'Input Tracking Number',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  //labelText:  'Tracking Number'
                                ),
                              )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: widget.onTap,
                              child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.red[700],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Search',
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 14),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 22),
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Text('or',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[500]))),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width / 3,
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              )
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 14),
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          "assets/Qr.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var hasil = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new ScanerCode(
                                        title: 'QR Code Scanner',
                                      )));
                          setState(() {
                            inputNumber.text = hasil;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width - 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.red[700],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                'Scan!',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ],
                  )),
            ]),
          )),
    );
  }
}
