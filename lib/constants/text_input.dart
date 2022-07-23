import 'package:flutter/material.dart';
import 'package:funconnect/constants/fonts.dart';

import 'colors.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Widget? suffix;
  final Widget? prefix;
  final bool readOnly;
  final bool expands;
  final int? minLines, maxLines, maxLength;
  final bool enabled;
  final Function()? function;
  final void Function(String)? onChanged;

  const AppTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.suffix,
    this.obscureText = false,
    this.prefix,
    this.initialValue,
    this.readOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.function,
    this.onChanged,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      readOnly: readOnly,
      expands: expands,
      maxLines: maxLines,
      onChanged: onChanged,
      minLines: minLines,
      maxLength: maxLength,
      onEditingComplete: function ?? () => FocusScope.of(context).nextFocus(),
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: AppFonts.gtWalshPro,
      ),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: suffix,
        prefixIcon: prefix,
        filled: true,
        enabled: enabled,
        fillColor: AppColors.mainCardLight,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.stroke,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.stroke,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.stroke,
            width: 1,
          ),
        ),
        labelStyle: const TextStyle(
          color: AppColors.par,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: AppFonts.gtWalshPro,
        ),
        hintStyle: const TextStyle(
          color: AppColors.par,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: AppFonts.gtWalshPro,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
      ),
    );
  }
}
