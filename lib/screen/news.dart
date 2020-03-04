import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
// import 'package:flutter_html/flutter_html.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
        title: Text("NEWS",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.white,
                      fontFamily: "sans"),
                  ),
         
          ),
          
          body:Column(
                  children:<Widget>[
               Container(
               margin: EdgeInsets.only(top:50, left: 15),
               child: Column(
                 children: <Widget>[
                   InkWell(
                     onTap: (){
                      //  Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (_){
                      //     return NewsHolidays();
                      //   }));
                     },
                     child: Image.asset("assets/holiday.png", fit: BoxFit.cover,),
                   ),

                    InkWell(
                     onTap: (){
                      //  Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (_){
                      //     return ComproPage();
                      //   }));
                     },
                     child: Image.asset("assets/promo.png", fit: BoxFit.cover,),
                   ),

                   InkWell(
                     onTap: (){
                        // Navigator.of(context).push(
                        // MaterialPageRoute(builder: (_){
                        //   return OurclientPage();
                        // }));
                     },
                     child: Image.asset("assets/others.png", fit: BoxFit.cover,),
                   ),

                 ],
               ),
             ),
              

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

// class news extends StatefulWidget {
//   @override
//   _newsState createState() => _newsState();
// }

// class _newsState extends State<news> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   bool _loadingInProgress = false;
//   RestDatasource _rest = RestDatasource();
//   List<Newsdata> berita = List();

//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState
//         .showSnackBar(new SnackBar(content: new Text(value.toString())));
//   }


// getNews() async{
//   setState(() {
//     _loadingInProgress = true;
//   });
//   _rest.getBerita('content/post/get?type_id=news&id&is_published=1&expand=content').then((onValue){
//     for(var x in onValue['data']){
//       berita.add(Newsdata.map(x));
//     }
//     setState(() {
//     _loadingInProgress = false;
//   });
//   }).catchError((onError) {
//         showInSnackBar(onError.message);
//       });
// }

//   @override
//   void initState() {
//     // TODO: implement initState
//     getNews();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ModalProgressHUD(
//         child: Stack(
//           children: <Widget>[
//         new Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             image: DecorationImage(
//               image: AssetImage("assets/header.png"),
//               fit: BoxFit.cover )
//           ),
//         ),

//         Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             title: Text("News",style: TextStyle(color:Colors.white),),
                    
//             ),
          
//           backgroundColor: Colors.transparent,
//           body: Container(
//             width: MediaQuery.of(context).size.width,
//           // decoration: BoxDecoration(
//           //   color: Colors.grey,
//           //   image: DecorationImage(
//           //     image: AssetImage("assets/header.png"),
//           //     fit: BoxFit.cover )
//           // ),
//             padding: EdgeInsets.all(10.0),
//             child: SingleChildScrollView(
//               child:Column(
//                 children:List.generate(berita.length, (index)=> bodyBerita(berita: berita[index],))
//               ),
              
//             ),
//           ),
//         )
//       ],),
//       color: Colors.black,
//         progressIndicator: CircularProgressIndicator(backgroundColor: Colors.black38,),
//         inAsyncCall: _loadingInProgress,),
//     );
//   }
// }


// class bodyBerita extends StatelessWidget {
//   Newsdata berita;
//   bodyBerita({
//     Key key,
//     this.berita
//   });
//   @override
//   Widget build(BuildContext context) {
//     return  Container(   
//       margin: EdgeInsets.all(5.0),       
//       width: MediaQuery.of(context).size.width,
//        decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all( Radius.circular(20),
//                         ),
//                         boxShadow: <BoxShadow>[
//                         BoxShadow(
//                           spreadRadius: 1.0,
//                           blurRadius: 2.0,
//                           color:Colors.black26,
//                           offset: Offset(2.0, 2.0) )
//                       ]
//                       ),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                       child:  Container(  
//                         height: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
//                       color: Colors.white,
//                       image: DecorationImage(
//                         image: NetworkImage(berita.picture),
//                         fit: BoxFit.fitWidth
//                       ),

                      
//                     ),
//                     ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 10,top: 10, bottom: 10),
//                       child:
//                       // Html(data: berita.content,)
//                       Text("Keberangkatan barang terakhir tanggal 28 mei Penerimaan barang terakhir tanggal  27  mei Lebaran tanggal 1 Juni s/d 9 Juni Buka kembali tanggal 10 juni",style: TextStyle(
//                         fontSize: 14, fontFamily: 'sans', height: 1.5,
//                       ),),
//                     ),
                    
//                   ],
//                 ),
//                 );
                                    
//   }
// }