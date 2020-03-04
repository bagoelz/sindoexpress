import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:flutter/cupertino.dart';
import 'package:sindoexpress/library/input.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/screen/detailSchedule.dart';
// import 'package:flutter_svg/flutter_svg.dart';
class schedule extends StatefulWidget {
  @override
  _scheduleState createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loadingInProgress = false, _autovalidate = false, flagA=false,flagB=false;
  TextEditingController _asalText = TextEditingController();
  TextEditingController _tujuanText = TextEditingController();
  RestDatasource _rest = RestDatasource();
  int _selectedPortA= 0,_selectedPortB= 0;
  List<Pelabuhan> dataPelabuhan = List();
  List jadwal =[];
  String asal ="Port of Loading";
  String tujuan ="Port of Discharge";
@override
void initState(){
  getPort();
  super.initState();
 
}

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }

getPort(){
  _rest.getPort('sindo/port/get').then((onValue){
    for(var x in onValue['data']){
      dataPelabuhan.add(Pelabuhan.map(x));
    }
    getSearching();
  });
}

matchPort({id}) {
  var hasil;
  dataPelabuhan.forEach((item){
    if(item.id == id){
       setState(() {
         hasil = item.nama;
       });
    }
    return hasil;
  });
  return hasil;
}

Future<bool> checkJadwal(x)async{
  bool hasil;
   jadwal.forEach((item){
            if(x['departure_port_id'] == item['idAsal'] && x['destination_port_id'] == item['idTujuan']){
              if(item['ship'].length < 2){
                item['ship'].add({'nama':x['ship']['name'],
              'ETD':x['departure_date'],
              'ETA':x['arrival_date'],
              'Closing':x['closing_date']});
              }
            hasil = true;
            }else{
              hasil = false;
            };
            return hasil;
   });
   return hasil;
}

