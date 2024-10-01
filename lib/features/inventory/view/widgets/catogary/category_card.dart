import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/inventory/view/screens/product_display_page.dart';
import '../../../models/category_model.dart';

class CatCard extends StatelessWidget {
  const CatCard({super.key, required this.cat});

  final CategoryModel cat;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProductDisplayPage(category: cat.categoryName!)));
        },
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
                    image: DecorationImage(image: FileImage(File(cat.image!)))),
              ),
              SizedBox(height: 6),
              Text(
                cat.categoryName!,
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
