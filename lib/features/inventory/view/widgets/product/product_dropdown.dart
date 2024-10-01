import 'package:flutter/material.dart';

import '../../../models/category_model.dart';

class CategoryDropdown extends StatelessWidget {
  final Future<List<CategoryModel>> categoriesFuture;
  final String? selectedType;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    required this.categoriesFuture,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<CategoryModel> categories = snapshot.data ?? [];

          return DropdownButtonFormField<String>(
            value: selectedType,
            onChanged: onChanged,
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category.categoryName,
                child: Text(category.categoryName ?? 'Unknown'),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
          );
        }
      },
    );
  }
}
