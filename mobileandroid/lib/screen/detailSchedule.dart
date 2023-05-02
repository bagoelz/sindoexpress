import 'package:flutter/material.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:intl/intl.dart';
class detailSchedule extends StatefulWidget {
  List<DataSchedule>  data;
  List<Pelabuhan> pelabuhan;
  detailSchedule({
    Key key, this.data,this.pelabuhan,
  });

  @override
  _detailScheduleState createState() => _detailScheduleState();
}

class _detailScheduleState extends State<detailSchedule> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

     child:Stack(
                children: <Widget>[
                  new Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image:AssetImage("assets/background.png"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  Scaffold(
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      title: 
                        Row(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text("Detail Schedule",style: TextStyle(color: Colors.black),),),

                      ],)
                    ),
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
             child:Container(
            width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                      child: DataTable(
              columnSpacing: 10,
              sortColumnIndex: 1,
              sortAscending: true,
                  columns: [
                    DataColumn(label: Text('P. Loading', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                    DataColumn(label: Text('P. Discharge', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                    DataColumn(label: Text('Dpt. Date', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                    DataColumn(label: Text('Arv. Date', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  ],
                rows:
                 widget.data.map(((DataSchedule element ) => DataRow(
                     selected: true,
                      cells: <DataCell>[
                      
                        DataCell(
                          Text(widget.pelabuhan[element.asal].nama.toString()),
                          // onTap: (){
                          //    Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (BuildContext context) => detailReportInside(
                          //     kasusDetail: element,
                          //     title: element.CaseName,
                          //   )));
                          // }
                          ),
                        DataCell(
                          Text(widget.pelabuhan[element.tujuan].nama.toString()),
                          // onTap: (){
                          //    Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (BuildContext context) => detailReportInside(
                          //     kasusDetail: element,
                          //     title: element.CaseName,
                          //   )));
                          // }
                          ),
                          DataCell(
                          Text(DateFormat('d MMM y HH:m').format(DateTime.fromMillisecondsSinceEpoch(element.tglberangkat)).toString()),
                          // onTap: (){
                          //    Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (BuildContext context) => detailReportInside(
                          //     kasusDetail: element,
                          //     title: element.CaseName,
                          //   )));
                          // }
                          ),
                          DataCell(
                          Text(DateFormat('d MMM y HH:m').format(DateTime.fromMillisecondsSinceEpoch(element.tgltiba)).toString()),
                          // onTap: (){
                          //    Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (BuildContext context) => detailReportInside(
                          //     kasusDetail: element,
                          //     title: element.CaseName,
                          //   )));
                          // }
                          ),
                      ],
                    )),
                 ).toList(),
          ),
          ),
             )
                    )
                  )
                ]
                )
    );
  }
}

