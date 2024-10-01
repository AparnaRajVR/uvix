import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../mobiles/product_detail_row.dart';

class AccessoriesProductDetails extends StatelessWidget {
  final ProductModel product;

  AccessoriesProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Image.file(
            File(product.image ?? 'https://via.placeholder.com/150'),
            height: 200,
            width: 200,
          ),
        ),
        SizedBox(height: 16.0),
        ProductDetailRow(label: 'Product Name', value: product.productName),
        ProductDetailRow(label: 'Category', value: product.category),
        ProductDetailRow(label: 'Brand', value: product.brand),
        ProductDetailRow(
            label: 'Compatibility', value: '${product.compatibility}'),
        ProductDetailRow(label: 'Material', value: '${product.material}'),
        ProductDetailRow(label: 'Features', value: '${product.features}'),
        ProductDetailRow(
            label: 'Color', value: product.color ?? 'Unknown Color'),
        ProductDetailRow(
            label: 'Price', value: '₹${product.price.toStringAsFixed(2)}'),
      ],
    );
  }
}
