import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:sindoexpress/screen/profil.dart';
import 'package:sindoexpress/library/input.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/validation.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sindoexpress/library/SharedPref.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  var tap = 0;
  bool _loadingInProgress = false, flagpass = true;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserData _userData = UserData();
  DataLogin _dataLogin = DataLogin();
  DataLogin _dataLogin1 = DataLogin();
  bool _autovalidate = false, _login = false;
  ValidationsLogin _validations = new ValidationsLogin();
  RestDatasource _rest = new RestDatasource();
  final LocalStorage storage = new LocalStorage('Sindo_app');

  SharedPref sharedPref = SharedPref();

  /// Set AnimationController to initState
  @override
  void initState() {
    checkLogin();
    // TODO: implement initState
    super.initState();
  }

  checkLogin() async {
    setState(() {
      _loadingInProgress = true;
    });
    var login = await sharedPref.read('USERNAME');
    if (login != null) {
      setState(() {
        _loadingInProgress = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => new profil()));
    } else {
      setState(() {
        _loadingInProgress = false;
        _login = true;
      });
    }
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    String koin = await storage.getItem('fcm');
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      setState(() {
        _loadingInProgress = true;
      });

      form.save();
      _rest
          .getAuth('https://www.sindo.co.id/apk/login.php?key=s3ks9293ks9',
              _userData)
          .then((onValue) {
        String status = onValue.toString();
        if (status == 'false') {
          showInSnackBar('Wrong Username or Password ');
          new Future.delayed(new Duration(seconds: 1), () {
            setState(() {
              _loadingInProgress = false;
            });
          });
        } else {
          // showInSnackBar(onValue['messages']['success'].toString());
          sharedPref.save('PASSWORD', _userData.password);
          sharedPref.save('USERNAME', _userData.username);
          sharedPref.save('NAMA', onValue['nama']);
          sharedPref.save('KODE', onValue['kode']);
          sharedPref.save('ALAMAT', onValue['alamat']);
          sharedPref.save('KOTA', onValue['kota']);
          sharedPref.save('TELP', onValue['telp']);
          new Future.delayed(new Duration(seconds: 1), () {
            _rest
                .sendToken('sindo/token',
                    token: koin,
                    nama: onValue['nama'].toString(),
                    kode: onValue['kode'])
                .then((onValue) {
              if (onValue['data']['gagal'].toString() == 'true') {
                showInSnackBar('Save Notification Token failed.. ');
              }
            });
          });
          new Future.delayed(new Duration(seconds: 1), () {
            //_dataLogin = DataLogin.map(onValue['data']);
            //sharedPref.save('TOKEN', onValue['access_token']);

            setState(() {
              _loadingInProgress = false;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => new profil()));
            });
          });
        }
      }).catchError((PlatformException onError) {
        showInSnackBar(onError.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      Container(
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background01.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
              child: ModalProgressHUD(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  // title: Text(
                  //   'LOGIN',
                  //   style: TextStyle(
                  //       fontSize: 16,
                  //       color: Colors.white,
                  //       fontFamily: "Montserrat"),
                  // ),
                ),
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 8,
                                bottom: 50),
                            child: Image.asset(
                              "assets/sindo-express-text.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                      Center(
                          child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width / 1.3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/background03.jpg",
                                  ),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                    offset: Offset(5, 2),
                                    color: Colors.black54,
                                  )
                                ],
                                color: Colors.redAccent,
                              ),
                              child: Container(
                                  child: Builder(
                                builder: (context) => Form(
                                  key: _formKey,
                                  autovalidate: _autovalidate,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 50, bottom: 50),
                                        child: Text(
                                          "LOG-IN",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: new Border.all(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25),
                                              ),
                                              height: 50,
                                              width: width - 120,
                                              margin: EdgeInsets.only(
                                                  left: 15, bottom: 15),
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 5,
                                                  bottom: 10,
                                                  top: 10),
                                              child: TextFormField(
                                                  validator: _validations
                                                      .validateUsername,
                                                  onSaved: (val) {
                                                    _userData.username = val;
                                                  },
                                                  decoration: InputDecoration(
                                                    prefixIcon: Image.asset(
                                                      "assets/iconusername.png",
                                                      width: 5,
                                                      height: 5,
                                                    ),
                                                    hintText: "USERNAME",
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent)),
                                                    errorBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                              decoration: BoxDecoration(
                                                border: new Border.all(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25),
                                              ),
                                              height: 50,
                                              width: width - 120,
                                              margin: EdgeInsets.only(
                                                  left: 15, bottom: 15),
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextFormField(
                                                        onSaved: (val) {
                                                          _userData.password =
                                                              val;
                                                        },
                                                        validator: _validations
                                                            .validatePassword,
                                                        obscureText: flagpass
                                                            ? true
                                                            : false,
                                                        decoration:
                                                            InputDecoration(
                                                          prefixIcon:
                                                              Image.asset(
                                                            "assets/iconpassword.png",
                                                          ),
                                                          hintText: "PASSWORD",
                                                          focusedErrorBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent)),
                                                          errorBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                        )),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          flagpass = !flagpass;
                                                        });
                                                      },
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          height: 20,
                                                          width: 20,
                                                          child: flagpass
                                                              ? Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: Colors
                                                                          .blue[
                                                                      500],
                                                                )))
                                                ],
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 50, bottom: 50),
                                        child: InkWell(
                                          onTap: () {
                                            _handleSubmitted();
                                          },
                                          child: Image.asset(
                                            "assets/loginbtn.png",
                                            width: 200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))))
                    ],
                  ),
                )),
            inAsyncCall: _loadingInProgress,
            progressIndicator: CircularProgressIndicator(
              backgroundColor: Colors.black38,
            ),
          )))
    ]);
  }
}
