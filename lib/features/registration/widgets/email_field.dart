import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:email_validator/email_validator.dart';

class EmailField extends StatefulWidget {
  final TextEditingController controller;

  const EmailField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: 'Email address',
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          fillColor: Palette.lightGrey),
      cursorColor: Colors.black,
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      validator: (email) => (email != null && !EmailValidator.validate(email))
          ? 'Enter a valid email'
          : null,
    );
  }
}
