import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/validation.dart';
import 'package:sindoexpress/screen/detailTracking.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:intl/intl.dart';
import 'package:sindoexpress/screen/detailTrackingLogin.dart';

class dataTracking extends StatefulWidget {
  List<DataResi> dataTrack;
  String title;
  final bool tracking;
  final bool search;
  final bool detail;
  final bool login;
  String tally;
  dataTracking(
      {Key key,
      this.dataTrack,
      this.title,
      this.login: false,
      this.detail: false,
      this.tracking: false,
      this.search: false,
      this.tally});
  @override
  _dataTrackingState createState() => _dataTrackingState();
}

class _dataTrackingState extends State<dataTracking> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loadingInProgress = false;
  SharedPref sharedPref = SharedPref();
  RestDatasource _rest = RestDatasource();
  List<DataResi> _dataResi = List();
  ValidationsLogin _validations = new ValidationsLogin();
  TextEditingController awalTgl = TextEditingController();
  TextEditingController akhirTgl = TextEditingController();
  DateTime dateAwal, dateAkhir;
  final LocalStorage storage = new LocalStorage('Sindo_app');
  var awal = '';
  var akhir = '';
  DateTime selectedDate = DateTime.now();
  final _fixedRowCells = [
    "Date",
    "QTY",
    "Trk. Number",
  ];

  @override
  void initState() {
    var now = DateTime.now();
    awal =
        DateFormat("yyyy-MM-dd").format(now.subtract(new Duration(days: 60)));
    akhir = DateFormat("yyyy-MM-dd").format(now);
    if (widget.dataTrack != null) {
      _dataResi = widget.dataTrack;
    } else {
      _dataResi = [];
    }
    if (widget.search == true) {
      cariDataResi2(widget.tally);
    }
    // TODO: implement initState
    print('ini login ' + widget.login.toString());
    print('ini detail ' + widget.detail.toString());
    super.initState();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }

  customDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(builder: (context, passwordchange) {
            return AlertDialog(
                title: new Text(
                  "Warning",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                content: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max, // To make the card compact
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Text(
                        "Only allowed 60 days difference for Tracking !",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // To close the dialog
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(
                                fontSize: 18, color: Colors.blue[500]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  cariDataResi() async {
    final start = DateTime(dateAwal.year, dateAwal.month, dateAwal.day);
    final end = DateTime(dateAkhir.year, dateAkhir.month, dateAkhir.day);
    final difference = end.difference(start).inDays;
    if (difference > 60) {
      customDialog();
      return;
    }
    List<DataResi> data = List();
    setState(() {
      _loadingInProgress = true;
    });
    var resi = await sharedPref.read('KODE');
    await _rest
        .getHistoryTgl('&kd_penerima=&cust=' +
            resi +
            '&date1=${awalTgl.text}&date2=${akhirTgl.text}')
        .then((onValue) {
      setState(() {
        _loadingInProgress = false;
        for (var x in onValue) {
          _dataResi.add(DataResi.map(x));
        }
      });
    });
  }

  cariDataResi2(notally) async {
    List<DataResi> data = List();
    setState(() {
      _loadingInProgress = true;
    });
    var resi = await sharedPref.read('KODE');
    await _rest
        .getHistoryTgl('&kd_penerima=&cust=' + resi + '&tally=' + notally)
        .then((onValue) {
      setState(() {
        _loadingInProgress = false;
        for (var x in onValue) {
          _dataResi.add(DataResi.map(x));
        }
      });
    });
  }

  Future<Null> _selectDate(BuildContext context, stat) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
              //primarySwatch: buttonTextColor,//OK/Cancel button text color
              primaryColor: Colors.indigo[900], //Head background
              accentColor: Colors.indigo[900] //selection color
              //dialogBackgroundColor: Colors.white,//Background color
              ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) if (stat == 'akhir') {
      setState(() {
        dateAkhir = picked;
        akhirTgl.text =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(picked.toString()));
      });
    } else {
      setState(() {
        dateAwal = picked;
        awalTgl.text =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(picked.toString()));
      });
    }
  }
  // Widget datetime(res) {
  //   return CupertinoDatePicker(
  //     initialDateTime: DateTime.now(),
  //     onDateTimeChanged: (DateTime newdate) {
  //       if(res=='akhir'){
  //         setState(() {
  //           dateAkhir = newdate;
  //           akhirTgl.text=DateFormat('yyyy-MM-dd').format(DateTime.parse(newdate.toString()));
  //         });
  //       }else{
  //         setState(() {
  //           dateAwal = newdate;
  //          awalTgl.text=DateFormat('yyyy-MM-dd').format(DateTime.parse(newdate.toString()));
  //         });
  //       }
  //     },
  //     use24hFormat: false,
  //     maximumDate: new DateTime.now(),
  //     minimumYear: 2010,
  //     maximumYear: DateTime.now().year,
  //     mode: CupertinoDatePickerMode.date,
  //   );
  // }

  // shotTgl(res){
  //   showModalBottomSheet(
  //   context: context,
  //   builder: (BuildContext builder) {
  //     return Container(
  //         height:
  //             MediaQuery.of(context).copyWith().size.height /
  //                 3,
  //         child: datetime(res));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: SafeArea(
          child: Stack(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              //   image: DecorationImage(
              //     image: AssetImage("assets/background01.jpg"),
              //     fit: BoxFit.cover )
            ),
          ),
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                widget.tracking
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: () => _selectDate(context, 'awal'),
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              width: MediaQuery.of(context).size.width / 2.6,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: 'Montserrat'),
                                  controller: awalTgl,
                                  enabled: false,
                                  onSaved: (val) {
                                    //_userData.password = val;
                                  },
                                  //validator: _validations.validateResi,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 5, top: 15),
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: awal,
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    errorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () => _selectDate(context, 'akhir'),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.6,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: 'Montserrat'),
                                  enabled: false,
                                  controller: akhirTgl,
                                  onSaved: (val) {
                                    //_userData.password = val;
                                  },
                                  //validator: _validations.validateResi,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 5, top: 15),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                    hintText: akhir,
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    errorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                  )),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                cariDataResi();
                                // setState(() {
                                //   //flagpass = !flagpass;
                                // });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey[400],
                                ),
                              ))
                        ],
                      )
                    : Container(height: 0),
                Container(
                  margin: EdgeInsets.all(20.0),
                  height: widget.tracking
                      ? MediaQuery.of(context).size.height / 1.5
                      : MediaQuery.of(context).size.height / 1.35,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background02.jpg'),
                        fit: BoxFit.cover),
                    color: Colors.white,
                    border: new Border.all(width: 1.0, color: Colors.grey[200]),
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        height: widget.tracking
                            ? MediaQuery.of(context).size.height / 1.5
                            : MediaQuery.of(context).size.height / 1.35,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(10),
                          child: CustomDataTable(
                            fixedRowCells: _fixedRowCells,
                            rowsCells: _dataResi,
                            login: widget.login,
                            detail: widget.detail,
                            cellWidth:
                                (MediaQuery.of(context).size.width - 80) / 3,
                            cellBuilderC: (data) {
                              return Text('$data',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700));
                            },
                            cellBuilder: (data) {
                              return Text('$data',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700));
                            },
                          ),
                        )
                        // child: DataTable(
                        //   columnSpacing: 1,
                        //   sortColumnIndex: 1,
                        //   sortAscending: true,
                        //       columns: [
                        //       DataColumn(label:Text('Entry Date', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                        //       DataColumn(label: Text('Qty', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)) ,
                        //       DataColumn(label: Text('Trk. Number', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)) ,
                        //       // DataColumn(label: Text('Pengirim', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                        //       // DataColumn(label: Text('Kontainer', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                        //        ],
                        //       rows:
                        //       _dataResi.map(((DataResi element ) => DataRow(
                        //          selected: true,
                        // cells: <DataCell>[
                        //    DataCell(Text(element.tglMasuk,style: TextStyle(color:Colors.black,fontSize: 14,)),
                        //   onTap: (){
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (BuildContext context) => trackingDetail(
                        //         dataTracking: element
                        //       )));
                        //   }),
                        //             DataCell(
                        //               Text(element.qty.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        //               onTap: (){
                        //                  Navigator.of(context).push(MaterialPageRoute(
                        //                 builder: (BuildContext context) => trackingDetail(
                        //                   dataTracking: element
                        //                 )));
                        //               }),
                        //             DataCell(Text(element.resi.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        //             onTap: (){
                        //                 Navigator.of(context).push(MaterialPageRoute(
                        //                 builder: (BuildContext context) => trackingDetail(
                        //                   dataTracking: element
                        //                 )));
                        //             }),

                        //             // DataCell(Text(element.noKontainer.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        //             // onTap: (){
                        //             //     Navigator.of(context).push(MaterialPageRoute(
                        //             //     builder: (BuildContext context) => trackingDetail(
                        //             //       dataTracking: element
                        //             //     )));
                        //             // }),
                        //           ]
                        //        )
                        //        )

                        // ).toList()
                        // ),

                        ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 100,
                        child: Image.asset(
                          "assets/sindocopyrightlogo.png",
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    ],
                  )))
        ],
      )),
      inAsyncCall: _loadingInProgress,
      color: Colors.black,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: Colors.black12,
      ),
    );
  }
}

