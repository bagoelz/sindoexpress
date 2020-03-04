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
  @override
  Widget build(BuildContext context) {
    final width   = MediaQuery.of(context).size.width;
    final height  = MediaQuery.of(context).size.height;
    return Stack(
            children:<Widget>[
              Container(
                width: width,
                decoration: BoxDecoration(
                  image:DecorationImage(image: AssetImage("assets/background01.jpg"), fit: BoxFit.cover,
                ),
                ),
                child:SafeArea(
        child: Scaffold(
           backgroundColor: Colors.transparent,     
          body: SingleChildScrollView(
            child: Column(
                 children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/8,bottom:50),
                  child:  Image.asset("assets/sindo-express-text.png", width: 200,),
                ),
              Center(
                child:  Container(
                  margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width /1.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/background03.jpg",),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius:5,
                      spreadRadius:5,
                      offset: Offset(5, 2),
                      color:Colors.black54,
                    )
                  ],
                  color: Colors.redAccent,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:50,bottom:50),
                      child:Text("LOG-IN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),),
                    ),
                     Padding(
                       padding: EdgeInsets.only(left: 20, right: 20,bottom:20),
                       child:  TextField(
                      decoration: InputDecoration(
                       prefixIcon: Image.asset("assets/iconusername.png", width: 5, height: 5,),
                        hintText: "USERNAME",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)))),
                   
                      ),
                     Padding(
                       padding: EdgeInsets.only(left: 20, right: 20),
                       child:  TextField(
                      decoration: InputDecoration(
                       prefixIcon: Image.asset("assets/iconpassword.png", width: 5, height: 5,),
                        hintText: "PASSWORD",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)))),
                   
                      ),
                       
                    Padding(
                      padding: EdgeInsets.only(top:50,bottom:50),
                        child:  InkWell(
                        onTap: (){},
                        child: Image.asset("assets/loginbtn.png", width: 200,),
                      ),
                    ),
                  
                    
                  ],
                ),
               )
              )     
            ],
           ),
          )
        )
                )
        )]);
  }
}


// class loginScreen extends StatefulWidget {
//   @override
//   _loginScreenState createState() => _loginScreenState();
// }

// /// Component Widget this layout UI
// class _loginScreenState extends State<loginScreen>
//     with TickerProviderStateMixin {
//   //Animation Declaration
//   AnimationController sanimationController;
//   AnimationController animationControllerScreen;
//   Animation animationScreen;
//   var tap = 0;
//   bool _loadingInProgress = false;
//   final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   UserData _userData = UserData();
//   DataLogin _dataLogin = DataLogin();
//   DataLogin _dataLogin1 = DataLogin();
//   bool _autovalidate = false, _login = false;
//   ValidationsLogin _validations = new ValidationsLogin();
//   RestDatasource _rest = new RestDatasource();
//   final LocalStorage storage = new LocalStorage('Sindo_app');

//   SharedPref sharedPref = SharedPref();

//   /// Set AnimationController to initState
//   @override
//   void initState() {
//     //_dataLogin1 = DataLogin.map(sharedPref.read("AUTH").toString());
//    //print(_dataLogin1.toString());
//         sanimationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 800))
//           ..addStatusListener((statuss) {
//             if (statuss == AnimationStatus.dismissed) {
//               setState(() {
//                 tap = 0;
//               });
//             }
//           });
//           checkLogin();
//     // TODO: implement initState
//     super.initState();
//   }

//   /// Dispose animationController
//   @override
//   void dispose() {
//     super.dispose();
//     sanimationController.dispose();
//   }

//   checkLogin() async{
//      setState(() {
//       _loadingInProgress = true;
//     });
//     var login = await sharedPref.read('USERNAME');
//     if(login != null ){
//       setState(() {
//       _loadingInProgress = false;
//     });
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => new profil()));
//     }else{
//        setState(() {
//       _loadingInProgress = false;
//       _login = true;
//     });
//     }
//   }
//   /// Playanimation set forward reverse
//   Future<Null> _PlayAnimation() async {
//     try {
//       await sanimationController.forward();
//       await sanimationController.reverse();
//     } on TickerCanceled {}
//   }

