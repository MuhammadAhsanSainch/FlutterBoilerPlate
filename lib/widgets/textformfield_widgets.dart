import 'package:flutter/material.dart';

import '../utilities/app_theme.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final bool? obscure;
  final int? maxLine;
  final Function(String)? onChanged;

  const TextFormFieldWidget({super.key, required this.controller, required this.hintText, required this.labelText, this.icon, this.obscure, this.maxLine, this.onChanged});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine ?? 1,
      controller: widget.controller,
      obscuringCharacter: '*',
      obscureText: (widget.obscure == true && passwordVisible == false) ? true : false,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          prefixIcon: Icon(
            widget.icon,
            color: Colors.black,
          ),
          suffixIcon: widget.obscure == true
              ? IconButton(
                  icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                )
              : const SizedBox.shrink(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppThemes.primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          filled: true,
          fillColor: Colors.white),
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Fill This Field';
        }
        return null;
      },
    );
  }
}
