import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/controller/product_services.dart';
import 'package:yuvix/features/inventory/models/product_model.dart';
import 'package:yuvix/core/constants/color.dart';

class OutOfStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Out of Stock Products',
              style: TextStyle(color: ConstC.getColor(AppColor.textC1))),
          centerTitle: true,
          backgroundColor: ConstC.getColor(AppColor.appBar)),
      backgroundColor: ConstC.getColor(AppColor.scaffold),
      body: Consumer<ProductService>(
        builder: (context, productService, child) {
          final outOfStockProducts = productService.getOutOfStockProducts();

          if (outOfStockProducts.isEmpty) {
            return Center(
              child: Text(
                'No Out of Stock Items',
                style: TextStyle(
                    fontSize: 18, color: ConstC.getColor(AppColor.text)),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: outOfStockProducts.length,
            itemBuilder: (context, index) {
              final product = outOfStockProducts[index];
              return _buildProductCard(product);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(child: Image.file(File(product.image.toString()))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ConstC.getColor(AppColor.textC2),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  ' ${product.category}',
                  style: TextStyle(
                    fontSize: 15,
                    color: ConstC.getColor(AppColor.textC2),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Price: ₹${product.price}',
                  style: TextStyle(
                    fontSize: 14,
                    color: ConstC.getColor(AppColor.buttonBackground2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
