import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:sindoexpress/screen/dataHistory.dart';
import 'package:sindoexpress/screen/dataInvoice.dart';
import 'package:sindoexpress/screen/home.dart';
import 'package:sindoexpress/library/validation.dart';
import 'package:sindoexpress/library/input.dart';
import 'package:intl/intl.dart';
import 'package:sindoexpress/screen/notifDetail.dart';
import 'dataTracking.dart';

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
  String referrerUsername, nama, kode, alamat, kota, telp;
  File _gambarFile;
  RestDatasource _rest = new RestDatasource();
  SharedPref sharedPref = SharedPref();
  List<DataNotif> kapalBerangkat = <DataNotif>[];
  List<DataNotif> kapalTiba = <DataNotif>[];
  List<DataNotif> barangMasuk = <DataNotif>[];
  List<DataNotif> barangDiterima = <DataNotif>[];
  int jlhBrk =0,jlhSt = 0, jlhSj = 0, jlhDtg =0;
  @override
  void initState() {
    getAUTH();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  getNotif(){
    //  SJ = SURAT JALAN
		// , ST = SERAH TERIMA / TERKIRIM
		// , BRK = KAPAL BERANGKAT
		// , DTG = KEDATANGAN KAPAL
    setState(() {
      barangDiterima=[];
      barangMasuk=[];
      kapalBerangkat=[];
      kapalTiba=[];
         jlhBrk =0; jlhSt = 0;  jlhSj = 0; jlhDtg = 0;
    });
    var dari = DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(new Duration(days: 14)));
    var sampai = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _rest.getNotif('&tgl_not1='+dari+'&tgl_not2='+sampai+'&kd_sub='+kode).then((onValue){
         onValue.forEach((item) async {
                if(item['modul']=='SJ'){
                    if(item['tgl_baca']== null){
                      setState(() {
                       jlhSj = jlhSj + 1;
                      });
                    }
                    barangMasuk.add(DataNotif.map(item));
                }
                if(item['modul']=='ST'){
                  if(item['tgl_baca']== null){
                      setState(() {
                       jlhSt = jlhSt + 1;
                      });
                    }
                   barangDiterima.add(DataNotif.map(item));
                }
                if(item['modul']=='DTG'){
                  if(item['tgl_baca']== null){
                      setState(() {
                       jlhDtg = jlhDtg + 1;
                      });
                    }
                  kapalTiba.add(DataNotif.map(item));
                }
                if(item['modul']=='BRK'){
                  if(item['tgl_baca']== null){
                      setState(() {
                       jlhBrk = jlhBrk + 1;
                      });
                    }
                  kapalBerangkat.add(DataNotif.map(item));
                }
            setState(() {
            _loadingInProgress = false;
          });    
            
         });
    });
  }




  getAUTH() async {
    nama = await sharedPref.read('NAMA');
    kode = await sharedPref.read('KODE');
    alamat = await sharedPref.read('ALAMAT');
    kota = await sharedPref.read('KOTA');
    telp = await sharedPref.read('TELP');
     await getNotif();
    //_dataLogin = DataLogin.map(items);
    //profileName = _dataLogin.profile_picture.split("/").last;
  }

  signOut() async {
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => new home()));
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value.toString()),
      duration: Duration(seconds: 2),
    ));
  }

  geInvoice() async {
    setState(() {
      _loadingInProgress = true;
    });
    _rest.getInvoice(
      '&kd_sub=' + kode.toString(),
    )
        .then((onValue) {
      for (var x in onValue) {}
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
      if (_changePassword.newpassword != _changePassword.repeatpassword) {
        showInSnackBar('New Password not match');
        return;
      }
      setState(() {
        _loadingInProgress = true;
      });

      form.save();
      
      _rest
          .changePass(
        '&user=' + kode + '&pass=' + _changePassword.newpassword,
      )
          .then((onValue) {
        var status = onValue;
        if (status == false) {
          showInSnackBar('Change Paswword fail ');
          new Future.delayed(new Duration(seconds: 1), () {
            setState(() {
              _loadingInProgress = false;
            });
          });
        } else {
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
        return StatefulBuilder(builder: (context, passwordchange) {
          return AlertDialog(
            title: new Text(
              "Change Password",
              style: TextStyle(
                  fontFamily: 'sans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
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
                              validateFunction: _validations.validatePassword,
                              onSaved: (val) {
                                _changePassword.newpassword = val;
                              },
                              text: "New Password",
                              inputType: TextInputType.text,
                            ),
                            textFromField(
                              password: true,
                              validateFunction: _validations.validatePassword,
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
                  )),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  _changePassword.newpassword = '';
                  _changePassword.password = '';
                  _changePassword.repeatpassword = '';
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
                      image: AssetImage("assets/background01.jpg"),
                      fit: BoxFit.cover)),
            ),
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              appBar: new AppBar(
                iconTheme: new IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                title: Text(
                  'Your Profile',
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
                                      padding: EdgeInsets.only(top: 0),
                                      child: Text(
                                        nama.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Gotik',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Address : " + alamat,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Gotik',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "City : " + kota,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Gotik',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Phone : " + telp,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Gotik',
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.all(25.0),
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/background02.jpg'),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey[300],
                                    //     blurRadius:
                                    //         5.0, // has the effect of softening the shadow
                                    //     spreadRadius:
                                    //         2.0, // has the effect of extending the shadow
                                    //     offset: Offset(
                                    //       3.0, // horizontal, move right 10
                                    //       3.0, // vertical, move down 10
                                    //     ),
                                    //   )
                                    // ],
                                    border: new Border.all(
                                        width: 1.0, color: Colors.grey[200]),
                                    borderRadius: new BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          category(
                                            txt: "Tracking History ",
                                            padding: 5.0,
                                            isi: '',
                                            icons: Icon(
                                              Icons.history,
                                            ),
                                            tap: () {
                                              Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                      pageBuilder: (_, __,
                                                              ___) =>
                                                          new dataTracking(title: 'TRACKING HISTORY',tracking: true,)));
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 26.0,
                                                right: 20.0),
                                            child: Divider(
                                              color: Colors.black12,
                                              height: 2.0,
                                            ),
                                          ),
                                          category(
                                            txt: "Invoice ",
                                            padding: 5.0,
                                            isi: '',
                                            icons: Icon(
                                              MdiIcons.file
                                            ),
                                            tap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => InvoiceScreen()),
                                                  );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 26.0,
                                                right: 20.0),
                                            child: Divider(
                                              color: Colors.black12,
                                              height: 2.0,
                                            ),
                                          ),
                                          category(
                                            txt: "Change Password ",
                                            padding: 5.0,
                                            isi: '',
                                            icons: Icon(MdiIcons.lock),
                                            // Icon(MdiIcons.keyChange,),
                                            tap: () {
                                              passwordForm();
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 26.0,
                                                right: 20.0),
                                            child: Divider(
                                              color: Colors.black12,
                                              height: 2.0,
                                            ),
                                          ),
                                           category(
                                            txt: "Goods Received",
                                            padding: 5.0,
                                            notif: jlhSj,
                                            isi: 'SJ',
                                            // Icon(MdiIcons.keyChange,),
                                            tap: () async {
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => NotifDetail(title:'Goods Received',notif:barangMasuk,kode: kode,param:'SJ') ));
                                            getNotif();
                                            },
                                          ), 
                                          
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 26.0,
                                                right: 20.0),
                                            child: Divider(
                                              color: Colors.black12,
                                              height: 2.0,
                                            ),
                                          ),
                                           category(
                                            txt: "Ship Departure",
                                            padding: 5.0,
                                            notif: jlhBrk,
                                            isi: 'BRK',
                                            icons: Icon(MdiIcons.packageDown),
                                            // Icon(MdiIcons.keyChange,),
                                            tap: () async{
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => NotifDetail(title:'Ship departure',notif:kapalBerangkat, kode: kode,param:'BRK') ));
                                              getNotif();
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 26.0,
                                                right: 20.0),
                                            child: Divider(
                                              color: Colors.black12,
                                              height: 2.0,
                                            ),
                                          ),
                                           category(
                                            txt: "Ship Arrival",
                                            padding: 5.0,
                                            notif: jlhDtg,
                                            isi: 'DTG',
                                            icons: Icon(MdiIcons.shipWheel),
                                            // Icon(MdiIcons.keyChange,),
                                            tap: () async {
                                           await Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => NotifDetail(title:'Ship Arrival',notif:kapalTiba, kode: kode,param:'DTG') ));
                                             getNotif();
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 26.0,
                                                right: 20.0),
                                            child: Divider(
                                              color: Colors.black12,
                                              height: 2.0,
                                            ),
                                          ),
                                           category(
                                            txt: "Goods Delivered",
                                            padding: 5.0,
                                            notif: jlhSt,
                                            isi: 'ST',
                                            // Icon(MdiIcons.keyChange,),
                                            tap: ()async {
                                            await  Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => NotifDetail(title:'Goods delivered',notif:barangDiterima,kode:kode,param: 'ST',) ));
                                             getNotif();
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 26.0,
                                                right: 20.0),
                                            child: Divider(
                                              color: Colors.black12,
                                              height: 2.0,
                                            ),
                                          ),
                                          // category(
                                          //   txt: "Sign Out",
                                          //   warna: Colors.red,
                                          //   padding: 26.0,
                                          //   isi:'',
                                          //   icons: Icon(Icons.access_alarm),

                                          //   //Icon(MdiIcons.logout,color: Colors.red[600],),
                                          //   tap: () {
                                          //    signOut();
                                          //   },
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       top: 20.0, left: 26.0, right: 20.0),
                                          //   child: Divider(
                                          //     color: Colors.black12,
                                          //     height: 2.0,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  25,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () => signOut(),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: new Border.all(
                                                          color:
                                                              Colors.red[700],
                                                          width: 1.0,
                                                        ),
                                                        color: Colors.red[700],
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(25),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          top: 5,
                                                          bottom: 5,
                                                          left: 10,
                                                          right: 10),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Icon(
                                                                MdiIcons.logout,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Text(
                                                              'Log Out',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )))
                                    ],
                                  )),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ),
            )
          ],
        ),
        inAsyncCall: _loadingInProgress,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.black38,
        ),
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
  int notif;

  category(
      {this.txt,
      this.icons,
      this.tap,
      this.isi,
      this.warna,
      this.tebal,
      this.notif,
      this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  isi =='' ? icons != null
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
                      : Container()
                    :Container(
                      child: isi == 'ST' ? Container(padding:EdgeInsets.only(right:5),width:20,height:17,child:Image.asset('assets/barangDiterima.jpeg',fit: BoxFit.cover,))
                      : isi == 'SJ' ? Container(padding:EdgeInsets.only(right:5),width:20,height:17,child:Image.asset('assets/barangIn.jpeg',fit: BoxFit.cover,))
                      : isi == 'BRK' ? Container(padding:EdgeInsets.only(right:5),width:20,height:17,child:Image.asset('assets/kapalBerangkat.jpeg',fit: BoxFit.cover,))
                      : Container(padding:EdgeInsets.only(right:5),width:20,height:17,child:Image.asset('assets/kapalTiba.jpeg',fit: BoxFit.cover,))
                      
                    ),
                  Container(
                    width: icons != null
                        ? MediaQuery.of(context).size.width - 117 :
                       notif != null ? MediaQuery.of(context).size.width - 90: MediaQuery.of(context).size.width - 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         
                        Container(
                          child: Text(
                            txt,
                            style: TextStyle(
                                color: this.warna != null
                                    ? this.warna
                                    : Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                       notif != null ?  Container(
                          height: 25,
                           width: 25,
                          child: Stack(children: <Widget>[
                            Positioned(
                              child: Container(
                            height: 15,
                           width: 15,
                           decoration: BoxDecoration(
                             color:  notif != 0 ? Colors.red[700]:Colors.transparent,
                             borderRadius:BorderRadius.all(Radius.circular(15))
                           ),
                          child: Text(notif.toString(),
                              style: TextStyle(
                                fontFamily: 'Sans',
                                fontSize: 13.0,
                                  color: this.warna != null
                                      ? this.warna
                                      : notif != 0 ? Colors.white :Colors.transparent,
                                  fontWeight: this.tebal != null
                                      ? this.tebal
                                      : FontWeight.bold),
                              textAlign: TextAlign.center),
                            )
                              )
                          ],)
                          
                        ):Container(),
                       
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
