import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/constants/_constants.dart';

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
  final BorderRadius? borderRadius;
  final Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;

  const AppTextField(
      {Key? key,
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
      this.onEditingComplete,
      this.onChanged,
      this.onTap,
      this.borderRadius,
      this.floatingLabelBehavior,
      this.inputFormatters,
      this.autovalidateMode})
      : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      readOnly: readOnly,
      expands: expands,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onTap: onTap,
      minLines: minLines,
      maxLength: maxLength,
      onEditingComplete:
          onEditingComplete ?? () => FocusScope.of(context).nextFocus(),
      style: AppTextStyles.regular14.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: suffix,
        prefixIcon: prefix,
        enabled: enabled,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.always,
        floatingLabelStyle: AppTextStyles.regular14.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(14),
          borderSide: BorderSide(
            color: !isDarkMode ? AppColors.wGrey84 : AppColors.gray333,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: !isDarkMode ? AppColors.wGrey84 : AppColors.gray333,
            width: 1,
          ),
        ),
        labelStyle: AppTextStyles.regular14
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
        hintStyle: AppTextStyles.regular14.copyWith(
          color: !isDarkMode ? AppColors.wGrey84 : AppColors.gray333,
          fontWeight: FontWeight.w300,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: !isDarkMode ? AppColors.wGrey84 : AppColors.gray333,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class AppDropdownField<T extends Object> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Widget Function(T)? customItem;
  final String Function(T)? displayItem;
  final String? label, hint;
  final String? headingText;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final bool enabled;
  final Color? fillColor;
  final bool hasBorder;

  const AppDropdownField({
    Key? key,
    required this.items,
    required this.value,
    this.onChanged,
    this.validator,
    this.label,
    this.hint,
    this.headingText,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.fillColor,
    this.focusNode,
    this.customItem,
    this.displayItem,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: items.map(
        (T item) {
          if (customItem != null) {
            return DropdownMenuItem(
              value: item,
              child: customItem!(item),
            );
          }
          return DropdownMenuItem(
            value: item,
            child: Text(
              displayItem != null ? displayItem!(item) : item.toString(),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          );
        },
      ).toList(),
      isExpanded: true,
      onChanged: onChanged,
      dropdownColor: AppColors.gray333,
      value: value,
      focusNode: focusNode,
      validator: validator,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: AppColors.gray333,
        size: 0,
      ),
      style: AppTextStyles.medium14.copyWith(
        height: 1.2,
        color: AppColors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: suffix ??
            const Icon(
              Icons.arrow_drop_down_sharp,
              color: AppColors.gray333,
              size: 25,
            ),
        prefixIcon: prefix,
        enabled: enabled,
        contentPadding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: AppTextStyles.regular14.copyWith(
          color: AppColors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.gray333,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.gray333,
            width: 1,
          ),
        ),
        labelStyle: AppTextStyles.regular14.copyWith(
          color: AppColors.white,
        ),
        hintStyle: AppTextStyles.regular14.copyWith(
          color: AppColors.gray333,
          fontWeight: FontWeight.w300,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.gray333,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class AppSearchField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final void Function()? onPressed;

  const AppSearchField(
      {Key? key, this.hintText, this.labelText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: AppColors.searchBarColor,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 17.0),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AppAssets.searchSvg,
            height: 13,
            width: 12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(39.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(39.0),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: AppTextStyles.regular14.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}
