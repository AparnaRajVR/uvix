
import 'package:flutter/material.dart';
import 'package:yuvix/features/profile/view/widgets/background.dart';
import 'package:yuvix/features/profile/view/widgets/register_form.dart';


class RegScreen extends StatelessWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          const RegistrationForm(),
        ],
      ),
    );
  }
}
