import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/color.dart';
import '../../controller/product_services.dart';
import '../widgets/product/product_navigator.dart';

class ProductDisplayPage extends StatelessWidget {
  final String category;

  ProductDisplayPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    productService.getProducts();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: ConstC.getColor(AppColor.textC1),
        backgroundColor: ConstC.getColor(AppColor.appBar),
        title: Text('$category Products',
            style: TextStyle(color: ConstC.getColor(AppColor.textC1))),
        centerTitle: true,
      ),
      body: Consumer<ProductService>(builder: (context, value, child) {
        var filterProducts = value.productsMy
            .where((element) => element.category == category)
            .toList();

        return GridView.builder(
          padding: EdgeInsets.all(6.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: filterProducts.length,
          itemBuilder: (context, index) {
            final product = filterProducts[index];

            return ProductNavigator(product: product);
          },
        );
      }),
    );
  }
}
