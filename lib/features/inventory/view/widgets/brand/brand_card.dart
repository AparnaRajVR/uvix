import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import '../../../models/brand_model.dart';
import '../../screens/brand_detail_page.dart';

class BrandCard extends StatelessWidget {
  final BrandModel brand;

  BrandCard({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BrandDetailPage(brand: brand.brandName!)));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 160,
          height: 150,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ConstC.getColor(AppColor.background1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ConstC.getColor(AppColor.textC1),
                  image: DecorationImage(
                    image: FileImage(File(brand.brandImage!)),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(
                brand.brandName!,
                style: TextStyle(
                    color: ConstC.getColor(AppColor.textC1), fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
