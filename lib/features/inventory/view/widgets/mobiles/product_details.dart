import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import 'product_detail_row.dart';
class MobileProductDetails extends StatelessWidget {
  final ProductModel product;

  MobileProductDetails({required this.product});

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
        ProductDetailRow(label: 'RAM', value: '${product.ram} GB'),
        ProductDetailRow(label: 'Processor', value: '${product.processor}'),
        ProductDetailRow(label: 'Camera', value: '${product.camera}'),
        ProductDetailRow(label: 'Battery', value: '${product.battery} mAh'),
        ProductDetailRow(label: 'Storage', value: '${product.storage} GB'),
         ProductDetailRow(label: 'Display Size', value:'${product.displaySize}'),
        ProductDetailRow(label: 'Network Connectivity', value:'${product.networkConnectivity}'),
        ProductDetailRow(label: 'Color', value: product.color ?? 'Unknown Color'),

        ProductDetailRow(label: 'Quantity', value: '${product.quantity}'),
        ProductDetailRow(label: 'Price', value: '₹${product.price.toStringAsFixed(2)}'),
      ],
    );
  }
}
