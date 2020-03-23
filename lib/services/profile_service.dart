import "package:talio_travel/models/profile.dart";
import 'package:talio_travel/Api/api_list.dart';
import "package:http/http.dart" show Client;

class ProfileService{
  Client client = Client();
/*
  Future <List <Profile>> getProfiles () async{
    final response = await client.get(APIList.profileAPI);
    if(response.statusCode == APIList.statusCodeOK){
      return profileFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<bool> createProfile(Profile data) async {
    final response = await client.post(
      APIList.profileAPI,
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    return APIList.checkPostResp(response);
  }

  Future<bool> updateProfile(Profile data, String type) async {
    final response = await client.put(
      "${APIList.profileAPI}/${data.id}",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    return APIList.checkPutResp(response);
  }

  Future<bool> updateProfileByGoogle(Profile data) async {
    final response = await client.put(
      "${APIList.profileAPI}/google/${data.googleId}",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    return APIList.checkPutResp(response);
  }


  Future<bool> updateProfileByFacebook(Profile data) async {
    final response = await client.put(
      "${APIList.profileAPI}/facebook/${data.facebookId}",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    return APIList.checkPutResp(response);
  }

 */
}