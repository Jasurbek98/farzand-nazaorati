import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hint;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Color borderColor;
  final bool obscureText;
  final bool autoFocus;
  final int? errorTextLine;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final bool isTextCenter;
  final int maxLines;
  final int? minLines;
  final TextInputAction? inputAction;
  final Color fillColor;
  final FloatingLabelBehavior behavior;
  final EdgeInsetsGeometry? padding;

  const CustomInput({
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.labelText,
    this.validator,
    this.borderColor = Colors.indigo,
    this.obscureText = false,
    this.errorTextLine,
    this.enabled = true,
    this.autoFocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.isTextCenter = false,
    this.maxLines = 1,
    this.minLines,
    this.inputAction,
    this.padding,
    this.fillColor = Colors.white70,
    this.behavior = FloatingLabelBehavior.auto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: validator,
        focusNode: focusNode,
        onChanged: onChange,
        textInputAction: inputAction,
        inputFormatters: inputFormatters,
        autofocus: autoFocus,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.indigo,
        obscureText: obscureText,
        onFieldSubmitted: onSubmit,
        enabled: enabled,
        minLines: minLines,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14),
        textAlign: isTextCenter ? TextAlign.center : TextAlign.start,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          floatingLabelBehavior: behavior,
          errorMaxLines: errorTextLine,
          labelText: labelText,
          filled: true,
          fillColor: fillColor,
          hintText: hint,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 11),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor.withOpacity(0.3)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor.withOpacity(0.3)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
