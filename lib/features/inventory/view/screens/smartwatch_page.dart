import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/inventory/view/widgets/smartwatch/edit_watch.dart';

import '../../models/product_model.dart';
import '../widgets/smartwatch/product_watch.dart';

class SmartwatchPage extends StatelessWidget {
  final ProductModel product;

  SmartwatchPage({required this.product});

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
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return EditProducWatchtDialog(
                        product: product,
                      );
                    },
                  )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: WatchProductDetails(product: product),
        ),
      ),
    );
  }
}
