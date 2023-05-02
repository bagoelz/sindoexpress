import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/validation.dart';
import 'package:flutter/services.dart';
import 'package:sindoexpress/screen/dataTracking.dart';
import 'package:sindoexpress/library/SharedPref.dart';

class dataHistory extends StatefulWidget {
  @override
  _dataHistoryState createState() => _dataHistoryState();
}

class _dataHistoryState extends State<dataHistory> {
  bool _loadingInProgress = false, _autovalidate = false, landscape = false;
  RestDatasource _rest = RestDatasource();
  NoResi _noresi = NoResi();
  List<DataResi> _dataResi = List();
  ValidationsLogin _validations = ValidationsLogin();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPref sharedPref = SharedPref();
  DateTime _setDate = DateTime.now();
  Duration initialtimer = new Duration();
  int selectitem = 1;
  @override
  void initState() {
    // TODO: implement initState
    ambilDataResi();
    super.initState();
  }

  @override
  void dispose() {
    //_portraitModeOnly();

    // TODO: implement dispose
    super.dispose();
  }

  ambilDataResi() async {
    setState(() {
      _loadingInProgress = true;
    });
    var resi = await sharedPref.read('KODE');
    _rest.getHistory('&kd_penerima=' + resi).then((onValue) {
      setState(() {
        _loadingInProgress = false;
      });
      for (var x in onValue) {
        _dataResi.add(DataResi.map(x));
      }
      showChart();
    });
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => dataTracking(
                dataTrack: _dataResi,
                tracking: true,
              )));
    } else {
      showInSnackBar('No data yet');
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: <Widget>[
      new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          //   image: DecorationImage(
          //     image: AssetImage("assets/background01.jpg"),
          //     fit: BoxFit.cover )
        ),
      ),
      ModalProgressHUD(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "TRACKING HISTORY",
              style: TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: "Montserrat"),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                autovalidate: _autovalidate,
                child: bodyTracking(
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
    ]));
  }
}

class bodyTracking extends StatefulWidget {
  var onSaved;
  var validations;
  bool rotate;
  bodyTracking({Key key, this.onSaved, this.validations, this.rotate})
      : super(key: key);
  @override
  _bodyTrackingState createState() => _bodyTrackingState();
}

class _bodyTrackingState extends State<bodyTracking> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black
              // image: DecorationImage(
              //   image: AssetImage("assets/background.png"),
              //   fit: BoxFit.cover
              // )
              ),
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height / 1.35,
                      margin: EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/background02.jpg'),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        border:
                            new Border.all(width: 1.0, color: Colors.grey[200]),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Please wait',
                        ),
                      )),
                ]),
          )),
    );
  }
}
