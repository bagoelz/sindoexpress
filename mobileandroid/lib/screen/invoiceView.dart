import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sindoexpress/library/api_rest.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();


class InvoiceView extends StatefulWidget {
  final String kode;
  final String title;
  InvoiceView({Key key,this.kode,this.title}) : super(key: key);

  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {

  bool _loadingInProgress = false;
  //   JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'Toaster',
  //       onMessageReceived: (JavascriptMessage message) {
  //         Scaffold.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       });
  // }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
         backgroundColor: Colors.black,       
        iconTheme: IconThemeData(color: Colors.white),
          title:Text(widget.title.toString(),style: TextStyle(fontFamily: 'Montserrat',),),
        ),
        body: Builder(builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
          child:WebviewScaffold(
            url: 'https://www.sindo.co.id/apk/inv_baca.php?key=s3ks9293ks9&no_invoice='+widget.kode,
            javascriptChannels: jsChannels,
            withZoom: true,
            withLocalStorage: false,
            useWideViewPort: true,
            withOverviewMode: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: const Center(
                child: Text('loading.....'),
              ),
            ),
        // child: WebView(
        //   initialUrl: 'https://www.sindo.co.id/apk/inv_baca.php?key=s3ks9293ks9&no_invoice='+widget.kode,
        //   javascriptMode: JavascriptMode.unrestricted,
        //   onWebViewCreated: (WebViewController webViewController) {
        //     _controller.complete(webViewController);
        //   },
        //   //  javascriptChannels: <JavascriptChannel>[
        //   //   _toasterJavascriptChannel(context),
        //   // ].toSet(),
         ),);
        })
      )
    ,inAsyncCall: _loadingInProgress,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.black38,
        ),)
      );
  }
}