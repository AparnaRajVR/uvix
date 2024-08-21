import 'package:flutter/material.dart';

import 'package:yuvix/features/inventory/view/widgets/mobiles/product_details.dart';
import '../../models/product_model.dart';

import '../widgets/product/other/show_dialog.dart';

class OtherFullDetails extends StatelessWidget {
  final ProductModel product;

  OtherFullDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
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
