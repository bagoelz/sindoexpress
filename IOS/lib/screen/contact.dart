import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background01.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  "OUR CONTACTS",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: "sans"),
                ),
              ),
              body: Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                width: width,
                height: height - 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/contactandbranches.png",
                        ),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 50, top: 20, bottom: 40),
                        child: Image.asset(
                          "assets/sindo-express-text.png",
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Expanded(
                      //     child: Image.asset(
                      //       "assets/contact_1.png",
                      //     ),
                      //   ),
                      // ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/contact_1.png")),
                      Container(
                          alignment: Alignment.centerLeft,
                          height: height / 5.8,
                          width: width,
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/contact_2.png")),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/contact_3.png")),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/contact_4.png")),
                      Container(
                          alignment: Alignment.centerLeft,
                          height: height / 4.8,
                          width: width,
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/contact_5.png")),

                      // Container(
                      //   margin: EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(20)),
                      //       image: DecorationImage(
                      //           image: AssetImage(
                      //             "assets/contact_2.png",
                      //           ),
                      //           fit: BoxFit.fitWidth)),
                      // ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/contact_3.png",
                                ),
                                fit: BoxFit.fitWidth)),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/contact_4.png",
                                ),
                                fit: BoxFit.fitWidth)),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/contact_5.png",
                                ),
                                fit: BoxFit.fitWidth)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              child: Container(
                  width: width,
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
      ),
    );
  }
}
