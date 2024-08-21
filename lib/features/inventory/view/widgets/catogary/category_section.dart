import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/controller/category_Service.dart';
import 'package:yuvix/features/inventory/models/category_model.dart';
import 'package:yuvix/features/inventory/view/widgets/catogary/category_card.dart';
import 'package:yuvix/features/inventory/view/widgets/catogary/category_grid.dart';
import 'package:yuvix/features/inventory/view/widgets/product/other/build_section_header.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildSectionHeaderWidget(
          title: "Category",
          onSeeMore: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryGridView()),
            );
          },
        ),
        SizedBox(height: 10),
        FutureBuilder<List<CategoryModel>>(
          future: categoryService.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No categories found');
            } else {
              log(snapshot.data!.length.toString());
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final category = snapshot.data![index];
                    return CatCard(cat: category);
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
  void showDeleteDialog(BuildContext context, CategoryService categoryService, CategoryModel category,int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Category'),
          content: Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                categoryService.deleteCategory(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}


