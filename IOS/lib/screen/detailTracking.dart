import 'package:flutter/material.dart';
import 'package:sindoexpress/library/SharedPref.dart';
import 'package:sindoexpress/library/model.dart';
import 'package:sindoexpress/screen/dataTracking.dart';

class trackingDetail extends StatefulWidget {
  DataResi dataTracking;
  final bool login;
  trackingDetail({Key ket, this.login: false, this.dataTracking});
  @override
  _trackingDetailState createState() => _trackingDetailState();
}

class _trackingDetailState extends State<trackingDetail> {
  SharedPref sharedPref = SharedPref();
  String _login;
  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  checkLogin() async {
    var _hasil = await sharedPref.read('USERNAME');
    setState(() {
      _login = _hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            // image: DecorationImage(
            //   image: AssetImage("assets/background01.jpg"),
            //   fit: BoxFit.cover )
          ),
        ),
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'DETAIL TRACKING',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: "Montserrat"),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Container(
                margin: EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height / 1.35,
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.all(10),
                              child: Text('Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  )),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  widget.dataTracking?.tglMasuk != null
                                      ? widget.dataTracking.tglMasuk
                                      : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.all(10),
                              child: Text('Quantity',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  )),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  widget.dataTracking?.qty != null
                                      ? widget.dataTracking.qty
                                      : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Unit',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  widget.dataTracking?.satuan != null
                                      ? widget.dataTracking.satuan
                                      : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text('Product',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        widget.dataTracking.namaBarang
                                            .replaceAll('<br>', ''),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Tracking Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                widget.dataTracking?.noResi != null
                                    ? widget.dataTracking.noResi
                                    : '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Sender',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      widget.dataTracking?.pengirim != null
                                          ? widget.dataTracking.pengirim
                                          : '',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Recipient',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                widget.dataTracking?.penerima != null
                                    ? widget.dataTracking.penerima
                                    : '',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Container',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      widget.dataTracking?.kontainer != null
                                          ? widget.dataTracking.kontainer
                                          : '',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Dimension',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      widget?.dataTracking?.panjang +
                                          ' X ' +
                                          widget?.dataTracking?.lebar +
                                          ' X ' +
                                          widget?.dataTracking?.tinggi +
                                          ' = ' +
                                          widget?.dataTracking?.luas,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text('Ship Name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                  widget.dataTracking.kapal
                                          .toUpperCase()
                                          .contains('EST EX ( BATAL KIRIM )')
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.1,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Text(
                                              widget.dataTracking?.kapal != null
                                                  ? widget.dataTracking.kapal
                                                  : '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        )
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.1,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                              widget.dataTracking?.kapal != null
                                                  ? widget.dataTracking.kapal
                                                  : '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                              )),
                                        ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text('ETD',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        widget.dataTracking.etd != null
                                            ? widget.dataTracking.etd
                                            : '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text('ETA',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        widget.dataTracking.eta != null
                                            ? widget.dataTracking.eta
                                            : '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text('ATD',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        widget.dataTracking?.atd != null
                                            ? widget.dataTracking.atd
                                            : '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'ATA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      widget.dataTracking?.ata != null
                                          ? widget.dataTracking.ata
                                          : '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      _login != null
                          ? Divider(color: Colors.grey)
                          : Container(),
                      _login != null
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'DT',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        widget.dataTracking?.tglDt != null
                                            ? widget.dataTracking.tglDt
                                            : '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _login != null ? Divider(color: Colors.grey) : Container()
                    ],
                  ),
                ))),
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
