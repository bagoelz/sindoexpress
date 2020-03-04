import 'package:flutter/material.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/screen/dataTracking.dart';
class trackingDetail extends StatefulWidget {
  DataResi dataTracking;
  trackingDetail({Key ket,this.dataTracking});
  @override
  _trackingDetailState createState() => _trackingDetailState();
}

class _trackingDetailState extends State<trackingDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover )
          ),
        ),
         Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text('Data Tracking'),
            ),
            backgroundColor: Colors.transparent,
        body: Container(
            height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('Tgl Masuk', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.tglMasuk),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.qty),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('#Sat', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.satuan),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('Nama Barang', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.namaBarang),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('No. Tracking', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.noResi),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('Pengirim', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.pengirim),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('Kontainer', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.kontainer),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('Kapal', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.kapal),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('ETD', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.etd),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('ETA', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.eta),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('ATD', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.atd),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              Container(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text('ATA', style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(10),
                    child: Text(widget.dataTracking.ata),
                  ),
                  
                ],
              ) ,
              ),
              Divider(color: Colors.grey),
              // Container(
              //   child:Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget>[
              //      Container(
              //        width: MediaQuery.of(context).size.width/2,
              //       padding: EdgeInsets.all(10),
              //       child: Text('DT', style: TextStyle(fontWeight: FontWeight.w600),),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width/2,
              //       padding: EdgeInsets.all(10),
              //       child: Text(widget.dataTracking.tglDt),
              //     ),
                  
              //   ],
              // ) ,
              // ),
              // Divider(color: Colors.grey)
              
            ],
        ),
        )
        )
         )
        ],
      )
    );
  }
}

