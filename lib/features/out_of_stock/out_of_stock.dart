// import 'package:flutter/material.dart';
// import 'package:yuvix/features/inventory/models/product_model.dart';


// class OutOfStock extends StatelessWidget {
//   final List<ProductModel> outOfStockProducts;

//   OutOfStock({required this.outOfStockProducts});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Out of Stock')),
//       body: ListView.builder(
//         itemCount: outOfStockProducts.length,
//         itemBuilder: (context, index) {
//           final product = outOfStockProducts[index];
//           return ListTile(
//             title: Text(product.productName),
//             subtitle: Text('This product is out of stock'),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class OutOfStock extends StatelessWidget {
  const OutOfStock({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}