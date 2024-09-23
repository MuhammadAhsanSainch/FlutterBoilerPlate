import 'package:flutter/material.dart';

import '../utilities/app_theme.dart';

class ButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color? textColor;
  final double? textFont;
  final Color? btnColor;
  final double? btnWidth;
  final double? btnHeight;
  final double? btnBorderCorner;
  final double? btnPadding;
  final IconData? icon;
  final Color? iconColors;

  const ButtonWidget({super.key, required this.onPressed, required this.text, this.textColor, this.textFont, this.btnColor, this.btnWidth, this.btnHeight, this.btnBorderCorner, this.btnPadding, this.icon, this.iconColors});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.btnWidth ?? size.width,
      height: widget.btnHeight ?? 50,
      child: widget.icon == null
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding: EdgeInsets.all(widget.btnPadding ?? 10.0),
                backgroundColor: widget.btnColor ?? AppThemes.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.btnBorderCorner ?? 10.0)),
                side: const BorderSide(width: 1.0, color: AppThemes.primaryColor),
              ),
              onPressed: widget.onPressed,
              child: Text(
                "${widget.text}",
                style: TextStyle(color: widget.textColor ?? AppThemes.white, fontSize: widget.textFont ?? 16),
              ),
            )
          : ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding: EdgeInsets.all(widget.btnPadding ?? 10.0),
                backgroundColor: widget.btnColor ?? AppThemes.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.btnBorderCorner ?? 10.0)),
                side: const BorderSide(width: 1.0, color: AppThemes.primaryColor),
              ),
              onPressed: widget.onPressed,
              icon: Icon(
                widget.icon,
                size: widget.textFont ?? 16,
                color: widget.iconColors ?? Colors.white,
              ),
              label: Text(
                "${widget.text}",
                style: TextStyle(color: widget.textColor ?? AppThemes.white, fontSize: widget.textFont ?? 16),
              ),
            ),
    );
  }
}