getSearching(){
  setState(() {
    _loadingInProgress = true;
  });
   _rest.getPort('sindo/schedule/get?expand=ship').then((onValue) async{
      for(var x in onValue['data']){
        if(jadwal.length > 0){
           var hasil = await checkJadwal(x);
           if(hasil==false){
            List ship=[];
            ship.add({
              'nama':x['ship']['name'],
              'ETD':x['departure_date'],
              'ETA':x['arrival_date'],
              'Closing':x['closing_date'],
            });
            jadwal.add({
             'idAsal':x['departure_port_id'],
             'idTujuan':x['destination_port_id'],
             'asal':matchPort(id:x['departure_port_id']),
             'tujuan':matchPort(id:x['destination_port_id']),
             'ship': ship
           });
           }
        }else{
          setState((){
            List ship=[];
            ship.add({
              'nama':x['ship']['name'],
              'ETD':x['departure_date'],
              'ETA':x['arrival_date'],
              'Closing':x['closing_date'],
            });
            jadwal.add({
             'idAsal':x['departure_port_id'],
             'idTujuan':x['destination_port_id'],
             'asal':matchPort(id:x['departure_port_id']),
             'tujuan':matchPort(id:x['destination_port_id']),
             'ship': ship
           });
             //matchPort(idAsal:x['departure_port_id'],idTujuan:x['destination_port_id'],idx: 0);
             _loadingInProgress = false;
          });
        }
        
      }  
      
  });
  
          }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
              child: ModalProgressHUD(
                child:Stack(
                children: <Widget>[
                  new Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image:AssetImage("assets/header.png"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  Scaffold(
                    resizeToAvoidBottomInset: false,
                    key: _scaffoldKey,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: 
                        Row(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 0),
                              child: Text("Schedule"),),
                          
                      ],)
                    ),
                    backgroundColor: Colors.transparent,
                    body:Container(
                              width: MediaQuery.of(context).size.width,
                              height:  MediaQuery.of(context).size.height,
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.only(top:10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                                )
                              ),
                              child:  SingleChildScrollView(
                      child: Container(
                              width: MediaQuery.of(context).size.width -30,
                              child:Column(
                                children: List.generate(jadwal.length, (index){
                                  return Column(
                                    children: <Widget>[
                                    //   Container(
                                    //     width: MediaQuery.of(context).size.width - 20,
                                    //     padding: EdgeInsets.only(left:10,right:10,top:15),
                                    //     height: 40,
                                    //   child: Text(jadwal[index]['asal'].toUpperCase(),style: TextStyle(letterSpacing: 0.5,fontSize: 16,fontWeight:FontWeight.w700 ),),
                                    // ),
                                          Container(
                                            width: MediaQuery.of(context).size.width -30,
                                            // height: 110.0 * jadwal[index]['ship'].length.toDouble(),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left:10,bottom: 5,top:15),
                                              width: 30,
                                              child:Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                                      color: Colors.red[700]
                                                    ),
                                                    width: 30,
                                                    height: 30,
                                                    child: Container(
                                                       decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                                      color: Colors.white
                                                    ),
                                                      // child: SvgPicture.asset(
                                                      //   'assets/cruise.svg',
                                                      //   color: Colors.red[700],
                                                      // ),
                                                    )
                                                  ),
                                                   Container(
                                                    width: 20,
                                                    height: jadwal[index]['ship'].length > 1 ? 90.0 * (jadwal[index]['ship'].length.toDouble()): 85.0 ,
                                                    child: VerticalDivider(color: Colors.red,width: 2,thickness: 2,),
                                                   ),
                                                   
                                                    Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                                      color: Colors.blue[700]
                                                    ),
                                                    width: 30,
                                                    height: 30,
                                                    child: Container(
                                                       decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                                      color: Colors.white
                                                    ),
                                                      // child: SvgPicture.asset(
                                                      //   'assets/cruise-1.svg',
                                                      // ),
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                          children: <Widget>[
                                            //asal
                                            Container(
                                                width: MediaQuery.of(context).size.width -100,
                                                margin: EdgeInsets.only(top:20),
                                              padding: EdgeInsets.only(left:10,right:10,top:0),
                                              height: 30,
                                            child: Text(jadwal[index]['asal'].toUpperCase(),style: TextStyle(letterSpacing: 0.5,fontSize: 16,fontWeight:FontWeight.w700,color: Colors.red[700],fontFamily: 'Montserrat' ),),
                                          ),


                                            Container(
                                               width: MediaQuery.of(context).size.width -130,
                                              child: Column(
                                                children: List.generate(jadwal[index]['ship'].length, (jlhkpl){
                                                  return Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                    padding: EdgeInsets.only(top:5),
                                                    child:  Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets.only(right: 5,),
                                                          child: Icon(Icons.radio_button_checked,size: 10,color: Colors.black,),
                                                        ),
                                                        Text(jadwal[index]['ship'][jlhkpl]['nama'].toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,letterSpacing: 0.5, color: Colors.black87,fontFamily: 'Montserrat'),)
                                                      ],
                                                    ),
                                                  ),
                                                  ),
                                                 SingleChildScrollView(
                                                   scrollDirection: Axis.horizontal,
                                                   child:   Container(
                                                    padding: EdgeInsets.only(left:15),
                                                    width: MediaQuery.of(context).size.width - 100,
                                                    child: Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                   Padding(
                                                        padding: EdgeInsets.only(bottom: 5,top:5),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets.only(top:5),
                                                                width: MediaQuery.of(context).size.width/5,
                                                                child: Text('CLOSE DATE ',style: TextStyle(color: Colors.grey, fontSize: 10,fontFamily: 'Montserrat',fontStyle: FontStyle.italic,fontWeight: FontWeight.w500),),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/5,
                                                                child: Text(DateFormat('d MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(jadwal[index]['ship'][jlhkpl]['Closing'] * 1000)).toString(),style: TextStyle(color: Colors.grey, fontSize: 12,fontFamily: 'Montserrat',fontWeight: FontWeight.w500),),
                                                              )
                                                          ],
                                                        )),
                                                  Padding(
                                                        padding: EdgeInsets.only(bottom: 5),
                                                        child:  Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/5,
                                                                child: Text('ETD ',style: TextStyle(color: Colors.grey, fontSize: 10,fontFamily: 'Montserrat',fontWeight: FontWeight.w500),),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/5,
                                                                child: Text(DateFormat('d MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(jadwal[index]['ship'][jlhkpl]['ETD'] * 1000)).toString(),style: TextStyle(color: Colors.grey, fontSize: 12,fontFamily: 'Montserrat',fontWeight: FontWeight.w500),),
                                                              )
                                                          ],
                                                        )),
                                                         Padding(
                                                        padding: EdgeInsets.only(bottom: 5),
                                                        child:  Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/5,
                                                                child: Text('ETA ',style: TextStyle(color: Colors.grey, fontSize: 10,fontFamily: 'Montserrat',fontWeight: FontWeight.w500),),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/5,
                                                                child: Text(DateFormat('d MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(jadwal[index]['ship'][jlhkpl]['ETA'] * 1000)).toString(),style: TextStyle(color: Colors.grey, fontSize: 12,fontFamily: 'Montserrat',fontWeight: FontWeight.w500),),
                                                              )
                                                          ],
                                                        )),
                                                    ],
                                                  ),

                                                   ),
                                                 ),
                                                
                                              
                                                ],
                                              );
                                                }),
                                              ),
                                            ),
                                            
                                            Container(
                                                       width: MediaQuery.of(context).size.width -100,
                                                      padding: EdgeInsets.only(left:10,right:10,top:5),
                                                      height: 30,
                                                    child: Text(jadwal[index]['tujuan'].toUpperCase(),style: TextStyle(letterSpacing: 0.5,fontSize: 16,fontWeight:FontWeight.w700,color: Colors.blue[800],fontFamily: 'Montserrat' ),),
                                                  ),
                                            //   Container(
                                            //   //padding: EdgeInsets.only(bottom: 10),
                                            //    width: MediaQuery.of(context).size.width -70,
                                            //   child: Divider(color: Colors.grey[600],),
                                            // ),
                                          ],
                                        ),
                                          ],
                                        )
                                      ),
                                       
                                    ],
                                  );
                                }),
                              ),
                      ),
                              ),
                            ),
                    
                    )
                    
                      
                
                ],
              
               ),
              color: Colors.black,
              progressIndicator: CircularProgressIndicator(backgroundColor: Colors.black38,),
              inAsyncCall: _loadingInProgress,)
          );
  }
}