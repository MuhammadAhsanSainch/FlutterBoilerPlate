import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as htpw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_button.dart';
import 'app_theme.dart';

class AppGlobals {
  ///
  /// VARIABLES
  ///
  // ApiService apiService = ApiService(dio.Dio(),AppUrl.apiUrl);
  static final GlobalKey<NavigatorState> appNavigationKey = GlobalKey<NavigatorState>();
  static bool isLogin = false;
  static String fcmToken = "";

  ///
  /// FUNCTIONS
  ///
  static Future<bool> internetConnectivityStatus() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('Internet Status = Connected');
        return true;
      } else {
        debugPrint('Internet Status = Not Connected');
        return false;
      }
    } on SocketException catch (_) {
      debugPrint('Internet Status = Not Connected');
      return false;
    }
  }

  static String getInitials(String bankAccountName) => bankAccountName.isNotEmpty ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join() : '';

  //static const _chars = '1234567890';
  static const String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  static final Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static DateTime parseToDateTime(String dateTime, String incomingFormat, String outgoingFormat) {
    var incomingDateTime = DateFormat(incomingFormat).parse(dateTime);
    var outgoingDateTime = DateFormat(outgoingFormat).parse(incomingDateTime.toString());
    return outgoingDateTime;
  }

  static showErrorSnackBar({String? heading, required String message, bool closeDialog = false}) {
    if (Get.context == null) return;
    if (Get.isDialogOpen! && closeDialog) Get.back();
    Get.snackbar(heading ?? 'Success', message, colorText: Colors.white, backgroundColor: Colors.redAccent, snackPosition: SnackPosition.top, maxWidth: 500, margin: const EdgeInsets.only(top: 20));
  }

  static showSuccessSnackBar({String? heading, required String message, int durationMilliSec = 3000}) {
    if (Get.context == null) return;
    Get.snackbar(heading ?? 'Success', message,
        colorText: AppThemes.lightColor,
        backgroundColor: AppThemes.primaryColor,
        snackPosition: SnackPosition.top,
        icon: const Icon(
          Icons.check_circle_sharp,
          color: AppThemes.lightColor,
        ),
        duration: Duration(milliseconds: durationMilliSec));
  }

  static printerPrint({required String title, required String body}) async {
    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/images/logo.png');
    final htmlBodyWidget = await htpw.HTMLToPdf().convert(body);
    htmlBodyWidget.insert(0,pw.SizedBox(height: 10));
    htmlBodyWidget.insert(0,pw.Divider(height: 3));
    htmlBodyWidget.insert(0,pw.Text(title, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)));
    htmlBodyWidget.insert(0,pw.SizedBox(height: 20));
    htmlBodyWidget.insert(0,pw.Center(child: pw.Image(image, alignment: pw.Alignment.center, width: 200)));

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return htmlBodyWidget;
        },
      ),
    );

    if(kIsWeb){
      await Printing.sharePdf(bytes: await pdf.save(), filename: '$title.pdf');
    } else {
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/$title.pdf');
      await file.writeAsBytes(await pdf.save());
      await Printing.layoutPdf(onLayout: (htpw.PdfPageFormat format) async => pdf.save());
    }
  }

  static showSimpleDialog({
    required BuildContext context,
    required Widget heading,
    required Widget content,
    double? width,
    double? height,
    bool isBarrierDismissible = true,
  }) {
    showDialog(
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppThemes.lightColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: AppThemes.lightColor,
              width: width ?? 500,
              height: height ?? 500,
              child: Column(
                children: [
                  heading,
                  Expanded(
                    child: content,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showAlertDialog({
    String? heading,
    required String message,
    bool closeDialog = false,
    bool dismissible = false,
    String? btnText,
    VoidCallback? onTap,
  }) {
    if (Get.context == null) return;
    if (Get.isDialogOpen! && closeDialog) Get.back();
    Get.dialog(
        AlertDialog(
          title: Text(heading ?? "Error"),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onTap ??
                      () {
                    Get.back();
                  },
              child: Text(
                btnText ?? "Ok",
                // style: AppThemes.lightTheme.textTheme.bodyMedium!
                //     .copyWith(color: AppThemes.secondaryBgColor)
              ),
            ),
          ],
        ),
        barrierDismissible: dismissible);
  }

  static deleteDialog({
    required BuildContext context,
    String? msg,
    String? btnText,
    required deleteBtnTap,
  }) {
    showSimpleDialog(
      width: 350,
      height: 250,
      context: context,
      heading: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10, right: 10),
            child: Image.asset(
              "assets/icons/close_circle.png",
            ),
          ),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const CircularProgressIndicator(
                  value: 1,
                  color: AppThemes.primaryColor,
                ),
                Image.asset(
                  "assets/icons/trash.png",
                )
              ],
            ),
            const Text(
              "Are you sure?",
              style: TextStyle(
                color: AppThemes.primaryColor,
              ),
            ),
            Text(
              msg ?? "Do you really want to delete this record? This process cannot be undone.",
              style: const TextStyle(
                color: AppThemes.greyColor,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomElevatedButton(
                      width: double.maxFinite,
                      onTap: deleteBtnTap,
                      text: 'Delete',
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: CustomElevatedButton(
                        width: double.maxFinite,
                        onTap: () {
                          Get.back();
                        },
                        text: 'Cancel',
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static String getTimeStamp({required String type}) {
    if (type.toLowerCase() == "tz") {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now().toUtc());
    } else if (type.toLowerCase() == "dt_name") {
      return DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now().toUtc());
    } else if (type.toLowerCase() == "dt") {
      /* if(getCurrentLocale()){
        return DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
      }*/
      return DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    } else if (type.toLowerCase() == "dt2") {
      return DateFormat('dd/MMM/yyyy hh:mm:ss').format(DateTime.now());
    } else if (type.toLowerCase() == "dt_save") {
      return DateFormat('ddMMyyyy_hhmm').format(DateTime.now());
    } else {
      return "none";
    }
    // debugPrint(DateTime.now().toUtc().toIso8601String());
    // debugPrint(DateTime.now().toString());
    // debugPrint(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now().toUtc()));
  }

  static String convertTimeToLocal({required String utcTime}) {
    if (utcTime != "") {
      return DateFormat("yyyy-MM-dd hh:mm:ss").parse(utcTime, true).toLocal().toString().split(".").first;
      // return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime.toLocal());
    }
    return "";
  }

  static String getCurrencySymbolFromCode(String code) {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: code.toUpperCase());
    return format.currencySymbol;
  }

  static showScaffold(String toastMsg) {
    ScaffoldMessenger.of(appNavigationKey.currentContext!).showSnackBar(
      SnackBar(content: Text(toastMsg)),
    );
  }
}
