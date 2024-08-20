// import 'package:flutter/foundation.dart';
// // import 'package:hive_flutter/hive_flutter.dart';

// import 'package:yuvix/main.dart';

// import '../models/category_model.dart';

// class CategoryService extends ChangeNotifier {

//   Future<void> addCategory(CategoryModel category, String imagePath) async {
//     category.image = imagePath; 
//     await catBox.add(category);
//     notifyListeners(); 
//   }

//   Future<List<CategoryModel>> getCategories() async {
    
//     return catBox.values.toList(); 
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:yuvix/main.dart';
import '../models/category_model.dart';
import 'dart:convert';

class CategoryService extends ChangeNotifier {
  Future<void> addCategory(CategoryModel category, dynamic imageData) async {
    if (kIsWeb) {
      // For web, convert the image data to a base64 string
      String base64Image = base64Encode(imageData);
      category.image = base64Image;
    } else {
      // For mobile, imageData is already a file path
      category.image = imageData;
    }

    await catBox.add(category);
    notifyListeners();
  }

  Future<List<CategoryModel>> getCategories() async {
    return catBox.values.toList();
  }
}