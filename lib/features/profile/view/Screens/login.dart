
import 'package:flutter/material.dart';
import 'package:yuvix/features/profile/view/widgets/build_widget.dart';
import 'package:yuvix/features/profile/view/widgets/login_form.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(context),
          const LoginForm(),
        ],
      ),
    );
  }

  
}
