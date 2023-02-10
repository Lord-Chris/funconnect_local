import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/constants/colors.dart';

class AppTextForm extends StatefulWidget {
  const AppTextForm({
    Key? key,
    this.inputFormatters,
    this.labelText,
    this.hintText,
    this.errorStyle,
    this.initialValue,
    this.autoFocus = false,
    this.controller,
    this.onChanged,
    required this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.minLines,
    this.lableStyle,
    this.disabled = false,
    this.hideLabel = false,
    this.textInputType,
    this.obscureText = false,
    this.showObscureTextToggle = false,
    this.focusNode,
    this.padding,
    this.textInputAction,
    this.onFieldSubmitted,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.prefixIcon,
    this.suffixIcon,
    this.infoText,
    this.textAlign,
    this.textAlignVertical,
    this.borderRadius,
    this.topLabelText,
    this.enableInteractiveSelection=true,
    this.showCursor=true,
    this.onTap
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  final int maxLines;
  final int? maxLength;
  final int? minLines;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFocus;
  final bool obscureText;
  final EdgeInsets? padding;
  final bool disabled;
  final bool hideLabel;
  final TextStyle? lableStyle;
  final TextStyle? errorStyle;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool showObscureTextToggle;
  final String? Function(String) validator;
  final String? infoText;
  final String? topLabelText;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final BorderRadius? borderRadius;
  final bool enableInteractiveSelection;
  final bool showCursor;
  final Function()? onTap;

  @override
  _AppTextFormState createState() => _AppTextFormState();
}

class _AppTextFormState extends State<AppTextForm>
    with TickerProviderStateMixin {
  FocusNode? focusNode;
  TextEditingController? controller;
  late ValueNotifier<bool> obscureTextValueListenable;
  ValueNotifier<bool> dirtyValueListenable = ValueNotifier<bool>(false);

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    obscureTextValueListenable = ValueNotifier<bool>(widget.obscureText);
    controller = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      controller!.text = widget.initialValue!;
    }

    controller!.addListener(() {
      if (controller!.value.text.isNotEmpty) {
        dirtyValueListenable.value = true;
      } else {}
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    if (widget.controller == null) {
      controller!.dispose();
    }
    dirtyValueListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.topLabelText != null && !widget.hideLabel)
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                widget.topLabelText!,
                textAlign: TextAlign.left,
                style: widget.lableStyle ??
                    const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
              ),
            ),
          Container(
            constraints: BoxConstraints(minHeight: max(40.toDouble(), 40)),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(20.0),
              color: widget.backgroundColor ?? AppColors.transparent,
            ),
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 300),
              opacity: widget.disabled ? .4 : 1.0,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 800),
                    transform: Matrix4.identity()
                      ..translate(
                          0.0,
                          widget.hideLabel
                              ? 0.0
                              : focusNode!.hasFocus ||
                                      controller!.text.isNotEmpty
                                  ? .0
                                  : 0.0),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: obscureTextValueListenable,
                      builder: (BuildContext context, bool obscuringText,
                          Widget? child) {
                        return TextFormField(
                          focusNode: focusNode,
                          autovalidateMode:
                              focusNode!.hasFocus && dirtyValueListenable.value
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.onUserInteraction,
                          obscuringCharacter: '*',
                          obscureText: obscuringText,
                          controller: controller,
                          cursorColor: widget.textColor,
                          textInputAction: widget.textInputAction,
                          maxLength: widget.maxLength,
                          maxLines: widget.maxLines,
                          autofocus: widget.autoFocus,
                          textAlignVertical: widget.textAlignVertical,
                          minLines: widget.minLines,
                          keyboardType: widget.textInputType,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: widget.textColor ?? AppColors.white,
                            fontSize: 16,
                          ),
                          onChanged: widget.onChanged,
                          textAlign: widget.textAlign ?? TextAlign.start,
                          inputFormatters: widget.inputFormatters,
                          onFieldSubmitted: widget.onFieldSubmitted,
                          enableInteractiveSelection: widget.enableInteractiveSelection,
                          showCursor: widget.showCursor,
                          onTap: widget.onTap,
                          decoration: InputDecoration(
                            prefix: widget.prefixIcon,
                            suffix: widget.suffixIcon,
                            labelText: widget.labelText,
                            labelStyle: const TextStyle(
                                color: AppColors.white, fontSize: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: widget.borderRadius ??
                                  BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(color: AppColors.ash),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.ash),
                              borderRadius: widget.borderRadius ??
                                  BorderRadius.circular(8.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.ash),
                              borderRadius: widget.borderRadius ??
                                  BorderRadius.circular(8.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 19,
                              vertical: 15,
                            ),
                            hintText: widget.hintText,
                            hintStyle: const TextStyle(
                                fontSize: 14, color: AppColors.ash),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: obscureTextValueListenable,
                      builder: (BuildContext context, bool obscuringText,
                          Widget? child) {
                        if (!widget.showObscureTextToggle ||
                            !focusNode!.hasFocus && !widget.obscureText) {
                          return const SizedBox(height: 20);
                        }

                        return AnimatedSwitcher(
                          reverseDuration: Duration.zero,
                          transitionBuilder:
                              (Widget? child, Animation<double> animation) {
                            final Animation<double> offset =
                                Tween<double>(begin: 0, end: 1.0)
                                    .animate(animation);
                            return ScaleTransition(scale: offset, child: child);
                          },
                          switchInCurve: Curves.elasticOut,
                          duration: const Duration(milliseconds: 700),
                          child: IconButton(
                            key: ValueKey<bool>(obscuringText),
                            onPressed: () {
                              obscureTextValueListenable.value = !obscuringText;
                            },
                            icon: obscuringText
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppColors.ash,
                                    size: 18,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: AppColors.ash,
                                    size: 18,
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller!,
            builder:
                (BuildContext context, TextEditingValue textEditingValue, _) {
              return ValueListenableBuilder<bool>(
                valueListenable: dirtyValueListenable,
                builder: (BuildContext context, bool dirty, _) {
                  final bool showError =
                      (widget.validator(textEditingValue.text) is String) &&
                          dirty;
                  return AnimatedSize(
                    curve: Curves.elasticOut,
                    duration: const Duration(milliseconds: 900),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Builder(
                          key: ValueKey<bool>(
                              showError || widget.infoText == null),
                          builder: (_) {
                            if (showError) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  widget.validator(controller!.value.text)!,
                                  style: widget.errorStyle ??
                                      const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                ),
                              );
                            }
                            return widget.infoText != null
                                ? Text(
                                    widget.infoText!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.white,
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
