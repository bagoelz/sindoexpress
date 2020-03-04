import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:sindoexpress/screen/dataHistory.dart';
import 'package:sindoexpress/screen/dataInvoice.dart';
import 'package:sindoexpress/screen/home.dart';
import 'package:sindoexpress/library/validation.dart';
import 'package:sindoexpress/library/input.dart';
class profil extends StatefulWidget {
  @override
  _profilState createState() => _profilState();
}

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

/// Get _txt and custom value of Variable for Name User
var _txtName = _txt.copyWith(fontWeight: FontWeight.w700, fontSize: 17.0);

/// Get _txt and custom value of Variable for Edit text
var _txtEdit = _txt.copyWith(color: Colors.black87, fontSize: 15.0);

/// Get _txt and custom value of Variable for Category Text
var _txtCategory = _txt.copyWith(
    fontSize: 14.5, color: Colors.black, fontWeight: FontWeight.bold);

class _profilState extends State<profil> {
  final LocalStorage storage = new LocalStorage('Sindo_app');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // SharedPref sharedPref = SharedPref();
  ValidationsLogin _validations = new ValidationsLogin();
  bool _autovalidate = false;
  DataLogin _dataLogin = DataLogin();
  ChangePassword _changePassword = ChangePassword();
  bool _loadingInProgress = true;
  var auth;
  String referrerUsername, nama,kode,alamat,kota,telp;
  File _gambarFile;
  RestDatasource _rest = new RestDatasource();
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    getAUTH();
    super.initState();
  }

  @override
    void dispose() {
      super.dispose();
    }

  getAUTH() async {
        nama = await sharedPref.read('NAMA');
        kode=  await sharedPref.read('KODE');
        alamat = await sharedPref.read('ALAMAT');
        kota = await sharedPref.read('KOTA');
        telp = await sharedPref.read('TELP');
    //_dataLogin = DataLogin.map(items);
    //profileName = _dataLogin.profile_picture.split("/").last;
    new Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        _loadingInProgress = false;
      });
    });
  }

signOut()async{
  setState(() {
        _loadingInProgress = true;
      });
  storage.clear();
  sharedPref.clear();
   new Future.delayed(new Duration(seconds: 1), () {
     setState(() {
        _loadingInProgress = false;
      });
      
    });
     Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => new home()));
}
void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString()),duration: Duration(seconds: 2),));
  }


