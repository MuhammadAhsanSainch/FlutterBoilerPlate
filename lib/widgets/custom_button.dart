import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.height = 44,
    this.width = 140,
    this.onTap,
    this.padding,
    this.isEnabled = true,
  });

  final double? height;
  final double? width;
  final String text;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isEnabled ? onTap : null,
          style: ElevatedButton.styleFrom(
              // maximumSize: Size(size.width, 40),
              backgroundColor: AppThemes.primaryColor,
              disabledBackgroundColor: AppThemes.blue300Color,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isEnabled ? AppThemes.primaryColor : AppThemes.blue300Color,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)))),
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppThemes.lightColor, fontSize: 16, fontWeight: FontWeight.w600)),
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
