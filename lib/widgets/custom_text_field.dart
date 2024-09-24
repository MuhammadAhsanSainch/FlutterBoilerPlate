import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/app_extensions.dart';
import '../themes/app_theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.helperValue = "",
    this.validator,
    this.readOnly = false,
    this.isEnabled = true,
    this.obscureText = false,
    this.showBorders = true,
    this.readOnlyTextColor,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.suffixIcon,
    this.suffixIconTap,
    this.hintValue,
    this.onChanged,
    this.prefixIconColor,
    this.type,
    this.prefixText,
    this.prefixStringText,
    this.suffixText,
    this.textCapitalization = TextCapitalization.none,
    this.prefixWidget,
    this.suffixWidget,
    this.fillColor,
    this.prefixType,
    this.maxLength = 40,
    this.maxLines = 1,
    this.minLines,
    this.onSubmit,
    this.helperTextStyle,
    this.hintTextStyle,
    this.textStyle,
    this.focusNode,
    this.upperLabel,
    this.upperLabelStyle,
    this.upperLabelReqStar,
    this.onEditingComplete,
    this.borderRadius,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.height,
    this.onTap,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.autocorrect = false,
    this.textDirection,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 2.0),
    this.showStaticBottomShadow = false,
    this.staticBottomShadowColor,
  });

  final String? prefixType;
  final String? hintValue;
  final String? helperValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixText;
  final String? prefixStringText;
  final Widget? suffixText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? fillColor;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconTap;
  final TextInputType? type;
  final int? minLines;
  final int? maxLines;
  final String? upperLabel;
  final TextStyle? upperLabelStyle;
  final String? upperLabelReqStar;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final int maxLength;
  final dynamic onSubmit;
  final TextStyle? helperTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool isEnabled;
  final bool showBorders;
  final Color? readOnlyTextColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final BorderRadius? borderRadius;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final double? height;
  final bool? enableInteractiveSelection;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextDirection? textDirection;
  final EdgeInsetsGeometry outerPadding;
  final bool showStaticBottomShadow;
  final Color? staticBottomShadowColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(widget.readOnly && !widget.isEnabled) && widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AbsorbPointer(
        absorbing: widget.readOnly,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.upperLabel.isNotNullAndNotEmpty
                ? Padding(
                    padding: widget.outerPadding,
                    child: Row(
                      children: [
                        Text(
                          widget.upperLabel!,
                          style: widget.upperLabelStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(color: widget.readOnly ? AppThemes.darkGreyColor : AppThemes.primaryColor, fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        if (widget.upperLabelReqStar.isNotNullAndNotEmpty)
                          Text(
                            widget.upperLabelReqStar!,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: widget.readOnly ? AppThemes.darkGreyColor : AppThemes.errorColor, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Focus(
              onFocusChange: (focus) {
                setState(() {});
              },
              child: Stack(
                children: [
                  Container(
                    height: 55,
                    width: MediaQuery.sizeOf(context).width,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 3.5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                      boxShadow: !widget.showBorders
                          ? [const BoxShadow(color: Colors.transparent)]
                          : [
                              BoxShadow(
                                color: _focusNode.hasFocus ? Colors.grey.withOpacity(0.15) : Colors.transparent,
                                spreadRadius: _focusNode.hasFocus ? 4 : 0,
                                blurRadius: _focusNode.hasFocus ? 2 : 0,
                                offset: const Offset(0, 0),
                              ),
                              BoxShadow(
                                color: _focusNode.hasFocus ? Colors.grey.withOpacity(0.1) : Colors.transparent,
                                // spreadRadius: _focusNode.hasFocus ? 3 : 0,
                                // blurRadius: _focusNode.hasFocus ? 2 : 0,
                              ),
                            ],
                    ),
                  ),
                  PhysicalModel(
                    color: Colors.transparent,
                    elevation: widget.showStaticBottomShadow ? 6 : 0,
                    shadowColor: widget.showStaticBottomShadow ? widget.staticBottomShadowColor ?? AppThemes.grey100Color.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(08),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: TextFormField(
                        autofocus: widget.autofocus,
                        textInputAction: widget.textInputAction,
                        inputFormatters: widget.inputFormatters,
                        style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(color: widget.readOnly ? widget.readOnlyTextColor ?? AppThemes.grey300Color : AppThemes.darkColor, fontWeight: FontWeight.w500, fontFamily: "WorkSans", fontSize: 15),
                        autocorrect: widget.autocorrect,
                        readOnly: widget.readOnly,
                        enabled: widget.isEnabled,
                        cursorColor: AppThemes.primaryColor,
                        focusNode: _focusNode,
                        obscuringCharacter: "*",
                        enableInteractiveSelection: widget.enableInteractiveSelection ?? !widget.obscureText,
                        enableSuggestions: widget.enableSuggestions,
                        keyboardType: widget.type,
                        minLines: widget.minLines,
                        maxLines: widget.maxLines,
                        obscureText: obscureText,
                        textCapitalization: widget.textCapitalization,
                        decoration: InputDecoration(
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            prefixIconConstraints: widget.prefixIconConstraints ??
                                const BoxConstraints(
                                  minWidth: 20,
                                  maxWidth: 35,
                                ),
                            suffixIconConstraints: widget.suffixIconConstraints ??
                                const BoxConstraints(
                                  minWidth: 45,
                                  maxWidth: 55,
                                ),
                            // contentPadding: EdgeInsets.zero,
                            suffixIcon: (widget.obscureText)
                                ? GestureDetector(
                                    onTap: () {
                                      if (widget.obscureText) {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      widget.suffixIcon ?? (obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                                      color: widget.readOnly ? AppThemes.grey300Color : AppThemes.darkColor,
                                    ),
                                  )
                                : widget.suffixIcon != null
                                    ? GestureDetector(
                                        onTap: () {
                                          if (widget.suffixIconTap != null) {
                                            widget.suffixIconTap!();
                                          }
                                        },
                                        child: Icon(
                                          widget.suffixIcon,
                                          color: widget.readOnly ? AppThemes.grey300Color : AppThemes.greyColor,
                                        ),
                                      )
                                    : widget.suffixText,
                            prefixIcon: (widget.prefixIcon != null)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Icon(
                                      widget.prefixIcon,
                                      color: widget.prefixIconColor ?? AppThemes.greyColor,
                                    ),
                                  )
                                : widget.prefixText != (null)
                                    ? widget.prefixText
                                    : null,
                            prefix: widget.prefixType == "countryPicker"
                                ? Transform.translate(offset: const Offset(0, 10), child: widget.prefixWidget)
                                : Padding(
                                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                                    child: Transform.translate(
                                      offset: const Offset(0, 6),
                                      child: widget.prefixWidget,
                                    )),
                            suffix: widget.suffixWidget,
                            prefixText: widget.prefixText == null && widget.prefixWidget == null ? widget.prefixStringText : null,
                            prefixStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: widget.readOnly ? AppThemes.grey300Color : AppThemes.darkColor,
                                ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: const BorderSide(
                                color: AppThemes.primaryLightColor,
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: const BorderSide(
                                color: AppThemes.errorColor,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: const BorderSide(
                                color: AppThemes.primaryLightColor,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: const BorderSide(color: AppThemes.grey200Color, width: 1),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: const BorderSide(color: AppThemes.grey200Color, width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: const BorderSide(color: AppThemes.grey200Color, width: 1),
                            ),
                            fillColor: widget.fillColor == (null)
                                ? widget.readOnly
                                    ? AppThemes.grey200Color.withOpacity(0.2)
                                    : AppThemes.lightColor
                                : widget.fillColor,
                            filled: true,
                            counterText: "",
                            // helperText: widget.helperValue,
                            helperText: widget.helperValue.isNullOREmpty ? null : widget.helperValue,
                            // errorStyle: TextStyle(
                            //     color: AppTheme.secondaryColor
                            // ),
                            // labelText: upperLabel,
                            // floatingLabelBehavior: FloatingLabelBehavior.never,
                            // alignLabelWithHint: false,
                            // floatingLabelStyle: TextStyle(letterSpacing: 0),
                            hintText: widget.hintValue,
                            hintStyle: widget.hintTextStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(color: widget.readOnly ? AppThemes.grey300Color : AppThemes.grey200Color)),
                        validator: widget.validator,
                        controller: widget.controller,
                        onChanged: widget.onChanged,
                        maxLength: widget.maxLength,
                        onFieldSubmitted: widget.onSubmit,
                        onEditingComplete: widget.onEditingComplete,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