geInvoice()async{
  setState(() {
        _loadingInProgress = true;
      });
  _rest.getInvoice('&kd_sub='+kode.toString(),).then((onValue) {
    for(var x in onValue){

    }
  });

   new Future.delayed(new Duration(seconds: 1), () {
     setState(() {
        _loadingInProgress = false;
      });
      
    });
    //  Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (BuildContext context) => new home()));
}


  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
   
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
    
    if(_changePassword.newpassword != _changePassword.repeatpassword){
       showInSnackBar('New Password not match');
       return;
    }
       setState(() {
      _loadingInProgress = true;
    });

      form.save();
      _rest.changePass('&user='+kode+'&pass='+_changePassword.newpassword,).then((onValue) {
        var status = onValue;
        if (status == false){
          showInSnackBar('Change Paswword fail ');
           new Future.delayed(new Duration(seconds: 1), () {
          setState(() {
            _loadingInProgress = false;
          });
        });
        }else{
         // showInSnackBar(onValue['messages']['success'].toString());
        //  sharedPref.save('NAMA', onValue['nama']);
        //  sharedPref.save('KODE', onValue['kode']);
        //  sharedPref.save('ALAMAT', onValue['alamat']);
        //  sharedPref.save('KOTA', onValue['kota']);
        //  sharedPref.save('TELP', onValue['telp']);
          showInSnackBar('Change Password Success ');
          new Future.delayed(new Duration(seconds: 1), () {
             //_dataLogin = DataLogin.map(onValue['data']);
             //sharedPref.save('TOKEN', onValue['access_token']);
            
               setState(() {
            _loadingInProgress = false;
            Navigator.of(context).pop();
         });
               
          
        });
          
        }
      }).catchError((PlatformException onError) {
        showInSnackBar(onError.message);
      });
    }
  }

  passwordForm() {
   showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(
        builder: (context, passwordchange) {
        return AlertDialog(
          title: new Text("Change Password",
          style: TextStyle(fontFamily: 'sans',fontSize: 16.0,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
        child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Builder(
                builder: (context) => Form(
                  key: _formKey,
                  autovalidate: _autovalidate,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      /// TextFromField Email
                      // textFromField(
                      //   password: true,
                      //   text: "Old Password",
                      //   validateFunction:
                      //       _validations.validatePassword,
                      //   onSaved: (val) {
                      //     _changePassword.password =val;
                      //   },
                      //   inputType:
                      //       TextInputType.text,
                      // ),

                      /// TextFromField Password
                      textFromField(
                        password: true,
                        validateFunction:
                            _validations.validatePassword,
                        onSaved: (val) {
                          _changePassword.newpassword = val;
                        },
                        text: "New Password",
                        inputType: TextInputType.text,
                      ),
                       textFromField(
                        password: true,
                        validateFunction:
                            _validations.validatePassword,
                        onSaved: (val) {
                         _changePassword.repeatpassword = val;
                        },
                        text: "Repeat Password",
                        inputType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              )
            ),
      ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("CANCEL", style: TextStyle(color: Colors.grey),),
              onPressed: () {
                _changePassword.newpassword='';
                _changePassword.password ='';
                _changePassword.repeatpassword='';
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("CONFIRM"),
              onPressed: () {
                _handleSubmitted();
              },
            ),
            
          ],
        );
        });
      },
    );
}
  @override
  Widget build(BuildContext context) {
    /// Declare MediaQueryData
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: ModalProgressHUD(
        child: Stack(
                      children: <Widget>[
                        /// Setting Header Banner
                        new Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/header.png"),
              fit: BoxFit.cover )
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            iconTheme: new IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(
              'Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sans',
                  fontSize: 16.0,
                  letterSpacing: 1.0),
            ),
            elevation: 0.0,
          ),
          //drawer: SideMenu(),
          body: SingleChildScrollView(
            child: Container(
              child: !_loadingInProgress
                  ? 
                        /// Calling _profile variable
                        //_profile,
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            /// Setting Category List
                            children: <Widget>[
                             Container(
                               child: Column(
                                 children: <Widget>[
                                   Padding(
                                     padding: EdgeInsets.only(top:0),
                                     child: Text(nama.toString(),style: TextStyle(fontSize: 15, fontFamily: 'Gotik', color: Colors.white),),
                                   ),
                                   Padding(
                                     padding: EdgeInsets.only(top:5),
                                     child: Text("Alamat : " + alamat,style: TextStyle(fontSize: 12, fontFamily: 'Gotik', color: Colors.white),),
                                   ),
                                   Padding(
                                     padding: EdgeInsets.only(top:5),
                                     child: Text("Kota : " + kota,style: TextStyle(fontSize: 12, fontFamily: 'Gotik', color: Colors.white),),
                                   ),
                                   Padding(
                                     padding: EdgeInsets.only(top:5),
                                     child: Text("Kontak : " + telp,style: TextStyle(fontSize: 12, fontFamily: 'Gotik', color: Colors.white),),
                                   )
                                 ],
                               ),
                             ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius:
                                          5.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          2.0, // has the effect of extending the shadow
                                      offset: Offset(
                                        3.0, // horizontal, move right 10
                                        3.0, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                  border: new Border.all(
                                      width: 1.0, color: Colors.grey[200]),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    category(
                                      txt: "History ",
                                      padding: 26.0,
                                      isi: '',
                                      icons: Icon(Icons.history,),
                                      tap: () {
                                        Navigator.of(context).push(PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                new dataHistory()));
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 26.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.black12,
                                        height: 2.0,
                                      ),
                                    ),
                                      category(
                                      txt: "Invoice ",
                                      padding: 26.0,
                                      isi: '',
                                      icons: Icon(Icons.event_note,),
                                      tap: () {
                                        Navigator.of(context).push(PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                new InvoiceScreen()));
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 26.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.black12,
                                        height: 2.0,
                                      ),
                                    ),
                                    category(
                                      txt: "Change Password ",
                                      padding: 26.0,
                                      isi: '',
                                      icons:  
                                     Icon(Icons.ac_unit), 
                                      // Icon(MdiIcons.keyChange,),
                                      tap: () {
                                       passwordForm();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 26.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.black12,
                                        height: 2.0,
                                      ),
                                    ),
                                    category(
                                      txt: "Sign Out",
                                      warna: Colors.red,
                                      padding: 26.0,
                                      isi:'',
                                      icons: Icon(Icons.access_alarm),
                                      
                                      //Icon(MdiIcons.logout,color: Colors.red[600],),
                                      tap: () {
                                       signOut();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 26.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.black12,
                                        height: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                             
                            ],
                          ),
                        ) : Container(),
                    
                 
            ),
          ),
        )
            ],
                    ),
                     inAsyncCall: _loadingInProgress,
        progressIndicator:CircularProgressIndicator(backgroundColor: Colors.black38,),
        ),
      );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt;
  var isi;
  Icon icons;
  GestureTapCallback tap;
  double padding;
  Color warna;
  FontWeight tebal;

  category(
      {this.txt,
      this.icons,
      this.tap,
      this.isi,
      this.warna,
      this.tebal,
      this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  icons != null
                      ? Padding(
                          padding: EdgeInsets.only(right: padding),
                          // child: Image.asset(
                          //   image,
                          //   height: 25.0,
                          // ),
                          child: icons == null
                              ? null
                              : Icon(
                                  icons.icon,
                                  color: icons.color,
                                  size: 20.0,
                                ),
                        )
                      : Container(),
                  Container(
                    width: icons != null
                        ? MediaQuery.of(context).size.width - 117
                        : MediaQuery.of(context).size.width - 71,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            txt,
                            style: TextStyle(
                                color: this.warna != null
                                    ? this.warna : Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                         
                          child: Text(
                            isi,
                            style: TextStyle(
                                color: this.warna != null
                                    ? this.warna
                                    : Colors.grey[400],
                                fontWeight: this.tebal != null
                                    ? this.tebal
                                    : FontWeight.bold),
                                    textAlign: TextAlign.right
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
              ),
        ],
      ),
    );
  }
}
