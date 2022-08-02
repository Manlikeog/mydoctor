import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final TextInputType? type;
  final FocusNode? focus;
  final Function(String?)? onchanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon,
      this.onchanged,
      this.validator,
      required this.type,
      this.focus,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.99,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        focusNode: focus,
        validator: validator,
        maxLines: null,
        onChanged: onchanged,
        cursorColor: Colors.black,
        keyboardType: type,
        autocorrect: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: const Color(0xff677294),
          ),
          hintText: hintText,
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0x1f677294),
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
