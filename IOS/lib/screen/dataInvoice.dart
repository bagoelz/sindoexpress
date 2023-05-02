import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:sindoexpress/screen/invoiceView.dart';
import 'package:intl/intl.dart';

formatuang(double amount) {
  return FlutterMoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
        symbol: '',
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      )).output.symbolOnLeft;
}

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  RestDatasource _rest = RestDatasource();
  List<Datainvoice> _dataInvoice = List();
  bool _loadingInProgress = false;
  SharedPref sharedPref = SharedPref();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String kalimat = '';
  TextEditingController awalTgl = TextEditingController();
  TextEditingController akhirTgl = TextEditingController();
  var awal = '';
  var akhir = '';
  DateTime dateAwal, dateAkhir;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    var now = DateTime.now();
    awal =
        DateFormat("yyyy-MM-dd").format(now.subtract(new Duration(days: 60)));
    akhir = DateFormat("yyyy-MM-dd").format(now);
    super.initState();
  }

  @override
  void dispose() {
    //_portraitModeOnly();

    // TODO: implement dispose
    super.dispose();
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

  cariDataResi() async {
    _dataInvoice = [];
    final start = DateTime(dateAwal.year, dateAwal.month, dateAwal.day);
    final end = DateTime(dateAkhir.year, dateAkhir.month, dateAkhir.day);
    final difference = end.difference(start).inDays;
    if (difference > 60) {
      customDialog();
      return;
    }
    setState(() {
      _loadingInProgress = true;
    });
    var kode = await sharedPref.read('KODE');
    _rest
        .getInvoice(
            '&kd_sub=' + kode + '&date1=${awalTgl.text}&date2=${akhirTgl.text}')
        .then((onValue) {
      setState(() {
        _loadingInProgress = false;
        for (var x in onValue) {
          _dataInvoice.add(Datainvoice.map(x));
        }
      });
    });
  }

  showChart() async {
    if (_dataInvoice.length > 0) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              DataInvoice(rotate: false, data: _dataInvoice)));
    } else {
      showInSnackBar('No data yet');
    }
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
                        "Only allowed 60 days difference for Searching !",
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        ModalProgressHUD(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  "INVOICE DETAIL",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Montserrat"),
                ),
              ),
              body: Column(
                children: <Widget>[
                  Row(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                errorBorder: UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                errorBorder: UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
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
                  ),
                  Container(
                      margin: EdgeInsets.all(20.0),
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/background02.jpg'),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        border:
                            new Border.all(width: 1.0, color: Colors.grey[200]),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      child: _dataInvoice.length > 0
                          ? DataInvoice(data: _dataInvoice, rotate: false)
                          : Center(
                              child: Text(kalimat),
                            )),
                ],
              )),
          inAsyncCall: _loadingInProgress,
          color: Colors.black,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.black12,
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
    ));
  }
}

class DataInvoice extends StatefulWidget {
  List<Datainvoice> data;
  bool rotate;
  DataInvoice({Key key, this.data, this.rotate}) : super(key: key);
  @override
  _DataInvoiceState createState() => _DataInvoiceState();
}

class _DataInvoiceState extends State<DataInvoice> {
  final _fixedRowCells = [
    "Date",
    "Invoice",
    "Amount",
  ];

// Widget _buildChild(double width, T data) => SizedBox(
//       width: width, child: widget.cellBuilder?.call(data) ?? Text('$data'));
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 1.6,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height / 1.6,
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.all( Radius.circular(15.0),
                  //   ),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey[300],
                  //       offset: Offset(1.0, 1.0)
                  //     )
                  //   ]
                  // ),
                  child: CustomDataTable(
                    fixedRowCells: _fixedRowCells,
                    rowsCells: widget.data,
                    cellWidth: (MediaQuery.of(context).size.width - 30) / 6,
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
              ]),
        ));
  }
}

class CustomDataTable<T> extends StatefulWidget {
  final T fixedCornerCell;
  final List<T> fixedColCells;
  final List<T> fixedRowCells;
  final List<Datainvoice> rowsCells;
  final Widget Function(DataResi data) cellBuilder;
  final Widget Function(T data) cellBuilderC;
  final double fixedColWidth;
  final double cellWidth;
  final double cellHeight;
  final double cellMargin;
  final double cellSpacing;

  CustomDataTable({
    this.fixedCornerCell,
    this.fixedColCells,
    this.fixedRowCells,
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

  Widget _buildChildC(double width, T data) => data != 'Amount'
      ? SizedBox(
          width: widget.cellWidth,
          child: Text('$data',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )))
      : SizedBox(
          width: MediaQuery.of(context).size.width - widget.cellWidth,
          child: Padding(
            padding: EdgeInsets.only(left: 45),
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
              horizontalMargin: 5,
              columnSpacing: 10,
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
        horizontalMargin: 5,
        columnSpacing: 10,
        headingRowHeight: widget.cellHeight,
        dataRowHeight: widget.cellHeight,
        columns: widget.fixedRowCells
            .map((c) => DataColumn(label: _buildChildC(widget.cellWidth, c)))
            .toList(),
        rows: widget.rowsCells
            .map((row) => DataRow(cells: <DataCell>[
                  DataCell(
                      Text(row.tglJt,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          )), onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InvoiceView(title: row.nota, kode: row.nota)));
                  }),
                  DataCell(
                      Text(row.nota,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          )), onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InvoiceView(title: row.nota, kode: row.nota)));
                  }),

                  DataCell(
                      Container(
                        width: MediaQuery.of(context).size.width / 3.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Rp',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              formatuang(double.parse(row.debet)),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ), onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InvoiceView(title: row.nota, kode: row.nota)));
                  }),
                  // DataCell(Text(row.kredit,style: TextStyle(color:Colors.black,fontSize: 14,)),
                  // onTap: (){
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => InvoiceView(
                  //       title:row.nota,
                  //       kode:row.nota
                  //     )));
                  // }
                  // ),
                  // DataCell(Text(row.sisa,style: TextStyle(color:Colors.black,fontSize: 14,)),
                  // onTap: (){
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => InvoiceView(
                  //       title:row.nota,
                  //       kode:row.nota
                  //     )));
                  // }
                  // ),
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
                scrollDirection: Axis.vertical,
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
              child: _buildFixedRow(),
            ),
          ],
        ),
      ],
    );
  }
}
