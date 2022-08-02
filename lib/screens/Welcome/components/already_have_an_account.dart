import 'package:flutter/material.dart';

class AccountStatus extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AccountStatus({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(
            color: Color(0xff0EBE7F),
          ),
        ),
        TextButton(
          onPressed: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: Color(0xff0EBE7F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
