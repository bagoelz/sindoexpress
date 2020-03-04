import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';
class NetworkUtil {
   static NetworkUtil _instance = new NetworkUtil.internal();
   NetworkUtil.internal();
  factory NetworkUtil() => _instance;
  Future<http.Response> get(String url, Map headers) {
    return http.get(url, headers: headers).then((http.Response response) {
      return handleResponse(response);
    });
  }

   Future<http.Response> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future getPoint(String url, {Map headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
    if (statusCode == 401) {
      throw new Exception("Unauthorized");
    } else if (statusCode == 422) {
      return response;
    }else if (statusCode != 200) {
      throw new Exception("Error while fetching data");
    }else{
      return response;
    }
    });
  }

  Future postAuth(String url, {Map headers, body, encoding}) async{
    return await http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {
      throw new Exception("Unauthorized");
    } else if (statusCode == 422) {
      return response;
    }else if (statusCode != 200) {
      throw new Exception("Error while fetching data");
    }else{
      return response;
    }
    });
  }

  
Future upload(String url, File imageFile,{Map headers, body}) async {   
      // open a bytestream
       return await http
        .post(url, body: body, headers: headers)
        .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {
      throw new Exception("Unauthorized");
    } else if (statusCode == 422) {
      return response;
    }else if (statusCode != 200) {
      throw new Exception("Error while fetching data");
    }else{
      return response;
    }
    });
  }
  
  http.Response handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {
      throw new Exception("Unauthorized");
    } else if (statusCode != 200) {
      throw new Exception("Error while fetching data");
    }
  
    return response;
  }
}