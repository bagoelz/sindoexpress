import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen/ourclient.dart';
import 'screen/splashscrren_view.dart';

void main(){
  runApp(myApp());
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