//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState
//         .showSnackBar(new SnackBar(content: new Text(value.toString())));
//   }

//   void _handleSubmitted() async {
//     final FormState form = _formKey.currentState;
   
//     if (!form.validate()) {
//       _autovalidate = true; // Start validating on every change.
//       showInSnackBar('Please fix the errors in red before submitting.');
//     } else {
//        setState(() {
//       _loadingInProgress = true;
//     });

//       form.save();
//       _rest.getAuth('https://www.sindo.co.id/apk/login.php?key=s3ks9293ks9', _userData).then((onValue) {
//         var status = onValue;
//         if (status == false){
//           showInSnackBar('Wrong Username or Password ');
//            new Future.delayed(new Duration(seconds: 1), () {
//           setState(() {
//             _loadingInProgress = false;
//           });
//         });
//         }else{
//          // showInSnackBar(onValue['messages']['success'].toString());
//          sharedPref.save('PASSWORD', _userData.password);
//          sharedPref.save('USERNAME', _userData.username);
//          sharedPref.save('NAMA', onValue['nama']);
//          sharedPref.save('KODE', onValue['kode']);
//          sharedPref.save('ALAMAT', onValue['alamat']);
//          sharedPref.save('KOTA', onValue['kota']);
//          sharedPref.save('TELP', onValue['telp']);
         
//           new Future.delayed(new Duration(seconds: 1), () {
//              //_dataLogin = DataLogin.map(onValue['data']);
//              //sharedPref.save('TOKEN', onValue['access_token']);
            
//                setState(() {
//             _loadingInProgress = false;
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => new profil()));
//          });
               
          
//         });
          
//         }
//       }).catchError((PlatformException onError) {
//         showInSnackBar(onError.message);
//       });
//     }
//   }



//   /// Component Widget layout UI
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData mediaQueryData = MediaQuery.of(context);

//     return SafeArea(
//       child: ModalProgressHUD(child: _login ? 
//       Scaffold(
//         key: _scaffoldKey,
//         resizeToAvoidBottomPadding: false ,
//         // appBar: AppBar(
//         //     title: Text('Sindo Express',
//         //               style: TextStyle(
//         //                   color: Colors.white,
//         //                   fontSize: 25.0,
//         //                   fontWeight: FontWeight.w600,
//         //                   fontFamily: "Sans"),
//         //               textAlign: TextAlign.right),
//         //     backgroundColor: Colors.transparent,
//         //     elevation: 0.0,
//         // ),
//         body:Column(
//           children: <Widget>[
//             Container(
//               height: MediaQuery.of(context).size.height -24,
             
//               child: Container(
//                 decoration: new BoxDecoration(
//                   image: DecorationImage(
//             image: AssetImage("assets/header.png"),
//             fit: BoxFit.cover
//           ),
//                     // color: Colors.white,
//                     // borderRadius: new BorderRadius.only(
//                     //     topLeft: const Radius.circular(30.0),
//                     //     topRight: const Radius.circular(30.0))
//                         ),

