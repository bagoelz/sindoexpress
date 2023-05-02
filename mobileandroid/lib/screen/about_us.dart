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
               margin: EdgeInsets.only(top: 5, left: 15),
               child: Column(
                 children: <Widget>[

                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return ContactPage();
                        }));
                     },
                      child: Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /13)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/contactbranch.png",), fit: BoxFit.contain,)
                     ),
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                       Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                       Container(
                         padding: EdgeInsets.only(top:2.5),
                         color: Colors.red[700],
                        margin: EdgeInsets.only(left:30,),
                        width: MediaQuery.of(context).size.width /4.5,
                        height: 25,
                        child: Text('more',style:TextStyle(color: Colors.white,fontFamily: 'Sans',letterSpacing: 0.5),textAlign: TextAlign.center,),
                       )
                     ],),
                     ],
                     )
                     ),
                   ),

                    InkWell(
                     onTap: (){
                       Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_){
                          return ComproPage();
                        }));
                     },
                   child: Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /13)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/compro.png",), fit: BoxFit.contain,)
                     ),
                     child:Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                       Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                       Container(
                         padding: EdgeInsets.only(top:2.5),
                         color: Colors.red[700],
                        margin: EdgeInsets.only(left:30,),
                        width: MediaQuery.of(context).size.width /4.5,
                        height: 25,
                        child: Text('more',style:TextStyle(color: Colors.white,fontFamily: 'Sans',letterSpacing: 0.5),textAlign: TextAlign.center,),
                       )
                     ],),
                     ],
                     )
                     ),
                   ),

                   InkWell(
                     onTap: (){
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return OurclientPage();
                        }));
                     },
                     child: Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /13)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/ourclient.png",), fit: BoxFit.contain,)
                     ),
                     child:Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                       Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                       Container(
                         padding: EdgeInsets.only(top:5),
                         color: Colors.red[700],
                        margin: EdgeInsets.only(left:30,),
                        width: MediaQuery.of(context).size.width /4.5,
                        height: 25,
                        child: Text('more',style:TextStyle(color: Colors.white,fontFamily: 'Sans',letterSpacing: 0.5),textAlign: TextAlign.center,),
                       )
                     ],),
                     ],
                     )
                     ),
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