class CustomDataTable<T> extends StatefulWidget {
  final T fixedCornerCell;
  final List<T> fixedColCells;
  final List<T> fixedRowCells;
  final List<DataResi> rowsCells;
  final Widget Function(DataResi data) cellBuilder;
  final Widget Function(T data) cellBuilderC;
  final double fixedColWidth;
  final double cellWidth;
  final double cellHeight;
  final double cellMargin;
  final double cellSpacing;
  final bool login;
  final bool detail;

  CustomDataTable({
    this.fixedCornerCell,
    this.fixedColCells,
    this.fixedRowCells,
    this.login,
    this.detail,
    @required this.rowsCells,
    this.cellBuilderC,
    this.cellBuilder,
    this.fixedColWidth = 120.0,
    this.cellHeight = 50.0,
    this.cellWidth,
    this.cellMargin = 10.0,
    this.cellSpacing = 1.0,
  });

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();

  // Widget _buildChild(double width, DataResi data) => SizedBox(
  //     width: width, child: widget.cellBuilder?.call(data) ?? Text('$data'));

  Widget _buildChildC(double width, T data) => data == 'QTY'
      ? SizedBox(
          width: 50,
          child: Text('$data',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )))
      : SizedBox(
          width: widget.cellWidth,
          child: Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              '$data',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
          ));
  // Widget _buildFixedCol() => widget.fixedColCells == null
  //     ? SizedBox.shrink()
  //     : Material(
  //         color: Colors.lightBlueAccent,
  //         child: DataTable(
  //             horizontalMargin: widget.cellMargin,
  //             columnSpacing: widget.cellSpacing,
  //             headingRowHeight: widget.cellHeight,
  //             dataRowHeight: widget.cellHeight,
  //             columns: [
  //               DataColumn(
  //                   label: _buildChild(
  //                       widget.fixedColWidth, widget.fixedColCells.first))
  //             ],
  //             rows: widget.fixedColCells
  //                 .sublist(widget.fixedRowCells == null ? 1 : 0)
  //                 .map((c) => DataRow(
  //                     cells: [DataCell(_buildChild(widget.fixedColWidth, c))]))
  //                 .toList()),
  //       );

  Widget _buildFixedRow() => widget.fixedRowCells == null
      ? SizedBox.shrink()
      : Material(
          color: Colors.white,
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: widget.cellHeight,
              dataRowHeight: widget.cellHeight,
              columns: widget.fixedRowCells
                  .map((c) =>
                      DataColumn(label: _buildChildC(widget.cellWidth, c)))
                  .toList(),
              rows: []),
        );

  Widget _buildSubTable() => Material(
      color: Colors.transparent,
      child: DataTable(
        horizontalMargin: widget.cellMargin,
        columnSpacing: widget.cellSpacing,
        headingRowHeight: widget.cellHeight,
        dataRowHeight: widget.cellHeight,
        columns: widget.fixedRowCells
            .map((c) => DataColumn(label: _buildChildC(widget.cellWidth, c)))
            .toList(),
        rows: widget.rowsCells
            .map((row) => DataRow(cells: <DataCell>[
                  DataCell(
                      Text(row.tglMasuk,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )), onTap: () {
                    if (widget.login == true && widget.detail == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              trackingDetailLogin(dataTracking: row)));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              trackingDetail(dataTracking: row)));
                    }
                  }),
                  DataCell(
                      Text(row.qty,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )), onTap: () {
                    if (widget.login == true && widget.detail == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              trackingDetailLogin(dataTracking: row)));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              trackingDetail(dataTracking: row)));
                    }
                  }),
                  DataCell(
                      Text(row.noResi,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )), onTap: () {
                    if (widget.login == true && widget.detail == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              trackingDetailLogin(dataTracking: row)));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              trackingDetail(dataTracking: row)));
                    }
                  }),
                ]))
            .toList(),
      ));
  // Widget _buildCornerCell() =>
  //     widget.fixedColCells == null || widget.fixedRowCells == null
  //         ? SizedBox.shrink()
  //         : Material(
  //             color: Colors.amberAccent,
  //             child: DataTable(
  //                 horizontalMargin: widget.cellMargin,
  //                 columnSpacing: widget.cellSpacing,
  //                 headingRowHeight: widget.cellHeight,
  //                 dataRowHeight: widget.cellHeight,
  //                 columns: [
  //                   DataColumn(
  //                       label: _buildChild(
  //                           widget.fixedColWidth, widget.fixedCornerCell))
  //                 ],
  //                 rows: []),
  //           );

  @override
  void initState() {
    super.initState();
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            // SingleChildScrollView(
            //   controller: _columnController,
            //   scrollDirection: Axis.vertical,
            //   physics: NeverScrollableScrollPhysics(),
            //   child: _buildFixedCol(),
            // ),
            Flexible(
              child: SingleChildScrollView(
                controller: _subTableXController,
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  controller: _subTableYController,
                  scrollDirection: Axis.vertical,
                  child: _buildSubTable(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            //_buildCornerCell(),
            Flexible(
              child: SingleChildScrollView(
                controller: _rowController,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                child: _buildFixedRow(),
              ),
            ),
          ],
        ),
        // Row(
        //   children: <Widget>[
        //    // _buildCornerCell(),
        //     Flexible(
        //       child:_buildFixedRow(),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
