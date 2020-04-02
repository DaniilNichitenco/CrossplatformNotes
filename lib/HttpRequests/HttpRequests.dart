import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpRequests {
  static String mainUrl = 'http://188.138.179.52:256/';
  
  static Future<String> getRequest(String requestUrl) async {
    var response = await http.get(mainUrl + requestUrl);

    return response.body;
  }

  ///Возвращает необработанный ответ
  static Future<String> postRequest(String requestUrl, dynamic content) async {
    var response = await http.post(
      mainUrl + requestUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(content),
    );

    return response.body;
  }

  ///Возвращает уже сериализованный JSON
  static Future<Map<String, Object>> jsonPostRequest(
      String requestUrl, dynamic content) async {
    var r = await postRequest(requestUrl, content);

    return jsonDecode(r);
  }
}
