import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
            title: Text("OUR CONTACTS",
                        style: TextStyle(
                          fontSize: 18, 
                          color: Colors.white,
                          fontFamily: "sans"),
                      ),
            
              ),
          body: Column(
            children: <Widget>[
             Container(
               margin: EdgeInsets.only(top:50),
               width: width,
               child: Image.asset("assets/contactandbranches.png", width: width, height: height / 1.5,),
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