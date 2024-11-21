import 'package:flutter/material.dart';

import '../themes/app_globals.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_button.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String description;
  final double? height;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onClickedYes;
  final String? onClickedYesText;
  final Color? onClickedYesColor;
  final Color? onClickedYesTextColor;
  final VoidCallback? onClickedNo;
  final String? onClickedNoText;
  final Color? onClickedNoColor;
  final Color? onClickedNoTextColor;

  const CustomDialog(
      {super.key, required this.title, required this.description, this.onClickedYes, this.onClickedNo, this.icon, this.iconColor, this.onClickedYesText, this.onClickedNoText, this.height, this.onClickedYesColor, this.onClickedNoColor, this.onClickedYesTextColor, this.onClickedNoTextColor});

  @override
  State<CustomDialog> createState() => _CustomDialog();
}

class _CustomDialog extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    debugPrint("title: ${widget.title}");
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        alignment: Alignment.center,
        content: Stack(
          clipBehavior: Clip.none, // Allows overflow
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: widget.height ?? 140,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.title != ""
                      ? Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        textAlign: TextAlign.center,
                        )
                      : const SizedBox.shrink(),
                  widget.title != "" ? const SizedBox(height: 10) : const SizedBox.shrink(),
                  widget.description != "" ? Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            Positioned(
              top: -50, // Half of the icon overflow
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 4, // How much the shadow spreads
                      blurRadius: 10, // Softness of the shadow
                      offset: const Offset(0, 5), // Shadow position
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Icon(
                    widget.icon ?? Icons.thumb_up,
                    color: widget.iconColor ?? Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.onClickedNo != null
                  ? CustomElevatedButton(
                      height: 40,
                      fontSize: 13,
                      width: 100,
                      onTap: widget.onClickedNo,
                      buttonColor: widget.onClickedNoColor ?? AppThemes.primaryColor,
                      textColor: widget.onClickedNoTextColor ?? AppThemes.white,
                      text: widget.onClickedNoText ?? "No",
                    )
                  : const SizedBox.shrink(),
              (widget.onClickedNo != null && widget.onClickedYes != null)
                  ? const SizedBox(
                      width: 10,
                    )
                  : const SizedBox.shrink(),
              widget.onClickedYes != null
                  ? CustomElevatedButton(
                      height: 40,
                      fontSize: 13,
                      width: 100,
                      onTap: widget.onClickedYes,
                      buttonColor: widget.onClickedYesColor ?? AppThemes.primaryColor,
                      textColor: widget.onClickedYesTextColor ?? AppThemes.white,
                      text: widget.onClickedYesText ?? "No",
                    )
                  : const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}

showCustomDialog({
  required String title,
  required String description,
  VoidCallback? onClickedYes,
  VoidCallback? onClickedNo,
  IconData? icon,
  Color? iconColor,
  String? onClickedYesText,
  String? onClickedNoText,
  double? height,
}) {
  showDialog(
    barrierDismissible: false,
    context: AppGlobals.appNavigationKey.currentContext!,
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        description: description,
        onClickedYes: onClickedYes,
        onClickedNo: onClickedNo,
        icon: icon,
        iconColor: iconColor,
        onClickedYesText: onClickedYesText,
        onClickedNoText: onClickedNoText,
        height: height,
      );
    },
  );
}
