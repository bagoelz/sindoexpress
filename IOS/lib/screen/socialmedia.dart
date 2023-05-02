import 'package:flutter/material.dart';
import 'package:sindoexpress/screen/home.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialmediaPage extends StatefulWidget {
  @override
  _SocialmediaPageState createState() => _SocialmediaPageState();
}

class _SocialmediaPageState extends State<SocialmediaPage> {
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
        title: Text("OUR SOCIAL MEDIA",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.white,
                      fontFamily: "sans"),
                  ),
         
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: ()async{
                        launch("https://www.instagram.com/sindo_express");
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/ig.png"),
                        radius: 40,
                      )
                    ),

                     InkWell(
                         onTap: ()async{
                        launch("https://www.facebook.com/sindoexpress");
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/fb.png"),
                        radius: 40,
                      )
                    )
                  ],
                ),

                SizedBox(height: 50,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: ()async{
                        launch("https://youtu.be/eqJDA5YJMm4");
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/yt.png"),
                        radius: 40,
                      )
                    ),

                     InkWell(
                      onTap: ()async{
                        launch("https://ptsindo.com/");
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/web.png"),
                        radius: 40,
                      )
                    )
                  ],
                ),

                ],
              ),
        )
        )),
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