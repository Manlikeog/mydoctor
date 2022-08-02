import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final FocusNode? focus;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final ValueChanged<String> sub;

  const RoundedPasswordField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.sub,
    this.focus,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool visibility = true;

  void ontapsee() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.99,
      child: TextFormField(
        obscureText: visibility,
        controller: widget.controller,
        focusNode: widget.focus,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: widget.sub,
        validator: widget.validator,
        cursorColor: Colors.black,
        autocorrect: false,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock_rounded,
            color: Color(0xff677294),
          ),
          suffixIcon: InkWell(
            onTap: (() {
              ontapsee();
            }),
            child: Icon(
              visibility ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xff677294),
            ),
          ),
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0x1f677294),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xff0EBE7F),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xff0EBE7F),
            ),
          ),
        ),
      ),
    );
  }
}
