import 'package:flutter/material.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GalleryDetail extends StatefulWidget {
  @override
  _GalleryDetailState createState() => _GalleryDetailState();
}

class _GalleryDetailState extends State<GalleryDetail> {
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
               padding: EdgeInsets.only(left:15),
               width: width,
               child: Column(
                 children: <Widget>[
                   InkWell(
                     onTap: null,
                     child: Image.asset("assets/generalcargotabicon.png", fit: BoxFit.cover,),
                   ),

                    InkWell(
                     onTap: null,
                     child: Image.asset("assets/cars.png",fit: BoxFit.cover,),
                   ),

                   InkWell(
                     onTap: null,
                     child: Image.asset("assets/motorcycle.png", fit: BoxFit.cover,),
                   ),

                   InkWell(
                     onTap: null,
                     child: Image.asset("assets/heavydutyshipmenttabicon.png", fit: BoxFit.cover,),
                   ),

                    InkWell(
                     onTap: null,
                     child: Image.asset("assets/ourfleettabicon.png", fit: BoxFit.cover,),
                   ),
                 ],
               ),
             ),
            ],
          ),
        ),
                ))]
    );
  }
}

// class GalleryDetail extends StatefulWidget {
//   List<DataGallery> dataGallery;
//   GalleryDetail({Key key, this.dataGallery}) : super(key: key);

//   @override
//   _GalleryDetailState createState() => _GalleryDetailState();
// }

// class _GalleryDetailState extends State<GalleryDetail> {
//    bool _loadingInProgress = true;

//    @override
//   void initState() {
//     if(widget.dataGallery.length > 1 )
//       setState(() {
//         _loadingInProgress = false;
//       });
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//        child: ModalProgressHUD(child:Scaffold(
//          appBar: AppBar(  
//            backgroundColor: Colors.transparent,
//           title: Text("Gallery",
//                     style: TextStyle(
//                       fontSize: 18, 
//                       color: Colors.black,
//                       fontFamily: "sans"),
//                   ),
//           ),
//           body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/background.png"),
//             fit: BoxFit.cover
//           )
//         ),
//         child: SingleChildScrollView(
//           child: GridView.count(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
//                 crossAxisSpacing: 5.0,
//                 mainAxisSpacing: 5.0,
//                 childAspectRatio: 0.65,
//                 crossAxisCount: 2,
//                 primary: false,
//                 children: List.generate(widget.dataGallery.length, (index)=>tampilGallery(dataGallery: widget.dataGallery[index],)),
//         )

       
//         )
//           ),
        
//     ), inAsyncCall: _loadingInProgress,
//         progressIndicator:CircularProgressIndicator(backgroundColor: Colors.black38,),)
//         );
//   }
// }

// class tampilGallery extends StatelessWidget {
//   final DataGallery dataGallery;
//   const tampilGallery({Key key, this.dataGallery}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//           Navigator.of(context).push(
//               MaterialPageRoute(builder: (_){
//                 return Center(
//                   child:
//                     Container(
//                      color: Colors.transparent,
//                      child: Image.network('https://ptsindo.com/rebuild/protected/system/slide/picture/'+dataGallery.picture,fit: BoxFit.cover,),
//                     )
//                 );

//                }));

//       },
//       child: Container(
//       decoration: BoxDecoration(
//         // border: Border.all(width: 5,color: Colors.white),
//          borderRadius: BorderRadius.all(Radius.circular(5)),
//         image: DecorationImage(image: NetworkImage('https://ptsindo.com/rebuild/protected/system/slide/picture/'+dataGallery.picture),fit: BoxFit.cover)
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Expanded(
//             child: Container(
//               height: 50,
//               color: Colors.black26,
//             padding: EdgeInsets.all(10),
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: Text(dataGallery.caption.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 14),),
//         ),),
//           )
//             ],
//           )
          
//         ],
//       ),
//     ),
//     );
//   }
// }