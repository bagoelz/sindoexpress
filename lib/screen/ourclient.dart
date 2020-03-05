import 'package:flutter/material.dart';

class OurclientPage extends StatefulWidget {
  
  @override
  _OurclientPageState createState() => _OurclientPageState();
}

class _OurclientPageState extends State<OurclientPage> {
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
                    title: Text("OUR CLIENTS",
                                style: TextStyle(
                                  fontSize: 18, 
                                  color: Colors.white,
                                  fontFamily: "sans"),
                              ),
                ),
                
          body: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(5),
                width: width,
                height: height / 1.5 ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                    image: AssetImage("assets/background02.jpg",),fit: BoxFit.cover
                  )
                ),
                child: SingleChildScrollView(
                  child:Column(
                  children: <Widget>[

                    Center(
                      child: Image.asset("assets/sindo-express-text.png", width: 200, height: 70,),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Astra.png", ),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/CLub.png",),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Daihatsu.png",),)
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Hino.png", ),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Hock.png",),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Honda.png",),)
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      Container(width: width/4, height: width/4,child:Image.asset("assets/LG.png", ),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Mitsubishi.png",),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Nissan.png",),)
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Polytron.png", ),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Suzuki.png",),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Toyota.png",),)
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Unicharm.png", ),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Wuling.png",),),
                      Container(width: width/4, height: width/4,child:Image.asset("assets/Yamaha.png",),)
                    ],)
                    // Container(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   width:  width,
                    //   height: height,
                    //   child: GridView.count(
                    //    crossAxisCount: 3,
                    //    mainAxisSpacing: 4.0,
                    //   children: <Widget>[
                 
                    //   Image.asset("assets/Hino.png", width: width/3.5, height: width/3.5,),
                    //   Image.asset("assets/Hock.png", width: width/3.5, height: width/3.5,),
                    //   Image.asset("assets/Honda.png", width: width/3.5, height: width/3.5,),
                    //   Image.asset("assets/LG.png"),
                    //   Image.asset("assets/Mitsubishi.png"),
                    //   Image.asset("assets/Nissan.png"),
                    //   Image.asset("assets/Polytron.png"),
                    //   Image.asset("assets/Suzuki.png"),
                    //   Image.asset("assets/Toyota.png"),
                    //   Image.asset("assets/Unicharm.png"),
                    //   Image.asset("assets/Wuling.png"),
                    //   Image.asset("assets/Yamaha.png"),
                    //  ],

                    //   )
                    // ),
                    

                  ])
                )
                 
          ),
          

              )

        )
    ),Positioned(
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

class Client{
  final Image image;
  const Client({this.image});
}