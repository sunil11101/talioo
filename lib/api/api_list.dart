import 'package:http/http.dart';

class APIList{
  static final String _APIVersion = "";
  static final String _baseAPIUrl = "http://talioo.com/api";

  static int statusCodeOK = 200;
  static int statusCodeCreated = 201;
  static int statusCodeAccepted = 202;

  static String socialAuthAPI = "$_baseAPIUrl/social_auth";
  static String userInfoAPI = "$_baseAPIUrl/user_info";

  static bool checkPostResp(Response response){
    if (response.statusCode == statusCodeCreated) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkPutResp(Response response){
    if (response.statusCode == statusCodeOK) {
      return true;
    } else {
      return false;
    }
  }
}