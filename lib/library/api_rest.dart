import 'dart:async';
import 'dart:convert';
import 'model.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'api_network.dart';
import 'package:flutter/services.dart';

class RestDatasource {
  NetworkUtil _netUtil = NetworkUtil();
  String baseUrl = 'https://www.sindo.co.id/apk/tracking.php?key=s3ks9293ks9&tally=';
  String baseUrl1 = 'https://ptsindo.com/rebuild/rest.php/v1/';
  Dio dio = new Dio();
  Response response;
Future<dynamic> getHeaders() async {
    return {
      // "UID": auth.uid,
      // "ACCESS_TOKEN": auth.accessToken,
      // "DEVICE_TOKEN": auth.deviceToken,
      // "CLIENT": auth.clientId
      //"Key": apiKey ? apiKey : null,
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
  }

Future getResi(String ctrl) {
  var url = baseUrl + ctrl;
  print('ini url ' + url.toString());
  return getHeaders().then((dynamic headers) {
      return _netUtil
          .getPoint(url, headers:headers)
          .then((dynamic res) {
            
        var body = jsonDecode(res.body);
        return body;
      }).catchError((error){
        return false;
      });
  });
}


Future getHistory(String ctrl) {
  var url = baseUrl + ctrl;
  return getHeaders().then((dynamic headers) {
      return _netUtil
          .getPoint(url, headers:headers)
          .then((dynamic res) {
        var body = jsonDecode(res.body);
        return body;
      });
  });
}
Future getInvoice(String ctrl) async{
  var url = 'https://www.sindo.co.id/apk/invoice.php?key=s3ks9293ks9' + ctrl;
  response = await dio.get(url);// or ResponseType.JSON);
    var body =jsonDecode(response.toString());
    return body;
  // return getHeaders().then((dynamic headers) {
  //     return _netUtil
  //         .getPoint(url, headers:headers)
  //         .then((dynamic res) {
  //       var body = jsonDecode(res.body);
  //       return body;
  //     });
  // });
}

Future getgallery(String ctrl) {
  var url = baseUrl1 + ctrl;
  return getHeaders().then((dynamic headers) {
      return _netUtil
          .getPoint(url, headers:headers)
          .then((dynamic res) {
        var body = jsonDecode(res.body);
        return body;
      });
  });
}

Future changePass(String ctrl) {
  var url = 'https://www.sindo.co.id/apk/update_password.php?key=s3ks9293ks9' + ctrl;
  return getHeaders().then((dynamic headers) {
      return _netUtil
          .getPoint(url, headers:headers)
          .then((dynamic res) {
        var body = jsonDecode(res.body);
        return body;
      });
  });
}

Future getSlide(String ctrl) {
  var url = baseUrl1 + ctrl;
  return getHeaders().then((dynamic headers) {
      return _netUtil
          .getPoint(url, headers:headers)
          .then((dynamic res) {
        var body = jsonDecode(res.body);
        return body;
      });
  });
}

Future getPort(String ctrl) {
  var url = baseUrl1 + ctrl;
  return getHeaders().then((dynamic headers) {
      return _netUtil
          .getPoint(url, headers:headers)
          .then((dynamic res) {
        var body = jsonDecode(res.body);
        return body;
      });
  });
}


Future getBerita(String ctrl) {
  var url = baseUrl1 + ctrl;
  return getHeaders().then((dynamic headers) {
      return _netUtil
          .getPoint(url, headers:headers)
          .then((dynamic res) {
        var body = jsonDecode(res.body);
        return body;
      });
  });
}

Future upload(String ctrl, File imageFile,{bankid,holder,account,namafile}) async {   
   var url = baseUrl + ctrl; 
    FormData formData = new FormData();
formData.fields
..add(MapEntry("bank_id", bankid))
..add(MapEntry("bank_account_holder", holder))
..add(MapEntry("bank_account", account));

  formData.files.add(MapEntry(
    "uploaded_photo",
    await MultipartFile.fromFile(imageFile.path.toString(),
        filename: namafile.toString()),
  ));

    response = await dio.post(url, data: formData);// or ResponseType.JSON);
    var body =jsonDecode(response.toString());
    return body;
}


// Future getAuth(String ctrl, UserData userData) {
//   var url = baseUrl + ctrl;
//   Map<String, String> stringParams = {
//         'password': userData.password,
//         'username': userData.username,
//       };
  
//   return getHeaders().then((dynamic headers) {
//       return _netUtil
//           .postAuth(url, body: stringParams, headers: headers)
//           .then((dynamic res) {
//         var body = jsonDecode(res.body);
//         return body;
//       });
//   });
// }
Future getAuth(String ctrl,UserData userData) async {   
   var url = ctrl +"&user="+userData.username+"&pass="+userData.password; 
    response = await dio.get(url);// or ResponseType.JSON);
    var body =jsonDecode(response.toString());
    return body;
}


// Future<QuizModel> sendResultQuiz(String messageUrl, Map params) {
//     return getHeaders().then((dynamic headers) {
//       return _netUtil
//           .post(messageUrl, body: params, headers: headers)
//           .then((dynamic res) {
//         // var body = jsonDecode(res.body);
//         // print("Quiz Result = "+body.toString());
//         print("Quiz Result = " + res.body.toString());
//         // if (body["error"] != null) throw new Exception(body["error_msg"]);

//         // return new ListMessage.map(body);
//         // return QuizModel.map(body);
//       });
//     });
//   }
}