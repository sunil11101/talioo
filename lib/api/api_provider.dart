import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('accessToken');
  }

  authData(data, apiUrl) async {
    var fullUrl = apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setAuthHeaders()
    );
  }

  postData(data, apiUrl) async {
    var fullUrl = apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setTokenHeaders()
    );
  }

  putData(data, apiUrl) async {
    var fullUrl = apiUrl;
    await _getToken();
    return await http.put(
        fullUrl,
        body: jsonEncode(data),
        headers: _setTokenHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = apiUrl;
    await _getToken();
    print("Token:$token");
    return await http.get(
        fullUrl,
        headers: _setTokenHeaders()
    );
  }

  _setTokenHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

  _setAuthHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };
}