import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../mobiles/product_detail_row.dart';

class WatchProductDetails extends StatelessWidget {
  final ProductModel product;

  WatchProductDetails({required this.product});

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
        ProductDetailRow(label: 'Battery', value: '${product.battery} mAh'),
        ProductDetailRow(label: 'Color', value: product.color ?? 'Unknown Color'),
        ProductDetailRow(label: 'Display Size', value: '${product.displaySize}'),
        ProductDetailRow(label: 'Quantity', value: '${product.quantity}'),
        ProductDetailRow(label: 'compatibility', value: '${product.compatibility}'),
        ProductDetailRow(label: 'features', value: '${product.features}'),
        ProductDetailRow(label: 'Price', value: '₹${product.price.toStringAsFixed(2)}'),
      ],
    );
  }
}
