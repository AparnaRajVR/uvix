
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product_model.dart';

class ProductService with ChangeNotifier {
  Box<ProductModel>? _productBox;
  List<ProductModel> _products = [];
  List<ProductModel> productsMy = [];
  List<ProductModel> _filteredProducts = []; 
  File? _imageFile;

  List<ProductModel> get products => _products;
  List<ProductModel> get filteredProducts => _filteredProducts; 
  File? get imageFile => _imageFile;

  ProductService() {
    _initializeBox();
  }

  Future<void> _initializeBox() async {
    _productBox = await Hive.openBox<ProductModel>('products');
    _products = _productBox?.values.toList() ?? [];
    notifyListeners();
  }

  Future<void> getProducts() async {
    final productBox = await Hive.openBox<ProductModel>('products');
    productsMy = productBox.values.toList();
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    if (_productBox == null) return;
    await _productBox!.add(product);
    _products = _productBox!.values.toList();
    notifyListeners();
  }

  Future<void> deleteProduct(int productId) async {
    if (_productBox == null) return;
    final productKey = _productBox!.keys.firstWhere(
      (key) => _productBox!.get(key)!.productId == productId,
      orElse: () => null,
    );

    if (productKey != null) {
      await _productBox!.delete(productKey);
      _products = _productBox!.values.toList();
      notifyListeners();
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    if (_productBox == null) return;
    final index = _productBox!.values.toList().indexWhere((value) => value.productId == product.productId);
    if (index != -1) {
      await _productBox!.putAt(index, product);
      _products = _productBox!.values.toList();
      notifyListeners();
    }
  }

  void editProductImage(File? file) {
    _imageFile = file;
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts =_products; 
    } else {
      _filteredProducts = _products 
          .where((product) => product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterProducts(Map<String, List<String>> filters) {
    List<ProductModel> filteredProducts = _products;

    bool hasPriceFilter = filters.containsKey('Price');
    bool hasColorFilter = filters.containsKey('Color');

    if (hasPriceFilter) {
      List<String> priceFilters = filters['Price']!;
      filteredProducts = filteredProducts.where((product) {
        double price = product.price;
        bool priceMatch = false;
        if (priceFilters.contains('Under ₹15,000') && price < 15000) priceMatch = true;
        if (priceFilters.contains('₹15,000 - ₹30,000') && price >= 15000 && price <= 30000) priceMatch = true;
        if (priceFilters.contains('₹30,000 - ₹60,000') && price > 30000 && price <= 60000) priceMatch = true;
        if (priceFilters.contains('Above ₹60,000') && price > 60000) priceMatch = true;
        return priceMatch;
      }).toList();
      print('After Price Filter: ${filteredProducts.length}');
    }

    if (hasColorFilter) {
      List<String> colorFilters = filters['Color']!;
      filteredProducts = filteredProducts.where((product) {
        bool colorMatch = colorFilters.any((filterColor) {
          String productColor = product.color?.toLowerCase() ?? '';
          return productColor == filterColor.toLowerCase();
        });
        return colorMatch;
      }).toList();
      print('After Color Filter: ${filteredProducts.length}');
    }

    _filteredProducts = filteredProducts;
    print('Filtered Products Count: ${_filteredProducts.length}');
    notifyListeners();
  }

  Future<void> filterProductsByCategory(String categoryName, String query) async {
    final productBox = await Hive.openBox<ProductModel>('products');
    _filteredProducts = productBox.values
        .where((product) => product.category == categoryName && product.productName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

