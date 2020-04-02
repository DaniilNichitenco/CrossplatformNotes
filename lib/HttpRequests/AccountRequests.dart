import 'HttpRequests.dart';

class AccountRequests {
  static String authorizationToken = "";

  ///Авторизация - возвращает токен - JWT(JSON Web Token)
  static Future<String> logIn(String email, String password) async {
    String response = await HttpRequests.postRequest(
        'api/accounts/LogIn', {"Email": email, "Password": password});

    authorizationToken = response;

    return response;
  }

  static Future<String> register(
      String email, String password, String firstName, String lastName) async {
    String response = await HttpRequests.postRequest('api/accounts/Register', {
      "Email": email,
      "Password": password,
      "FirstName": firstName,
      "LastName": lastName
    });

    return response;
  }

  static Future<String> testRequest() async {
    String response = await HttpRequests.getRequest('api/accounts/Test');
    var len = response.length;

    return response;
  }
}
