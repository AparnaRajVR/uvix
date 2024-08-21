import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/inventory/view/widgets/mobiles/product_details.dart';
import '../../models/product_model.dart';
import '../widgets/product/other/show_dialog.dart';

class MobilesFullDetailsPage extends StatelessWidget {
  final ProductModel product;

  MobilesFullDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ConstC.getColor(AppColor.textC1),
        backgroundColor: ConstC.getColor(AppColor.appBar),
        title: Text(
          product.productName,
          style: TextStyle(
            color: ConstC.getColor(AppColor.textC1),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => showEditDialog(context, product),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: MobileProductDetails(product: product),
        ),
      ),
    );
  }
}
