import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();
  String fcmServer =
      "key=AAAAZVBA_GM:APA91bE0xXFCkCllQVBm9ESrhIgultdXSEsnO9wdNxHMEJuwxEMcgC_FWQHNM8wWfEPz3VjdTXtAfc58bCKPfT3Ylr6OlgSoRUdPYcWTrKymVrgwoXKqDsfweINtZTg4M8KvN9FDIKZD";
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

  Future sendNotif(
      {int id, String title, String body, String keyname, server}) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization": fcmServer,
      };
      var request = {
        "notification": {
          "title": title,
          "body": body,
          "sound": "default",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        },
        "data": {"keyname": "history"},
        "to": server,
        "priority": "high",
        // "to": "/topics/all",
      };
      await http.post(url, headers: header, body: json.encode(request));
      return true;
    } catch (e, s) {
      print(e);
      return false;
    }
  }

  Future getPoint(String url, {Map headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 401) {
        throw new Exception("Unauthorized");
      } else if (statusCode == 422) {
        return response;
      } else if (statusCode != 200) {
        throw new Exception("Error while fetching data");
      } else {
        return response;
      }
    });
  }

  Future postAuth(String url, {Map headers, body, encoding}) async {
    return await http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 401) {
        throw new Exception("Unauthorized");
      } else if (statusCode == 422) {
        return response;
      } else if (statusCode != 200) {
        throw new Exception("Error while fetching data");
      } else {
        return response;
      }
    });
  }

  Future upload(String url, File imageFile, {Map headers, body}) async {
    // open a bytestream
    return await http
        .post(url, body: body, headers: headers)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 401) {
        throw new Exception("Unauthorized");
      } else if (statusCode == 422) {
        return response;
      } else if (statusCode != 200) {
        throw new Exception("Error while fetching data");
      } else {
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
