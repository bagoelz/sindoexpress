import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

formatuang (double amount){
return FlutterMoneyFormatter(
    amount: amount,
    settings: MoneyFormatterSettings(
        symbol: 'Rp',
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
    )
).output.symbolOnLeft;
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
  String kalimat ='Please Wait';
  @override
  void initState() {
    // TODO: implement initState
     ambilDataResi();
    super.initState();
  }
  @override
  void dispose() {
    //_portraitModeOnly();
   
    // TODO: implement dispose
    super.dispose();
  }
  ambilDataResi() async{
    setState(() {
      _loadingInProgress = true;
    });
    var kode = await sharedPref.read('KODE');
    _rest.getInvoice('&kd_sub='+ 'C.DUA-002').then((onValue){
      setState(() {
      _loadingInProgress = false;
    });
        for(var x in onValue){
          _dataInvoice.add(Datainvoice.map(x));
        }
        //showChart();
    });
    // .catchError((onError){
    //   showInSnackBar('Network Error');
    //   setState(() {
    //     kalimat ='No data yet';
    //   _loadingInProgress = false;
    // });
    // });
  }

   showChart() async{
      if(_dataInvoice.length > 0 ){
         Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => DataInvoice(
                              rotate: false,
                              data: _dataInvoice
                            )));
      }else{
        showInSnackBar('No data yet');
      }
    }
      void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value.toString())));
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        child:Scaffold(
          key: _scaffoldKey,
       resizeToAvoidBottomPadding: false ,
      appBar: AppBar(  
        elevation: 0.0,
        backgroundColor: Colors.white,     
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Invoice Data",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.black,
                      fontFamily: "sans"),
                  ),
         
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover
          )
        ),
            child: _dataInvoice.length > 0 ? 
            DataInvoice(data: _dataInvoice ,rotate: false)
            :
            Center(
              child: Text(kalimat),
            )
          ),
      ),
       inAsyncCall: _loadingInProgress,
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.black12,
        ),
      )
    );
  }
}



class DataInvoice extends StatefulWidget {
  List<Datainvoice> data;
  bool rotate;
  DataInvoice({Key key,this.data, this.rotate}) : super(key: key);
  @override
  _DataInvoiceState createState() => _DataInvoiceState();
}

class _DataInvoiceState extends State<DataInvoice> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(top:10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: widget.rotate ? MediaQuery.of(context).size.width - 70 : MediaQuery.of(context).size.height / 2 - 70,
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
                child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 5,
              sortColumnIndex: 1,
              sortAscending: true,
                  columns: [
                  DataColumn(label: Text('KDAC', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)) ,
                  DataColumn(label: Text('J. Tempo', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  DataColumn(label: Text('Debit', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  DataColumn(label: Text('Kredit', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  DataColumn(label: Text('Sisa', style: TextStyle(color:Colors.black,fontSize: 14, fontWeight: FontWeight.w700),)),
                  
                  ],
                  rows: 
                   widget.data.map(((Datainvoice element ) => DataRow(
                     selected: true,
                      cells: <DataCell>[
                        DataCell(
                          Text(element.kdac.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                          onTap: (){
                            //  Navigator.of(context).push(MaterialPageRoute(
                            // builder: (BuildContext context) => trackingDetail(
                            //   dataTracking: element
                            // )));
                          }),
                        DataCell(Text(element.tglJt.toString(),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        onTap: (){
                            // Navigator.of(context).push(MaterialPageRoute(
                            // builder: (BuildContext context) => trackingDetail(
                            //   dataTracking: element
                            // )));
                        }),
                       
                        DataCell(Text(formatuang(double.parse(element.debet.toString())),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        onTap: (){
                            // Navigator.of(context).push(MaterialPageRoute(
                            // builder: (BuildContext context) => trackingDetail(
                            //   dataTracking: element
                            // )));
                        }),
                        DataCell(Text(formatuang(double.parse(element.kredit.toString())),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        onTap: (){
                            // Navigator.of(context).push(MaterialPageRoute(
                            // builder: (BuildContext context) => trackingDetail(
                            //   dataTracking: element
                            // )));
                        }),
                         DataCell(Text(formatuang(double.parse(element.sisa.toString())),style: TextStyle(color:Colors.black,fontSize: 14,)),
                        onTap: (){
                            // Navigator.of(context).push(MaterialPageRoute(
                            // builder: (BuildContext context) => trackingDetail(
                            //   dataTracking: element
                            // )));
                        }),
                      ]
                   )
                   )
                   
            ).toList()
            ),
          )
                
              ),

             
        ]),
        )
        
      
    ),
    );
  }
}