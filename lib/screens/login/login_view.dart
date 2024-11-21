import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utilities/shared_preference.dart';
import '../../themes/app_globals.dart';
import '../../themes/app_theme.dart';
import '../../utilities/form_validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  // Server Switching Init
  final formKey = GlobalKey<FormState>();
  final TextEditingController securePassword = TextEditingController(text: "");
  final TextEditingController serverURL = TextEditingController(text: "");
  final TextEditingController socketURL = TextEditingController(text: "");
  final TextEditingController webURL = TextEditingController(text: "");
  bool secureShow = true;
  bool isLoader = false;
  bool _customURLs = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<LoginController>(
      init: Get.find<LoginController>(),
      builder: (loginController) => Scaffold(
        body: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: loginController.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: loginController.emailController,
                    outerPadding: const EdgeInsets.only(left: 2.0, top: 10),
                    upperLabel: "User Name",
                    upperLabelReqStar: "*",
                    hintValue: "Enter your user name",
                    validator: (value) => validateEmail(
                      value,
                    ),
                    type: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z0-9@._-]'), allow: true),
                    ],
                    onChanged: (String value) {},
                  ),
                  CustomTextField(
                    controller: loginController.passwordController,
                    outerPadding: const EdgeInsets.only(left: 2.0, top: 10),
                    upperLabel: "Password",
                    upperLabelReqStar: "*",
                    hintValue: "Your Password",
                    enableInteractiveSelection: true,
                    enableSuggestions: false,
                    obscureText: true,
                    validator: (value) => validatePassword(value),
                    type: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z0-9!#$%^&*()=+~`<>,/?:;"|\\@._-]'), allow: true),
                    ],
                    onChanged: (String value) {},
                  ),
                  CustomElevatedButton(
                    width: size.width,
                    text: "Login",
                    onTap: () {},
                  ),

                  ///TODO: Remove Beta Before Final Release
                  if (Platform.isAndroid)
                    const Text(
                      "v 1.0.0+1",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.right,
                    )
                  else
                    const Text(
                      "v 1.0.0+1",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.right,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordServerSelectionDialog(BuildContext context) {
    return Column(
      children: [
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                      color: AppThemes.primaryColor,
                    ),
                    child: const Text(
                      "Server Switching Access",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoader == true
                      ? const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: AppThemes.primaryColor,
                          ),
                        )
                      : Image.asset(
                          "assets/icons/lock.png",
                          width: 50,
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Enter Password For Secure Access",
                    style: TextStyle(color: AppThemes.primaryColor, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: securePassword,
                      obscureText: secureShow,
                      decoration: InputDecoration(
                          label: const Text("Enter Password"),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                secureShow = !secureShow;
                              });
                            },
                          )),
                      validator: (newvalue) {
                        if (newvalue == null || newvalue.isEmpty) {
                          return 'Type Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomElevatedButton(
                    onTap: () {
                      setState(() {
                        isLoader = true;
                      });
                      if (formKey.currentState!.validate()) {
                        if (securePassword.text == "11223344") {
                          Future.delayed(const Duration(seconds: 3), () {
                            Get.back();
                            setState(() {
                              isLoader = false;
                              securePassword.text = "";
                            });
                            AppGlobals.showSimpleDialog(context: AppGlobals.appNavigationKey.currentContext!, heading: const SizedBox.shrink(), content: changeServerSelectionDialog(AppGlobals.appNavigationKey.currentContext!), height: 520);
                          });
                        } else {
                          AppGlobals.showErrorSnackBar(message: 'Password is Incorrect. Please Try Again.');
                          setState(() {
                            isLoader = false;
                          });
                        }
                      } else {
                        AppGlobals.showErrorSnackBar(message: 'Please Enter Your Password.');
                        setState(() {
                          isLoader = false;
                        });
                      }
                    },
                    text: 'Proceed',
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget changeServerSelectionDialog(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                    color: AppThemes.primaryColor,
                  ),
                  child: const Text(
                    "Server Selection",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'Dev',
                        groupValue: UserPreferences.currentServer,
                        onChanged: (String? value) async {
                          await prefs.clear();
                          setState(() {
                            _customURLs = false;
                            UserPreferences.currentServer = value!;
                            UserPreferences.apiURL = "https://edsidera-dev-90f118bc5451.herokuapp.com/api";
                            UserPreferences.socketURL = "https://edsidera-dev-90f118bc5451.herokuapp.com";
                            UserPreferences.webURL = "https://edsidera-dev-90f118bc5451.herokuapp.com/uploads";
                          });
                        },
                      ),
                      const Text(
                        'Dev',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'QA',
                        groupValue: UserPreferences.currentServer,
                        onChanged: (String? value) async {
                          await prefs.clear();
                          setState(() {
                            _customURLs = false;
                            UserPreferences.currentServer = value!;
                            UserPreferences.apiURL = "https://edsidera-staging-7ab88110fccd.herokuapp.com/api";
                            UserPreferences.socketURL = "https://edsidera-staging-7ab88110fccd.herokuapp.com";
                            UserPreferences.webURL = "https://edsidera-staging-7ab88110fccd.herokuapp.com/uploads";
                          });
                        },
                      ),
                      const Text('QA', style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'Release',
                        groupValue: UserPreferences.currentServer,
                        onChanged: (String? value) async {
                          await prefs.clear();
                          setState(() {
                            _customURLs = false;
                            UserPreferences.currentServer = value!;
                            UserPreferences.apiURL = "https://edsidera-release-231650504fa8.herokuapp.com/api";
                            UserPreferences.socketURL = "https://edsidera-release-231650504fa8.herokuapp.com";
                            UserPreferences.webURL = "https://edsidera-release-231650504fa8.herokuapp.com/uploads";
                          });
                        },
                      ),
                      const Text('Release', style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'Live',
                        groupValue: UserPreferences.currentServer,
                        onChanged: (String? value) async {
                          await prefs.clear();
                          setState(() {
                            _customURLs = false;
                            UserPreferences.currentServer = value!;
                            UserPreferences.apiURL = "https://api.edsidera.com/api";
                            UserPreferences.socketURL = "https://api.edsidera.com";
                            UserPreferences.webURL = "https://api.edsidera.com/uploads";
                          });
                        },
                      ),
                      const Text('Live', style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Custom',
                            groupValue: UserPreferences.currentServer,
                            onChanged: (String? value) {
                              setState(() {
                                UserPreferences.currentServer = value!;
                                _customURLs = true;
                              });
                            },
                          ),
                          const Text('Custom', style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      _customURLs == true
                          ? TextFormField(
                              controller: serverURL,
                              decoration: InputDecoration(
                                label: const Text("Enter Server URL"),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.link),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _customURLs == true
                          ? TextFormField(
                              controller: socketURL,
                              decoration: InputDecoration(
                                label: const Text("Enter Socket URL"),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.link),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _customURLs == true
                          ? TextFormField(
                              controller: webURL,
                              decoration: InputDecoration(
                                label: const Text("Enter Web URL"),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.link),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomElevatedButton(
                  onTap: () async {
                    if (serverURL.text.isNotEmpty && socketURL.text.isNotEmpty && webURL.text.isNotEmpty) {
                      await prefs.clear();
                      UserPreferences.apiURL = serverURL.text;
                      UserPreferences.socketURL = socketURL.text;
                      UserPreferences.webURL = webURL.text;
                      await prefs.reload();
                      Get.back();
                    } else {
                      if (UserPreferences.currentServer != "Custom") {
                        Get.back();
                        await prefs.reload();
                      } else {
                        AppGlobals.showErrorSnackBar(message: "Please Select/Enter A Server");
                      }
                    }
                  },
                  text: 'Proceed',
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
