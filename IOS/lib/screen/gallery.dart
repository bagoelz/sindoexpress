import 'package:flutter/material.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GalleryDetail extends StatefulWidget {
  List<DataGallery> galleryGeneral = List();
  List<DataGallery> galleryCar = List();
  List<DataGallery> galleryMotor = List();
  List<DataGallery> galleryHeavy = List();
  List<DataGallery> galleryFleet = List();
  GalleryDetail({Key key, this.galleryCar,this.galleryFleet,this.galleryGeneral,this.galleryHeavy,this.galleryMotor});
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
                    title: Text("GALLERY",
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
               height: MediaQuery.of(context).size.height - 135,
               child: SingleChildScrollView(
                 child:Column(
                 children: <Widget>[
                   InkWell(
                     onTap: (){ 
                       Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new GalleryDetailSee(dataGallery: widget.galleryGeneral,)));
                   
                 },
                     child: Container(
                      padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /14)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                         //border: Border.all(width:1,color:Colors.red),
                       image:DecorationImage(image: AssetImage("assets/generalcargotabicon.png",), fit: BoxFit.contain,)
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

                    InkWell(
                       onTap: (){  
                             Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new GalleryDetailSee(dataGallery: widget.galleryCar,)));
                            
                       },
                     child: Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /14)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/cars.png",), fit: BoxFit.fitWidth,)
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

                   InkWell(
                       onTap: (){ 
                    Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new GalleryDetailSee(dataGallery: widget.galleryMotor,)));
                       },
                     child:Container(
                        padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /14)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/motorcycle.png",), fit: BoxFit.contain,)
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

                   InkWell(
                       onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new GalleryDetailSee(dataGallery: widget.galleryHeavy,)));
                       
                       },
                     child:Container(
                       padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /14)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/heavydutyshipmenttabicon.png",), fit: BoxFit.contain,)
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

                    InkWell(
                       onTap: (){  
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new GalleryDetailSee(dataGallery: widget.galleryFleet,)));
                       },
                     child:Container(
                        padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height /13)),
                       width: MediaQuery.of(context).size.width - 20,
                       height: MediaQuery.of(context).size.height /4,
                       decoration: BoxDecoration(
                       image:DecorationImage(image: AssetImage("assets/ourfleettabicon.png",), fit: BoxFit.contain,)
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
               )
             ),
            ],
          ),
        ),
                ))]
    );
  }
}

class GalleryDetailSee extends StatefulWidget {
  List<DataGallery> dataGallery;
  GalleryDetailSee({Key key, this.dataGallery}) : super(key: key);

  @override
  _GalleryDetailSeeState createState() => _GalleryDetailSeeState();
}

class _GalleryDetailSeeState extends State<GalleryDetailSee> {
   bool _loadingInProgress = true;

   @override
  void initState() {
    if(widget.dataGallery.length > 0 )
      setState(() {
        _loadingInProgress = false;
      });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     final width   = MediaQuery.of(context).size.width;
      final height  = MediaQuery.of(context).size.height;
    return Stack(
            children: <Widget>[
        Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image:DecorationImage(image: AssetImage("assets/background01.jpg"), fit: BoxFit.cover,
               ),
                ),
                child:SafeArea(
       child: ModalProgressHUD(child:Scaffold(
         backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,     
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("GALLERY",
                        style: TextStyle(
                          fontSize: 18, 
                          color: Colors.white,
                          fontFamily: "sans"),
                      ),
            
              ),
          body: Container(
            color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                primary: false,
                children: List.generate(widget.dataGallery.length, (index)=>tampilGallery(dataGallery: widget.dataGallery[index],)),
        )
        )
          ),
        
    ), inAsyncCall: _loadingInProgress,
        progressIndicator:CircularProgressIndicator(backgroundColor: Colors.black38,),)
        )
        )
            ]
    );
  }
}

class tampilGallery extends StatelessWidget {
  final DataGallery dataGallery;
  const tampilGallery({Key key, this.dataGallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_){
                return Center(
                  child:
                    Container(
                     color: Colors.transparent,
                     child: Image.network('https://ptsindo.com/protected/system/slide/picture/'+dataGallery.picture,fit: BoxFit.cover,),
                    )
                );

               }));

      },
      child: Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 5,color: Colors.white),
         borderRadius: BorderRadius.all(Radius.circular(5)),
        image: DecorationImage(image: NetworkImage('https://ptsindo.com/protected/system/slide/picture/'+dataGallery.picture),fit: BoxFit.cover)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Container(
              height: 25,
              margin: EdgeInsets.only(left:5,bottom:5),
              color: Colors.black26,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(onTap:(){
              Navigator.of(context).push(
              MaterialPageRoute(builder: (_){
                return Center(
                  child:
                    Container(
                     color: Colors.transparent,
                     child: Image.network('https://ptsindo.com/protected/system/slide/picture/'+dataGallery.picture,fit: BoxFit.cover,),
                    )
                );

               }));
          },child:Image.asset('assets/galleryZoom.png',fit: BoxFit.cover,),
          )
        ),),
          
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
            Expanded(
            child: Container(
              height: 50,
              color: Colors.black26,
            padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(dataGallery.caption.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 14),),
        ),),
          )
            ],
          )
          
        ],
      ),
    ),
    );
  }
}