import 'package:hive_flutter/adapters.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  int? categoryId;

  @HiveField(1)
  String? categoryName;

  @HiveField(2)
  String? image;

  @HiveField(3)
  int? productCount;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.image,
    this.productCount = 0,
  });
}
