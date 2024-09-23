import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dialog/error_dialog.dart';
import '../../utilities/app_globals.dart';
import '../../utilities/app_theme.dart';
import '../../utilities/shared_preference.dart';
import '../../widgets/button_widgets.dart';

class Logging extends Interceptor {
  String endpoint = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    endpoint = options.path;
    debugPrint('REQUEST[${options.path}] => DATA: ${options.data}');
    AppGlobals.internetConnectivityStatus().then((value) {
      if (value == false) {
        debugPrint("API is not Connected to the Internet.");
        return false;
      }
    });
    if (options.path != '/signin' &&
        options.path != '/signup' &&
        options.path != '/forgetpassword' &&
        options.path != '/products' &&
        options.path != '/relatedproducts' &&
        options.path != '/freight' &&
        options.path != '/freightdiscounted' &&
        options.path != '/slider' &&
        options.path != '/categories' &&
        options.path != '/pages' &&
        options.path != '/getacall' &&
        options.path != '/contact' &&
        options.path != '/coupons' &&
        options.path != '/reviews' &&
        options.path != '/reviewadd') {
      options.headers.addEntries([MapEntry("AuthToken", UserPreferences.authToken)]);
    }
    if (options.path == '/updateprofile' || options.path == '/ticketreply' || options.path == '/ticketadd') {
      options.contentType = 'multipart/form-data';
    }
    debugPrint('Currently Hit Complete API URL:\t\t${options.baseUrl}${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.requestOptions.path}] => DATA: ${response.toString()}',
    );
    if (response.data['message'] == 'User Is Not Logged In') {
      _tokenExpiredDialog(AppGlobals.appNavigationKey.currentContext!);
    } else if (response.data['status'] == 0) {
      showErrorDialog(response.data['message'].toString());
    }
    // debugPrint("XXX ${response.requestOptions.contentType}");
    // if (response.requestOptions.contentType != "application/json") {
    //   response.data = jsonDecode(response.data as String);
    // }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();
    debugPrint(
      'ERROR[${err.requestOptions.path}] => DATA: ${err.toString()}',
    );
    if (err.response?.statusCode == 101) {
      showErrorDialog('Network Is Unreachable');
    } else if (err.response?.statusCode == 404) {
      showErrorDialog(err.error.toString());
    } else {
      Fluttertoast.showToast(msg: "Internet Connection Failed", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppThemes.primaryColor, textColor: Colors.white, fontSize: 16.0);
    }
    debugPrint("[ERROR CODE] ${err.error.toString()}");
    //return super.onError(err, handler);
  }

  _tokenExpiredDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User Must Tap Button
      builder: (BuildContext context) {
        return PopScope<Object?>(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) {
              return;
            }
            final bool shouldPop = await _showBackDialog(context) ?? false;
            if (context.mounted && shouldPop) {
              Navigator.pop(context);
            }
          },
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Container(
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                "Authentication Expired".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20, fontStyle: FontStyle.normal),
              ),
            ),
            titlePadding: const EdgeInsets.all(0),
            content: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Ohh Sorry!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Your Authentication Has Been Expired. Please Login Again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            alignment: Alignment.center,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonWidget(
                    onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.of(context).pushNamedAndRemoveUntil('/Welcome', (Route<dynamic> route) => false);
                    },
                    text: 'Okay',
                    textFont: 14,
                    btnColor: AppThemes.primaryColor,
                    btnWidth: 90,
                    btnHeight: 35,
                    btnPadding: 5,
                    icon: Icons.check,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<bool?> _showBackDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}
