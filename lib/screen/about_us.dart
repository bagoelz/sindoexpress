import 'package:flutter/material.dart';
import 'companyprofile.dart';
import 'contact.dart';
import 'ourclient.dart';
// import 'package:flutter_youtube/flutter_youtube.dart';


class about_us extends StatefulWidget {
  @override
  _about_usState createState() => _about_usState();
}

class _about_usState extends State<about_us> {
  @override
  Widget build(BuildContext context) {
         
    final width   = MediaQuery.of(context).size.width;
    final height  = MediaQuery.of(context).size.height;

    return Stack(
            children: <Widget>[
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
            title: Text("ABOUT US",
                        style: TextStyle(
                          fontSize: 18, 
                          color: Colors.white,
                          fontFamily: "sans"),
                      ),
            
              ),
          body: Column(
            children: <Widget>[
             Container(
               margin: EdgeInsets.only(top: 50, left: 15),
               child: Column(
                 children: <Widget>[

                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return ContactPage();
                        }));
                     },
                     child: Image.asset("assets/contactbranch.png", fit: BoxFit.cover,),
                   ),

                    InkWell(
                     onTap: (){
                       Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return ComproPage();
                        }));
                     },
                     child: Image.asset("assets/compro.png", fit: BoxFit.cover,),
                   ),

                   InkWell(
                     onTap: (){
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return OurclientPage();
                        }));
                     },
                     child: Image.asset("assets/ourclient.png", fit: BoxFit.cover,),
                   ),

                 ],
               ),
             ),

            ],
          ),
        ),
      
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

