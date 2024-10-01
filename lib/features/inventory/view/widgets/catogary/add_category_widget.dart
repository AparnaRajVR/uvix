import 'package:flutter/material.dart';

import '../../../../../core/constants/color.dart';
import 'category_add.dart';

class AddCategoryCard extends StatelessWidget {
  final title;
  const AddCategoryCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCategory()),
          );
        },
        child: Container(
          width: 100,
          height: 120,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ConstC.getColor(AppColor.background1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: ConstC.getColor(AppColor.icon1),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                    color: ConstC.getColor(AppColor.textC1),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
