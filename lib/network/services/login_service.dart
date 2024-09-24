import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../themes/app_globals.dart';
import 'package:dio/dio.dart' as dio;
import '../../network/app_url.dart';
import '../../network/response/general_map_response.dart';
import '../../utilities/shared_preference.dart';

class LoginService {

  Future<Map<String, dynamic>> signIn(Map<String, dynamic> reqBody) async {
    Map<String, dynamic> results = {};
    debugPrint("[REQUEST] (signIn): ${reqBody.toString()}");
    try {
      Future<Map<String, dynamic>> returnFromThisFunc = AppGlobals.internetConnectivityStatus().then((value) async {
        if (value == true) {
          GeneralMapResponse response = await AppUrl.apiService.signin(reqBody);
          debugPrint("[RESPONSE] (signIn): ${response.data.toString()}");
          if (response.status == 1) {
            UserPreferences.loginData = response.data!;
            UserPreferences.isLogin = true;
            UserPreferences.authToken = response.data!['AuthToken'];
            debugPrint("[SUCCESS] (signIn): ${response.data.toString()}");
            results = {"status": true, "message": response.message, "data": response.data};
            return results;
          } else {
            UserPreferences.loginData = {};
            UserPreferences.isLogin = false;
            UserPreferences.authToken = "";
            debugPrint("[FAILURE] (signIn): ${response.data.toString()}");
            results = {"status": false, "message": response.message, "data": response.data};
            return results;
          }
        } else {
          AppGlobals.showErrorSnackBar(message: 'Internet Not Available');
          debugPrint("[FAILURE] (signIn): Internet Not Available");
          results = {"status": false, "message": "Internet Not Available", "data": {}};
          return results;
        }
      });
      return returnFromThisFunc;
    } catch (e) {
      AppGlobals.showErrorSnackBar(message: 'An error "${e.toString()}" occurred while trying to "signIn". Please try again later.');
      debugPrint("[EXCEPTION] (signIn): ${e.toString()}");
      results = {
        "status": false,
        "message": e.toString(),
        "data": {},
      };
      return results;
    } finally {
      // Close The Loader
    }
  }

  Future<Map<String, dynamic>> signUp(dio.FormData reqBody) async {
    Map<String, dynamic> results = {};
    try {
      // var formData;
      // if(isImageInRequest == true){
      //   formData = FormData.fromMap({
      //     'textKey': textValue,
      //     "fileKey": await MultipartFile.fromFile(File(xFile.path).path),
      //   });
      // } else {
      //   formData = FormData.fromMap({
      //     'textKey': textValue,
      //   });
      // }
      // Print FormData Text Fields
      reqBody.fields.forEach((e) => debugPrint("[REQUEST BODY] (signUp):  : $e"));
      // Print FormData File Fields
      reqBody.files.forEach((e) => debugPrint("[REQUEST BODY] (signUp):  : $e"));
      Future<Map<String, dynamic>> returnFromThisFunc = AppGlobals.internetConnectivityStatus().then((value) async {
        if (value == true) {
          GeneralMapResponse response = await AppUrl.apiService.signup(reqBody);
          debugPrint("[RESPONSE] (signUp): ${response.data.toString()}");
          if (response.status == 1) {
            debugPrint("[SUCCESS] (signUp): ${response.data.toString()}");
            results = {"status": true, "message": response.message, "data": response.data};
            return results;
          } else {
            debugPrint("[FAILURE] (signUp): ${response.data.toString()}");
            results = {"status": false, "message": response.message, "data": response.data};
            return results;
          }
        } else {
          AppGlobals.showErrorSnackBar(message: 'Internet Not Available');
          debugPrint("[FAILURE] (signUp): Internet Not Available");
          results = {"status": false, "message": "Internet Not Available", "data": {}};
          return results;
        }
      });
      return returnFromThisFunc;
    } catch (e) {
      AppGlobals.showErrorSnackBar(message: 'An error "${e.toString()}" occurred while trying to "signUp". Please try again later.');
      debugPrint("[EXCEPTION] (signUp): ${e.toString()}");
      results = {"status": false, "message": e.toString(), "data": {}};
      return results;
    } finally {
      // Close The Loader
    }
  }

}
