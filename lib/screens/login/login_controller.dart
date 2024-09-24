import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../network/models/login_model.dart';
import '../../network/services/login_service.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: kDebugMode ? "Username" : "");
  final TextEditingController passwordController = TextEditingController(text: kDebugMode ? "Pass" : "");

  static LoginController get to {
    try {
      return Get.find<LoginController>();
    } catch (e) {
      return Get.put(LoginController());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<LoginModel?> signIn(Map<String, dynamic> reqBody) {
    return LoginService().signIn(reqBody).then((value) {
      if(value['status'] == true){
        return LoginModel.fromJson(value['data']);
      } else {
        return null;
      }
    });
  }

  Future<LoginModel?> signUp(dio.FormData reqBody) {
    return LoginService().signUp(reqBody).then((value) {
      if(value['status'] == true){
        return LoginModel.fromJson(value['data']);
      } else {
        return null;
      }
    });
  }

}