//                 /// Set component layout
//                 child: ListView(
//                   children: <Widget>[
//                     Column(
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             Container(
//                               child: Column(
//                                 children: <Widget>[
//                                   /// padding logo
//                                   // Padding(
//                                   //     // padding: EdgeInsets.only(
//                                   //     //     top:
//                                   //     //         mediaQueryData.padding.top + 40.0)
//                                   //     ),
//                                   Container(
//                                     child: Builder(
//                                       builder: (context) => Form(
//                                         key: _formKey,
//                                         autovalidate: _autovalidate,
//                                         child: Column(
//                                           children: <Widget>[
//                                             Padding(padding: EdgeInsets.only(top:50),
//                                             child: Text('Sindo Express',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: "Sans"),
//                       textAlign: TextAlign.right) ,
//                                             ),
//                                             Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 50.0)),

//                                             /// TextFromField Email
//                                             textFromField(
//                                               password: false,
//                                               text: "Username",
//                                               validateFunction:
//                                                   _validations.validateUsername,
//                                               onSaved: (val) {
//                                                 _userData.username = val;
//                                               },
//                                               inputType:
//                                                   TextInputType.emailAddress,
//                                             ),
//                                             Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 5.0)),

//                                             /// TextFromField Password
//                                             textFromField(
//                                               password: true,
//                                               validateFunction:
//                                                   _validations.validatePassword,
//                                               onSaved: (val) {
//                                                 _userData.password = val;
//                                               },
//                                               text: "Password",
//                                               inputType: TextInputType.text,
//                                             ),
//                                              Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 20.0)),
//                                             InkWell(
//                                               splashColor: Colors.red,
//                                               onTap: () {
//                                                 _handleSubmitted();
//                                                 // setState(() {
//                                                 //   tap = 1;
//                                                 // });
//                                                 // _PlayAnimation();
//                                                 // return tap;
//                                               },
//                                               child: Container(
//                          width: MediaQuery.of(context).size.width -90,
//                          height: 50,
//                          decoration: BoxDecoration(
//                            color:Colors.red[700],
//                            borderRadius: BorderRadius.all(Radius.circular(15))
//                          ),
//                          child: Padding(
//                            padding: EdgeInsets.only(top:15),
//                            child: Text(
//                            'LOGIN', style:TextStyle(
//                             fontSize:16.0,
//                             color:Colors.white,
//                            ),
//                            textAlign: TextAlign.center,
//                          ),
//                          )
//                        ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),

//                                   /// Button daftar
//                                   // FlatButton(
//                                   //   onPressed: () {
//                                   //     // Navigator.of(context).pushReplacement(
//                                   //     //     MaterialPageRoute(
//                                   //     //         builder: (BuildContext context) =>
//                                   //     //             new Signup()));
//                                   //   },
//                                   //   // child: Text(
//                                   //   //   " Belum punya Akun ? Silahkan Daftar",
//                                   //   //   style: TextStyle(
//                                   //   //       color: Colors.black,
//                                   //   //       fontSize: 13.0,
//                                   //   //       fontWeight: FontWeight.w600,
//                                   //   //       fontFamily: "Sans"),
//                                   //   // )
//                                   //   child: RichText(
//                                   //     text: new TextSpan(
//                                   //       // Note: Styles for TextSpans must be explicitly defined.
//                                   //       // Child text spans will inherit styles from parent
//                                   //       style: new TextStyle(
//                                   //         fontSize: 14.0,
//                                   //         color: Colors.black,
//                                   //       ),
//                                   //       children: <TextSpan>[
//                                   //         new TextSpan(
//                                   //             text:
//                                   //                 'Lupa Password ? Click ',
//                                   //             style: TextStyle(
//                                   //               fontSize: 14.0,
//                                   //               fontFamily: "Sans",
//                                   //               fontWeight: FontWeight.w600,
//                                   //             )),
//                                   //         new TextSpan(
//                                   //             text: 'disini',
//                                   //             style: new TextStyle(
//                                   //               color: Colors.blue[600],
//                                   //               fontSize: 14.0,
//                                   //               fontFamily: "Sans",
//                                   //               fontWeight: FontWeight.w600,
//                                   //             )),
//                                   //       ],
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: mediaQueryData.padding.top + 0.0,
//                                         bottom: 0.0),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),

//                         /// Set Animaion after user click buttonLogin
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ):Container(),
//       color: Colors.black,
//         progressIndicator: CircularProgressIndicator(backgroundColor: Colors.black38,),
//         inAsyncCall: _loadingInProgress,)
//     );
//   }
// }

// /// textfromfield custom class
// ///ButtonBlack class
