import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:flutter_html/flutter_html.dart';

class news extends StatefulWidget {
  List<Newsdata> berita = List();
  news({Key key,this.berita});
  @override
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loadingInProgress = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        child: Stack(
          children: <Widget>[
        new Container(
          
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/background01.jpg"),
              fit: BoxFit.cover )
          ),
        ),

        Scaffold(
          
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("News",style: TextStyle(color:Colors.white),),
                    
            ),
          
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   color: Colors.grey,
          //   image: DecorationImage(
          //     image: AssetImage("assets/header.png"),
          //     fit: BoxFit.cover )
          // ),
            padding: EdgeInsets.all(10.0),
            child: widget.berita.length > 0 ? SingleChildScrollView(
              child:Column(
                children:List.generate(widget.berita.length, (index)=> bodyBerita(berita: widget.berita[index],))
              ),
              
            ):Center(
              child:Text('No news yet',style: TextStyle(fontSize:16, color:Colors.white,fontWeight: FontWeight.w600),)
            ),
          ),
        )
      ],),
      color: Colors.black,
        progressIndicator: CircularProgressIndicator(backgroundColor: Colors.black38,),
        inAsyncCall: _loadingInProgress,),
    );
  }
}


class bodyBerita extends StatelessWidget {
  Newsdata berita;
  bodyBerita({
    Key key,
    this.berita
  });
  @override
  Widget build(BuildContext context) {
    return  Container(   
      margin: EdgeInsets.all(5.0),       
      width: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all( Radius.circular(20),
                        ),
                        boxShadow: <BoxShadow>[
                        BoxShadow(
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color:Colors.black26,
                          offset: Offset(2.0, 2.0) )
                      ]
                      ),
            child: Column(
              children: <Widget>[
                Container(
                      child:  Container(  
                        height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(berita.picture),
                        fit: BoxFit.fitWidth
                      ),

                      
                    ),
                    ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,top: 10, bottom: 10),
                      child:
                      Html(data: berita.content,)
                      // Text("Keberangkatan barang terakhir tanggal 28 mei Penerimaan barang terakhir tanggal  27  mei Lebaran tanggal 1 Juni s/d 9 Juni Buka kembali tanggal 10 juni",style: TextStyle(
                      //   fontSize: 14, fontFamily: 'sans', height: 1.5,
                      // ),),
                    ),
                    
                  ],
                ),
                );
                                    
  }
}