import 'package:flutter/material.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/screen/detailTracking.dart';
class dataTracking extends StatefulWidget {
  List<DataResi> dataTrack;
  dataTracking({Key key, this.dataTrack});
  @override
  _dataTrackingState createState() => _dataTrackingState();
}

class _dataTrackingState extends State<dataTracking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          new Container(
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
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
             child:Container(
              height: MediaQuery.of(context).size.width -100,
            width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 1,
              sortColumnIndex: 1,
              sortAscending: true,
                  columns: [
                  DataColumn(label: Text('Qty', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)) ,
                  DataColumn(label: Text('Nama Barang', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  DataColumn(label: Text('Pengirim', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  DataColumn(label: Text('Kontainer', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  ],
                  rows: 
                   widget.dataTrack.map(((DataResi element ) => DataRow(
                     selected: true,
                      cells: <DataCell>[
                        DataCell(
                          Text(element.qty.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                          onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => trackingDetail(
                              dataTracking: element
                            )));
                          }),
                        DataCell(Text(element.namaBarang.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => trackingDetail(
                              dataTracking: element
                            )));
                        }),
                       
                        DataCell(Text(element.namaPengirim.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => trackingDetail(
                              dataTracking: element
                            )));
                        }),
                        DataCell(Text(element.noKontainer.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => trackingDetail(
                              dataTracking: element
                            )));
                        }),
                      ]
                   )
                   )
                   
            ).toList()
            ),
          )
             ),
          ),
      ),
        ],

      )
    );
  }
}