import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';

Widget buildBackground(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ConstC.getColor(AppColor.background1),
            const Color(0xff281537),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 22),
        child: Text(
          'Hello\nLogin!',
          style: TextStyle(
            fontSize: 30,
            color: ConstC.getColor(AppColor.textC1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }