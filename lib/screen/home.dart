import 'package:flutter/material.dart';
import 'package:sindoexpress/screen/about_us.dart';
import 'package:sindoexpress/screen/gallery.dart';
import 'package:sindoexpress/screen/login.dart';
import 'package:sindoexpress/screen/news.dart';
import 'package:sindoexpress/screen/socialmedia.dart';
import 'package:sindoexpress/screen/tracking.dart';
import 'package:sindoexpress/screen/schedule.dart';
import 'package:sindoexpress/screen/message.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/carousel_pro/carousel_pro.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
bool _loadingInProgress=false;
RestDatasource _rest = RestDatasource();
NoResi _noresi = NoResi();
List<DataSlide> _dataSlide = List();
List<DataGallery> dataGallery = List();
List slide=List();
int selectedIndex = 0;
  
  void onNavbarTaped(int index){
    setState(() {
     selectedIndex = index; 
     if(index == 2){
      Navigator.of(context).push(
            MaterialPageRoute(builder: (_){
              // return loginScreen();
            return  LoginPage();
      }));
     }
     if(index == 1){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_){
              return SocialmediaPage();
      }));
     }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    slide=[];
    ambilSlide();
    ambilGallery();
    super.initState();
  }

ambilSlide() async{
    setState(() {
      _loadingInProgress = true;
    });
    _rest.getSlide('content/slide/get?id&is_enabled').then((onValue){
      setState(() {
            _loadingInProgress = false;
          });
        for(var x in onValue['data']){
          _dataSlide.add(DataSlide.map(x));
          slide.add(NetworkImage(x['picture_url']));
        }
       
    });
    }

