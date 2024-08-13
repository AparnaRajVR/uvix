import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/view/widgets/product/product_card.dart';
import '../../controller/product_services.dart';

class BrandDetailPage extends StatelessWidget {
  final String brand;

  BrandDetailPage({required this.brand});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    productService.getProducts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff03448c),
        title: Text('${brand} Products'),
      ),
      body: Consumer<ProductService>(builder: (context, value, child) {
        var filteredProducts = value.productsMy.where((element) => element.brand == brand).toList();

        return GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];

            return ProductCard(
              imageUrl: product.image ?? 'https://via.placeholder.com/150',
              productName: product.productName,
              color: product.color ?? 'Unknown Color',
              price: '₹${product.price.toStringAsFixed(2)}',
            );
          },
        );
      }),
    );
  }
}
