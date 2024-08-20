import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 3)
class ProductModel {
  @HiveField(0)
  final int productId; 
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String brand;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final String? color; 
  @HiveField(6)
  final String? ram;
  @HiveField(7)
  final String? processor;
  @HiveField(8)
  final String? camera;
  @HiveField(9)
  final String? battery;
  @HiveField(10)
  final String? storage;
  @HiveField(11)
  final String? displaySize;
  @HiveField(12)
  final String? networkConnectivity;
  @HiveField(13)
  final String? compatibility;
  @HiveField(14)
  final String? material;
  @HiveField(15)
  final String? features;
  @HiveField(16)
  int?quantity;
  @HiveField(17)
  final double price;

  ProductModel({
    required this.productId, 
    required this.productName,
    required this.category,
    required this.brand,
    this.image,
    this.color, 
    this.ram,
    this.processor,
    this.camera,
    this.battery,
    this.storage,
    this.displaySize,
    this.networkConnectivity,
    this.compatibility,
    this.material,
    this.features,
    required this.quantity,
    required this.price, 
  });
}
