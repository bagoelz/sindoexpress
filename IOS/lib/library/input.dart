import 'package:flutter/material.dart';

class textFromField extends StatelessWidget {
  bool password;
  String text;
  IconData icon;
  TextInputType inputType;
  var onSaved;
  var validateFunction;
  String value;
  TextEditingController textController;

  textFromField({this.text, this.icon, this.inputType, this.password, this.onSaved, this.validateFunction, this.textController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(14.0),
        //     color: Colors.white,
        //     boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            controller: textController,
            obscureText: password,
            onSaved: onSaved,
            validator: validateFunction,
            decoration: InputDecoration(
            border: new UnderlineInputBorder(
            borderSide: new BorderSide(
              color: Colors.grey[200]
              )
            ),
            labelText: text,
                
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}
