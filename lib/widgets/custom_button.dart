import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.height = 55,
    this.width = 140,
    this.fontSize = 16,
    this.onTap,
    this.padding,
    this.isEnabled = true,
    this.buttonColor,
    this.textColor,
    this.icon,
  });

  final double? height;
  final double? width;
  final double? fontSize;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Icon? icon;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          padding: padding ?? EdgeInsets.zero,
          backgroundColor: buttonColor ?? AppThemes.primaryColor,
          disabledBackgroundColor: AppThemes.lightGreyColor,
          shape: RoundedRectangleBorder(
            side: buttonColor != null
                ? BorderSide.none
                : BorderSide(
              color: isEnabled ? AppThemes.primaryColor : AppThemes.lightGreyColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: textColor ?? AppThemes.lightColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null) const SizedBox(width: 5,),
            if (icon != null) icon!,
          ],
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  final double fontSize;
  final double? width;
  final double? height;

  const CustomOutlineButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width,
    this.height = 44,
    this.fontSize = 14,
    this.bgColor = AppThemes.lightColor,
    this.textColor = AppThemes.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8), border: Border.all(width: 1.2, color: AppThemes.primaryColor)),
        child: Text(title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
