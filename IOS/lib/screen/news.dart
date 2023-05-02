import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';

import 'newsDetail.dart';
// import 'package:flutter_html/flutter_html.dart';

class NewsPage extends StatefulWidget {
  final String category;
  NewsPage({Key key, this.category,});
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loadingInProgress = false;
  RestDatasource _rest = RestDatasource();
  List<Newsdata> beritaHoliday = List();
  List<Newsdata> beritaPromo = List();
  List<Newsdata> beritaOthers= List();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }


  @override
  void initState() {
    // TODO: implement initState
    getNews();
    super.initState();
  }
  
getNews() async{
  setState(() {
    _loadingInProgress = true;
  });
  _rest.getBerita('content/post/get?type_id=news&id&is_published=1&expand=content').then((onValue){
    for(var x in onValue['data']){
       if(x['category'] == 1){
            beritaHoliday.add(Newsdata.map(x));
          }
      if(x['category'] == 2){
            beritaPromo.add(Newsdata.map(x));
          }
      if(x['category'] == 3){
            beritaOthers.add(Newsdata.map(x));
          }
    }
    setState(() {
    _loadingInProgress = false;
  });
  }).catchError((onError) {
        showInSnackBar(onError.message);
      });
}
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
               margin: EdgeInsets.only(top:5, left: 15),
               child: Column(
                 children: <Widget>[
                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(
                        MaterialPageRoute(builder: (_){
                          return news(berita:beritaHoliday);
                        }));
                     },
                     child: Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /16)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/holiday.png",), fit: BoxFit.contain,)
                     ),
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                       Container(
                        width: MediaQuery.of(context).size.width /3.5,
                        height: 20,
                        child: Text('HOLIDAY',style:TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: 'Sans',letterSpacing: 0.5),textAlign: TextAlign.center,),
                       )
                     ],),
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                       Container(
                        padding: EdgeInsets.only(top:5),
                        width: MediaQuery.of(context).size.width /3.5,
                        height: 30,
                        color: Colors.red[700],
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
                          return news(berita:beritaPromo);
                        }));
                     },
                     child: Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /16)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/promo.png",), fit: BoxFit.contain,)
                     ),
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                     children: <Widget>[
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                       Container(
                        width: MediaQuery.of(context).size.width /3.5,
                        height: 20,
                        child: Text('PROMO',style:TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: 'Sans',letterSpacing: 0.5),textAlign: TextAlign.center,),
                       )
                     ],),
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                       Container(
                        padding: EdgeInsets.only(top:5),
                        width: MediaQuery.of(context).size.width /3.5,
                        height: 30,
                        color: Colors.red[700],
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
                          return news(berita:beritaOthers);
                        }));
                     },
                     child: Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /16)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/others.png",), fit: BoxFit.contain,),
                     ),
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                       Container(
                        width: MediaQuery.of(context).size.width /3.5,
                        height: 20,
                        child: Text('OTHERS',style:TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: 'Sans',letterSpacing: 0.5),textAlign: TextAlign.center,),
                       )
                     ],),
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                       Container(
                        padding: EdgeInsets.only(top:5),
                        width: MediaQuery.of(context).size.width /3.5,
                        height: 30,
                        color: Colors.red[700],
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