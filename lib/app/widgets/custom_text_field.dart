import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType? textInputType;
  final Icon? icon;
  final TextEditingController? controller;
  final bool? isPassword;

  const CustomTextField({
    super.key,
    this.hintText,
    this.textInputType,
    this.icon,
    this.controller,
    this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ?? false,
      controller: controller,
      cursorColor: const Color(0xFF00623B),
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
      ),
      autocorrect: false,
      // onTapOutside: (event) {
      //   FocusScope.of(context).unfocus();
      // },
    );
  }
}