ambilGallery() async{
    setState(() {
      _loadingInProgress = true;
    });
    _rest.getgallery('content/gallery/get?id&is_enabled').then((onValue){
      setState(() {
            _loadingInProgress = false;
          });
        for(var x in onValue['data']){
          dataGallery.add(DataGallery.map(x));
        }
       
    });
    }
    

  @override
  Widget build(BuildContext context) {

    final pages = [

        //home(),
        message(),
       // SocialmediaPage()
        
    ];

  callPhone(nomor) async{
    await launch("tel://"+nomor);
  }
   final bottomNavBarItems = <BottomNavigationBarItem>[

      BottomNavigationBarItem(
        icon: Container(
          height: 30,
          width: 30,
          child: selectedIndex == 0 ? Image.asset('assets/homeicon.png',fit: BoxFit.fill,): Image.asset('assets/homeicon.png',fit: BoxFit.fill,),
        ),
        title: Text("")
      ),

      BottomNavigationBarItem(
        icon: Container(
          height: 30,
          width: 30,
          child: selectedIndex == 1 ? Image.asset('assets/sosmedicon.png',fit: BoxFit.fill,): Image.asset('assets/sosmedicon.png',fit: BoxFit.fill,),
        ),
        title: Text("")
      ),

      BottomNavigationBarItem(
        icon: Container(
          height: 30,
          width: 30,
          child: selectedIndex == 2 ? Image.asset('assets/accicon.png',fit: BoxFit.fill,): Image.asset('assets/accicon.png',fit: BoxFit.fill,),
        ),
        title: Text("")
      )
    ];


    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: selectedIndex,
      onTap: onNavbarTaped,
    );

    final width   = MediaQuery.of(context).size.width;
    final height  = MediaQuery.of(context).size.height;
   
    return SafeArea(
      child: Scaffold(
       // backgroundColor: Colors.grey,  color body
       resizeToAvoidBottomPadding: false ,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[900],
          actions: <Widget>[
            
             new Container(
               padding: EdgeInsets.only(right: 15, left: 10),
               width: (MediaQuery.of(context).size.width),
               child: new Row(
                 
            
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Container(
                     child:  new Image.asset(
                     'assets/sindo-express-text.png',
                     width: 150,
                     ),
                   ),
                  
                    Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                             callPhone('+628113286800');
                              },
                            child: new Image.asset(
                      'assets/csicon.png',
                       width: 30, color: Colors.white,),
                          ),
                          SizedBox(width: 20,),
                          new Image.asset(
                      'assets/notification.png',
                       width: 30,),
                        
                        ],
                      ),
                    )
                    
                 ],
               ),
             )
          ],
        ),
      body:SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height / 1.2,
                child: Image.asset("assets/background02.jpg"),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 120,
                child: body(slide: slide,dataGallery: dataGallery,)
              ),
            ],
          )
        ),
        bottomNavigationBar: bottomNavBar
      ),
    );
  }

}
class body extends StatefulWidget {
  List slide;
  List<DataGallery> dataGallery;
  body({
    Key key, this.slide,this.dataGallery
  });
  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<body> {
//   // start bottom navigation bar

// int selectedIndex = 0;

// void onNavbarTaped(int index){
//   setState(() {
//     selectedIndex = index;
//   });
// }
 void whatsAppOpen(nomor) async {
    await FlutterOpenWhatsapp.sendSingleMessage(nomor, "Hallo Sindo Express");
  }
  

// // end bottom navigation bar
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      widget.slide.length > 0 ? Container (
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Carousel(
                images: widget.slide,
                boxFit: BoxFit.cover,
                showIndicator: true,
                dotColor: Color(0xFF6991C7).withOpacity(0.8),
                dotSize: 5.5,
                dotSpacing: 16.0,
                dotBgColor: Colors.transparent,
                autoplay: true,
              ),  
             ):Container (
        height: 200,
        width: MediaQuery.of(context).size.width,),
      Row(children: <Widget>[
         Container(
           padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 13),
           child:  Text(
            "",
             style: TextStyle(
              fontSize: 20,
              fontFamily: "sans",
              fontWeight: FontWeight.w900),
              ),
         )
        ],
      ),


      
      Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
              MaterialPageRoute(builder: (_){
                return tracking();
              }));
              },
              child: Column(
              children: <Widget>[
              Image.asset('assets/tracking.png',
              width: 53,),
              Text("Tracking")
            ],),
            )
          ),


          Container(
            padding: EdgeInsets.only(top: 22),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
            child: InkWell(
              onTap: (){
                 Navigator.of(context).push(
                   MaterialPageRoute(builder: (_){
                     return schedule();
                   })
                 );
              },
              child: Column(
              children: <Widget>[
              Image.asset('assets/schedule.png',
              width: 53,),
              Text("Schedule")
            ],
            )
          ),
          ),
          
          Container(
            padding: EdgeInsets.only(top: 25),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
            child: InkWell(
              onTap: (){
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (_){
                    return NewsPage();
                  }));
              },
              child: Column(
              children: <Widget>[
              Image.asset('assets/news.png',
              width: 50,),
              Text("News")
            ],),
            )
          ),
      ],),


      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25),
            margin: EdgeInsets.only(top: 20),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
            child: InkWell(
              onTap: (){
                 Navigator.of(context).push(
              MaterialPageRoute(builder: (_){
                return about_us();
              }));
               },
              child: 
              
              Column(
                  children: <Widget>[
                  Image.asset('assets/aboutus.png',
                  width: 60,),
                  Text("About Us")
                ],
              )
            )
          ),


          Container(
           padding: EdgeInsets.only(top: 25),
           margin: EdgeInsets.only(top: 20),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
            child:InkWell(
              onTap: () {
                 whatsAppOpen('+628113286800');
              },
              child:  Column(
              children: <Widget>[
              Image.asset('assets/contact.png',
              width: 55,),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text("Chat"),
              )
            ],),
            )
          ),

          Container(
            padding: EdgeInsets.only(top: 25),
            margin: EdgeInsets.only(top: 20),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
             child:  
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                   MaterialPageRoute(builder: (_){
                     return 
                    //  GalleryDetail(dataGallery: widget.dataGallery,);
                     GalleryDetail();
                   })
                 );
              },
              child: Column(
              children: <Widget>[
              Image.asset('assets/gallery.jpeg',
              width: 50,),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text("Gallery"),
              )
            ],),
            )
          ),
      ],),


   

      ],
    );

  }
}


