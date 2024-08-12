import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/profile/view/screens/register.dart';

Widget buildSignUpOption(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegScreen()),
              );
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: ConstC.getColor(AppColor.textC2),
              ),
            ),
          ),
        ],
      ),
    );
  }
