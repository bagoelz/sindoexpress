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
                alignment: Alignment.center,
                width: width /1,
                height: height / 1.2 ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                    image: AssetImage("assets/background02.jpg"),
                  )
                ),
                child:     
                 Column(
                  children: <Widget>[

                    Center(
                      child: Image.asset("assets/sindo-express-text.png", width: 200, height: 70,),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width:  width / 1.2,
                      height: height / 1.4,
                      child: GridView.count(
                       crossAxisCount: 3,
                       mainAxisSpacing: 4.0,
                      children: <Widget>[

                      Image.asset("assets/Astra.png", width: 50, height: 50,),
                      Image.asset("assets/CLub.png", width: 50, height: 50),
                      Image.asset("assets/Daihatsu.png", width: 50, height: 50),
                      Image.asset("assets/Hino.png", width: 50, height: 50),
                      Image.asset("assets/Hock.png", width: 50, height: 50),
                      Image.asset("assets/Honda.png", width: 50, height: 50),
                      Image.asset("assets/LG.png"),
                      Image.asset("assets/Mitsubishi.png"),
                      Image.asset("assets/Nissan.png"),
                      Image.asset("assets/Polytron.png"),
                      Image.asset("assets/Suzuki.png"),
                      Image.asset("assets/Toyota.png"),
                      Image.asset("assets/Unicharm.png"),
                      Image.asset("assets/Wuling.png"),
                      Image.asset("assets/Yamaha.png"),
                     ],

                      )
                    )

                  ])
                   


          )

              )

        )
    ),
            // Positioned(
            //     bottom: 5,
            //     child:Container(
            //       width:width,
            //       child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //       Container(
            //         width: 200,
            //         height: 100,
            //         child: Image.asset("assets/sindocopyrightlogo.png",fit: BoxFit.fitWidth,),
            //       )
            //       ],
            //     )
            //     )
            // )
 ]
          );
  }
}

class Client{
  final Image image;
  const Client({this.image});
}