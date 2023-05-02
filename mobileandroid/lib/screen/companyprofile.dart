import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class ComproPage extends StatefulWidget {
  @override
  _ComproPageState createState() => _ComproPageState();
}

class _ComproPageState extends State<ComproPage> {
   String link='https://www.youtube.com/watch?v=eqJDA5YJMm4';
  // void playVideo() {
  //   FlutterYoutube.playYoutubeVideoByUrl(
  //     apiKey: "AIzaSyAUjMGjTQeid3YWGh7xTIyGrfTlOjV94MI",
  //     autoPlay: true,
  //     videoUrl: "https://www.youtube.com/watch?v=eqJDA5YJMm4",
  //   );
  // }
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
          appBar: AppBar(
               elevation: 0.0,
        backgroundColor: Colors.transparent,     
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("COMPANY PROFILE",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.white,
                      fontFamily: "sans"),
                  ),
         
          ),
          
          body:Column(
                  children:<Widget>[
                    Row(children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height/2,
                            width: MediaQuery.of(context).size.width-20,
                          child: FlutterYoutube.playYoutubeVideoByUrl(
                            backgroundColor: Colors.transparent,
                              apiKey: "key=AIzaSyBw4Y1E1SKAymeB1y2ZGYQvJ1R_rOCXTYo",
                              videoUrl:link,
                              autoPlay: false, //default falase
                              fullScreen: false //default false
                            ),
                          )     
                                     ],)

                  ]
                )
           
                
                )

        )
    ),
    Positioned(
                bottom: 10,
                child:Container(
                  width:width,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                    width: 200,
                    height: 100,
                    child: Image.asset("assets/sindocopyrightlogo.png",fit: BoxFit.fitWidth,),
                  )
                  ],
                )
                )
            )
 ]
          );
  }
}