import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:yuvix/main.dart';

import '../models/brand_model.dart';

class BrandService extends ChangeNotifier {
  Future<void> openBox() async {
    brandbox = await Hive.openBox<BrandModel>('brandBox');
  }

  Future<void> addBrand(BrandModel brand, String imagePath) async {
    brand.brandImage = imagePath;
    await brandbox.add(brand);
    notifyListeners();
  }

  Future<List<BrandModel>> getBrands() async {
    return brandbox.values.toList();
  }
}
