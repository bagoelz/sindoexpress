import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();


class NotifView extends StatefulWidget {
  final String id;
  final String title;
  NotifView({Key key, this.id,this.title}) : super(key: key);

  @override
  _NotifViewState createState() => _NotifViewState();
}

class _NotifViewState extends State<NotifView> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
         backgroundColor: Colors.black,       
        iconTheme: IconThemeData(color: Colors.white),
          title:Text(widget.title.toUpperCase(),style: TextStyle(fontSize: 14,fontFamily: 'Montserrat',),),
        ),
        body: Builder(builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
          child:WebviewScaffold(
            url: 'https://www.sindo.co.id/apk/notif_baca.php?key=s3ks9293ks9&id='+widget.id.toString(),
            javascriptChannels: jsChannels,
            withZoom: true,
            withLocalStorage: true,
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